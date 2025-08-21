Return-Path: <linux-erofs+bounces-859-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FEDB2F479
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 11:48:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6z5d1Nndz30T8;
	Thu, 21 Aug 2025 19:48:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755769685;
	cv=none; b=H8vjrmb4KTngLI573MN/c/a8TKAfEc5Ujb9mgkEHcj5FqHlrfhI7u7PDd5eOcZNbYYDZHNrKJZEVHyeA/UF/OA0K5j0F9TLWmSUPmpaQ1TEWNdVngqL6sO6X3kxKiZS9Z9Mm+ghFu31n7WXP4U/SeWVFvFdzIeyzEOLgYmizFLfo/iBNXl1z3Z8xO2erwO5Zzt2gsLDgxx7W5u1Q/LBADuaU8Pgq4abdkshTfgaYhjHSiAYkDkQi6NuZuQft4+QVr1Z8f1344tNxprEerqno6d9LA8Chz4HNca2aS6BBBTlvwtudxhrB4EpUWxU2Qir35Lm9DHSQScrWCU7FnMeP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755769685; c=relaxed/relaxed;
	bh=CgJcbDKN+MTSvpgvbmZRd0uo1XfWR3RZXlsg6cyYMKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAedLudjj8aYB2aEsokLh8Tu6BRE1k/G1ggCJUu6Rl+NDe/CtQhe+/R130zUBptHmE1bRzMLVIe8rYBn74iuUDr9O4Bosmm6aCM3QPrGJJCUlETBat/KfWvZ7cpvj4O/LUZ/yXpTJGO1CJwOE+9/WrzWoTh41buUF6vw4CTWyTRs//XzWqB5BdjkWYVuaeRN89RuCwnDuFCkB4lnVz/YOpekUTYqq8s6Ez2kz6Et1KYIIRi4+fCjrQ2DRbwVn+EAfsRoyw4qaS6RZkAY2vwWr9+3GTrUo/kWrsUmtW3WHu0AtMC7AEDbkBGAlv1rtiz7y9rJV7OMfXloelbQtWxDFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=poqi0D9/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=poqi0D9/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6z5b0NGpz2ydj
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 19:48:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755769678; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CgJcbDKN+MTSvpgvbmZRd0uo1XfWR3RZXlsg6cyYMKM=;
	b=poqi0D9/xRJFDZppCNHNGUWBYObirlrXWaskXv0IjQSLYlm+7bWTjGr9gfZFOlwrr0zlZTzi3jJGCMEwIbKn+oPZ7TquR/uzdv4y/X6FoGGfZhHSuZImPXWOMc1q3I/M4sL+shn1l63lRuUAkfY9sA2jjkATIVzTCF7vj1qRZLs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmFdvw2_1755769674 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 17:47:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.16.y 2/2] erofs: Do not select tristate symbols from bool symbols
Date: Thu, 21 Aug 2025 17:47:49 +0800
Message-ID: <20250821094749.3665395-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
References: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 74da24f0ac9b8aabfb8d7feeba6c32ddff3065e0 upstream.

The EROFS filesystem has many configurable options, controlled through
boolean Kconfig symbols.  When enabled, these options may need to enable
additional library functionality elsewhere.  Currently this is done by
selecting the symbol for the additional functionality.  However, if
EROFS_FS itself is modular, and the target symbol is a tristate symbol,
the additional functionality is always forced built-in.

Selecting tristate symbols from a tristate symbol does keep modular
transitivity.  Hence fix this by moving selects of tristate symbols to
the main EROFS_FS symbol.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/da1b899e511145dd43fd2d398f64b2e03c6a39e7.1753879351.git.geert+renesas@glider.be
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
to address:
 https://lore.kernel.org/r/ca432b9e-e016-4d2d-b137-79def0aaca85@kernel.org

 fs/erofs/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7b26efc271ee..d81f3318417d 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,8 +3,18 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select CACHEFILES if EROFS_FS_ONDEMAND
 	select CRC32
+	select CRYPTO if EROFS_FS_ZIP_ACCEL
+	select CRYPTO_DEFLATE if EROFS_FS_ZIP_ACCEL
 	select FS_IOMAP
+	select LZ4_DECOMPRESS if EROFS_FS_ZIP
+	select NETFS_SUPPORT if EROFS_FS_ONDEMAND
+	select XXHASH if EROFS_FS_XATTR
+	select XZ_DEC if EROFS_FS_ZIP_LZMA
+	select XZ_DEC_MICROLZMA if EROFS_FS_ZIP_LZMA
+	select ZLIB_INFLATE if EROFS_FS_ZIP_DEFLATE
+	select ZSTD_DECOMPRESS if EROFS_FS_ZIP_ZSTD
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
 	  file system with modern designs (e.g. no buffer heads, inline
@@ -38,7 +48,6 @@ config EROFS_FS_DEBUG
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
-	select XXHASH
 	default y
 	help
 	  Extended attributes are name:value pairs associated with inodes by
@@ -94,7 +103,6 @@ config EROFS_FS_BACKED_BY_FILE
 config EROFS_FS_ZIP
 	bool "EROFS Data Compression Support"
 	depends on EROFS_FS
-	select LZ4_DECOMPRESS
 	default y
 	help
 	  Enable transparent compression support for EROFS file systems.
@@ -104,8 +112,6 @@ config EROFS_FS_ZIP
 config EROFS_FS_ZIP_LZMA
 	bool "EROFS LZMA compressed data support"
 	depends on EROFS_FS_ZIP
-	select XZ_DEC
-	select XZ_DEC_MICROLZMA
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing LZMA compressed data, specifically called microLZMA. It
@@ -117,7 +123,6 @@ config EROFS_FS_ZIP_LZMA
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
-	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing DEFLATE compressed data.  It gives better compression
@@ -132,7 +137,6 @@ config EROFS_FS_ZIP_DEFLATE
 config EROFS_FS_ZIP_ZSTD
 	bool "EROFS Zstandard compressed data support"
 	depends on EROFS_FS_ZIP
-	select ZSTD_DECOMPRESS
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing Zstandard compressed data.  It gives better compression
@@ -147,8 +151,6 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
-	select CRYPTO
-	select CRYPTO_DEFLATE
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
@@ -163,9 +165,7 @@ config EROFS_FS_ZIP_ACCEL
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
-	select NETFS_SUPPORT
 	select FSCACHE
-	select CACHEFILES
 	select CACHEFILES_ONDEMAND
 	help
 	  This permits EROFS to use fscache-backed data blobs with on-demand
-- 
2.43.5


