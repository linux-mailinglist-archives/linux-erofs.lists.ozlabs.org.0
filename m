Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D964D80F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:53:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXmHG2MPWz3bWq
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:53:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXmH5547dz3bP1
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:53:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VXMHvCj_1671094411;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXMHvCj_1671094411)
          by smtp.aliyun-inc.com;
          Thu, 15 Dec 2022 16:53:32 +0800
Date: Thu, 15 Dec 2022 16:53:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH v3 1/3] configure: use AC_SYS_LARGEFILE
Message-ID: <Y5rgio/1qNZaicRz@B-P7TQMD6M-0146.local>
References: <20221215064758.93821-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215064758.93821-1-raj.khem@gmail.com>
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

On Wed, Dec 14, 2022 at 10:47:56PM -0800, Khem Raj wrote:
> The autoconf macro AC_SYS_LARGEFILE defines _FILE_OFFSET_BITS=64
> where necessary to ensure that off_t and all interfaces using off_t
> are 64bit, even on 32bit systems.
> 
> Pass -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=66 via CFLAGS

                             ^ -D_FILE_OFFSET_BITS=64?

> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  configure.ac | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index a736ff0..e8bb003 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -13,6 +13,8 @@ AC_CONFIG_MACRO_DIR([m4])
>  AC_CONFIG_AUX_DIR(config)
>  AM_INIT_AUTOMAKE([foreign -Wall])
>  
> +AC_SYS_LARGEFILE

Do we still need this? Also it introduces --disable-largefile and which
will break the functionality to us.

Also see:
https://lore.kernel.org/linux-xfs/1480552932-614-1-git-send-email-ebiggers@google.com

Otherwise looks good to me.

Thanks,
Gao Xiang

> +
>  # Checks for programs.
>  AM_PROG_AR
>  AC_PROG_CC
> @@ -319,6 +321,9 @@ if test "x$enable_lzma" = "xyes"; then
>    CPPFLAGS="${saved_CPPFLAGS}"
>  fi
>  
> +# Enable 64-bit off_t
> +CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
> +
>  # Set up needed symbols, conditionals and compiler/linker flags
>  AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
>  AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
> -- 
> 2.39.0
