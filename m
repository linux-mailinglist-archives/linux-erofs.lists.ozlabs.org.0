Return-Path: <linux-erofs+bounces-286-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A3AAD2E4
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 03:43:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsdMm2ZWkz2ydN;
	Wed,  7 May 2025 11:43:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746582228;
	cv=none; b=mtDYUYfsDR6TeOsN6wMbKtG6al9FIOTSn0Ezh6madJC6xcq4o+IOxRPK5h1NKOf69YleCeaerZCQquGdu7ZUwgLHbyh7CeHWHGZZedyMgIkO6twqOBR5ZpNozZsNPaeZtlivtf+nHHcNTHPsK7pG0jq9BPLWWdAefS4gc4jYtPsw4Jie0xPyMeXKlO5Kaj5kkAd/HtOgfBZDwRON8hIZXsJkb7pQ+6/y0qoWeeYITsDt/mfIkNeVEV32m1FIj6S7dH8g5JF/NuOItJql2x7MFjJnj1IA1jIeFlMrHf/dRWxh1aJRRkx73CqjTvxBGscX+92ISbyxVqcSENJShEIWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746582228; c=relaxed/relaxed;
	bh=y9Yi0r9ZK/5+UwwW0HQooou6AaN4L3BQNIjxgZbMIXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bo79mAV5Jrlt8IiiV1VjQhlz5bsvww5HN31+5OTrmvfG92SxH/pV7pvGxZcY5DizL9rKZqo9KKMSlqtXRKQyXlZYAAxPwXAIVp6mf8SQPqxpRA4m9xzSoKrUlLXOlUlMLfsvTeJlp92etbgWd8lRG43+A9a82xGKEovhbcBEcdpju4n+Y7G1b4kYSM0+C1LARRP+0Jb8kkvWWhusdeTNRIcowpm9uuiD+/TKhIGBhXoLiM78nvPE5FX6gsBaJhdd1gvRsqiOT8rDZjhcdEnb7r4hgQaobExOxTJ7GFjmxb7UwRgQoievQBNn5zwkxnaLaRQTAuLnAQ3JQaZAAK494g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K//IcyDw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K//IcyDw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsdMk2n6dz2yGx
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 11:43:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746582221; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y9Yi0r9ZK/5+UwwW0HQooou6AaN4L3BQNIjxgZbMIXA=;
	b=K//IcyDw5e59FW7WoGHgJXNeHJGfomI3nXHzgkwFL3jHdysz96d3MmG4EcZZDsT6nQIBYTZZ9Rx2G2PmxgEgHKjYgXdSiTnovEZCFcA4OdwCr64POViudez3+++Sq9gR3iSasU4GrDc/j5CYVnM+G5wGC6N/f5oNhAMOGafyoMM=
Received: from 30.221.131.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZhchsg_1746582218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 09:43:38 +0800
Message-ID: <db000560-e185-4ff5-916c-cffd190cb543@linux.alibaba.com>
Date: Wed, 7 May 2025 09:43:38 +0800
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
Subject: Re: [PATCH] erofs: ensure the extra temporary copy is valid for
 shortened bvecs
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250506101850.191506-1-hsiangkao@linux.alibaba.com>
 <d1a4ac64-9e5a-45e2-905a-90f61a3d5d43@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d1a4ac64-9e5a-45e2-905a-90f61a3d5d43@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 09:40, Hongbo Li wrote:
> 
> 
> On 2025/5/6 18:18, Gao Xiang wrote:
>> When compressed data deduplication is enabled, multiple logical extents
>> may reference the same compressed physical cluster.
>>
>> The previous commit 94c43de73521 ("erofs: fix wrong primary bvec
>> selection on deduplicated extents") already avoids using shortened
>> bvecs.  However, in such cases, the extra temporary buffers also
>> need to be preserved for later use in z_erofs_fill_other_copies() to
>> to prevent data corruption.
>>
>> IOWs, extra temporary buffers have to be retained not only due to
>> varying start relative offsets (`pageofs_out`, as indicated by
>> `pcl->multibases`) but also because of shortened bvecs.
>>
>> android.hardware.graphics.composer@2.1.so : 270696 bytes
>>     0:        0..  204185 |  204185 :  628019200.. 628084736 |   65536
>> -> 1:   204185..  225536 |   21351 :  544063488.. 544129024 |   65536
>>     2:   225536..  270696 |   45160 :          0..         0 |       0
>>
>> com.android.vndk.v28.apex : 93814897 bytes
>> ...
>>     364: 53869896..54095257 |  225361 :  543997952.. 544063488 |   65536
>> -> 365: 54095257..54309344 |  214087 :  544063488.. 544129024 |   65536
>>     366: 54309344..54514557 |  205213 :  544129024.. 544194560 |   65536
>> ...
>>
>> Both 204185 and 54095257 have the same start relative offset of 3481,
>> but the logical page 55 of `android.hardware.graphics.composer@2.1.so`
>> ranges from 225280 to 229632, forming a shortened bvec [225280, 225536)
>> that cannot be used for decompressing the range from 54095257 to
>> 54309344 of `com.android.vndk.v28.apex`.
>>
>> Since `pcl->multibases` is already meaningless, just mark `keepxcpy`
>> on demand for simplicity.
>>
>> Again, this issue can only lead to data corruption if `-Ededupe` is on.
>>
>> Fixes: 94c43de73521 ("erofs: fix wrong primary bvec selection on deduplicated extents")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 31 ++++++++++++++-----------------
>>   1 file changed, 14 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 5c061aaeeb45..b8e6b76c23d5 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -79,9 +79,6 @@ struct z_erofs_pcluster {
>>       /* L: whether partial decompression or not */
>>       bool partial;
>> -    /* L: indicate several pageofs_outs or not */
>> -    bool multibases;
>> -
>>       /* L: whether extra buffer allocations are best-effort */
>>       bool besteffort;
>> @@ -1046,8 +1043,6 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
>>                   break;
>>               erofs_onlinefolio_split(folio);
>> -            if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
>> -                f->pcl->multibases = true;
>>               if (f->pcl->length < offset + end - map->m_la) {
>>                   f->pcl->length = offset + end - map->m_la;
>>                   f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
>> @@ -1093,7 +1088,6 @@ struct z_erofs_backend {
>>       struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
>>       struct super_block *sb;
>>       struct z_erofs_pcluster *pcl;
>> -
>>       /* pages with the longest decompressed length for deduplication */
>>       struct page **decompressed_pages;
>>       /* pages to keep the compressed data */
>> @@ -1102,6 +1096,8 @@ struct z_erofs_backend {
>>       struct list_head decompressed_secondary_bvecs;
>>       struct page **pagepool;
>>       unsigned int onstack_used, nr_pages;
>> +    /* indicate if temporary copies should be preserved for later use */
>> +    bool keepxcpy;
>>   };
>>   struct z_erofs_bvec_item {
>> @@ -1112,18 +1108,20 @@ struct z_erofs_bvec_item {
>>   static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
>>                        struct z_erofs_bvec *bvec)
>>   {
>> +    int poff = bvec->offset + be->pcl->pageofs_out;
> 
> Looks good!
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks, and the stress test also passes. Will submit it soon.

Thanks,
Gao Xiang

