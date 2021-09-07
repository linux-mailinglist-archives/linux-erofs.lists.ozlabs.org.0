Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD27402194
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 02:09:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3Qc03KRjz2y8S
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 10:09:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KHR6II5O;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KHR6II5O; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3Qbt5H1gz2xtV
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 10:08:58 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E67C16109D;
 Tue,  7 Sep 2021 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630973333;
 bh=vlUmG5pl2Xe/uQ1PMtDbqvqcJrY8WMLZ9fl8jeqUGD4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KHR6II5OOz2nfXYUjSXfIw6WnAZEBqX2+0MAwYdZn02bPOGlUGEQ1dQ7nYYp85AHj
 4lN1pu3gUmWydY/nOle4b7HRa6dXGmSQuk6seohRJGjgxv3ZB32W+K3atya0DxOhKo
 CtcCP5IbTvmJesn1TYQILBRToQWYnR3hOBxmHDzup8AJiYhs7Vde32+v3sEGKZlLdz
 CW+Y+9Dxkp3BT4gEhWn2SMir++jEp4LJb98yFMGoLANtQSHjxRVj5SD86OCcnQxzDD
 ArOTe3WFpLsGhbVknU9m5GDii/kHXzMFlghzSQ6qRcnXI3t6hWVqu3cbBEjbpHYnoo
 fRVvrhSiB8Y2w==
Date: Tue, 7 Sep 2021 08:08:30 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: remove unnecessary "\n"
Message-ID: <20210907000824.GB23541@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210906081359.17440-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906081359.17440-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 06, 2021 at 04:13:58PM +0800, Huang Jianan via Linux-erofs wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  lib/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 5bad75e..0ad703d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -744,7 +744,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  			  cfg.target_out_path,
>  			  &uid, &gid, &mode, &inode->capabilities);
>  
> -	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64 "\n",
> +	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64,
>  		  fspath, mode, uid, gid, inode->capabilities);

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

>  
>  	if (decorated)
> -- 
> 2.25.1
> 
