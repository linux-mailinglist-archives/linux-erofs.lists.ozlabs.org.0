Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB1575B6D
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 08:19:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkh6B3MYwz3c4c
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 16:19:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=An8s0dot;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=An8s0dot;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkh634Hfnz3bnH
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 16:19:38 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so10652867pjo.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMVwwltACNc6monef/AHodt8BdNnm+vUW23Zo1dbsV4=;
        b=An8s0dotOcucer5lOaB8bEsBQxHb6V1tNxM+gPNpGVivXCn41Y3QFlr8CHPm8UzEfm
         Ob0mT7Ec4xc5KCgdk+VvzSas475PzPLW+ElthlYuSjRxlSVEArSd8vGkqMPBl3YTJUcD
         HDXai127x3c5O5g7Ex7tNzG17kfFfoKXwP3/4RLWvYL2WeEr1MXG0WHM406CE+gR0HRp
         II3mAd0TyvfLyfrg9ryEPjUMZb+UcWti+uSNnIFYaJsG4DrpM4Fs9Zb5ou53Uw29vU0I
         fFMCoqtRPTbGRDoiz0UOgFoUQLZo88V8Iau5mWuSUTfYev0lS1romqXvxYgZCW4pJ3Wk
         UJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMVwwltACNc6monef/AHodt8BdNnm+vUW23Zo1dbsV4=;
        b=6IROBFO6xTD65UmjrIzgWZNQvFii7MJ2E/lIV63M/P6Xysyc54ukowFxiZQrS7gTak
         FF/Rb+apNdpTgHnh8162WQFcZZ7L+z1IIB55IDkiSrt4QYXl1mQmbIMh8OSubf0531ly
         hBAlcgcVElHTX2YWUgquJ6hugXXHe1Z7I0m2LkWfvgWZ4RIYP372/DLLUdEGb8OYxttC
         G4mTNKHKF1ihI7VS6iXetd4qn4yHHxireTl9gFDPBj24UMIp0Gp/NqJIzKrG8IPx2AE6
         8eSq40buxAeeAqFOti+If6OZ3HM5hMF9mQY3pBslxLTQEkglH/C+rmq76s4tfKEwqP+/
         YPfg==
X-Gm-Message-State: AJIora9k3hnsUbZKuT0ly0ZOnpJ1jfxOQ0Fu3O8IsoQt0eLMLOYC6Pp9
	OWFzw+U9TCi7PmG9oWEk1m0=
X-Google-Smtp-Source: AGRyM1trRcOnQ7lQ+XriIfbnO1jIeaPRUywUIOOPYh2v5ddznNGOPTpJHvBXKzG5GwIjDsujiFWC5w==
X-Received: by 2002:a17:902:d50a:b0:16c:3c08:3637 with SMTP id b10-20020a170902d50a00b0016c3c083637mr12735767plg.137.1657865976459;
        Thu, 14 Jul 2022 23:19:36 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id oj4-20020a17090b4d8400b001ef8fb72224sm4765610pjb.53.2022.07.14.23.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:19:36 -0700 (PDT)
Date: Fri, 15 Jul 2022 14:20:58 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 01/16] erofs: get rid of unneeded `inode', `map' and
 `sb'
Message-ID: <20220715142058.00005f60.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-2-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 14 Jul 2022 21:20:36 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Since commit 5c6dcc57e2e5 ("erofs: get rid of
> `struct z_erofs_collector'"), these arguments can be dropped as well.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 724bb57075f6..1b6816dd235f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -404,10 +404,9 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
>  	f->mode = COLLECT_PRIMARY;
>  }
>  
> -static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
> -				   struct inode *inode,
> -				   struct erofs_map_blocks *map)
> +static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	struct z_erofs_pcluster *pcl = fe->pcl;
>  	unsigned int length;
>  
> @@ -449,10 +448,9 @@ static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
>  	return 0;
>  }
>  
> -static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
> -				     struct inode *inode,
> -				     struct erofs_map_blocks *map)
> +static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	bool ztailpacking = map->m_flags & EROFS_MAP_META;
>  	struct z_erofs_pcluster *pcl;
>  	struct erofs_workgroup *grp;
> @@ -494,7 +492,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
>  	} else {
>  		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
>  
> -		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> +		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>  		if (IS_ERR(grp)) {
>  			err = PTR_ERR(grp);
>  			goto err_out;
> @@ -520,10 +518,9 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
>  	return err;
>  }
>  
> -static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
> -				   struct inode *inode,
> -				   struct erofs_map_blocks *map)
> +static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	struct erofs_workgroup *grp;
>  	int ret;
>  
> @@ -541,19 +538,19 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
>  		goto tailpacking;
>  	}
>  
> -	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
> +	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
>  		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
>  	} else {
>  tailpacking:
> -		ret = z_erofs_register_pcluster(fe, inode, map);
> +		ret = z_erofs_register_pcluster(fe);
>  		if (!ret)
>  			goto out;
>  		if (ret != -EEXIST)
>  			return ret;
>  	}
>  
> -	ret = z_erofs_lookup_pcluster(fe, inode, map);
> +	ret = z_erofs_lookup_pcluster(fe);
>  	if (ret) {
>  		erofs_workgroup_put(&fe->pcl->obj);
>  		return ret;
> @@ -663,7 +660,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	if (!(map->m_flags & EROFS_MAP_MAPPED))
>  		goto hitted;
>  
> -	err = z_erofs_collector_begin(fe, inode, map);
> +	err = z_erofs_collector_begin(fe);
>  	if (err)
>  		goto err_out;
>  
> @@ -1259,13 +1256,13 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -static void z_erofs_submit_queue(struct super_block *sb,
> -				 struct z_erofs_decompress_frontend *f,
> +static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  				 struct page **pagepool,
>  				 struct z_erofs_decompressqueue *fgq,
>  				 bool *force_fg)
>  {
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> +	struct super_block *sb = f->inode->i_sb;
> +	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
>  	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
>  	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
>  	void *bi_private;
> @@ -1317,7 +1314,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  			struct page *page;
>  
>  			page = pickup_page_for_submission(pcl, i++, pagepool,
> -							  MNGD_MAPPING(sbi));
> +							  mc);
>  			if (!page)
>  				continue;
>  
> @@ -1369,15 +1366,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
>  }
>  
> -static void z_erofs_runqueue(struct super_block *sb,
> -			     struct z_erofs_decompress_frontend *f,
> +static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
>  			     struct page **pagepool, bool force_fg)
>  {
>  	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
>  
>  	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
>  		return;
> -	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
> +	z_erofs_submit_queue(f, pagepool, io, &force_fg);
>  
>  	/* handle bypass queue (no i/o pclusters) immediately */
>  	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
> @@ -1475,7 +1471,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>  	(void)z_erofs_collector_end(&f);
>  
>  	/* if some compressed cluster ready, need submit them anyway */
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> +	z_erofs_runqueue(&f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, 0));
>  
>  	if (err)
> @@ -1524,7 +1520,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
>  	(void)z_erofs_collector_end(&f);
>  
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> +	z_erofs_runqueue(&f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
>  	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&pagepool);

Reviewed-by: Yue Hu <huyue2@coolpad.com>
