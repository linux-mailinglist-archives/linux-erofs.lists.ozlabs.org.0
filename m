Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DF32E263
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 07:41:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsJ6r4wD5z30L1
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 17:41:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BhxqAPhJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/dRU5ds;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BhxqAPhJ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/dRU5ds; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsJ6p0F9Sz2ysv
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 17:41:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614926492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JnmAd/cAWPZB1mz8gyad2diGqBlDPO14Y3hGtx+7soo=;
 b=BhxqAPhJarDXk91g2/lhVgXTo6fwf5oSjSuocSbDPC41opYc0MmhkTyEbjfqNU+KNDIXCD
 N0vH4uOseBYKhDao8OctQWSf8nKm+YyTURJLQJlIl0P9mDGZGMELR9RptCgFOQVpUGgU22
 qGuoCb5bY8hYPObU0MtHBzktTWR/2Fc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614926493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JnmAd/cAWPZB1mz8gyad2diGqBlDPO14Y3hGtx+7soo=;
 b=N/dRU5dsYyx/uj/QilC4KBNZ6QNl/Rs+G2VXdkauaof3C1k2EnE91Jn/9VXyaIqFGnUkO4
 Pc+EtRzrtt78eoiBM+mbwxg13Zgke0czp6pI4BD/UaxeaA4xLtCKAU4b3+04DHLABD3RjQ
 X3ZyrERGc8VrwmRjUKwpfHixECwn7j8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ebWATVGBOz-48WH2GNcCbg-1; Fri, 05 Mar 2021 01:41:29 -0500
X-MC-Unique: ebWATVGBOz-48WH2GNcCbg-1
Received: by mail-pf1-f199.google.com with SMTP id z5so733234pfz.19
 for <linux-erofs@lists.ozlabs.org>; Thu, 04 Mar 2021 22:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JnmAd/cAWPZB1mz8gyad2diGqBlDPO14Y3hGtx+7soo=;
 b=U7+9xXwomn5NYQfgNkhSFGNMXuew3D+qy2hPHCxTPzEfpxXrmitPYajrBxtY35V1hL
 8hJEAt2OQd1riCRsNzstR8yxj/VX+SvvhmuPXwE7l2DbmcmFI1JybbBnZZCSpeKAC6wR
 pTeEgfBi5ew0bxGQn7qoy04xVyKZBLDqwWatTQ8DeBmeaBuocgn8wxP7t09j9j3FB2pz
 E1OS8rsEy4nCSklUl0BynjMmmyAHz+g5kYYFAjFGVhBdCNyE1VLBoxjU3ZheX5GSWP+1
 PqF1bcXsmIRBQzZG86iWwEuGP879SQYSbiHpcQjoP0xB2iiWS+DQfgs2qyUDamvX1rjU
 9X7g==
X-Gm-Message-State: AOAM5333PZr25HVky48i2PImwD1h5faOe20oerG9jVcJcSBhNsHmguBt
 MD3wt/CZuEis9pLRgMAGPuKin7rJawm/DSOSa8Jsjm+bCqipo0XSi3BrXzYSwY4MLwxv1YnV8hM
 U2oq/ixc1dJTxLfh7lF4djPkE
X-Received: by 2002:a65:6209:: with SMTP id d9mr6740462pgv.206.1614926488627; 
 Thu, 04 Mar 2021 22:41:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC7frt3RFKJdsozBuny+luFPIDt4luub4tK+4JtOYyAspsCezfpvpM0F+OfJ9Kwgx/Xz3Gaw==
X-Received: by 2002:a65:6209:: with SMTP id d9mr6740443pgv.206.1614926488308; 
 Thu, 04 Mar 2021 22:41:28 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 144sm1279435pgd.83.2021.03.04.22.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 22:41:28 -0800 (PST)
Date: Fri, 5 Mar 2021 14:41:17 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH 2/2] erofs: decompress in endio if possible
Message-ID: <20210305064117.GA3093390@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305062219.557128-2-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210305062219.557128-2-huangjianan@oppo.com>
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

On Fri, Mar 05, 2021 at 02:22:19PM +0800, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the interrupt
> context, for example, when dm-verity is turned on. In this scenario,
> io should be decompressed directly to avoid additional scheduling
> overhead. Also there is no need to wait for endio to execute
> synchronous decompression.

