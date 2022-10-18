Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD56030BF
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 18:28:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsK792twDz3c7B
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 03:28:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=G13rMOjM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=fmdefrancesco@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=G13rMOjM;
	dkim-atps=neutral
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsK6z6v5Sz3bjy
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 03:28:42 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id y10so11131829wma.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Oct 2022 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTA7UUH9Sc6w6mw3sahpbZ8SmBuvn7L+yuJ6XWXaN2M=;
        b=G13rMOjM1R+vT4b9/UdXLEfPEGilWz18Np35M/Nq2V+yIFkBF9YL4rLCNQsH2mdJN9
         +rt/KDbuJuMZfmHHXm6nPN5QJUP07S8SwRYs3snhIhEqhtecgRj4KTq6fTtlN95837vw
         nyl/b3uFeMlFQy2gMoDuiRjh+UCzZHm4CCmdEoQxQu1id7rO0LeUDsjHF+gRAVE6Y3j5
         eFc/J7mJsZTzjes9eT+zOEg+0/wJCjZXo44VtW0jhab3n6iHcalNLfo8cL5GA36HcGZP
         V6InKZS0dB9JTjmzuFVGkv8WAHjmoVHP69gh80EHE6MKz74FiMzaQG10MFFCVIXacgrg
         5UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTA7UUH9Sc6w6mw3sahpbZ8SmBuvn7L+yuJ6XWXaN2M=;
        b=fMe81Sp9nXRvbCqKqbxCUDr8mC5Chv8F2lr3+p3qZKSyCyEVk7WCtvCEmpVbSaveB4
         ahd4NcsAB7w4SoZymOOlY/wWeR0FBnpZz//dbr0c9+ZiV77IQcKhemSjd5lq439PeU6Q
         L2EewZLgEdtVURHuzWMac8zFnfFPlWHZABzN/Z9rKgba7kcT52oTjwVefoNZUH0YTt6P
         cTMaxU/XHEtKJd3J2v8sFq8cHPXQlq0KqqN0MIWw9OfJD5jkgKFxKOjR18YzirQNqkCn
         CpPEBWr5yE7NiI2M8snmL4XVno5r+vUacLeYY0ippD51yXiRlq6+bJg/tNeQaB4Snqst
         HzwA==
X-Gm-Message-State: ACrzQf2tuIUnbHIWr1Si6T9zUlhU04NKViDBijJYkdEc5JRRuWm90JkL
	cIPdcFTyKXowfp9KOsbWnvtPVXUgWd5NpHMy
X-Google-Smtp-Source: AMsMyM6QN4IrEpfjZhFIvIWGL8qE7CBV8oho3Qa93e84JnGYOUsE7i2Sem2XIDyHcJJ/hd5h6S2ztw==
X-Received: by 2002:a05:600c:468f:b0:3c6:f85c:25a1 with SMTP id p15-20020a05600c468f00b003c6f85c25a1mr2607351wmo.60.1666110513808;
        Tue, 18 Oct 2022 09:28:33 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm11496761wru.109.2022.10.18.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:28:32 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date: Tue, 18 Oct 2022 18:28:46 +0200
Message-ID: <2266595.ElGaqSPkdT@mypc>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 8 ++------
>  fs/erofs/internal.h | 3 +--
>  fs/erofs/xattr.c    | 8 ++++----
>  fs/erofs/zmap.c     | 4 ++--
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fe8ac0e163f7..fe1ae80284bf 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -13,9 +13,7 @@
>  void erofs_unmap_metabuf(struct erofs_buf *buf)
>  {
>  	if (buf->kmap_type == EROFS_KMAP)
> -		kunmap(buf->page);
> -	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> -		kunmap_atomic(buf->base);
> +		kunmap_local(buf->base);
>  	buf->base = NULL;
>  	buf->kmap_type = EROFS_NO_KMAP;
>  }
> @@ -54,9 +52,7 @@ void *erofs_bread(struct erofs_buf *buf, struct inode 
*inode,
>  	}
>  	if (buf->kmap_type == EROFS_NO_KMAP) {
>  		if (type == EROFS_KMAP)
> -			buf->base = kmap(page);
> -		else if (type == EROFS_KMAP_ATOMIC)
> -			buf->base = kmap_atomic(page);
> +			buf->base = kmap_local_page(page);
>  		buf->kmap_type = type;
>  	} else if (buf->kmap_type != type) {
>  		DBG_BUGON(1);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1701df48c446..67dc8e177211 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -253,8 +253,7 @@ static inline int erofs_wait_on_workgroup_freezed(struct 
erofs_workgroup *grp)
>  
>  enum erofs_kmap_type {
>  	EROFS_NO_KMAP,		/* don't map the buffer */
> -	EROFS_KMAP,		/* use kmap() to map the buffer */
> -	EROFS_KMAP_ATOMIC,	/* use kmap_atomic() to map the buffer */
> +	EROFS_KMAP,		/* use kmap_local_page() to map the 
buffer */
>  };
>  
>  struct erofs_buf {
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 8106bcb5a38d..a62fb8a3318a 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -148,7 +148,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
>  
>  	it->blkaddr += erofs_blknr(it->ofs);
>  	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	it->ofs = erofs_blkoff(it->ofs);
> @@ -174,7 +174,7 @@ static int inline_xattr_iter_begin(struct xattr_iter 
*it,
>  	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  
>  	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	return vi->xattr_isize - xattr_header_sz;
> @@ -368,7 +368,7 @@ static int shared_getxattr(struct inode *inode, struct 
getxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi-
>xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, 
blkaddr,
> -						  
EROFS_KMAP_ATOMIC);
> +						  
EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> @@ -580,7 +580,7 @@ static int shared_listxattr(struct listxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi-
>xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, 
blkaddr,
> -						  
EROFS_KMAP_ATOMIC);
> +						  
EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..749a5ac943f4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -178,7 +178,7 @@ static int legacy_load_cluster_from_disk(struct 
z_erofs_maprecorder *m,
>  	unsigned int advise, type;
>  
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), 
EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), 
EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  
> @@ -416,7 +416,7 @@ static int compacted_load_cluster_from_disk(struct 
z_erofs_maprecorder *m,
>  out:
>  	pos += lcn * (1 << amortizedshift);
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), 
EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), 
EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
> -- 
> 2.24.4
> 
> 
Can you please say whether or not you ran some tests on a 32 bits machine, 
possibly QEMU/KVM x86_32 with enough RAM (I'd suggest 6GB), booting a kernel 
with HIGHMEM4G or HIGHMEM64G enabled?

Did you check whether or not the pointers are handed to other contexts?

You didn't say anything about the safety of these conversions. And you also 
didn't say why you did them (I don't care but many might ignore why).

Therefore, can you please say at least how you checked that these conversions 
are safe so that they won't break the filesystem in 32bit machines?

Thanks,

Fabio M. De Francesco



