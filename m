Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFE575BFC
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 09:06:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkj7y6Zbqz3c4r
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:06:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XOvThNMd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XOvThNMd;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkj7s516yz302d
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 17:06:16 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso5283499pjh.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylNpmY8OjpT6V3PMei76YslGWY2A1hjfP99ZRj79w5M=;
        b=XOvThNMdmYCZxtRivclOseYYoiYIT1NajTd3xl2hJEd9Wv48kn5hXhW+RIVwe0L5j7
         UbmyDN5miB5hNyGni3n/N6DtxZt0Car8fE6CVuMNDfjPBW7DvP00OAGmIIf4c2/IIPvb
         oFEO5ddwH922L9xeP6sLYFrbg+bIyGLmp0FZGQg+pIEBJhKtBYv92359nwGMdI1lCujf
         qZqmM9SRGdLvt5ipi1Xci9WxinnpNdA8qCTidtwdWboJcRSVeM5gXNqaQjYHhahAaU4D
         8edrRH3OmKO0ECXsiTmvGCKChIFYR/ViZOs2CpVI+2p11uEtHcfJbylyDa+DpFdtf1nP
         gQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylNpmY8OjpT6V3PMei76YslGWY2A1hjfP99ZRj79w5M=;
        b=P3Bb9GXnw8IS1uncf7C3E4p7YBf6lgn9HYLkc9Vqn7XFmCzAlVLmHV62DBaBTM5IHY
         1JBjoVeiNc2tWN6hA2/wy4cTuNwgirpL8gHfDO+kRa9IQD9jzeqqkTqCl/4nVLmQTYxy
         0Hk2gAJnxfKk4izFOxwX3x2gMqEQJ1qpuy2SqlV3A5Ruw39FN4JEcN2JNrOG383xZAqn
         L16YWXlSxYRoglTA5SPU+lO9zfuTQIPMZTrBhu6WxZR4eibCicyQmXjJFMhCjpn/tD2S
         GeScPxPw3QJS46NHO2Zn/eQwYJIOMpcbxMmEny9mkWjqSyNDVDASrxZxxpD7BkiB2PQc
         0OdQ==
X-Gm-Message-State: AJIora/9EL1V09esU8sFJb3RNh+UQEtZ2ieQg+NuRQeWRtUC5BwSxcVP
	waViOwWW745cVCrJ5SkC/uA=
X-Google-Smtp-Source: AGRyM1sj5kv4P2h4xTfonaXCbz3oKTBtJnKcHU90UYPzCXB7G+V6GXG4KwXdTWXLtFXN8Cgv3iYfYA==
X-Received: by 2002:a17:902:cad5:b0:16b:e3f1:fd8e with SMTP id y21-20020a170902cad500b0016be3f1fd8emr12413293pld.106.1657868774833;
        Fri, 15 Jul 2022 00:06:14 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r3-20020a63a543000000b0040d1eb90d67sm2446495pgu.93.2022.07.15.00.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 00:06:14 -0700 (PDT)
Date: Fri, 15 Jul 2022 15:07:37 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 05/16] erofs: drop the old pagevec approach
Message-ID: <20220715150737.00006764.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-6-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-6-hsiangkao@linux.alibaba.com>
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

On Thu, 14 Jul 2022 21:20:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Remove the old pagevec approach but keep z_erofs_page_type for now.
> It will be reworked in the following commits as well.
> 
> Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
> the new value 2 since it's actually enough to bootstrap.

I notice there are 2 comments as below which still use pagevec, should we
update it as well?

[1] 
* pagevec) since it can be directly decoded without I/O submission.
[2]
* for inplace I/O or pagevec (should be processed in strict order.)

BTW, utils.c includes needles <pagevec.h>, we can remove it along with the patchset
or remove it later.

> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c |  17 +++--
>  fs/erofs/zdata.h |   9 +--
>  fs/erofs/zpvec.h | 159 -----------------------------------------------
>  3 files changed, 16 insertions(+), 169 deletions(-)
>  delete mode 100644 fs/erofs/zpvec.h
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index f52c54058f31..e96704db106e 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -27,6 +27,17 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
>  	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
>  };
>  
> +/* page type in pagevec for decompress subsystem */
> +enum z_erofs_page_type {
> +	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
> +	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
> +
> +	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
> +
> +	Z_EROFS_VLE_PAGE_TYPE_HEAD,
> +	Z_EROFS_VLE_PAGE_TYPE_MAX
> +};
> +
>  struct z_erofs_bvec_iter {
>  	struct page *bvpage;
>  	struct z_erofs_bvset *bvset;
> @@ -273,7 +284,6 @@ struct z_erofs_decompress_frontend {
>  	struct inode *const inode;
>  	struct erofs_map_blocks map;
>  	struct z_erofs_bvec_iter biter;
> -	struct z_erofs_pagevec_ctor vector;
>  
>  	struct page *candidate_bvpage;
>  	struct z_erofs_pcluster *pcl, *tailpcl;
> @@ -636,7 +646,7 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  		return ret;
>  	}
>  	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> -				Z_EROFS_NR_INLINE_PAGEVECS, fe->pcl->vcnt);
> +				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */
>  	fe->icpage_ptr = fe->pcl->compressed_pages +
>  			z_erofs_pclusterpages(fe->pcl);
> @@ -871,8 +881,7 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
>  	struct page *old_bvpage;
>  	int i, err = 0;
>  
> -	z_erofs_bvec_iter_begin(&biter, &pcl->bvset,
> -				Z_EROFS_NR_INLINE_PAGEVECS, 0);
> +	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
>  	for (i = 0; i < pcl->vcnt; ++i) {
>  		struct z_erofs_bvec bvec;
>  		unsigned int pagenr;
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index d03e333e4fde..a755c5a44d87 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -7,10 +7,10 @@
>  #define __EROFS_FS_ZDATA_H
>  
>  #include "internal.h"
> -#include "zpvec.h"
> +#include "tagptr.h"
>  
>  #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
> -#define Z_EROFS_NR_INLINE_PAGEVECS      3
> +#define Z_EROFS_INLINE_BVECS		2
>  
>  #define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
>  #define Z_EROFS_PCLUSTER_LENGTH_BIT     1
> @@ -34,7 +34,7 @@ struct name { \
>  	struct z_erofs_bvec bvec[total]; \
>  };
>  __Z_EROFS_BVSET(z_erofs_bvset,)
> -__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_NR_INLINE_PAGEVECS)
> +__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS)
>  
>  /*
>   * Structure fields follow one of the following exclusion rules.
> @@ -69,9 +69,6 @@ struct z_erofs_pcluster {
>  	unsigned short nr_pages;
>  
>  	union {
> -		/* L: inline a certain number of pagevecs for bootstrap */
> -		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
> -
>  		/* L: inline a certain number of bvec for bootstrap */
>  		struct z_erofs_bvset_inline bvset;
>  
> diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
> deleted file mode 100644
> index b05464f4a808..000000000000
> --- a/fs/erofs/zpvec.h
> +++ /dev/null
> @@ -1,159 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2018 HUAWEI, Inc.
> - *             https://www.huawei.com/
> - */
> -#ifndef __EROFS_FS_ZPVEC_H
> -#define __EROFS_FS_ZPVEC_H
> -
> -#include "tagptr.h"
> -
> -/* page type in pagevec for decompress subsystem */
> -enum z_erofs_page_type {
> -	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
> -	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
> -
> -	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
> -
> -	Z_EROFS_VLE_PAGE_TYPE_HEAD,
> -	Z_EROFS_VLE_PAGE_TYPE_MAX
> -};
> -
> -extern void __compiletime_error("Z_EROFS_PAGE_TYPE_EXCLUSIVE != 0")
> -	__bad_page_type_exclusive(void);
> -
> -/* pagevec tagged pointer */
> -typedef tagptr2_t	erofs_vtptr_t;
> -
> -/* pagevec collector */
> -struct z_erofs_pagevec_ctor {
> -	struct page *curr, *next;
> -	erofs_vtptr_t *pages;
> -
> -	unsigned int nr, index;
> -};
> -
> -static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
> -					     bool atomic)
> -{
> -	if (!ctor->curr)
> -		return;
> -
> -	if (atomic)
> -		kunmap_atomic(ctor->pages);
> -	else
> -		kunmap(ctor->curr);
> -}
> -
> -static inline struct page *
> -z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
> -			       unsigned int nr)
> -{
> -	unsigned int index;
> -
> -	/* keep away from occupied pages */
> -	if (ctor->next)
> -		return ctor->next;
> -
> -	for (index = 0; index < nr; ++index) {
> -		const erofs_vtptr_t t = ctor->pages[index];
> -		const unsigned int tags = tagptr_unfold_tags(t);
> -
> -		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
> -			return tagptr_unfold_ptr(t);
> -	}
> -	DBG_BUGON(nr >= ctor->nr);
> -	return NULL;
> -}
> -
> -static inline void
> -z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
> -			      bool atomic)
> -{
> -	struct page *next = z_erofs_pagevec_ctor_next_page(ctor, ctor->nr);
> -
> -	z_erofs_pagevec_ctor_exit(ctor, atomic);
> -
> -	ctor->curr = next;
> -	ctor->next = NULL;
> -	ctor->pages = atomic ?
> -		kmap_atomic(ctor->curr) : kmap(ctor->curr);
> -
> -	ctor->nr = PAGE_SIZE / sizeof(struct page *);
> -	ctor->index = 0;
> -}
> -
> -static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
> -					     unsigned int nr,
> -					     erofs_vtptr_t *pages,
> -					     unsigned int i)
> -{
> -	ctor->nr = nr;
> -	ctor->curr = ctor->next = NULL;
> -	ctor->pages = pages;
> -
> -	if (i >= nr) {
> -		i -= nr;
> -		z_erofs_pagevec_ctor_pagedown(ctor, false);
> -		while (i > ctor->nr) {
> -			i -= ctor->nr;
> -			z_erofs_pagevec_ctor_pagedown(ctor, false);
> -		}
> -	}
> -	ctor->next = z_erofs_pagevec_ctor_next_page(ctor, i);
> -	ctor->index = i;
> -}
> -
> -static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
> -					   struct page *page,
> -					   enum z_erofs_page_type type,
> -					   bool pvec_safereuse)
> -{
> -	if (!ctor->next) {
> -		/* some pages cannot be reused as pvec safely without I/O */
> -		if (type == Z_EROFS_PAGE_TYPE_EXCLUSIVE && !pvec_safereuse)
> -			type = Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED;
> -
> -		if (type != Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
> -		    ctor->index + 1 == ctor->nr)
> -			return false;
> -	}
> -
> -	if (ctor->index >= ctor->nr)
> -		z_erofs_pagevec_ctor_pagedown(ctor, false);
> -
> -	/* exclusive page type must be 0 */
> -	if (Z_EROFS_PAGE_TYPE_EXCLUSIVE != (uintptr_t)NULL)
> -		__bad_page_type_exclusive();
> -
> -	/* should remind that collector->next never equal to 1, 2 */
> -	if (type == (uintptr_t)ctor->next) {
> -		ctor->next = page;
> -	}
> -	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
> -	return true;
> -}
> -
> -static inline struct page *
> -z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
> -			enum z_erofs_page_type *type)
> -{
> -	erofs_vtptr_t t;
> -
> -	if (ctor->index >= ctor->nr) {
> -		DBG_BUGON(!ctor->next);
> -		z_erofs_pagevec_ctor_pagedown(ctor, true);
> -	}
> -
> -	t = ctor->pages[ctor->index];
> -
> -	*type = tagptr_unfold_tags(t);
> -
> -	/* should remind that collector->next never equal to 1, 2 */
> -	if (*type == (uintptr_t)ctor->next)
> -		ctor->next = tagptr_unfold_ptr(t);
> -
> -	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, NULL, 0);
> -	return tagptr_unfold_ptr(t);
> -}
> -#endif

