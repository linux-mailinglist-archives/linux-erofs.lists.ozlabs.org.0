Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD2739780
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 08:37:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmrJQ3bHFz30BY
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 16:37:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmrJL6BDQz2ydd
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 16:37:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VliIWD4_1687415818;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VliIWD4_1687415818)
          by smtp.aliyun-inc.com;
          Thu, 22 Jun 2023 14:37:00 +0800
Message-ID: <3730215c-d59d-8b8e-fe36-7754f7782d15@linux.alibaba.com>
Date: Thu, 22 Jun 2023 14:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To: Alexander Larsson <alexl@redhat.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 6/21/23 7:50 PM, Alexander Larsson wrote:
> On Wed, Jun 21, 2023 at 10:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Background
>> ==========
>> Filesystems with ACL enabled generally need to read
>> "system.posix_acl_access"/"system.posix_acl_default" xattr to get the
>> access and default ACL.  When filesystem is mounted with ACL enabled
>> while files in the system have not set access/default ACL, the getattr()
>> will run in vain while the round trip can decrease the performance in
>> workload like "ls -lR".
>>
>> For example, there's a 12% performance boost if erofs is mounted with
>> "noacl" when running "ls -lR" workload on dataset [1] (given in [2]).
>>
>> We'd better offer a fastpath to boost the above workload, as well as
>> other negative xattr lookup.
>>
>>
>> Proposal
>> ========
>> Introduce a per-inode bloom filter for xattrs to boost the negative
>> xattr queries.
>>
>> As following shows, a 32-bit bloom filter is introduced for each inode,
>> describing if a xattr with specific name exists on this inode.
>>
>> ```
>>  struct erofs_xattr_ibody_header {
>> -       __le32 h_reserved;
>> +       __le32 h_map; /* bloom filter */
>>         ...
>> }
>> ```
>>
>> Following are some implementation details for bloom filter.
>>
>> 1. Reverse bit value
>> --------------------
>> The bloom filter structure describes if a given data is inside the set.
>> It will map the given data into several bits of the bloom filter map.
>> The data must not exist inside the set if any mapped bit is 0, while the
>> data may be not inside the set even if all mapped bits is 1.
>>
>> While in our use case, as erofs_xattr_ibody_header.h_map is previously a
>> (all zero) reserved field, the bit value for the bloom filter has a
>> reverse semantics in consideration for compatibility.  That is, for a
>> given data, the mapped bits will be cleared to 0.  Thus for a previously
>> built image without support for bloom filter, the bloom filter is all
>> zero and when it's mounted by the new kernel with support for bloom
>> filter, it can not determine if the queried xattr exists on the inode and
>> thus will fallback to the original routine of iterating all on-disk
>> xattrs to determine if the queried xattr exists.
>>
>>
>> 2. The number of hash functions
>> -------------------------------
>> The optimal value for the number of the hash functions (k) is (ln2 *
>> m/n), where m stands the number of bits of the bloom filter map, while n
>> stands the number of all candidates may be inside the set.
>>
>> In our use case, the number of common used xattr (n) is approximately 8,
>> including system.[posix_acl_access|posix_acl_default],
>> security.[capability|selinux] and
>> security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].
>>
>> Given the number of bits of the bloom filter (m) is 32, the optimal value
>> for the number of the hash functions (k) is 2 (ln2 * m/n = 2.7).
> 
> This is indeed the optimal value in a traditional use of bloom
> filters. However, I think it is based on a much larger set of values.
> For this usecase it may be better to choose a different value.
> 
> I did some research a while ago on this, and I thought about the
> counts too. Having more than one hash function is useful because it
> allows you to avoid problems if two values happen to hash to the same
> bucket, but this happens at the cost of there being less "unique
> buckets".  I spent some time looking for common xattr values
> (including some from userspace) and ended up with a list of about 30.

Yeah, if the number of common used xattr (n) is 30, then the optimal
value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).
The optimal value in theory also matches our intuition.


> If we can choose a single hash function that maps all (or most) of
> these to a unique bucket (mod 32),

Excellent research!  Would you mind sharing the list of these
approximately 30 commonly used xattrs, so that I could check if they are
mapped to unique bucket with the single hash function we proposed?


-- 
Thanks,
Jingbo
