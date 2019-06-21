Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E54E0BC
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 09:01:42 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VV3Q28pqzDqdD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 17:01:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ILZQNeJR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VV3G3SGQzDqcg
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 17:01:30 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8457B2083B;
 Fri, 21 Jun 2019 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561100488;
 bh=BTcp4fDsaV7iSGi7Qev5B5v/M0ne6mptcsFgiq3fBgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ILZQNeJRHbANYzoHXQoj0Y4zkQFkLgV6ouY1Bxs2h2elJf1LuTOM2aBk+1vS+Atf9
 NN3bGFOYynXpWAEO1s2rL2hJ4mP6r7dwjIxBtc5I3MoXxKw8Lgg4RplQz3yew4p3vt
 q79wV7YlfhcoiEj5tg/x/T7xz4JBeqPHZ/BIT4eM=
Date: Fri, 21 Jun 2019 09:01:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
Message-ID: <20190621070125.GB3029@kroah.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620083004.2488-1-zbestahu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 20, 2019 at 04:30:04PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> erofs_xattr_security_handler is already marked __maybe_unused, no need
> to add CONFIG_EROFS_FS_SECURITY condition.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/staging/erofs/xattr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> index df40654..06024ac 100644
> --- a/drivers/staging/erofs/xattr.c
> +++ b/drivers/staging/erofs/xattr.c
> @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>  	.get	= erofs_xattr_generic_get,
>  };
>  
> -#ifdef CONFIG_EROFS_FS_SECURITY
>  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
>  	.prefix	= XATTR_SECURITY_PREFIX,
>  	.flags	= EROFS_XATTR_INDEX_SECURITY,
>  	.get	= erofs_xattr_generic_get,
>  };
> -#endif

It's nicer just to leave this as-is for now, the memory savings isn't
much at all.

thanks,

greg k-h
