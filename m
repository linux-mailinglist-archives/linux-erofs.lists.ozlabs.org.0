Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A454480FDD
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 06:22:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JP0Cl612wz3056
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 16:22:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fvjTzUkN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=fvjTzUkN; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JP0Cd30qsz2ymc
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Dec 2021 16:22:35 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id co15so17637047pjb.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 21:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4C/ZfoHso9zU9dv9Ot9SBewHCwTKutD8VZUD2f8hOE=;
 b=fvjTzUkNpkTBhj7EHepSnt/5sJ17B94RRrFcAsWeL4z8mxa4J5QbTX2V6hmGrMauAG
 cbuDLKhXgq+rVdioPLSPYZ/7DAT+c3DNp+TDMwmzX2XqVAvNwG3CxaHX2ML+dpPkEi5o
 yOH0mxsjSKw/2zIFjMeRVV0hCmcrZY90uozhE9J4yUYcSgqlSecIRC0RY8HRaJ6TIYe8
 yzL3ZsX1h5nH6R83v276ph9TKnxOQ3JboP8EsLhJAAtscepKLNqikyGMx4tLA1haLElD
 Q38nZcTwnjVN/GTZWwfyJ7kdF/Ml35wMW5c4gylKvbuwn7XsIlJiEms4wSd9URsF7EPQ
 7laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4C/ZfoHso9zU9dv9Ot9SBewHCwTKutD8VZUD2f8hOE=;
 b=nntGMmYhSlnJYwaZnXTkeSLeicefMhbAQK7TpS6aRLhZvFPfkTRPQAzJUX8OntfHwt
 Zw0Yamu4jGblo6pcwXMUzRKJJQs52oy8TWfLCB8s165t+JDlx5SjwZSJaZBYKDAZ9qmw
 wTNkElRrL8NilikO44Sny7Htfl8vg3MybP2/MnAyauTPrvTgz4Pmlha1KmwSF+pb9sQp
 IZjIyaZmOb9HIozWfn8GEykmw4BcfTBLkIR7JuOxt7Z28BHWwQNh/QadvCx2D/JPTPkc
 mA68/LxPFgA5fG1RJJp1mzVin4JrqYdb390WRNjGLLj5GdZbVclaGe9aR1wAKH+N1eWs
 BegA==
X-Gm-Message-State: AOAM5301h5x0Sb/udN8aW2yS7T0On4/u6ftRCBjb/DJV+JSE1LEn9tng
 X4MH0hT3MZ5bjCqitM+vNOI=
X-Google-Smtp-Source: ABdhPJz4+gFiblWfiQXuvJkek3yUXw9MAUr1r6IySB+Cm6ZkFaV62EUgNYzAKvk8m8tawtEtefMgIA==
X-Received: by 2002:a17:902:d2d1:b0:149:7d85:745f with SMTP id
 n17-20020a170902d2d100b001497d85745fmr13126018plc.55.1640755352174; 
 Tue, 28 Dec 2021 21:22:32 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id g5sm23899849pfj.143.2021.12.28.21.22.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 28 Dec 2021 21:22:31 -0800 (PST)
