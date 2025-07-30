Return-Path: <linux-erofs+bounces-728-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEFCB16086
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 14:45:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsX3x44Lgz30Vq;
	Wed, 30 Jul 2025 22:45:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753879501;
	cv=none; b=jq7T6BqkZivkiw0SB55eQauiX4Vh+Ns0/jI/2HjlP7xe6IGCwXDHLD6IgKK4QYcqmf3jkdK0MjLZUSjj/Ga9jnhuaDhnkoHJ5YuYb1T9D9hb+CnFCyLtWik6XEHl85dWu1ENrwkxlC2RBjaN9+WvGoVx4iOVv4NC8foXfKcXg83BTDZxVF20lIGtXW/MxsiqCTv1W/wgcTjECHv8DSMiwAT0GDmrB6pGUyRsgZ4BCTeAcKWw6AdZc5L8FRnlpk/XX7dOVSd2U2+4A94UEqKLvOOgLQQOaKCfJCZqbmWDIaUQ3tnpnEWFCrUNKcOEXPvINBnm4mXgiUUZhsRSZfe/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753879501; c=relaxed/relaxed;
	bh=s82CGBNzAbYYFbrx2YefyjBuaccC9rFravG7g4r3lpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCYhf9+LmARvxCIqcW0ac++GuJUfOoQZ3Lz3vzZugkvRfsPLHaIhU7NCnnDsZNlewS4SeAiZ1Dym1lRCYgDUEbXvATJqUNQIo+PRtHY0FTwSSOSZX9RXRR2EujgLwvDyYoU3BMmHwcrtENbqXMuzQT8lnt3NUaxf1MaeADvGvoq/t5/8mMh/ML+gaKabtxCGVsk1TrvKL5ox6BDf283/bxIPBdbhOVDKKFEANXL7ULO+AbjEc02NTnTnMmcOahruSsYtysg+FmAdN7qJP3kJxgXDE/VQr4zkxiXmbJdhaOVK5FnPCJa4/Wg2YnXbbFGrJJWd9yJqahH6E8uySWwToQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=qwve=2l=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=qwve=2l=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsX3v6P8zz2xnM
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 22:44:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 529AF5C5BDE;
	Wed, 30 Jul 2025 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FDCC4CEE7;
	Wed, 30 Jul 2025 12:44:54 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Bo Liu <liubo03@inspur.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] erofs: Do not select tristate symbols from bool symbols
Date: Wed, 30 Jul 2025 14:44:49 +0200
Message-ID: <da1b899e511145dd43fd2d398f64b2e03c6a39e7.1753879351.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

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
---
Triggered by noticing that commit 5e0bf36fd156b8d9 ("erofs: fix build
error with CONFIG_EROFS_FS_ZIP_ACCEL=y") caused CONFIG_CRYPTO_DEFLATE
and CONFIG_ZLIB_DEFLATE to change from m to y in m68k/allmodconfig.

Unfortunately Kconfig cannot be changed easily to detect this
automatically, as it cannot distinguish between a "bool" symbol
representing a configurable option in a module, and a driver that cannot
be a module.
---
 fs/erofs/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7b26efc271eec733..d81f3318417dff7c 100644
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
2.43.0


