Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B251045831A
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 12:25:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hxp483tsWz301j
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 22:25:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W0LLj18k;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=W0LLj18k; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hxp441TBKz2yLd
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 22:25:40 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B12BF60462;
 Sun, 21 Nov 2021 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637493937;
 bh=9nYwvpwjv6fAaxhSUyLK/GmitycrsLqLtOKWbAxoloU=;
 h=From:To:Cc:Subject:Date:From;
 b=W0LLj18kKO8msaGqZER/Taxo2e0Nov5BKb+AwvjEizhopkIlhyNta2WMfMI/JtFKl
 dHxzPiDKXirdN5tDl9HVGA9VplP3qQ12qh5fWPIRJpPl5wXGiMyyiFeTSetKhGqiHj
 w6o1DOKoXTlLtBLhyAln7SvCDE531sWWEGCcu4XZWRkOx6Bq6UM35cVjC3MKddK+U1
 oW5g0+IOJ9YLO3Hp6g4b4DXHP9sEswMJ02bHwsfkkLO2VS0/GKscW5tTYI1DRzYfZ8
 5QuE7i6YpQBaDX7jpn48Ba2iOmZx9eea5vU208HWNSloOudcCoDbZAxd4JcqVvzdpI
 cQYOsta2s08Fg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update README
Date: Sun, 21 Nov 2021 19:25:27 +0800
Message-Id: <20211121112527.8782-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

update README for the upcoming erofs-utils v1.4.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 README | 55 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/README b/README
index 333dcb4..8a47a55 100644
--- a/README
+++ b/README
@@ -2,7 +2,8 @@ erofs-utils
 ===========
 
 erofs-utils includes user-space tools for EROFS filesystem.
-Currently mkfs.erofs and erofsfuse (experimental) are available.
+Currently mkfs.erofs, (experimental) erofsfuse, dump.erofs, fsck.erofs
+are available.
 
 Dependencies & build
 --------------------
@@ -12,8 +13,8 @@ Dependencies & build
 
  libfuse 2.6+ for erofsfuse enabled as a plus.
 
-How to build for lz4-1.9.0 or above
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to build with lz4-1.9.0 or above
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To build, you can run the following commands in order:
 
@@ -32,8 +33,8 @@ mkfs.erofs binary will be generated under mkfs folder.
    LZ4_decompress_safe_partial() [5], which impacts erofsfuse
    functionality for legacy images (without 0PADDING).
 
-How to build for lz4-1.8.0~1.8.3
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to build with lz4-1.8.0~1.8.3
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For these old lz4 versions, lz4hc algorithm cannot be supported
 without lz4-static installed due to LZ4_compress_HC_destSize()
@@ -48,6 +49,16 @@ However, it's still not recommended using those versions directly
 since there are serious bugs in these compressors, see [2] [3] [4]
 as well.
 
+How to build with liblzma
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In order to enable LZMA support, build with the following commands:
+	$ ./configure --enable-lzma
+	$ make
+
+Additionally, you could specify liblzma build paths with:
+	--with-liblzma-incdir and --with-liblzma-libdir
+
 mkfs.erofs
 ----------
 
@@ -57,15 +68,15 @@ two main kinds of EROFS images can be generated: (un)compressed.
    files in these images. However, it can decide whether the tail
    block of a file should be inlined or not properly [1].
 
- - For compressed images, it will try to use lz4(hc) algorithm
+ - For compressed images, it'll try to use specific algorithms
    first for each regular file and see if storage space can be
    saved with compression. If not, fallback to an uncompressed
    file.
 
-How to generate EROFS images (Linux 5.3+)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to generate EROFS images (lz4 for Linux 5.3+, lzma for Linux 5.16+)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Currently lz4 and lz4hc are available for compression, e.g.
+Currently lz4(hc) and lzma are available for compression, e.g.
  $ mkfs.erofs -zlz4hc foo.erofs.img foo/
 
 Or leave all files uncompressed as an option:
@@ -75,6 +86,10 @@ In addition, you could specify a higher compression level to get a
 (slightly) better compression ratio than the default level, e.g.
  $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
 
+Note that all compressors are still single-threaded for now, thus it
+could take more time on the multiprocessor platform. Multi-threaded
+approach is already in our TODO list.
+
 How to generate EROFS big pcluster images (Linux 5.13+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -97,7 +112,8 @@ How to generate legacy EROFS images (Linux 4.19+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Decompression inplace and compacted indexes have been introduced in
-linux-5.3, which are not forward-compatible with older kernels.
+Linux upstream v5.3, which are not forward-compatible with older
+kernels.
 
 In order to generate _legacy_ EROFS images for old kernels,
 consider adding "-E legacy-compress" to the command line, e.g.
@@ -117,8 +133,8 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
 
 PLEASE NOTE: This version is highly _NOT recommended_ now.
 
-erofsfuse (experimental, unstable)
-----------------------------------
+erofsfuse (experimental)
+------------------------
 
 erofsfuse is introduced to support EROFS format for various platforms
 (including older linux kernels) and new on-disk features iteration.
@@ -138,8 +154,8 @@ as always, welcome.
 How to build erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~
 
-It's disabled by default as an experimental feature for now, to enable
-and build it manually:
+It's disabled by default as an experimental feature for now due to
+the extra libfuse dependency, to enable and build it manually:
 
 	$ ./configure --enable-fuse
 	$ make
@@ -162,6 +178,17 @@ To debug erofsfuse (also automatically run in foreground):
 To unmount an erofsfuse mountpoint as a non-root user:
  $ fusermount -u foo/
 
+dump.erofs and fsck.erofs (experimental)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+dump.erofs and fsck.erofs are two new experimental tools to analyse
+and check EROFS file systems.
+
+They are still incomplete and actively under development by the
+community. But you could check them out if needed in advance.
+
+Report, feedback and/or contribution are welcomed.
+
 Contribution
 ------------
 
-- 
2.33.0

