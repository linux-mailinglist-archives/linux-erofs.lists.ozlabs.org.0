Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F245F4752
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:16:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhjVr67nkz30NS
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:16:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=otqypTAr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=otqypTAr;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhjVm4Tl9z2xyB
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:16:00 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 022CB614B0;
	Tue,  4 Oct 2022 16:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45BEC433C1;
	Tue,  4 Oct 2022 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664900157;
	bh=mTxm81WlhwLNeRXNGoYwb+9o4PCxVTEvJixOWIHQsdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otqypTAr/BrDIZ8W97oecwmS4KZg4kiV+9w0XPA93Zctd0ZvyauiIioYlcCuR/qCM
	 9MRtUIzdvEx53ihOID3PuY7O9dTQS8TNMApT0dPcfouOxaC0qLqMf0cfJdt4Texv4Z
	 c3Dt644lHkkdyRwld3JnPj3b9cW6FK4JZZuOKf5ZKxIsPCrjIuh2aM0GBEAxu2VctI
	 jAy71Dyzgyef7DWAQ06f2Yqa0poVYg1y5ZwMn69XzdBdJI76r/y0MhGMIUOpWOxyGg
	 HH6vKbLnHzT/JCNNduOydHpw83Pq4sWZadeuIVpN980WJztCf/SPNrELgrUT3ZOWPp
	 bsiUBffWcCccw==
Date: Wed, 5 Oct 2022 00:15:53 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Message-ID: <YzxcOcJK+8gB8psP@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <20221004160237.10849-1-naoto.yamaguchi@aisin.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004160237.10849-1-naoto.yamaguchi@aisin.co.jp>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Naoto,

On Wed, Oct 05, 2022 at 01:02:37AM +0900, Naoto Yamaguchi wrote:
> The erofs_super_block has volume_name field.  On the other hand,
> mkfs.erofs is not supporting to set volume name.
> This patch add volume-name setting support to mkfs.erofs.
> Option keyword is similar to mkfs.vfat.
> 
> usage:
>   mkfs.erofs -n volume-name image-fn dir

Thanks for your patch! The patch itself generally looks good to me.


Just two minor ideas:

1) How about following mke2fs by using "-L volume-label" ?
https://www.man7.org/linux/man-pages/man8/mke2fs.8.html

2) If possible, how about adding a kernel ioctl for this if you have
more interest?  I mean FS_IOC_GETFSLABEL.

> 
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> ---
>  include/erofs/internal.h |  1 +
>  man/mkfs.erofs.1         |  4 ++++
>  mkfs/main.c              | 13 ++++++++++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 2e0aae8..7dc42eb 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -92,6 +92,7 @@ struct erofs_sb_info {
>  	u64 inos;
>  
>  	u8 uuid[16];
> +	char volume_name[16];
>  
>  	u16 available_compr_algs;
>  	u16 lz4_max_distance;
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 11e8323..fb98505 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -32,6 +32,10 @@ big pcluster feature if needed (Linux v5.13+).
>  Specify the level of debugging messages. The default is 2, which shows basic
>  warning messages.
>  .TP
> +.BI "\-n " volume-name
> +Set the volume name for the filesystem to volume-name.  The maximum length of
> +the volume name is 16 bytes.
> +.TP
>  .BI "\-x " #
>  Specify the upper limit of an xattr which is still inlined. The default is 2.
>  Disable storing xattrs if < 0.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 594ecf9..613ee46 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -80,6 +80,7 @@ static void usage(void)
>  	fputs("usage: [options] FILE DIRECTORY\n\n"
>  	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
>  	      " -d#                   set output message level to # (maximum 9)\n"
> +	      " -n volume-name        set the volume name (max 16 bytes).\n"

...

>  	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
>  	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
>  	      " -C#                   specify the size of compress physical cluster in bytes\n"


	      " -L volume-label       set the volume label (maximum 12)\n"

Thanks,
Gao Xiang
