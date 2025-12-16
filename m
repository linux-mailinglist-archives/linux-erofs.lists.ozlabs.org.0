Return-Path: <linux-erofs+bounces-1501-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D0CC1933
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 09:31:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVqs40zW1z2xqj;
	Tue, 16 Dec 2025 19:31:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765873880;
	cv=none; b=n1rLKT/Ttc1DJ6y7BS8BOzQ/06BZAhQS6j0hmjFo71/HO/gm1n8KarxPcF02dDnyXa0MZ0UEIaHJi/x3JPPg+mlPyF9RaaQmS7otI5dVAXFTJWCq3Y7OXGrRp760Z+rVVmjcMszIMzLJlR844mfnrTS5ev3vAfVbM5vrrjIjDM4wON2Sk0gL7dwL297Q8titj+Pa5DYdUon/B7xJ7wY351/mf3VdCFjwGEzHDpNQ7V7Q6gXP5fs98rQMxBr4NGER5q6K/FDUbwxtxv6sqGi2DbESA1V8vYPZc15NmrdWuubABlPdca+20z3ltMKSY90HkChPHVxg33xWOYDk94eODg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765873880; c=relaxed/relaxed;
	bh=jxOjlXVXNyftFL8feMtFEmzMHSy/HETN2LNFtZeYH2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j6EpFempZYM35YZwSF0ZKQzu/Z1xMSJojpUUdlxHH5I2Eo6j52vinexFGP7twgwNQ4lprOfNnEr/sss1xOGLNhkS7kGsnBiqduGtN9HJKGemcFT3EWKj1jYVmg0hxqdsdG4qY7bKtDF3e+f8q3Ch3j3/aFMjoBHPCQsK97wdpppZ+k2AfSAL0OXueST1yy4lCRHMG+5f7+hGUVwWOdQQzbiebHWgJmnoGDhu/knoj5ASUyU0LZw7iC1eeThLKZfLj+XdvD8iwFjL2doMd3pkJ7Ho9H62eoeLu2gu9DnV+tQKc4dzXcRWOuWwM7rHwfBfp3SVOM/UtOCx6iSvOjbeTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xD/Qbwuk; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xD/Qbwuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVqs201DYz2xqf
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 19:31:17 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jxOjlXVXNyftFL8feMtFEmzMHSy/HETN2LNFtZeYH2I=;
	b=xD/QbwukMqpJGsSru1PfHBEDFV/m0J2fW11ird3bASCx3ufoKD4LrOceFUBSia2u3qMVbfcst
	Bskjlkq1YKVjtg9ye8wzX9uuncpDE7eON1+faZWC+DMAkr/HCbWjtMiMfIj/yi7HLf/QspvbIUV
	0q4tLmONlTnGWxD2sCa6Lls=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dVqpb6DTWz1prLS;
	Tue, 16 Dec 2025 16:29:11 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 437DF180478;
	Tue, 16 Dec 2025 16:31:13 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 16 Dec 2025 16:31:12 +0800
Message-ID: <5d1f109a-7613-4b5f-a5d8-305b0f3ade3a@huawei.com>
Date: Tue, 16 Dec 2025 16:31:12 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: restrict `ocierofs_io_open()`
 to single-layer images
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <hudson@cyzhu.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
 <20251216070557.743122-2-zhaoyifan28@huawei.com>
 <31adc60f-fc76-471f-aea9-18304b9f01b8@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <31adc60f-fc76-471f-aea9-18304b9f01b8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/12/16 15:23, Gao Xiang wrote:


>
>
> On 2025/12/16 16:05, Yifan Zhao wrote:
>> When mounting an OCI image with `mount.erofs -t erofs.nbd` without
>> specifying either `oci.layer=` or `oci.blob=`, a segfault occurs in the
>> `ocierofs_download_blob_range() → ocierofs_find_layer_by_digest()` call
>> path due to an empty `ctx->blob_digest`.
>>
>> As mounting multi-layer OCI images is not yet supported, let's exit
>> early in `ocierofs_io_open()` with an error in this case.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/remotes/oci.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>> index d5afd6a..ce7a1a5 100644
>> --- a/lib/remotes/oci.c
>> +++ b/lib/remotes/oci.c
>> @@ -1479,16 +1479,18 @@ int ocierofs_io_open(struct erofs_vfile 
>> *vfile, const struct ocierofs_config *cf
>>           return -ENOMEM;
>>         err = ocierofs_init(ctx, cfg);
>> -    if (err) {
>> -        free(ctx);
>> -        return err;
>> +    if (err)
>> +        goto out;
>> +
>> +    if (!ctx->blob_digest) {
>> +        err = -EINVAL;
>
> Is it possible to add a dedicated error message for this case?

Note: Apologies — this was originally sent directly to the maintainer by 
mistake and is now being resent to the list for visibility and review.


Hi Xiang,

Acknowledged. However, when netlink is unavailable, this logic runs in 
both `erofsmount_startnbd` and `erofsmount_startnbd_nl`,

causing duplicate error output. A refactor may be warranted later, but 
for now, let's just add the error print.


Thanks,

Yifan Zhao

>
> Thanks,
> Gao Xiang

