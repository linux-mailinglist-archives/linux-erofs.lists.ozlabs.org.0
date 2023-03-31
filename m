Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 517DD6D1720
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 08:04:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnqWJ3BYnz3f4M
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 17:04:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fvuKbD5+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fvuKbD5+;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnqW92TvXz3cMy
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Mar 2023 17:04:36 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso22313296pjb.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 23:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680242673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnq5zu1bFiAP4f0TH11pC6UpcZpEsYNIYEydKcUnmlM=;
        b=fvuKbD5+qaXRPuzfCvHzUd8xgCEwk8xJaeKItbh9uQKVYGx5XFRctlpiVkw/kLexd4
         ptsZjaBLlzYBwLShC+TzioS0FGxD2NWpZMCAB/jk0B0x1TphvpbdXkuKm+eUXVrgTJES
         5BrgNnnDQL/P+3B+I66NNEcZj4z9uxnk/6ugWSC+3MED+qf0X1PXS9RjXTolq8t6AD9r
         7sRuhX4GdSkeCTFBNctOmKVC1X2NzgL34j7G18406BSpZDSpHRfcY6p1Lcl8sWjdKhQn
         GzTkPsuAc2O2YlI22bqePnoRvzH9hbzgCNWEwGMi7sSoBj5tai42HySpCrTRn8keF3go
         aNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnq5zu1bFiAP4f0TH11pC6UpcZpEsYNIYEydKcUnmlM=;
        b=YFLLSvUzr4EekMswDcuJ4Oc+0XrcbxbAv10rzoOqbw37wilYx8msnNOI6R+7l1PA3/
         Tc6k6x5HwFPgvWgMpC5JDgzySoMxJn2hgM4LSJNkzPIs+IxHks+tWBimELQMsNVjXzDp
         5vfOieMuGBi2COf0hThSUUTTumHLE8J4ZMhCnzmnfx2TWYS56Ks3HQ07aQFSem0OGEPz
         AZmG6BLgv0OC1BXypIb2LGEzhrzK6mWi34cfLJkOfBu74lug95QxCWral9wMI86l0hub
         G/O65LNT62jzUB4T198Kl6MJLX4Ywvjw5dEKwmH5tM6UEbSXKpv9dNRSMtPtTAG7/7bp
         7sWQ==
X-Gm-Message-State: AAQBX9ftsd5+scNQszYIivD3jkzXpbDrf1FL9ppe0j0/1BNbmpPws1fB
	9N+/s0MixIgU2OU3EuoV3kU=
X-Google-Smtp-Source: AKy350aw96mfi1pNysToEbJwd3uwZrZxSTfSwJnRXOk1ePintMaHnL16QkUJ/IQYSlXCFgcjYDB40w==
X-Received: by 2002:a17:90b:1e49:b0:233:76bd:9faa with SMTP id pi9-20020a17090b1e4900b0023376bd9faamr29318409pjb.47.1680242673209;
        Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a2e8a00b0023d1976cd34sm671080pjd.17.2023.03.30.23.04.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:04:33 -0700 (PDT)
Date: Fri, 31 Mar 2023 14:11:24 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 2/8] erofs: rename init_inode_xattrs with erofs_
 prefix
Message-ID: <20230331141124.00006bcd.zbestahu@gmail.com>
In-Reply-To: <20230330082910.125374-3-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
	<20230330082910.125374-3-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 30 Mar 2023 16:29:04 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
> change.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/xattr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 9ccd57581bc7..dc36a0c0919c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,7 +29,7 @@ struct xattr_iter {
>  	unsigned int ofs;
>  };
>  
> -static int init_inode_xattrs(struct inode *inode)
> +static int erofs_init_inode_xattrs(struct inode *inode)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct xattr_iter it;
> @@ -405,7 +405,7 @@ int erofs_getxattr(struct inode *inode, int index,
>  	if (!name)
>  		return -EINVAL;
>  
> -	ret = init_inode_xattrs(inode);
> +	ret = erofs_init_inode_xattrs(inode);
>  	if (ret)
>  		return ret;
>  
> @@ -600,7 +600,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	int ret;
>  	struct listxattr_iter it;
>  
> -	ret = init_inode_xattrs(d_inode(dentry));
> +	ret = erofs_init_inode_xattrs(d_inode(dentry));
>  	if (ret == -ENOATTR)
>  		return 0;
>  	if (ret)