Date: Wed, 29 Dec 2021 13:19:46 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 5/5] erofs: use meta buffers for zmap operations
Message-ID: <20211229131946.000043c5.zbestahu@gmail.com>
In-Reply-To: <20211229041405.45921-6-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
 <20211229041405.45921-6-hsiangkao@linux.alibaba.com>
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
Cc: geshifei@coolpad.com, LKML <linux-kernel@vger.kernel.org>,
 zhangwen@coolpad.com, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 29 Dec 2021 12:14:05 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Get rid of old erofs_get_meta_page() within zmap operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Finally, erofs_get_meta_page() is useless. Get rid of it!
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 13 -----------
>  fs/erofs/internal.h |  6 ++---
>  fs/erofs/zdata.c    | 23 ++++++++-----------
>  fs/erofs/zmap.c     | 56 +++++++++++++--------------------------------
>  4 files changed, 28 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6495e16a50a9..187f19f8a9a1 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -9,19 +9,6 @@
>  #include <linux/dax.h>
>  #include <trace/events/erofs.h>
>  
> -struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
> -{
> -	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
> -	struct page *page;
> -
> -	page = read_cache_page_gfp(mapping, blkaddr,
> -				   mapping_gfp_constraint(mapping, ~__GFP_FS));
> -	/* should already be PageUptodate */
> -	if (!IS_ERR(page))
> -		lock_page(page);
> -	return page;
> -}
> -
>  void erofs_unmap_metabuf(struct erofs_buf *buf)
>  {
>  	if (buf->kmap_type == EROFS_KMAP)
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f1e4eb3025f6..3db494a398b2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -419,14 +419,14 @@ enum {
>  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
>  
>  struct erofs_map_blocks {
> +	struct erofs_buf buf;
> +
>  	erofs_off_t m_pa, m_la;
>  	u64 m_plen, m_llen;
>  
>  	unsigned short m_deviceid;
>  	char m_algorithmformat;
>  	unsigned int m_flags;
> -
> -	struct page *mpage;
>  };
>  
>  /* Flags used by erofs_map_blocks_flatmode() */
> @@ -474,7 +474,7 @@ struct erofs_map_dev {
>  
>  /* data.c */
>  extern const struct file_operations erofs_file_fops;
> -struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
> +void erofs_unmap_metabuf(struct erofs_buf *buf);
>  void erofs_put_metabuf(struct erofs_buf *buf);
>  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 49da3931b2e3..498b7666efe8 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -698,20 +698,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		goto err_out;
>  
>  	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> -		struct page *mpage;
> +		void *mp;
>  
> -		mpage = erofs_get_meta_page(inode->i_sb,
> -					    erofs_blknr(map->m_pa));
> -		if (IS_ERR(mpage)) {
> -			err = PTR_ERR(mpage);
> +		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> +					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
> +		if (IS_ERR(mp)) {
> +			err = PTR_ERR(mp);
>  			erofs_err(inode->i_sb,
>  				  "failed to get inline page, err %d", err);
>  			goto err_out;
>  		}
> -		/* TODO: new subpage feature will get rid of it */
> -		unlock_page(mpage);
> -
> -		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> +		get_page(fe->map.buf.page);
> +		WRITE_ONCE(clt->pcl->compressed_pages[0], fe->map.buf.page);
>  		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  	} else {
>  		/* preload all compressed pages (can change mode if needed) */
> @@ -1529,9 +1527,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
>  	if (err)
>  		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
>  
> -	if (f.map.mpage)
> -		put_page(f.map.mpage);
> -
> +	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&pagepool);
>  	return err;
>  }
> @@ -1576,8 +1572,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  
>  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
> -	if (f.map.mpage)
> -		put_page(f.map.mpage);
> +	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&pagepool);
>  }
>  
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 1037ac17b7a6..18d7fd1a5064 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -35,7 +35,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  	struct super_block *const sb = inode->i_sb;
>  	int err, headnr;
>  	erofs_off_t pos;
> -	struct page *page;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	void *kaddr;
>  	struct z_erofs_map_header *h;
>  
> @@ -61,14 +61,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  
>  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
>  		    vi->xattr_isize, 8);
> -	page = erofs_get_meta_page(sb, erofs_blknr(pos));
> -	if (IS_ERR(page)) {
> -		err = PTR_ERR(page);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> +				   EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(kaddr)) {
> +		err = PTR_ERR(kaddr);
>  		goto out_unlock;
>  	}
>  
> -	kaddr = kmap_atomic(page);
> -
>  	h = kaddr + erofs_blkoff(pos);
>  	vi->z_advise = le16_to_cpu(h->h_advise);
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> @@ -101,20 +100,19 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		goto unmap_done;
>  	}
>  unmap_done:
> -	kunmap_atomic(kaddr);
> -	unlock_page(page);
> -	put_page(page);
> +	erofs_put_metabuf(&buf);
>  	if (err)
>  		goto out_unlock;
>  
>  	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> -		struct erofs_map_blocks map = { .mpage = NULL };
> +		struct erofs_map_blocks map = {
> +			.buf = __EROFS_BUF_INITIALIZER
> +		};
>  
>  		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
>  		err = z_erofs_do_map_blocks(inode, &map,
>  					    EROFS_GET_BLOCKS_FINDTAIL);
> -		if (map.mpage)
> -			put_page(map.mpage);
> +		erofs_put_metabuf(&map.buf);
>  
>  		if (!map.m_plen ||
>  		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> @@ -151,31 +149,11 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
>  				  erofs_blk_t eblk)
>  {
>  	struct super_block *const sb = m->inode->i_sb;
> -	struct erofs_map_blocks *const map = m->map;
> -	struct page *mpage = map->mpage;
> -
> -	if (mpage) {
> -		if (mpage->index == eblk) {
> -			if (!m->kaddr)
> -				m->kaddr = kmap_atomic(mpage);
> -			return 0;
> -		}
>  
> -		if (m->kaddr) {
> -			kunmap_atomic(m->kaddr);
> -			m->kaddr = NULL;
> -		}
> -		put_page(mpage);
> -	}
> -
> -	mpage = erofs_get_meta_page(sb, eblk);
> -	if (IS_ERR(mpage)) {
> -		map->mpage = NULL;
> -		return PTR_ERR(mpage);
> -	}
> -	m->kaddr = kmap_atomic(mpage);
> -	unlock_page(mpage);
> -	map->mpage = mpage;
> +	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
> +				      EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(m->kaddr))
> +		return PTR_ERR(m->kaddr);
>  	return 0;
>  }

remove z_erofs_reload_indexes() and use erofs_read_metabuf() directly in caller?

>  
> @@ -711,8 +689,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  			map->m_flags |= EROFS_MAP_FULL_MAPPED;
>  	}
>  unmap_out:
> -	if (m.kaddr)
> -		kunmap_atomic(m.kaddr);
> +	erofs_unmap_metabuf(&m.map->buf);
>  
>  out:
>  	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
> @@ -759,8 +736,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
>  	struct erofs_map_blocks map = { .m_la = offset };
>  
>  	ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
> -	if (map.mpage)
> -		put_page(map.mpage);
> +	erofs_put_metabuf(&map.buf);
>  	if (ret < 0)
>  		return ret;
>  

Reviewed-by: Yue Hu <huyue2@yulong.com>

