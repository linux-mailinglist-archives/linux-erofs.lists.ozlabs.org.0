Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4A322526
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 06:19:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl6n13X0Lz30RG
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 16:19:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8BO77TZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHym78tC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=L8BO77TZ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHym78tC; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl6mz14Bzz30KQ
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 16:19:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614057580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRY4EIG8QWABwtBIFNtzKLvglOXNCK9nv/ZZ50jZYQw=;
 b=L8BO77TZy/i8nHJmO3Iscu2F2EgMDR68osiWYgq7MPlbENyUrxvF+U0kQNmUP6colFj6sE
 a7iFK0pVIvzBOiOdLB7CUQBJTp44vg/A3Quqad3SbRHusfS3T2gj+e7qhbsohTainrwKLs
 fjJxI7FPE33U4Xi4RV+nO+wb8/HdlaU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614057581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRY4EIG8QWABwtBIFNtzKLvglOXNCK9nv/ZZ50jZYQw=;
 b=MHym78tCWuzqx+aHS8qITBoCiCOldDf5VvRUaPN/4Eps5r0tqcTInaNcDCITkWcPg3DsLl
 /PTJrh2dWN58nR2U6uG8AtwWSMy04KkSA/kPs2Y71mCwaFZNsR5YL3kDi+96Yb753mu+TK
 oo7ee8k8u7NDw1s0SF86f2w7tiUplkU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-ss5oKXqAPHKU9Fq2DFak7g-1; Tue, 23 Feb 2021 00:19:37 -0500
X-MC-Unique: ss5oKXqAPHKU9Fq2DFak7g-1
Received: by mail-pj1-f72.google.com with SMTP id 2so1045008pje.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Feb 2021 21:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nRY4EIG8QWABwtBIFNtzKLvglOXNCK9nv/ZZ50jZYQw=;
 b=W/QAUlUe5GIh9sdp8uXpW9N7qHF4ylaFcrOiHo61nqu8SgvL3eZtB5yhQH8K+fUUqA
 XtL7CQCrZG5CRx8nBoQiZTK+fDOfhIQVPl9ceZ8iMjh981emJ3Enfo+KAnQuSsXVfxsg
 767D0IQUxCnF83/yNsf1J71uLHSQQzirEMakPlo2/3HN/bw3blTCyEHa9iPOI92TR1Yt
 4ju15EhoyydmOrn7yrGB2VjWIZ/eUvp2raf6ATnJ0jJLrDezyKLz0kf/GJrG/h/7eXgF
 e0b5Ve9VX4SkwLgvcJ4EsMqyOpBaUX+6zainI/3SjRPvUOUtLpXSY2OvqOgKRc3g9QHz
 2vSg==
X-Gm-Message-State: AOAM530ZobsRXLviVp5IEmNlKdrtssS8BmQdJFwPAI82u1SIW+kQv8KK
 uRsWqjv4AXgljYhv5H7E+6obHkKzRIpsOKS6qIp537q+Wj1goHjdwv/eJSnd/QUbkd1lMb+yNnC
 vUvOoqnc+acjHiYxMq6QhwqJf
X-Received: by 2002:a17:902:c083:b029:e3:ef59:5a15 with SMTP id
 j3-20020a170902c083b02900e3ef595a15mr10198802pld.83.1614057576770; 
 Mon, 22 Feb 2021 21:19:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvvO9RshceS/wXHkdZ4j5fG/eyTXtrflV7OndDWJJLFMiCnAR7r3atl1duV8eWrVt4zjhGpw==
X-Received: by 2002:a17:902:c083:b029:e3:ef59:5a15 with SMTP id
 j3-20020a170902c083b02900e3ef595a15mr10198786pld.83.1614057576508; 
 Mon, 22 Feb 2021 21:19:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f7sm1293346pjh.45.2021.02.22.21.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 21:19:36 -0800 (PST)
