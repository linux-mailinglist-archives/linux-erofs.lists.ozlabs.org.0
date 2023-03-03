Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D126A9448
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 10:39:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSjcM4bXsz3cd1
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 20:39:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RROqCvkj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RROqCvkj;
	dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSjcC1P3dz3bg8
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 20:39:38 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id n6so2114683plf.5
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Mar 2023 01:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677836375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33gLk8Tw1nggbjQVuaZyK2nFl6qm0IvqWZy/T6zIY+Y=;
        b=RROqCvkjoeWR0pq9pQe6BP5NtfsxwaYokopXZaZ7oPolo6mhlmVeOSv5Vxev4WEZBK
         RVsNb1d0CnW+EjetTamvNLpqb1uAINPac9aMYv7Lk+NLnh4e7QzdFyN/dLccEMtdwMLd
         Pm+7Oi5Cg3iCRqCY3VJjkbjPn1NtqfuDsDe93hlBIdkSThLnA9TYiQw31vYDlA3Rr6aC
         V25+x/LUe9+b/65niWwztN00DDw7OKdYLbxU0sFMhgZ3NGUZ03O61MJ4+5aKxmUCB1/G
         4NHfJcqvDufX9yLrMnGH1XVQcGAgk1onALEHsriYEsfJ8ehrr8/ZC/zwYTWoXG03dXwa
         ulRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677836375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33gLk8Tw1nggbjQVuaZyK2nFl6qm0IvqWZy/T6zIY+Y=;
        b=G6/Rf16nRFAIlxaOGGK2KOPNFHKZaHsiezvesXkgX3IdSd1e1ogESS51jylWI+HEyU
         68LvuJdmPXOnx2kqSZGuUuaS8QhFFzFFiAEzoVYKL8vwlBiiyvkYPQQEvwwgO2brezx3
         PL8r6KhCOMP/cQTcbbbgY0wPjZbr6mYvYZ67qcxZN/kYj+n/EgdKQTmO3yT6iLo7nIkq
         nPm6CDwhJNl3CiedS70hj1LdBw8KeEgry44HXcX3mhOespkMf+SRBR9HRaKECcdhmI7D
         1W15yYTVs4O+v0fwYTM5AOK3Zjz3Qawepps6kohWaZyXnAlI+D9dIu8BR7kCz1VDbXQu
         vrmg==
X-Gm-Message-State: AO0yUKXjZKYHFVs7ToD3SDHpKMw2I6/XI7O6a1uMRJ80+03nz6mkQuVE
	ApW2tUyg/1zfO9Ab9lLE764=
X-Google-Smtp-Source: AK7set+D9aYrNbbecwDapGjW4oncmH5i1b6vAPv8ETeQyO+L/GJ9TW1ts0PgHDPaLNylas6IrMOa4A==
X-Received: by 2002:a17:902:e543:b0:19a:96d2:2407 with SMTP id n3-20020a170902e54300b0019a96d22407mr5976635plf.8.1677836374715;
        Fri, 03 Mar 2023 01:39:34 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b0019a8b057359sm1085846plf.130.2023.03.03.01.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Mar 2023 01:39:34 -0800 (PST)
Date: Fri, 3 Mar 2023 17:45:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Noboru Asai <asai@sijam.com>
Subject: Re: [PATCH] erofs: avoid useless memory allocation
Message-ID: <20230303174548.00000b0b.zbestahu@gmail.com>
In-Reply-To: <20230303075218.675733-1-asai@sijam.com>
References: <20230303075218.675733-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  3 Mar 2023 16:52:18 +0900
Noboru Asai <asai@sijam.com> wrote:

> The variable 'vi->xattr_shared_count' could be ZERO.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>
> ---
>  fs/erofs/xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 60729b1220b6..5164813a693b 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)
>  
>  	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
>  	vi->xattr_shared_count = ih->h_shared_count;
> +	if (!vi->xattr_shared_count)
> +		goto out_unlock;

Questions: ret = 0? no need to erofs_put_metabuf?

I think we can keep current since kmalloc_array() will check whether the
size(->xattr_shared_count) is zero size or not. rt?

>  	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
>  						sizeof(uint), GFP_KERNEL);
>  	if (!vi->xattr_shared_xattrs) {

