Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59894283D3
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:32:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFWk3ttfz2yTr
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:32:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kg2QzZ7J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Kg2QzZ7J; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFWf5G2kz2xtR
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:32:30 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EDDA61078;
 Sun, 10 Oct 2021 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901548;
 bh=BZE2h9T8kyoATakOTh1LoFvV5zvzgcuKHtqR+EVL11M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kg2QzZ7JGpiNKtuXDrwRJ//c7Hmv4APTJv5h8yQooetJFE0bDaMkINRoqZm0C9dzi
 tMZj0s/bkrl/yEDXrhHzCtkkl62Pj3TiEAwKA9zy7AOvhveV1QSz5HaJNSP70AReBb
 FuGFqAEiYajXnmiewHLfQBkUS4Gccn1fXxaRzERg4GC46MURkJwZVeRtZySjp7YIxG
 0/CoXFcKBEDfXeYBm9UWJTbmPr3XeCSn9KZRBE97Z6H/rRyEpkQWiVmrw8x+yPdKrz
 wexsk7LeyAkajNdmF17ttebxfOXxvOIYcp0ioYvTE4PUp4vmg6RKA5V87YE3MZ0NOB
 qHaS/cZg0TDfQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] lib/xz, lib/decompress_unxz.c: Fix spelling in comments
Date: Mon, 11 Oct 2021 05:31:43 +0800
Message-Id: <20211010213145.17462-6-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Lasse Collin <lasse.collin@tukaani.org>

uncompressible -> incompressible
non-splitted -> non-split

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress_unxz.c | 10 +++++-----
 lib/xz/xz_dec_lzma2.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index f7a3dc13316a..9f4262ee33a5 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -20,8 +20,8 @@
  *
  * The worst case for in-place decompression is that the beginning of
  * the file is compressed extremely well, and the rest of the file is
- * uncompressible. Thus, we must look for worst-case expansion when the
- * compressor is encoding uncompressible data.
+ * incompressible. Thus, we must look for worst-case expansion when the
+ * compressor is encoding incompressible data.
  *
  * The structure of the .xz file in case of a compressed kernel is as follows.
  * Sizes (as bytes) of the fields are in parenthesis.
@@ -58,7 +58,7 @@
  * uncompressed size of the payload is in practice never less than the
  * payload size itself. The LZMA2 format would allow uncompressed size
  * to be less than the payload size, but no sane compressor creates such
- * files. LZMA2 supports storing uncompressible data in uncompressed form,
+ * files. LZMA2 supports storing incompressible data in uncompressed form,
  * so there's never a need to create payloads whose uncompressed size is
  * smaller than the compressed size.
  *
@@ -167,8 +167,8 @@
  * memeq and memzero are not used much and any remotely sane implementation
  * is fast enough. memcpy/memmove speed matters in multi-call mode, but
  * the kernel image is decompressed in single-call mode, in which only
- * memmove speed can matter and only if there is a lot of uncompressible data
- * (LZMA2 stores uncompressible chunks in uncompressed form). Thus, the
+ * memmove speed can matter and only if there is a lot of incompressible data
+ * (LZMA2 stores incompressible chunks in uncompressed form). Thus, the
  * functions below should just be kept small; it's probably not worth
  * optimizing for speed.
  */
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 46b186d7eb45..27ce34520e78 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -520,7 +520,7 @@ static __always_inline void rc_normalize(struct rc_dec *rc)
  * functions so that the compiler is supposed to be able to more easily avoid
  * an extra branch. In this particular version of the LZMA decoder, this
  * doesn't seem to be a good idea (tested with GCC 3.3.6, 3.4.6, and 4.3.3
- * on x86). Using a non-splitted version results in nicer looking code too.
+ * on x86). Using a non-split version results in nicer looking code too.
  *
  * NOTE: This must return an int. Do not make it return a bool or the speed
  * of the code generated by GCC 3.x decreases 10-15 %. (GCC 4.3 doesn't care,
-- 
2.20.1

