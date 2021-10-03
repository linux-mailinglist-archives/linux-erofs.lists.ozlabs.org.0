Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2D41FFD2
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 06:41:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HMWQF2ZtPz2yQ3
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 15:41:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q2O1hlS8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q2O1hlS8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HMWQB2F4jz2yMg
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Oct 2021 15:41:22 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1665461B1F;
 Sun,  3 Oct 2021 04:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633236079;
 bh=3cYkoqqatitoP9g5w4WYrCaUTeAI6MLablIs+alWkM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q2O1hlS88aohHGIsj/XGmcDmHSjeIR0yiqZlvLOEWThvJCPWUq2CXqhnRT7T+BCb2
 hQaPcl+0F3nHM7n8PnfJY1gnV4fPrUDw1BZcBhAUruDmcVHLTRjd3Jodr4Pn4eQRNm
 ssdfNwNmyGDp9zs+8mmDzJgjff9h+wmsWyBv72yFO4BEsIEgoP2PsTdOPU7dWZcZIM
 9fxdQsQMk2FohJK50S0quFqmQoPkVg21j5k6YXYsGFBLZknlPZW70eiUsrrB2AzqQ7
 3ECWsT9/Ulf0ZAQCMGH0qUp3/coUh6Fv1GQ9nnPOrqfyqJ3imXEraoNaN6eMd/j6ZT
 tL11y+KtRGg/w==
Date: Sun, 3 Oct 2021 12:41:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] erofs-utils: dump: fix linking when using --with-selinux
Message-ID: <20211003044112.GB9546@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: David Michael <fedora.dm0@gmail.com>,
 linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com,
 miaoxie@huawei.com, fangwei1@huawei.com, xiang@kernel.org,
 yuchao0@huawei.com
References: <875yufoxvi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875yufoxvi.fsf@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, yuchao0@huawei.com, bluce.liguifu@huawei.com,
 miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Sat, Oct 02, 2021 at 06:38:57PM -0400, David Michael wrote:
> The libselinux functions selabel_open and selabel_close are called
> by lib/config.c, so include libselinux in CFLAGS and LIBS to fix
> building dump.erofs.
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> I tried building the dev branch with SELinux support and got this:
> 
> /bin/sh ../libtool  --tag=CC   --mode=link x86_64-pc-linux-gnu-gcc -Wall -Werror -I../include -O2 -pipe  -Wl,-O1 -Wl,--as-needed -o dump.erofs dump_erofs-main.o ../lib/liberofs.la -luuid  
> libtool: link: x86_64-pc-linux-gnu-gcc -Wall -Werror -I../include -O2 -pipe -Wl,-O1 -o dump.erofs dump_erofs-main.o  -Wl,--as-needed ../lib/.libs/liberofs.a -luuid
> /usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_exit_configure':
> config.c:(.text+0xe2): undefined reference to `selabel_close'
> /usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_selabel_open':
> config.c:(.text+0x180): undefined reference to `selabel_open'
> collect2: error: ld returned 1 exit status
> 
> Should it just link libselinux to fix the build?

Many thanks for the patch! My nightly CI environment doesn't cover selinux build yet.
It should be fixed.

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
> 
>  dump/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index 0bb7b4e..f0246d7 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
>  AM_CPPFLAGS = ${libuuid_CFLAGS}
>  dump_erofs_SOURCES = main.c
>  dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> -dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
> \ No newline at end of file
> +dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS}
> -- 
> 2.31.1
