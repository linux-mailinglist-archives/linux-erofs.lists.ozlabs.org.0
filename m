Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51E6A91AD
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 08:23:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSfbG1789z3cdb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 18:23:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iEgegoUf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iEgegoUf;
	dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSfb71qmQz3cK6
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 18:23:29 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id h8so1793888plf.10
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Mar 2023 23:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677828206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz93y4kdxoZ7hJ0xuk+CK0VVYtlFxJEX4hat/VAoNdY=;
        b=iEgegoUfCH7h7UUe0htn6FFMe69sN/kbKTOydrIbSpyZCHny8htDhEMx/TolXDY8Ut
         eZULpTs77c3wUmd6IgdgyIcGDTLjRKFCABl3XYZHkcvsfblTp9EIIKoDbJc4zczbhC7K
         nI+2FHbD5qn1NzjDJRgpBLTnk1WNgD465zGQOTPrL+ZgcRgFD+mKxMR6UM3DXu02Xz7z
         3Vy9Eu9ZKp8bUvrhltKqxGXQTjXLPh79OSlMXQq6ZZ2y9ZFdaUG3iZ971lCbfQs/Goy5
         715uw5scNmfQku3KxZM9NPjWYlSDPEFvgtnj1zzL+TXR7xMEmxHtGNQhltdg/PksrKCO
         qTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677828206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz93y4kdxoZ7hJ0xuk+CK0VVYtlFxJEX4hat/VAoNdY=;
        b=l2iv2iWTVADt+zGoKZyZZTIRea18Uw8FubTeHldZPuh5ZpRUtijHc+8svtESAA7SwM
         l9UCH8p+jvwdOEtOE8nEgFpnqRjim3A6t+/IM7gRCjBE23FfC8z8skWVYluCmk2WNmtv
         y869yBtvuxnvU/mDDPBW69sJNXjlUHfFRefEWV/VIiDse8UbxyUUgjqNrrvwoLUQFnwi
         ziKxs/6hwwSpUxGtgvBsr/ygOvuxZu8DEmkXxXIe0GhFWxOUPHDvDW79ECGehyt/0uQ/
         amOMQlDWFEzMDorlZv54f6fi6En+iZi/cJwIa3XuFhhX+tpJhcoTebtvf6vTRobR8QIw
         S1xg==
X-Gm-Message-State: AO0yUKWiYaAEXJ3XVi7z25bVBJRmpysIxLX/k5jsAwuJe6oXsc0Ydv0F
	77xcpTPyYvfzCvBSJHlRAOE=
X-Google-Smtp-Source: AK7set/PWCb3lresdBiBxYXymbS5tJ9mgK/xRyTK0LSPSUmQw+aF9UUa67AoPSmg8Vlo3XATWSqasA==
X-Received: by 2002:a05:6a20:244f:b0:be:a604:c683 with SMTP id t15-20020a056a20244f00b000bea604c683mr1344425pzc.45.1677828205823;
        Thu, 02 Mar 2023 23:23:25 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 19-20020a631253000000b004fb171df68fsm824216pgs.7.2023.03.02.23.23.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Mar 2023 23:23:25 -0800 (PST)
Date: Fri, 3 Mar 2023 15:29:37 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Message-ID: <20230303152937.0000571a.zbestahu@gmail.com>
In-Reply-To: <20230303063731.66760-1-frank.li@vivo.com>
References: <20230303063731.66760-1-frank.li@vivo.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  3 Mar 2023 14:37:31 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> v2:
> -change in internal.h
>  fs/erofs/decompressor_lzma.c | 2 +-
>  fs/erofs/internal.h          | 4 ++--
>  fs/erofs/pcpubuf.c           | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..307b37f0b9f5 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>  	}
>  }
>  
> -int z_erofs_lzma_init(void)
> +int __init z_erofs_lzma_init(void)
>  {
>  	unsigned int i;
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3f3561d37d1b..1db018f8c2e8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -486,7 +486,7 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  void *erofs_get_pcpubuf(unsigned int requiredpages);
>  void erofs_put_pcpubuf(void *ptr);
>  int erofs_pcpubuf_growsize(unsigned int nrpages);
> -void erofs_pcpubuf_init(void);
> +void __init erofs_pcpubuf_init(void);
>  void erofs_pcpubuf_exit(void);
>  
>  int erofs_register_sysfs(struct super_block *sb);
> @@ -545,7 +545,7 @@ static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP;
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> -int z_erofs_lzma_init(void);
> +int __init z_erofs_lzma_init(void);
>  void z_erofs_lzma_exit(void);
>  int z_erofs_load_lzma_config(struct super_block *sb,
>  			     struct erofs_super_block *dsb,
> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
> index a2efd833d1b6..c7a4b1d77069 100644
> --- a/fs/erofs/pcpubuf.c
> +++ b/fs/erofs/pcpubuf.c
> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>  	return ret;
>  }
>  
> -void erofs_pcpubuf_init(void)
> +void __init erofs_pcpubuf_init(void)
>  {
>  	int cpu;
>  

