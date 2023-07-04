Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E27746CFB
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 11:15:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwHFb1NhDz3bPV
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 19:15:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwHFS2LGMz2xdp
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jul 2023 19:15:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmcHuwv_1688462115;
Received: from 30.97.48.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmcHuwv_1688462115)
          by smtp.aliyun-inc.com;
          Tue, 04 Jul 2023 17:15:16 +0800
Message-ID: <c630bb18-2a50-13ed-f100-c4e40860e04b@linux.alibaba.com>
Date: Tue, 4 Jul 2023 17:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To: Alexander Larsson <alexl@redhat.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
 <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
 <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
 <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/4 16:05, Alexander Larsson wrote:
> On Tue, Jul 4, 2023 at 7:56 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>

...

>> ```
>> seed: 25bbe08f
>> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>>
>> seed: cc922efd
>> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>>
>> seed: cd478c17
>> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
>> ```
>>
>>
>> Any other idea?
> 
> Any of these three is good to me. I don't have any ideas directly
> related to this. However,  semi-related, it would be really cool if
> fuse supported the same approach for xattr lookup. I.e. if lookup
> could add a bloom filter value as part of the inode data, then we
> could avoid a kernel<->fusefs-d transition for negative xattrs
> lookups.

I think we could just use a hardcoded magic number (e.g. 25bbe08f)
as a start first, since it seems already fulfill our requirement
and it's a compatible feature (and the implementation is also not
complex.)  So I'm not quite worried about this.

Thanks,
Gao Xiang

> 
