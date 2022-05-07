Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7451E47A
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 07:40:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KwGW95CV3z3c7R
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 15:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EkJzGm/J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=EkJzGm/J; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KwGW12TF5z3bhR
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 15:40:44 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id c14so7908249pfn.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 06 May 2022 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AVuaOiXhV01Z47Oo1rP7YN34nHEPNRHjJX/XRSE9e0M=;
 b=EkJzGm/JeHn0Akm0WvBv/z4h/vyU57IPa7rnZoXNc/ZlcQ0LKsROLOEpk33iPvRk8H
 wAbpoS72stM8zkuhQq55tVgSEbT5p7v+UQrNpyWBG/D7qQ1vsOmTUkSNyAoHt7ljGG//
 4R5J+W1RhtpueH8IaUblBU46vRlfpC69NotB/JLGJgX3YsI1EV0SgevZ4Kw5tpoYZ2e/
 q2gd9srrc8xYR4riTXVR5YFFtaqQl41wfLR1AWCDoQsRSAqrDas2+9fixH5xynyLa0ur
 UUHm+uWyetASlKm/O8M6i1RTMyvbDlBrTnfuIjzY7z5esa6cc4AnIQtLrXudShsCR3iX
 bE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AVuaOiXhV01Z47Oo1rP7YN34nHEPNRHjJX/XRSE9e0M=;
 b=G/6epiKW/wFp+5dqVr4WmoeJ3HVXUQ/eVFNiQ4XjfB2ohlVs0C528ZxcnWdlFk0Lei
 IsV5BlYdZ0FKYgvui4h44xmSPn1KpklUqVsuGXxLq3dJBlmJ3i9pyW7vuEDHx9lFpMmW
 PSsq0ka63zuJ8WHsVagO4QtDzzrJdfZzHlmSlOpHX5ouym8XqC8Q4FYgjTXVxlB3VUB0
 HI10aV3MU9Ls7tkc+J8oFCm+JpZvT4Xv/jI0fbm1X2tabQaRTHz0+49u0uYQkGzOztS5
 h/25YAHgsDl8FqvXWaM5z+GC10/E+JSb67/JDca4fynq1b6RCu+shVQ3lbQL10zIqm00
 VeFw==
X-Gm-Message-State: AOAM532aEjh/CILWFdLatGnYITTqnrYvVqOlFw7zoVf1gzlc/BZM2hJ7
 E2Z72e2LO8cxBub5c5Jk6SA=
X-Google-Smtp-Source: ABdhPJz7LcUUD4gahOIUtRR7xASy10zcWdIn+aPL3P9fPuCKGJt388cR5ZYsKV4EWvX/n7RcOXduJw==
X-Received: by 2002:a63:eb58:0:b0:3c2:6d66:c238 with SMTP id
 b24-20020a63eb58000000b003c26d66c238mr5597405pgk.436.1651902040128; 
 Fri, 06 May 2022 22:40:40 -0700 (PDT)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 19-20020a170902e9d300b0015e8d4eb253sm2748412plk.157.2022.05.06.22.40.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 May 2022 22:40:39 -0700 (PDT)
Date: Sat, 7 May 2022 13:40:41 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/3] erofs: remove obsoluted comments
Message-ID: <20220507134041.000060da.zbestahu@gmail.com>
In-Reply-To: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  7 May 2022 03:46:11 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some comments haven't been useful anymore since the code updated.
> Let's drop them instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c    |  5 -----
>  fs/erofs/internal.h | 25 -------------------------
>  2 files changed, 30 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 8d3f56c6469b..8b18d57ec18f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,11 +8,6 @@
>  
>  #include <trace/events/erofs.h>
>  
> -/*
> - * if inode is successfully read, return its inode page (or sometimes
> - * the inode payload page if it's an extended inode) in order to fill
> - * inline data if possible.
> - */
>  static void *erofs_read_inode(struct erofs_buf *buf,
>  			      struct inode *inode, unsigned int *ofs)
>  {
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index ce2a04836cd2..cfee49d33b95 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -397,31 +397,6 @@ extern const struct super_operations erofs_sops;
>  extern const struct address_space_operations erofs_raw_access_aops;
>  extern const struct address_space_operations z_erofs_aops;
>  
> -/*
> - * Logical to physical block mapping
> - *
> - * Different with other file systems, it is used for 2 access modes:
> - *
> - * 1) RAW access mode:
> - *
> - * Users pass a valid (m_lblk, m_lofs -- usually 0) pair,
> - * and get the valid m_pblk, m_pofs and the longest m_len(in bytes).
> - *
> - * Note that m_lblk in the RAW access mode refers to the number of
> - * the compressed ondisk block rather than the uncompressed
> - * in-memory block for the compressed file.
> - *
> - * m_pofs equals to m_lofs except for the inline data page.
> - *
> - * 2) Normal access mode:
> - *
> - * If the inode is not compressed, it has no difference with
> - * the RAW access mode. However, if the inode is compressed,
> - * users should pass a valid (m_lblk, m_lofs) pair, and get
> - * the needed m_pblk, m_pofs, m_len to get the compressed data
> - * and the updated m_lblk, m_lofs which indicates the start
> - * of the corresponding uncompressed data in the file.
> - */
>  enum {
>  	BH_Encoded = BH_PrivateStart,
>  	BH_FullMapped,

Reviewed-by: Yue Hu <huyue2@coolpad.com>
