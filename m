Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066A74860
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 09:45:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45vPQB6fp4zDqM4
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 17:45:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMONLicx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45vPQ304YWzDq5f
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jul 2019 17:45:13 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36067218F0;
 Thu, 25 Jul 2019 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564040710;
 bh=4d4wFnMkYJqkZ8QvmsNAcdLlP9iQNxnOeI7LmYCX3DY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZMONLicxnalE+3iPFx+MZnesFcmWR/qTAd5VfcOQd3n0EdQGCatNI8vUA2/CzP5H5
 xf7rWP9XW3rYdjaWIeO6vE2TuPPBNXQnfTF+AA659mI+KF3VmjToLxVZhPasjWqrqS
 K6Qzyk/FfrMvzNXuS5jFbgUMGCD3Ksp4n9whIwec=
Date: Thu, 25 Jul 2019 09:45:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Karen Palacio <karen.palacio.1994@gmail.com>
Subject: Re: [PATCH] v3: staging: erofs: fix typo
Message-ID: <20190725074508.GA15090@kroah.com>
References: <1563394279-6719-1-git-send-email-karen.palacio.1994@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563394279-6719-1-git-send-email-karen.palacio.1994@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, yucha0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 17, 2019 at 05:11:19PM -0300, Karen Palacio wrote:
> Fix typo in Kconfig
> 
> Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
> index d04b798..0dcefac 100644
> --- a/drivers/staging/erofs/Kconfig
> +++ b/drivers/staging/erofs/Kconfig
> @@ -88,7 +88,7 @@ config EROFS_FS_IO_MAX_RETRIES
>           If unsure, leave the default value (5 retries, 6 IOs at most).
> 
>  config EROFS_FS_ZIP
> -       bool "EROFS Data Compresssion Support"
> +       bool "EROFS Data Compression Support"
>         depends on EROFS_FS
>         select LZ4_DECOMPRESS
>         help
> ---
>  drivers/staging/erofs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
> index d04b798..0dcefac 100644
> --- a/drivers/staging/erofs/Kconfig
> +++ b/drivers/staging/erofs/Kconfig
> @@ -88,7 +88,7 @@ config EROFS_FS_IO_MAX_RETRIES
>  	  If unsure, leave the default value (5 retries, 6 IOs at most).
>  
>  config EROFS_FS_ZIP
> -	bool "EROFS Data Compresssion Support"
> +	bool "EROFS Data Compression Support"
>  	depends on EROFS_FS
>  	select LZ4_DECOMPRESS
>  	help

Patch is corrupted and can not be applied.

There are also 2 copies of it here :(

Please fix up and resend.

thanks,

greg k-h