Date: Tue, 23 Feb 2021 13:19:26 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs: support adjust lz4 history window size
Message-ID: <20210223051926.GB1225203@xiangao.remote.csb>
References: <20210223043634.36807-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210223043634.36807-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 23, 2021 at 12:36:34PM +0800, Huang Jianan via Linux-erofs wrote:
> From: huangjianan <huangjianan@oppo.com>
> 
> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> using rolling decompression, a block with a higher compression
> ratio will cause a larger memory allocation (up to 64k). It may
> cause a large resource burden in extreme cases on devices with
> small memory and a large number of concurrent IOs. So appropriately
> reducing this value can improve performance.
> 
> Decreasing this value will reduce the compression ratio (except
> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> currently only supports 4k output, reducing this value will not
> significantly reduce the compression benefits.

It'd be better to add some description words here to explain why
old kernels could use such new adjusted images (because we only
decrease the sliding window size, and LZ4_MAX_DISTANCE in principle
is 64kb due to the length limitation of "offset" field for each
lz4 sequence.)

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
> 
> changes since previous version
> - change compr_alg to lz4_max_distance
> - calculate lz4_max_distance_pages when reading super_block
> 
>  fs/erofs/decompressor.c | 12 ++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  3 +++
>  fs/erofs/super.c        |  5 +++++
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..fb2b4f1b8806 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -36,22 +36,26 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>  	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>  					   BITS_PER_LONG)] = { 0 };
> +	unsigned int lz4_max_distance_pages = LZ4_MAX_DISTANCE_PAGES;

How about directly
unsigned int lz4_max_distance_pages = EROFS_SB(rq->sb)->lz4_max_distance_pages
here... (and see below.)

>  	void *kaddr = NULL;
>  	unsigned int i, j, top;
>  
> +	if (EROFS_SB(rq->sb)->lz4_max_distance_pages)
> +		lz4_max_distance_pages = EROFS_SB(rq->sb)->lz4_max_distance_pages;
> +
>  	top = 0;
>  	for (i = j = 0; i < nr; ++i, ++j) {
>  		struct page *const page = rq->out[i];
>  		struct page *victim;
>  
> -		if (j >= LZ4_MAX_DISTANCE_PAGES)
> +		if (j >= lz4_max_distance_pages)
>  			j = 0;
>  
>  		/* 'valid' bounced can only be tested after a complete round */
>  		if (test_bit(j, bounced)) {
> -			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
> -			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
> -			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
> +			DBG_BUGON(i < lz4_max_distance_pages);
> +			DBG_BUGON(top >= lz4_max_distance_pages);
> +			availables[top++] = rq->out[i - lz4_max_distance_pages];
>  		}
>  
>  		if (page) {
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 9ad1615f4474..5eb37002b1a3 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -39,7 +39,8 @@ struct erofs_super_block {
>  	__u8 uuid[16];          /* 128-bit uuid for volume */
>  	__u8 volume_name[16];   /* volume name */
>  	__le32 feature_incompat;
> -	__u8 reserved2[44];
> +	__le16 lz4_max_distance;	/* lz4 max distance */
> +	__u8 reserved2[42];
>  };
>  
>  /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..7457710a763a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -70,6 +70,9 @@ struct erofs_sb_info {
>  
>  	/* pseudo inode to manage cached pages */
>  	struct inode *managed_cache;
> +
> +	/* lz4 max distance pages */
> +	u16 lz4_max_distance_pages;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	u32 blocks;
>  	u32 meta_blkaddr;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d5a6b9b888a5..3a3d235de7cc 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -174,6 +174,11 @@ static int erofs_read_superblock(struct super_block *sb)
>  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
>  	sbi->inos = le64_to_cpu(dsb->inos);
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	if (dsb->lz4_max_distance)
> +		sbi->lz4_max_distance_pages =
> +			DIV_ROUND_UP(le16_to_cpu(dsb->lz4_max_distance), PAGE_SIZE) + 1;
> +#endif

How about adding a new helper e.g. z_erofs_load_lz4_config(sb, dsb)
in decompressor.c, and

int z_erofs_load_lz4_config(sb, dsb)
{
	if (dsb->lz4_max_distance)
		sbi->lz4_max_distance_pages = DIV_ROUND_UP ...
	else
		sbi->lz4_max_distance_pages = LZ4_MAX_DISTANCE_PAGES;
	return 0;
}

Also add a declaration in internal.h:

#ifdef CONFIG_EROFS_FS_ZIP
int z_erofs_load_lz4_config.....
#else
static inline int z_erofs_load_lz4_config() { return 0; }
#endif

Thanks,
Gao Xiang

>  
>  	sbi->build_time = le64_to_cpu(dsb->build_time);
>  	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> -- 
> 2.25.1
> 

