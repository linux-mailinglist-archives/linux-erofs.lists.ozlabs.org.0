Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C72647170
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 15:19:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSbqx0Q6Kz3bfk
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 01:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d4pWivPj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d4pWivPj;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSbqn6Gl7z3bVf
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Dec 2022 01:19:01 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id ACF37B822DD;
	Thu,  8 Dec 2022 14:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6005BC433C1;
	Thu,  8 Dec 2022 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670509135;
	bh=OEc+cIWlhT1Q8+k53Qjysy7mwVCwFj45IlUW/qVF18s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4pWivPju2wIP7cWA/1+gZCNxPZZEP50RVJYGW4CaVH5Zew1eJ+W4AhBs14NMtPQL
	 ozD6clrJeR9dRU2a6w+qmfpw3695Fhy6FOZfWs30Dh+rUwVXvdjVqxC2dYYc7QIUxo
	 UlOHdnSDIWe4x/uwlEcS+PS06/t8+fpCxYpHjlTWAS4kiM93sRbmT3lTkxTr3d+gjj
	 6QFuCfgIaJis5CmRzHTLVsP03kg/PSIfICSJlXN38vvqPyV0TFICra000j0dIPrRnF
	 Yf3dKC8Fk48Ix2aG2nIGfEerJiMrqh7ScuEDXV3Jp0ySlUBnDOsHlOAEvBGHax6TSz
	 ucgfL5gWYg0aw==
Date: Thu, 8 Dec 2022 22:18:48 +0800
From: Gao Xiang <xiang@kernel.org>
To: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH 2/3] erofs_fs.h: Make LFS mandatory for all usecases
Message-ID: <Y5HySDMzY8CSLQeJ@debian>
Mail-Followup-To: Khem Raj <raj.khem@gmail.com>,
	linux-erofs@lists.ozlabs.org
References: <20221208085335.2884608-1-raj.khem@gmail.com>
 <20221208085335.2884608-2-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208085335.2884608-2-raj.khem@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Khem,

On Thu, Dec 08, 2022 at 12:53:34AM -0800, Khem Raj wrote:
> erosfs depend on the consistent use of a 64bit offset

Thanks for your patch!

  ^ erofs

> type, force downstreams to use transparent LFS (_FILE_OFFSET_BITS=64),
> so that it becomes impossible for them to use 32bit interfaces.
> 
> include autoconf'ed config.h to get definition of _FILE_OFFSET_BITS
> which was detected by configure. This header needs to be included
> before any system headers are included to ensure they see the correct
> definition of _FILE_OFFSET_BITS for the platform
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---

...

> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 6a70f11..9cc20a8 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -12,6 +12,7 @@ extern "C"
>  {
>  #endif
>  
> +#include <config.h>

could we use alternative way? since I'd like to make include/ as
liberofs later, and "config.h" autoconf seems weird to me...

>  #include "list.h"
>  #include "err.h"
>  
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 08f9761..a3bd93c 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -9,6 +9,8 @@
>  #ifndef __EROFS_FS_H
>  #define __EROFS_FS_H
>  
> +#include <sys/types.h>

Could you give more hints why we need this here? 

> +
>  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
>  #define EROFS_SUPER_OFFSET      1024
>  
> @@ -410,6 +412,10 @@ enum {
>  
>  #define EROFS_NAME_LEN      255
>  
> +
> +/* make sure that any user of the erofs headers has atleast 64bit off_t type */
> +extern int eros_assert_largefile[sizeof(off_t)-8];

erofs? also you could add this into erofs/internal.h...

This file is just the on-disk definition...

> +
>  /* check the EROFS on-disk layout strictly at compile time */
>  static inline void erofs_check_ondisk_layout_definitions(void)
>  {
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 3fad357..88400ed 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -28,7 +28,7 @@ noinst_HEADERS += compressor.h
>  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>  		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>  		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
> -liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
> +liberofs_la_CFLAGS = -Wall -I$(top_builddir) -I$(top_srcdir)/include -include config.h

same here too...

Thanks,
Gao Xiang

>  if ENABLE_LZ4
>  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
>  liberofs_la_SOURCES += compressor_lz4.c
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d2c9830..0e601d9 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -5,6 +5,7 @@
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
>   */
>  #define _GNU_SOURCE
> +#include "config.h"
>  #include <time.h>
>  #include <sys/time.h>
>  #include <stdlib.h>
> -- 
> 2.38.1
> 
