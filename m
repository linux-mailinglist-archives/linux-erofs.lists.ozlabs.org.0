Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03278FE031
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 09:53:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9wb98Io;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvxR523Bjz3d9L
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 17:53:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9wb98Io;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvxQz5jqMz30V7
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 17:53:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717660404; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wU4aWe9lqMK97Py3uzxMLp6BmGrLhJsbmKbaQFbGox0=;
	b=I9wb98IofK2r7Zg4wtqxF2WNTNE8fdft0Rj791xtnvTUcKEr3dIJjk2G3jy/vGYuhajx5Kb0GzlhfrisCdoKYgHPNmqcS5NCviFrhYtL+7vRn8mZVTAuZe+duUVW0Z4hWju7Bm53BNQJXINRWfNCBbTns0GqbQOwPI1F+FEtYFk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7xd-px_1717660402;
Received: from 30.97.48.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7xd-px_1717660402)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 15:53:23 +0800
Message-ID: <903826ba-86f7-4c7a-8f11-0883ab9a44eb@linux.alibaba.com>
Date: Thu, 6 Jun 2024 15:53:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build: support building static library liberofsfuse
To: ComixHe <heyuming@deepin.org>
References: <64B0656069715534+20240606041826.46688-1-heyuming@deepin.org>
 <3399126AB01D5AB6+2bad5767fc035a7a2234408b0fffa53b3a07aa51.1717659178.git.heyuming@deepin.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3399126AB01D5AB6+2bad5767fc035a7a2234408b0fffa53b3a07aa51.1717659178.git.heyuming@deepin.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/6 15:39, ComixHe wrote:
> add new option '--enable-static-fuse' so that we
> could import erofsfuse as a static library directly
> into other projects
> 
> Signed-off-by: ComixHe <heyuming@deepin.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   configure.ac     | 7 +++++++
>   fuse/Makefile.am | 9 +++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 1989bca..f756139 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -147,6 +147,12 @@ AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
>   
> +AC_ARG_ENABLE([static-fuse],
> +    [AS_HELP_STRING([--enable-static-fuse],
> +                    [build erofsfuse as a static library @<:@default=no@:>@])],
> +    [enable_static_fuse="$enableval"],
> +    [enable_static_fuse="no"])
> +
>   AC_ARG_WITH(uuid,
>      [AS_HELP_STRING([--without-uuid],
>         [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
> @@ -525,6 +531,7 @@ AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
> +AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
>   
>   if test "x$have_uuid" = "xyes"; then
>     AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 7eae5f6..c5c5696 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -8,3 +8,12 @@ erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
>   erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>   erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
>   	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
> +
> +if ENABLE_STATIC_FUSE
> +lib_LIBRARIES = liberofsfuse.a
> +liberofsfuse_a_SOURCES = main.c
> +liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
> +liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
> +liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
> +	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
> +endif