z_erofs_decompressqueue_endio may not be executed in the atomic
context, for example, when dm-verity is turned on. In this scenario,
data can be decompressed directly to get rid of additional kworker
scheduling overhead. Also, it makes no sense to apply synchronous
decompression for such case.

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/internal.h |   3 ++
>  fs/erofs/super.c    |   1 +
>  fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++--------------------
>  3 files changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 77965490dced..a19bcbb681fc 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -71,6 +71,9 @@ struct erofs_sb_info {
>  	/* pseudo inode to manage cached pages */
>  	struct inode *managed_cache;
>  
> +	/* decide whether to decompress synchronously */
> +	bool sync_decompress;

bool readahead_sync_decompress;

> +
>  	/* # of pages needed for EROFS lz4 rolling decompression */
>  	u16 lz4_max_distance_pages;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 37f1cc9d28cc..5b9a21d10a30 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -188,6 +188,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	sbi->sync_decompress = false;

Ah, could you rebase the patch on the top of 5.12-rc1
rather than dev-test? since I've fold your
"erofs: support adjust lz4 history window size"
into a new patchset, see:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/compr_cfgs

>  	/* parse on-disk compression configurations */
>  	z_erofs_load_lz4_config(sbi, dsb);
>  	ret = 0;
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6cb356c4217b..727dd01f55c1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -706,56 +706,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	goto out;
>  }
>  
> -static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> -				       bool sync, int bios)
> -{
> -	/* wake up the caller thread for sync decompression */
> -	if (sync) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&io->u.wait.lock, flags);
> -		if (!atomic_add_return(bios, &io->pending_bios))
> -			wake_up_locked(&io->u.wait);
> -		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> -		return;
> -	}
> -
> -	if (!atomic_add_return(bios, &io->pending_bios))
> -		queue_work(z_erofs_workqueue, &io->u.work);
> -}

Is it necessary to move the code snippet?

> -
>  static bool z_erofs_page_is_invalidated(struct page *page)
>  {
>  	return !page->mapping && !z_erofs_is_shortlived_page(page);
>  }
>  
> -static void z_erofs_decompressqueue_endio(struct bio *bio)
> -{
> -	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> -	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> -	blk_status_t err = bio->bi_status;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> -
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -
> -		DBG_BUGON(PageUptodate(page));
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (err)
> -			SetPageError(page);
> -
> -		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> -			if (!err)
> -				SetPageUptodate(page);
> -			unlock_page(page);
> -		}
> -	}
> -	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> -	bio_put(bio);
> -}
> -
>  static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct z_erofs_pcluster *pcl,
>  				       struct list_head *pagepool)
> @@ -991,6 +946,60 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
>  	kvfree(bgq);
>  }
>  
> +static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> +				       bool sync, int bios)
> +{
> +	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> +
> +	/* wake up the caller thread for sync decompression */
> +	if (sync) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&io->u.wait.lock, flags);
> +		if (!atomic_add_return(bios, &io->pending_bios))
> +			wake_up_locked(&io->u.wait);
> +		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> +		return;
> +	}
> +
> +	if (!atomic_add_return(bios, &io->pending_bios)) {
> +		if (in_atomic() || irqs_disabled()) {
> +			queue_work(z_erofs_workqueue, &io->u.work);
> +			if (unlikely(!sbi->sync_decompress))
> +				sbi->sync_decompress = true;
> +		}
> +		else
> +			z_erofs_decompressqueue_work(&io->u.work);

Nit: coding style:

if () {
	...
} else {	this arm is needed.
	...
}

> +	}
> +}
> +
> +static void z_erofs_decompressqueue_endio(struct bio *bio)
> +{
> +	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> +	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> +	blk_status_t err = bio->bi_status;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +
> +		DBG_BUGON(PageUptodate(page));
> +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> +
> +		if (err)
> +			SetPageError(page);
> +
> +		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> +			if (!err)
> +				SetPageUptodate(page);
> +			unlock_page(page);
> +		}
> +	}
> +	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> +	bio_put(bio);
> +}
> +
>  static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  					       unsigned int nr,
>  					       struct list_head *pagepool,
> @@ -1333,7 +1342,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>  
>  	unsigned int nr_pages = readahead_count(rac);
> -	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
> +	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages) &
> +			sbi->sync_decompress;

it would be better written as:

bool sync = (sbi->readahead_sync_decompress &&
	     nr_pages <= sbi->ctx.max_sync_decompress_pages);

Thanks,
Gao Xiang

>  	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>  	struct page *page, *head = NULL;
>  	LIST_HEAD(pagepool);
> -- 
> 2.25.1
> 

