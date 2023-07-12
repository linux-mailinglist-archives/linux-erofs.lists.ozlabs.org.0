Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B00750749
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 13:58:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1GTk5KJvz3bwb
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 21:58:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1GTb6GJpz30Kf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 21:58:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnCu4op_1689163081;
Received: from 30.221.148.68(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnCu4op_1689163081)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 19:58:02 +0800
Message-ID: <a57cb804-0d78-255c-0bba-dab69686b196@linux.alibaba.com>
Date: Wed, 12 Jul 2023 19:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] erofs-utils: add xxh32 library
To: Gao Xiang <hsiangkao@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230705071017.104130-1-jefflexu@linux.alibaba.com>
 <20230705071017.104130-2-jefflexu@linux.alibaba.com>
 <b2f87329-8d2c-5106-e61c-4dffd8be7e8c@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <b2f87329-8d2c-5106-e61c-4dffd8be7e8c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/5/23 3:29 PM, Gao Xiang wrote:
> 
> 
> On 2023/7/5 15:10, Jingbo Xu wrote:
>> Add xxh32 library which could be used by following xattr bloom filter
>> feature.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> I'd suggest using the original xxhash library instead of copying an
> simplified implementation here since we don't touch the implementation.
> 
> https://rpmfind.net/linux/rpm2html/search.php?query=xxhash

Yeah.  I think xxhash-devel is available in most distributions.  XXH32()
could be used directly here and configure.ac needs to be updated to
reflect the package dependency.

As I'm not quite familiar with autoconf/automake, later in v3 I will
still attach the self-implemented xxh32() in erofs-utils.  Maybe later
we could change to use libxxhash directly.


-- 
Thanks,
Jingbo
