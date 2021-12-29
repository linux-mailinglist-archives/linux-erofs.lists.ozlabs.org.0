Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AFE48100F
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 06:34:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JP0Sv5TSGz3056
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 16:34:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JP0Sn6vt2z2xRn
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Dec 2021 16:34:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0V0BiBqT_1640755682; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0BiBqT_1640755682) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 29 Dec 2021 13:28:04 +0800
Date: Wed, 29 Dec 2021 13:28:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH 5/5] erofs: use meta buffers for zmap operations
Message-ID: <Ycvx4ogrZLkO7Q62@B-P7TQMD6M-0146.local>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
 <20211229041405.45921-6-hsiangkao@linux.alibaba.com>
 <20211229131946.000043c5.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211229131946.000043c5.zbestahu@gmail.com>
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

Hi Yue,

On Wed, Dec 29, 2021 at 01:19:46PM +0800, Yue Hu wrote:
> On Wed, 29 Dec 2021 12:14:05 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Get rid of old erofs_get_meta_page() within zmap operations by
> > using on-stack meta buffers in order to prepare subpage and folio
> > features.
> > 
> > Finally, erofs_get_meta_page() is useless. Get rid of it!
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/data.c     | 13 -----------
> >  fs/erofs/internal.h |  6 ++---
> >  fs/erofs/zdata.c    | 23 ++++++++-----------
> >  fs/erofs/zmap.c     | 56 +++++++++++++--------------------------------
> >  4 files changed, 28 insertions(+), 70 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 6495e16a50a9..187f19f8a9a1 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -9,19 +9,6 @@
> >  #include <linux/dax.h>
> >  #include <trace/events/erofs.h>
> >  
> > -struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
> > -{
> > -	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
> > -	struct page *page;
> > -
> > -	page = read_cache_page_gfp(mapping, blkaddr,
> > -				   mapping_gfp_constraint(mapping, ~__GFP_FS));
> > -	/* should already be PageUptodate */
> > -	if (!IS_ERR(page))
> > -		lock_page(page);
> > -	return page;
> > -}
> > -
> >  void erofs_unmap_metabuf(struct erofs_buf *buf)
> >  {
> >  	if (buf->kmap_type == EROFS_KMAP)
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index f1e4eb3025f6..3db494a398b2 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -419,14 +419,14 @@ enum {
> >  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
> >  
> >  struct erofs_map_blocks {
> > +	struct erofs_buf buf;
> > +
> >  	erofs_off_t m_pa, m_la;
> >  	u64 m_plen, m_llen;
> >  
> >  	unsigned short m_deviceid;
> >  	char m_algorithmformat;
> >  	unsigned int m_flags;
> > -
> > -	struct page *mpage;
> >  };
> >  
> >  /* Flags used by erofs_map_blocks_flatmode() */
> > @@ -474,7 +474,7 @@ struct erofs_map_dev {
> >  
> >  /* data.c */
> >  extern const struct file_operations erofs_file_fops;
> > -struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
> > +void erofs_unmap_metabuf(struct erofs_buf *buf);
> >  void erofs_put_metabuf(struct erofs_buf *buf);
> >  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> >  			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 49da3931b2e3..498b7666efe8 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -698,20 +698,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >  		goto err_out;
> >  
> >  	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> > -		struct page *mpage;
> > +		void *mp;
> >  
> > -		mpage = erofs_get_meta_page(inode->i_sb,
> > -					    erofs_blknr(map->m_pa));
> > -		if (IS_ERR(mpage)) {
> > -			err = PTR_ERR(mpage);
> > +		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> > +					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
> > +		if (IS_ERR(mp)) {
> > +			err = PTR_ERR(mp);
> >  			erofs_err(inode->i_sb,
> >  				  "failed to get inline page, err %d", err);
> >  			goto err_out;
> >  		}
> > -		/* TODO: new subpage feature will get rid of it */
> > -		unlock_page(mpage);
> > -
> > -		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> > +		get_page(fe->map.buf.page);
> > +		WRITE_ONCE(clt->pcl->compressed_pages[0], fe->map.buf.page);
> >  		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> >  	} else {
> >  		/* preload all compressed pages (can change mode if needed) */
> > @@ -1529,9 +1527,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
> >  	if (err)
> >  		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
> >  
> > -	if (f.map.mpage)
> > -		put_page(f.map.mpage);
> > -
> > +	erofs_put_metabuf(&f.map.buf);
> >  	erofs_release_pages(&pagepool);
> >  	return err;
> >  }
> > @@ -1576,8 +1572,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
> >  
> >  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> >  			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
> > -	if (f.map.mpage)
> > -		put_page(f.map.mpage);
> > +	erofs_put_metabuf(&f.map.buf);
> >  	erofs_release_pages(&pagepool);
> >  }
> >  
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 1037ac17b7a6..18d7fd1a5064 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -35,7 +35,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
> >  	struct super_block *const sb = inode->i_sb;
> >  	int err, headnr;
> >  	erofs_off_t pos;
> > -	struct page *page;
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> >  	void *kaddr;
> >  	struct z_erofs_map_header *h;
> >  
> > @@ -61,14 +61,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
> >  
> >  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
> >  		    vi->xattr_isize, 8);
> > -	page = erofs_get_meta_page(sb, erofs_blknr(pos));
> > -	if (IS_ERR(page)) {
> > -		err = PTR_ERR(page);
> > +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> > +				   EROFS_KMAP_ATOMIC);
> > +	if (IS_ERR(kaddr)) {
> > +		err = PTR_ERR(kaddr);
> >  		goto out_unlock;
> >  	}
> >  
> > -	kaddr = kmap_atomic(page);
> > -
> >  	h = kaddr + erofs_blkoff(pos);
> >  	vi->z_advise = le16_to_cpu(h->h_advise);
> >  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> > @@ -101,20 +100,19 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
> >  		goto unmap_done;
> >  	}
> >  unmap_done:
> > -	kunmap_atomic(kaddr);
> > -	unlock_page(page);
> > -	put_page(page);
> > +	erofs_put_metabuf(&buf);
> >  	if (err)
> >  		goto out_unlock;
> >  
> >  	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> > -		struct erofs_map_blocks map = { .mpage = NULL };
> > +		struct erofs_map_blocks map = {
> > +			.buf = __EROFS_BUF_INITIALIZER
> > +		};
> >  
> >  		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
> >  		err = z_erofs_do_map_blocks(inode, &map,
> >  					    EROFS_GET_BLOCKS_FINDTAIL);
> > -		if (map.mpage)
> > -			put_page(map.mpage);
> > +		erofs_put_metabuf(&map.buf);
> >  
> >  		if (!map.m_plen ||
> >  		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> > @@ -151,31 +149,11 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> >  				  erofs_blk_t eblk)
> >  {
> >  	struct super_block *const sb = m->inode->i_sb;
> > -	struct erofs_map_blocks *const map = m->map;
> > -	struct page *mpage = map->mpage;
> > -
> > -	if (mpage) {
> > -		if (mpage->index == eblk) {
> > -			if (!m->kaddr)
> > -				m->kaddr = kmap_atomic(mpage);
> > -			return 0;
> > -		}
> >  
> > -		if (m->kaddr) {
> > -			kunmap_atomic(m->kaddr);
> > -			m->kaddr = NULL;
> > -		}
> > -		put_page(mpage);
> > -	}
> > -
> > -	mpage = erofs_get_meta_page(sb, eblk);
> > -	if (IS_ERR(mpage)) {
> > -		map->mpage = NULL;
> > -		return PTR_ERR(mpage);
> > -	}
> > -	m->kaddr = kmap_atomic(mpage);
> > -	unlock_page(mpage);
> > -	map->mpage = mpage;
> > +	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
> > +				      EROFS_KMAP_ATOMIC);
> > +	if (IS_ERR(m->kaddr))
> > +		return PTR_ERR(m->kaddr);
> >  	return 0;
> >  }
> 
> remove z_erofs_reload_indexes() and use erofs_read_metabuf() directly in caller?

I'd suggest we do later since liberofs in erofs-utils doesn't
have erofs_buf for now.

We could get rid of it together with erofs-utils separately.
and if you have time ;)

> 
> >  
> > @@ -711,8 +689,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
> >  			map->m_flags |= EROFS_MAP_FULL_MAPPED;
> >  	}
> >  unmap_out:
> > -	if (m.kaddr)
> > -		kunmap_atomic(m.kaddr);
> > +	erofs_unmap_metabuf(&m.map->buf);
> >  
> >  out:
> >  	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
> > @@ -759,8 +736,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
> >  	struct erofs_map_blocks map = { .m_la = offset };
> >  
> >  	ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
> > -	if (map.mpage)
> > -		put_page(map.mpage);
> > +	erofs_put_metabuf(&map.buf);
> >  	if (ret < 0)
> >  		return ret;
> >  
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>

Thanks, if you have time, please also check out the rest patches...

Thanks,
Gao Xiang

