Return-Path: <linux-erofs+bounces-285-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6981AAD2DC
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 03:40:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsdJ76bKkz2ySf;
	Wed,  7 May 2025 11:40:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746582039;
	cv=none; b=cXptEAqBk2sF3LRcsbgrBYZNb5YB33hoKmBFpBkhV9Rdaxuu6fFuQxO2ffqwlUwbcQQvO8Vk43URLDxGwsSFjn/Mabc5ZvpdeuH4xMIMm46uzCKrq8bBX6s1GwV0WtlQPSlRUknKPOsKDi6pbsfTbhOIAhAwyE6L4/1XLV56ZQflT1T2pYTZ8eTppoAo+x6e6JxNSCjCKM/jpRvYtd74vRLr8uRAF952AN+doTCQWvWiTM8MMy38ILFKW9nMC0AoI6gkuchodLgwXLo/STHvmdQ3iUlhg5y0jsLBM+3+GZXofD5oDA8LBXJk+mpd6htyaE4PvPdy5fbAjg1l63/TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746582039; c=relaxed/relaxed;
	bh=O+R0KlOisFBTejt7ZBC39VF9n5NKSPoLxkKpujzhwxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EsrC/xTjCOqoWLCb+KTWcxy0JVl63r0omFcMiY3fu35JsN0dlssdZh92c1DOY9gjP6D7Z8lcIuFxgQ+MsoWaYevcN2UFuAct/fddq25q6BXquMm4r0plgZ0pjjAj5jfOOasLZlWbsd9bCxUC79clAjD6k/5Wic/FURf9iC1o2aaeGHIT0jJr5gBAN1BB+M9jZz1v/cVe6DtmfmE4EgE4aKoYvMKKviXX0wOq76o5ZfWqVUm8LKvuNTyWZ9zh0m2gzTVMV8/bgpSqJ+s8ZV4Tzwevnnov8S9DbOQuQcMQ33+7Q770YFRjxfZf6SXGKD8Iv7Bc/w4p3bnucRIKsx7NXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsdJ62tNkz2yGx
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 11:40:36 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZsdFZ1gvhz1R7Xb
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 09:38:26 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A4691A0190
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 09:40:32 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 09:40:31 +0800
Message-ID: <d1a4ac64-9e5a-45e2-905a-90f61a3d5d43@huawei.com>
Date: Wed, 7 May 2025 09:40:30 +0800
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
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250506101850.191506-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250506101850.191506-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/6 18:18, Gao Xiang wrote:
> When compressed data deduplication is enabled, multiple logical extents
> may reference the same compressed physical cluster.
> 
> The previous commit 94c43de73521 ("erofs: fix wrong primary bvec
> selection on deduplicated extents") already avoids using shortened
> bvecs.  However, in such cases, the extra temporary buffers also
> need to be preserved for later use in z_erofs_fill_other_copies() to
> to prevent data corruption.
> 
> IOWs, extra temporary buffers have to be retained not only due to
> varying start relative offsets (`pageofs_out`, as indicated by
> `pcl->multibases`) but also because of shortened bvecs.
> 
> android.hardware.graphics.composer@2.1.so : 270696 bytes
>     0:        0..  204185 |  204185 :  628019200.. 628084736 |   65536
> -> 1:   204185..  225536 |   21351 :  544063488.. 544129024 |   65536
>     2:   225536..  270696 |   45160 :          0..         0 |       0
> 
> com.android.vndk.v28.apex : 93814897 bytes
> ...
>     364: 53869896..54095257 |  225361 :  543997952.. 544063488 |   65536
> -> 365: 54095257..54309344 |  214087 :  544063488.. 544129024 |   65536
>     366: 54309344..54514557 |  205213 :  544129024.. 544194560 |   65536
> ...
> 
> Both 204185 and 54095257 have the same start relative offset of 3481,
> but the logical page 55 of `android.hardware.graphics.composer@2.1.so`
> ranges from 225280 to 229632, forming a shortened bvec [225280, 225536)
> that cannot be used for decompressing the range from 54095257 to
> 54309344 of `com.android.vndk.v28.apex`.
> 
> Since `pcl->multibases` is already meaningless, just mark `keepxcpy`
> on demand for simplicity.
> 
> Again, this issue can only lead to data corruption if `-Ededupe` is on.
> 
> Fixes: 94c43de73521 ("erofs: fix wrong primary bvec selection on deduplicated extents")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zdata.c | 31 ++++++++++++++-----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5c061aaeeb45..b8e6b76c23d5 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -79,9 +79,6 @@ struct z_erofs_pcluster {
>   	/* L: whether partial decompression or not */
>   	bool partial;
>   
> -	/* L: indicate several pageofs_outs or not */
> -	bool multibases;
> -
>   	/* L: whether extra buffer allocations are best-effort */
>   	bool besteffort;
>   
> @@ -1046,8 +1043,6 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
>   				break;
>   
>   			erofs_onlinefolio_split(folio);
> -			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
> -				f->pcl->multibases = true;
>   			if (f->pcl->length < offset + end - map->m_la) {
>   				f->pcl->length = offset + end - map->m_la;
>   				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
> @@ -1093,7 +1088,6 @@ struct z_erofs_backend {
>   	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
>   	struct super_block *sb;
>   	struct z_erofs_pcluster *pcl;
> -
>   	/* pages with the longest decompressed length for deduplication */
>   	struct page **decompressed_pages;
>   	/* pages to keep the compressed data */
> @@ -1102,6 +1096,8 @@ struct z_erofs_backend {
>   	struct list_head decompressed_secondary_bvecs;
>   	struct page **pagepool;
>   	unsigned int onstack_used, nr_pages;
> +	/* indicate if temporary copies should be preserved for later use */
> +	bool keepxcpy;
>   };
>   
>   struct z_erofs_bvec_item {
> @@ -1112,18 +1108,20 @@ struct z_erofs_bvec_item {
>   static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
>   					 struct z_erofs_bvec *bvec)
>   {
> +	int poff = bvec->offset + be->pcl->pageofs_out;

Looks good!

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

>   	struct z_erofs_bvec_item *item;
> -	unsigned int pgnr;
> -
> -	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
> -	    (bvec->end == PAGE_SIZE ||
> -	     bvec->offset + bvec->end == be->pcl->length)) {
> -		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
> -		DBG_BUGON(pgnr >= be->nr_pages);
> -		if (!be->decompressed_pages[pgnr]) {
> -			be->decompressed_pages[pgnr] = bvec->page;
> +	struct page **page;
> +
> +	if (!(poff & ~PAGE_MASK) && (bvec->end == PAGE_SIZE ||
> +			bvec->offset + bvec->end == be->pcl->length)) {
> +		DBG_BUGON((poff >> PAGE_SHIFT) >= be->nr_pages);
> +		page = be->decompressed_pages + (poff >> PAGE_SHIFT);
> +		if (!*page) {
> +			*page = bvec->page;
>   			return;
>   		}
> +	} else {
> +		be->keepxcpy = true;
>   	}
>   
>   	/* (cold path) one pcluster is requested multiple times */
> @@ -1289,7 +1287,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
>   					.alg = pcl->algorithmformat,
>   					.inplace_io = overlapped,
>   					.partial_decoding = pcl->partial,
> -					.fillgaps = pcl->multibases,
> +					.fillgaps = be->keepxcpy,
>   					.gfp = pcl->besteffort ? GFP_KERNEL :
>   						GFP_NOWAIT | __GFP_NORETRY
>   				 }, be->pagepool);
> @@ -1346,7 +1344,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
>   
>   	pcl->length = 0;
>   	pcl->partial = true;
> -	pcl->multibases = false;
>   	pcl->besteffort = false;
>   	pcl->bvset.nextpage = NULL;
>   	pcl->vcnt = 0;

