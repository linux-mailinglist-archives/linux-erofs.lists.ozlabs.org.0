Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A34CAF5
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 11:35:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TxWD0hdszDrK0
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 19:35:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxfZsr2/"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TxJd1gsXzDr7K
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 19:26:08 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id bh12so1154650plb.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sIC/r9ILTKFA7UFgU9ef3w5oCNBGVZQmgnGIx0VANXU=;
 b=HxfZsr2/saxJkz5tnzF163FsNq6+3F4K3B0ztdDfk4BT+TBRG6QYE9TmQ5hk171XQF
 97KemhHwTLZ+oY6wf7bH9+1WfFHNSJ/luspsTqSFvUf2WkXRbjmyPf3LVbkAZ2FuhSau
 MgvMShvm0YbOniTMJPjfQqgG9JNQrmbgx7Kae2oQFf417bo5pgfXAL4beXAh/WlXRXfT
 NKC+vE4RAWawxEwdd7IKBD77JllfYEdQsab4slPcFg257l/asQeDT+kwwKf3B5d3gwqM
 1LkTp3BinanFPLmXtMAtqZAhSF0l3tTna4L0GYNpChrzRP3ppglxj1/D7QH268QMLn6Z
 c5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sIC/r9ILTKFA7UFgU9ef3w5oCNBGVZQmgnGIx0VANXU=;
 b=espjmg+Yvv/ioahJh55e/LObyrkPNQxh/T5hPTKIsbxSQw1EpP7caqqs0xsOCSWl7K
 Ei7MEBtTMZPf42MTk3N8wXJmZ16u4K5+yonPQOqn/64/y5QyuSi8EeZcN7rc6nOvgOzm
 NQmminjvcQ2Zy2Gii8bw+2PX07kB8PstNusO/kVvSFYDSX7CaqFlAzjWH7iZHPZVfYXa
 Y68KlbZWNADiBiTLFI0Xf/LV0BTVXNouQ28WhjL2k+lzl1sx4oAHHQtv4uSz15/Nx9/2
 tVfGBfWSa+rE0I0bzZnc+4d+/XhI27CnsB8j7XvILY0cwaMFqr9TEDipB1NRRE6Ce/8H
 XHSQ==
X-Gm-Message-State: APjAAAVcHRp+eDLT/FI+XWHisGwsntY62JkP+rUQf9AQMizg4b6eU18S
 tOxdOKMW73p5HqojJV30kII=
X-Google-Smtp-Source: APXvYqyBJXB4xpJjeH9IWzCZUK+ikOdJXOZPeNfi1qNCJJg5VSUqKfj6KI83RCMIVB4t6xlFCDHVfA==
X-Received: by 2002:a17:902:8609:: with SMTP id
 f9mr115075002plo.252.1561022765141; 
 Thu, 20 Jun 2019 02:26:05 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id p68sm21460384pfb.80.2019.06.20.02.26.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 02:26:04 -0700 (PDT)
Date: Thu, 20 Jun 2019 17:25:52 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
Message-ID: <20190620172552.000015bd.zbestahu@gmail.com>
In-Reply-To: <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
 <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
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
Cc: gregkh@linuxfoundation.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 20 Jun 2019 16:32:01 +0800
Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Yue,
> 
> On 2019/6/20 16:30, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > erofs_xattr_security_handler is already marked __maybe_unused, no need
> > to add CONFIG_EROFS_FS_SECURITY condition.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/staging/erofs/xattr.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> > index df40654..06024ac 100644
> > --- a/drivers/staging/erofs/xattr.c
> > +++ b/drivers/staging/erofs/xattr.c
> > @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> >  	.get	= erofs_xattr_generic_get,
> >  };
> >  
> > -#ifdef CONFIG_EROFS_FS_SECURITY
> >  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
> >  	.prefix	= XATTR_SECURITY_PREFIX,
> >  	.flags	= EROFS_XATTR_INDEX_SECURITY,
> >  	.get	= erofs_xattr_generic_get,
> >  };
> > -#endif  
> 
> Thanks for your patch.
> 
> In that case...erofs_xattr_security_handler could be compiled into .rodata section?
> I am not sure...

Yes, just like erofs_xattr_user_handler as below in System.map.

ffffffff820ec2a0 R erofs_xattr_security_handler
ffffffff820ec2e0 R erofs_xattr_trusted_handler
ffffffff820ec320 R erofs_xattr_user_handler

Thx.

> 
> Thanks,
> Gao Xiang
> 
> >  
> >  const struct xattr_handler *erofs_xattr_handlers[] = {
> >  	&erofs_xattr_user_handler,
> >   

