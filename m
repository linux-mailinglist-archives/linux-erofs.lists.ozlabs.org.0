Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C83482A89
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 08:49:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JRWH30kSkz2ypn
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 18:49:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JRWGw6BBwz2xg3
 for <linux-erofs@lists.ozlabs.org>; Sun,  2 Jan 2022 18:49:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=bo.liu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0YT96V_1641109723; 
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0V0YT96V_1641109723) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 02 Jan 2022 15:48:43 +0800
Date: Sun, 2 Jan 2022 15:48:43 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 4/5] erofs: use meta buffers for xattr operations
Message-ID: <20220102074843.GE40650@rsjd01523.et2sqa>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: bo.liu@linux.alibaba.com
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jan 02, 2022 at 12:00:16PM +0800, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within xattr operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
>

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/xattr.c | 134 ++++++++++++++---------------------------------
>  1 file changed, 40 insertions(+), 94 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 01c581e93c5f..437ff6e7293d 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -8,33 +8,13 @@
>  
>  struct xattr_iter {
>  	struct super_block *sb;
> -	struct page *page;
> +	struct erofs_buf buf;
>  	void *kaddr;
>  
>  	erofs_blk_t blkaddr;
>  	unsigned int ofs;
>  };
>  
> -static inline void xattr_iter_end(struct xattr_iter *it, bool atomic)
> -{
> -	/* the only user of kunmap() is 'init_inode_xattrs' */
> -	if (!atomic)
> -		kunmap(it->page);
> -	else
> -		kunmap_atomic(it->kaddr);
> -
> -	unlock_page(it->page);
> -	put_page(it->page);
> -}
> -
> -static inline void xattr_iter_end_final(struct xattr_iter *it)
> -{
> -	if (!it->page)
> -		return;
> -
> -	xattr_iter_end(it, true);
> -}
> -
>  static int init_inode_xattrs(struct inode *inode)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -43,7 +23,6 @@ static int init_inode_xattrs(struct inode *inode)
>  	struct erofs_xattr_ibody_header *ih;
>  	struct super_block *sb;
>  	struct erofs_sb_info *sbi;
> -	bool atomic_map;
>  	int ret = 0;
>  
>  	/* the most case is that xattrs of this inode are initialized. */
> @@ -91,26 +70,23 @@ static int init_inode_xattrs(struct inode *inode)
>  
>  	sb = inode->i_sb;
>  	sbi = EROFS_SB(sb);
> +	it.buf = __EROFS_BUF_INITIALIZER;
>  	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
>  	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
>  
> -	it.page = erofs_get_meta_page(sb, it.blkaddr);
> -	if (IS_ERR(it.page)) {
> -		ret = PTR_ERR(it.page);
> +	/* read in shared xattr array (non-atomic, see kmalloc below) */
> +	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
> +	if (IS_ERR(it.kaddr)) {
> +		ret = PTR_ERR(it.kaddr);
>  		goto out_unlock;
>  	}
>  
> -	/* read in shared xattr array (non-atomic, see kmalloc below) */
> -	it.kaddr = kmap(it.page);
> -	atomic_map = false;
> -
>  	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
> -
>  	vi->xattr_shared_count = ih->h_shared_count;
>  	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
>  						sizeof(uint), GFP_KERNEL);
>  	if (!vi->xattr_shared_xattrs) {
> -		xattr_iter_end(&it, atomic_map);
> +		erofs_put_metabuf(&it.buf);
>  		ret = -ENOMEM;
>  		goto out_unlock;
>  	}
> @@ -122,25 +98,22 @@ static int init_inode_xattrs(struct inode *inode)
>  		if (it.ofs >= EROFS_BLKSIZ) {
>  			/* cannot be unaligned */
>  			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
> -			xattr_iter_end(&it, atomic_map);
>  
> -			it.page = erofs_get_meta_page(sb, ++it.blkaddr);
> -			if (IS_ERR(it.page)) {
> +			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
> +						      EROFS_KMAP);
> +			if (IS_ERR(it.kaddr)) {
>  				kfree(vi->xattr_shared_xattrs);
>  				vi->xattr_shared_xattrs = NULL;
> -				ret = PTR_ERR(it.page);
> +				ret = PTR_ERR(it.kaddr);
>  				goto out_unlock;
>  			}
> -
> -			it.kaddr = kmap_atomic(it.page);
> -			atomic_map = true;
>  			it.ofs = 0;
>  		}
>  		vi->xattr_shared_xattrs[i] =
>  			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
>  		it.ofs += sizeof(__le32);
>  	}
> -	xattr_iter_end(&it, atomic_map);
> +	erofs_put_metabuf(&it.buf);
>  
>  	/* paired with smp_mb() at the beginning of the function. */
>  	smp_mb();
> @@ -172,19 +145,11 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
>  	if (it->ofs < EROFS_BLKSIZ)
>  		return 0;
>  
> -	xattr_iter_end(it, true);
> -
>  	it->blkaddr += erofs_blknr(it->ofs);
> -
> -	it->page = erofs_get_meta_page(it->sb, it->blkaddr);
> -	if (IS_ERR(it->page)) {
> -		int err = PTR_ERR(it->page);
> -
> -		it->page = NULL;
> -		return err;
> -	}
> -
> -	it->kaddr = kmap_atomic(it->page);
> +	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
> +				       EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(it->kaddr))
> +		return PTR_ERR(it->kaddr);
>  	it->ofs = erofs_blkoff(it->ofs);
>  	return 0;
>  }
> @@ -207,11 +172,10 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  
> -	it->page = erofs_get_meta_page(inode->i_sb, it->blkaddr);
> -	if (IS_ERR(it->page))
> -		return PTR_ERR(it->page);
> -
> -	it->kaddr = kmap_atomic(it->page);
> +	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
> +				       EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(it->kaddr))
> +		return PTR_ERR(it->kaddr);
>  	return vi->xattr_isize - xattr_header_sz;
>  }
>  
> @@ -272,7 +236,7 @@ static int xattr_foreach(struct xattr_iter *it,
>  			it->ofs = 0;
>  		}
>  
> -		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
> +		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
>  			      entry.e_name_len - processed);
>  
>  		/* handle name */
> @@ -307,7 +271,7 @@ static int xattr_foreach(struct xattr_iter *it,
>  			it->ofs = 0;
>  		}
>  
> -		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
> +		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
>  			      value_sz - processed);
>  		op->value(it, processed, it->kaddr + it->ofs, slice);
>  		it->ofs += slice;
> @@ -386,8 +350,6 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
>  		if (ret != -ENOATTR)
>  			break;
>  	}
> -	xattr_iter_end_final(&it->it);
> -
>  	return ret ? ret : it->buffer_size;
>  }
>  
> @@ -404,26 +366,16 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
> -
> -		if (!i || blkaddr != it->it.blkaddr) {
> -			if (i)
> -				xattr_iter_end(&it->it, true);
> -
> -			it->it.page = erofs_get_meta_page(sb, blkaddr);
> -			if (IS_ERR(it->it.page))
> -				return PTR_ERR(it->it.page);
> -
> -			it->it.kaddr = kmap_atomic(it->it.page);
> -			it->it.blkaddr = blkaddr;
> -		}
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> +						  EROFS_KMAP_ATOMIC);
> +		if (IS_ERR(it->it.kaddr))
> +			return PTR_ERR(it->it.kaddr);
> +		it->it.blkaddr = blkaddr;
>  
>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
>  		if (ret != -ENOATTR)
>  			break;
>  	}
> -	if (vi->xattr_shared_count)
> -		xattr_iter_end_final(&it->it);
> -
>  	return ret ? ret : it->buffer_size;
>  }
>  
> @@ -452,10 +404,11 @@ int erofs_getxattr(struct inode *inode, int index,
>  		return ret;
>  
>  	it.index = index;
> -
>  	it.name.len = strlen(name);
>  	if (it.name.len > EROFS_NAME_LEN)
>  		return -ERANGE;
> +
> +	it.it.buf = __EROFS_BUF_INITIALIZER;
>  	it.name.name = name;
>  
>  	it.buffer = buffer;
> @@ -465,6 +418,7 @@ int erofs_getxattr(struct inode *inode, int index,
>  	ret = inline_getxattr(inode, &it);
>  	if (ret == -ENOATTR)
>  		ret = shared_getxattr(inode, &it);
> +	erofs_put_metabuf(&it.it.buf);
>  	return ret;
>  }
>  
> @@ -607,7 +561,6 @@ static int inline_listxattr(struct listxattr_iter *it)
>  		if (ret)
>  			break;
>  	}
> -	xattr_iter_end_final(&it->it);
>  	return ret ? ret : it->buffer_ofs;
>  }
>  
> @@ -625,25 +578,16 @@ static int shared_listxattr(struct listxattr_iter *it)
>  			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
> -		if (!i || blkaddr != it->it.blkaddr) {
> -			if (i)
> -				xattr_iter_end(&it->it, true);
> -
> -			it->it.page = erofs_get_meta_page(sb, blkaddr);
> -			if (IS_ERR(it->it.page))
> -				return PTR_ERR(it->it.page);
> -
> -			it->it.kaddr = kmap_atomic(it->it.page);
> -			it->it.blkaddr = blkaddr;
> -		}
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> +						  EROFS_KMAP_ATOMIC);
> +		if (IS_ERR(it->it.kaddr))
> +			return PTR_ERR(it->it.kaddr);
> +		it->it.blkaddr = blkaddr;
>  
>  		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
>  		if (ret)
>  			break;
>  	}
> -	if (vi->xattr_shared_count)
> -		xattr_iter_end_final(&it->it);
> -
>  	return ret ? ret : it->buffer_ofs;
>  }
>  
> @@ -659,6 +603,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	if (ret)
>  		return ret;
>  
> +	it.it.buf = __EROFS_BUF_INITIALIZER;
>  	it.dentry = dentry;
>  	it.buffer = buffer;
>  	it.buffer_size = buffer_size;
> @@ -667,9 +612,10 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	it.it.sb = dentry->d_sb;
>  
>  	ret = inline_listxattr(&it);
> -	if (ret < 0 && ret != -ENOATTR)
> -		return ret;
> -	return shared_listxattr(&it);
> +	if (ret >= 0 || ret == -ENOATTR)
> +		ret = shared_listxattr(&it);
> +	erofs_put_metabuf(&it.it.buf);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -- 
> 2.24.4
