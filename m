Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA66F45589A
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 11:07:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvwSm4KZDz2ynk
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 21:07:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=onxHzlnv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=onxHzlnv; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvwSc47Vtz2yPs
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 21:06:54 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id n26so5473464pff.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+uIhEKx3FaRyIVD+mj3dSeccwcC+YlKBKzq2myhB5rM=;
 b=onxHzlnvmOuKel9Yq7zZKMfOAxQZODM6uXSHlCJGYIX8xrRQoQsdooIS3Rvy87oLk+
 KaM7Q6mH4ddI6fe2QfhaBCy4W3n0H34nV8ms/ZcsV8wqH6tYae2Vy+13146xQTlZ11P3
 MAYoplp59z7ooGWu/rjc7mliyg+TeM6knSogqP7L0HVhfY5CPBkHosA4w7UAJrATbo+F
 hI++p+63HUR6Po4IrSbRCCnYuItBAPxqKSRSDW7EMELn4xtw6kx8eH+Pk8Zv6R98IloG
 /JmIbSdWtMEy7LPkCRMWhcr/OfNA7qyz2oTg3ACJDF3MRjyr2tYqsVc71fHUR9/GREkK
 k3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+uIhEKx3FaRyIVD+mj3dSeccwcC+YlKBKzq2myhB5rM=;
 b=kbCqKNUq++rSXDMqzcxoZ3mHCAUcbVNVtvEG9sgEK12NEPAOAWoG8LSRkmrtDIfOJ6
 OEZ0/grZYPKfEu3q6U/BX9+JesQbOVgYLVXY6/uJYKrA6YjSLxYM/IspK2egZa/6ZD6q
 gnvh2BnqzYQYdfC3bI/j0iN0HeHEJTTVENz3ngdESbfLV+DjoLRa+m55PitzQ0u7hjPi
 N2A4p9nJ1mAASKbpJtNCYI4B87QCgUZ5qD3oywhK1pGgt00cMn1TmhaNkXboD9VQlC2d
 FynqWt+3a3sPBPXoimPqJvohSio+3qTmZZgbIUMGD4NC2a9YucphIElQovLuha23mggQ
 WAWg==
X-Gm-Message-State: AOAM532TB4SmdW/dhgdBlia8oq2pscHMJrNH4adoODUP1f69WTNsdj6S
 5jyCxkCVaeBpDirN5zQq+UEkxWLlYWh6zA==
X-Google-Smtp-Source: ABdhPJylvAfTk/dOlJVbXRizvq+wCTL3IavLUrdlT3i86GwdzKT1k3FZvLP99mV3Hi5xFC+8fzxriw==
X-Received: by 2002:aa7:9af6:0:b0:4a2:fa4a:714c with SMTP id
 y22-20020aa79af6000000b004a2fa4a714cmr13791584pfp.40.1637230009223; 
 Thu, 18 Nov 2021 02:06:49 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id om8sm8528940pjb.12.2021.11.18.02.06.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Nov 2021 02:06:49 -0800 (PST)
Date: Thu, 18 Nov 2021 18:04:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs-utils: check the return value of erofs_d_alloc
Message-ID: <20211118180423.0000724e.zbestahu@gmail.com>
In-Reply-To: <20211117102120.30203-1-huangjianan@oppo.com>
References: <20211117102120.30203-1-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, yh@oppo.com, guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 17 Nov 2021 18:21:19 +0800
Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org> wrote:

> Need to check whether the allocation of erofs_dentry is successful.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  lib/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 5cbfc78..2fa74e2 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -162,11 +162,15 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
>  
>  	/* dot is pointed to the current dir inode */
>  	d = erofs_d_alloc(dir, ".");
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
>  	d->inode = erofs_igrab(dir);
>  	d->type = EROFS_FT_DIR;
>  
>  	/* dotdot is pointed to the parent dir */
>  	d = erofs_d_alloc(dir, "..");
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
>  	d->inode = erofs_igrab(dir->i_parent);
>  	d->type = EROFS_FT_DIR;
>  

Looks good to me

Reviewed-by: Yue Hu <huyue2@yulong.com>
