Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FF68238
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 04:28:07 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45n6rh6lxMzDqTV
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 12:28:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45n6mS6YyMzDqTZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2019 12:24:24 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 78A45E0644F90764DA1A;
 Mon, 15 Jul 2019 10:24:19 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 15 Jul
 2019 10:24:09 +0800
Subject: Re: [PATCH] Staging: erofs:converting all 'unsigned' to 'unsigned int'
To: Pratik Shinde <pratikshinde320@gmail.com>, <linux-erofs@lists.ozlabs.org>, 
 <yuchao0@huawei.com>
References: <20190714193019.9816-1-pratikshinde320@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <3445a2e2-3911-8929-a0fe-f4fa226f6097@huawei.com>
Date: Mon, 15 Jul 2019 10:23:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190714193019.9816-1-pratikshinde320@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On 2019/7/15 3:30, Pratik Shinde wrote:
> Fixing checkpath warnings : converting all 'unsigned' to 'unsigned int'
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  drivers/staging/erofs/internal.h      |  6 +++---
>  drivers/staging/erofs/unzip_pagevec.h | 10 +++++-----
>  drivers/staging/erofs/unzip_vle.h     |  8 ++++----
>  drivers/staging/erofs/xattr.h         | 10 +++++-----
>  4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 963cc1b..daae90b 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -359,8 +359,8 @@ struct erofs_vnode {
>  	unsigned char inode_isize;
>  	unsigned short xattr_isize;
>  
> -	unsigned xattr_shared_count;
> -	unsigned *xattr_shared_xattrs;
> +	unsigned int xattr_shared_count;
> +	unsigned int *xattr_shared_xattrs;
>  
>  	union {
>  		erofs_blk_t raw_blkaddr;
> @@ -510,7 +510,7 @@ erofs_grab_bio(struct super_block *sb,
>  	return bio;
>  }
>  
> -static inline void __submit_bio(struct bio *bio, unsigned op, unsigned op_flags)
> +static inline void __submit_bio(struct bio *bio, unsigned int op, unsigned int op_flags)

The subject line could be better as "staging: erofs: converting all 'unsigned' to 'unsigned int' "
and three new checkpatch warnings occurs after this patch...


WARNING: line over 80 characters
#86: FILE: drivers/staging/erofs/internal.h:513:
+static inline void __submit_bio(struct bio *bio, unsigned int op, unsigned int op_flags)

WARNING: line over 80 characters
#122: FILE: drivers/staging/erofs/unzip_pagevec.h:95:
+                                            erofs_vtptr_t *pages, unsigned int i)

WARNING: line over 80 characters
#203: FILE: drivers/staging/erofs/xattr.h:52:
+static inline const struct xattr_handler *erofs_xattr_handler(unsigned int index)

Thanks,
Gao Xiang

>  {
>  	bio_set_op_attrs(bio, op, op_flags);
>  	submit_bio(bio);
> diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
> index 7af0ba8..198b556 100644
> --- a/drivers/staging/erofs/unzip_pagevec.h
> +++ b/drivers/staging/erofs/unzip_pagevec.h
> @@ -54,9 +54,9 @@ static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
>  
>  static inline struct page *
>  z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
> -			       unsigned nr)
> +			       unsigned int nr)
>  {
> -	unsigned index;
> +	unsigned int index;
>  
>  	/* keep away from occupied pages */
>  	if (ctor->next)
> @@ -64,7 +64,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
>  
>  	for (index = 0; index < nr; ++index) {
>  		const erofs_vtptr_t t = ctor->pages[index];
> -		const unsigned tags = tagptr_unfold_tags(t);
> +		const unsigned int tags = tagptr_unfold_tags(t);
>  
>  		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
>  			return tagptr_unfold_ptr(t);
> @@ -91,8 +91,8 @@ z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
>  }
>  
>  static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
> -					     unsigned nr,
> -					     erofs_vtptr_t *pages, unsigned i)
> +					     unsigned int nr,
> +					     erofs_vtptr_t *pages, unsigned int i)
>  {
>  	ctor->nr = nr;
>  	ctor->curr = ctor->next = NULL;
> diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
> index ab509d75..df91ad1 100644
> --- a/drivers/staging/erofs/unzip_vle.h
> +++ b/drivers/staging/erofs/unzip_vle.h
> @@ -34,7 +34,7 @@ struct z_erofs_vle_work {
>  	unsigned short nr_pages;
>  
>  	/* L: queued pages in pagevec[] */
> -	unsigned vcnt;
> +	unsigned int vcnt;
>  
>  	union {
>  		/* L: pagevec */
> @@ -124,7 +124,7 @@ union z_erofs_onlinepage_converter {
>  	unsigned long *v;
>  };
>  
> -static inline unsigned z_erofs_onlinepage_index(struct page *page)
> +static inline unsigned int z_erofs_onlinepage_index(struct page *page)
>  {
>  	union z_erofs_onlinepage_converter u;
>  
> @@ -164,7 +164,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
>  	}
>  
>  	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
> -		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned)down);
> +		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
>  	if (cmpxchg(p, o, v) != o)
>  		goto repeat;
>  }
> @@ -172,7 +172,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
>  static inline void z_erofs_onlinepage_endio(struct page *page)
>  {
>  	union z_erofs_onlinepage_converter u;
> -	unsigned v;
> +	unsigned int v;
>  
>  	DBG_BUGON(!PagePrivate(page));
>  	u.v = &page_private(page);
> diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
> index 35ba5ac..2fc9b43 100644
> --- a/drivers/staging/erofs/xattr.h
> +++ b/drivers/staging/erofs/xattr.h
> @@ -20,14 +20,14 @@
>  /* Attribute not found */
>  #define ENOATTR         ENODATA
>  
> -static inline unsigned inlinexattr_header_size(struct inode *inode)
> +static inline unsigned int inlinexattr_header_size(struct inode *inode)
>  {
>  	return sizeof(struct erofs_xattr_ibody_header)
>  		+ sizeof(u32) * EROFS_V(inode)->xattr_shared_count;
>  }
>  
>  static inline erofs_blk_t
> -xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)
> +xattrblock_addr(struct erofs_sb_info *sbi, unsigned int xattr_id)
>  {
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	return sbi->xattr_blkaddr +
> @@ -37,8 +37,8 @@ xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)
>  #endif
>  }
>  
> -static inline unsigned
> -xattrblock_offset(struct erofs_sb_info *sbi, unsigned xattr_id)
> +static inline unsigned int
> +xattrblock_offset(struct erofs_sb_info *sbi, unsigned int xattr_id)
>  {
>  	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
>  }
> @@ -49,7 +49,7 @@ extern const struct xattr_handler erofs_xattr_trusted_handler;
>  extern const struct xattr_handler erofs_xattr_security_handler;
>  #endif
>  
> -static inline const struct xattr_handler *erofs_xattr_handler(unsigned index)
> +static inline const struct xattr_handler *erofs_xattr_handler(unsigned int index)
>  {
>  static const struct xattr_handler *xattr_handler_map[] = {
>  	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> 
