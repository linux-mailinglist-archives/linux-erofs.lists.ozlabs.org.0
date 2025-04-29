Return-Path: <linux-erofs+bounces-270-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B44AA0DF6
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 15:54:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zn1ys2K9pz30Vy;
	Tue, 29 Apr 2025 23:54:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745934885;
	cv=none; b=e08ivsayAReWnaodoNQYMHmRsyWg4BXLySMuzvMQ06Ty4F/WZOuhak62r73CTTnidkRNtMbBYLPXzUVEKoMUiqLEE6I8d7R/J4Ktr0AqXIKFOjfFVgpeu7PSVSOFG68R+pSciBHouu3LbADYVkdTZk2duehn+aJU59CxXkQgql4OwbQ2pu12Ei98ef7r862xmcqemybJOQEX/pW9Qp3TGk97iqWErTfN0UnIXi4hTKEtA/vv1lsVFORvojv2U1+RQb6vVhEQmmJhlvmu6DC3+x+KwtMt3IKRxgDQyb82Y0WYBERVOI8rqTUjlTgPVKQr9wPSPsB/Im1qbmpTW4E3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745934885; c=relaxed/relaxed;
	bh=g/1AMs9gTwWi9IYQnT9945hFSVSyCAbNlUK2wflFeCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAgkuF/1XEH/mbSpIGr/5CtZ1ITB6xIO7hUPlSrL298tHnCxb5edudyBf/LeHtj6AjaCzR7T2SVBe9qATuDzWVtgucxgc6t7U0CaDI9Xr7kgO/TrH/3KB2tCLCd6Jd8xLqcc7gAfwOO5H/vf5/EBnz4rU/XwKT9jeuMjlsi/rWQ08vGWUyW0VwJRj9XiL1gp7e12cOSmD/ka+EYS/rS4UGRLROVwBeSO7UzTsge7m9d97+KVjJkV3nvveIXJp1gjie+Mj9gMJ7R+3ryVSONNn+pVA/Ds2Bfy9b9GY8afclbOj3KyMZYr+iiTT4M1hkbBZk2s7KFE4qhrAQGkO6C9Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gB8RDVTE; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gB8RDVTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zn1yq02XHz30Tm
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 23:54:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A32CA4B4D6;
	Tue, 29 Apr 2025 13:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A859C4CEE3;
	Tue, 29 Apr 2025 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934880;
	bh=8v49i3m44AsbGJeT2yKfNY19q3FOegNFZ6oMOv789W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB8RDVTEWoqDU3jzMG8gyyCMKwXs+G7h8EEkMjV7vaBB/EJayXHL+V83cSzxLil4P
	 s4tPvyKx58WDMcfHZfxkFle1uY4ykXTWWLQqClaCV9r6Iuy0V1wQVjIsQe/xOfBsPi
	 zEOZe+BmXZvDpFOqo6SLYHm5YauzSPrzgnghI71Vr+oSbDJH7byK8lY0zyx1GlKl5l
	 8JO+Y2IOP9sfK8PJRkK3SjdVQpi0+RwBePaYJeJHrdHasLuAyt3Qgc9W0H9HFiqsDO
	 orG4VqrZY2uh30xGux5Da4x0TK9W///ZE+svPkOvUhKHBt6ioK/VL1/2ttdtSo5zv8
	 FrJ2QwBk/dWOw==
Date: Tue, 29 Apr 2025 21:54:34 +0800
From: Gao Xiang <xiang@kernel.org>
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 1/1] erofs-utils: fix endiannes issue
Message-ID: <aBDaGgtXhaCr9p0p@debian>
Mail-Followup-To: Alexander Egorenkov <egorenar@linux.ibm.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20250429073052.53681-1-egorenar@linux.ibm.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429073052.53681-1-egorenar@linux.ibm.com>
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Alexander,

On Tue, Apr 29, 2025 at 09:30:52AM +0200, Alexander Egorenkov wrote:
> From: Super User <root@a8345034.lnxne.boe>

Thanks for catching this, the "From:" line seems invalid, so
I change it as "From: Alexander Egorenkov <egorenar@linux.ibm.com>"

> 
> Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
> user space header 'endian.h'. Not including this header results in
> the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true, even on
> BE architectures (e.g. s390x). Due to this bug the compressor library was
> built for LE byte-order on BE arch s390x.
> 
> Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned access")
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  include/erofs/defs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 051a270531ca..196dfa8191a8 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -19,6 +19,7 @@ extern "C"
>  #include <inttypes.h>
>  #include <limits.h>
>  #include <stdbool.h>
> +#include <endian.h>

I guess it could break MacOS compilation, so I update as below:

From d55344291092b69a2ba6f11dbcda52fa534ac124 Mon Sep 17 00:00:00 2001
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Tue, 29 Apr 2025 09:30:52 +0200
Subject: [PATCH] erofs-utils: fix endiannes issue

Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
user space header 'endian.h'. Not including this header results in
the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true,
even on BE architectures (e.g. s390x). Due to this bug the compressor
library was built for LE byte-order on BE arch s390x.

Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned access")
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Ian Kent <raven@themaw.net>
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac         |  1 +
 include/erofs/defs.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6e1e7a1..88f1cbe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,7 @@ AC_ARG_WITH(selinux,
 AC_CHECK_HEADERS(m4_flatten([
 	dirent.h
 	execinfo.h
+	endian.h
 	fcntl.h
 	getopt.h
 	inttypes.h
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 051a270..21e0f09 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -24,6 +24,21 @@ extern "C"
 #include <config.h>
 #endif
 
+#ifdef HAVE_ENDIAN_H
+#include <endian.h>
+#else
+/* Use GNU C predefined macros as a fallback */
+#ifndef __BYTE_ORDER
+#define __BYTE_ORDER	__BYTE_ORDER__
+#endif
+#ifndef __LITTLE_ENDIAN
+#define __LITTLE_ENDIAN	__ORDER_LITTLE_ENDIAN__
+#endif
+#ifndef __BIG_ENDIAN
+#define __BIG_ENDIAN	__ORDER_BIG_ENDIAN__
+#endif
+#endif
+
 #ifdef HAVE_LINUX_TYPES_H
 #include <linux/types.h>
 #endif
-- 
2.30.2


