Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA833960E2
	for <lists+linux-erofs@lfdr.de>; Mon, 31 May 2021 16:31:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FtyQs4QyTz301N
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Jun 2021 00:31:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hILXw1E4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hILXw1E4; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FtyQn4Fspz2xb8
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Jun 2021 00:31:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0BA9613AF;
 Mon, 31 May 2021 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622471482;
 bh=AGw7GNvVmBMtuu+mjTAZFWiF24wkIZHZfnAILqYPwJ4=;
 h=From:To:Cc:Subject:Date:From;
 b=hILXw1E4FqQwvQNX1KDrTavk3IcpUB+t4p5BnBv0ym/S2zYGZaZCPn3ES7LhvdMxy
 5HpcaMHX/yQjhnaHTAPtpEnIImg0niQDSQ8POsF7SqyQ+1f62r77oiIIS/DVS4gFbh
 VNwFTBzo2P+6GxHaLONVPRqpCiObp3fZuMIgfLbKsWWmcWblN0hxCgyaa9ySQIf7oW
 L5zUX2CpuYiIxKEQQA5y5H/Dlc40yRk9XYaQ/BNLEZ1WDrxiYRBQ8jHj6FjxvdPpTB
 Ii7SPYMVybkxXhvgmOsBR+p22Pa0TQGHHZSQKuLpPuiPiIqlV9PwaC6LxROKpTq5UI
 eKSHvvs3Mq5tw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/3] erofs-utils: README: trivial updates
Date: Mon, 31 May 2021 22:31:15 +0800
Message-Id: <20210531143117.6327-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

- update erofs naming to EROFS;
- add some words about compression levels;
- add more description about legacy EROFS images.

Link: https://lore.kernel.org/r/20210522055057.25004-1-xiang@kernel.org
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 README | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/README b/README
index b57550b2a09e..bcf30e11aa52 100644
--- a/README
+++ b/README
@@ -1,7 +1,7 @@
 erofs-utils
 ===========
 
-erofs-utils includes user-space tools for erofs filesystem.
+erofs-utils includes user-space tools for EROFS filesystem.
 Currently mkfs.erofs and erofsfuse (experimental) are available.
 
 Dependencies & build
@@ -50,7 +50,7 @@ as well.
 mkfs.erofs
 ----------
 
-two main kinds of erofs images can be generated: (un)compressed.
+two main kinds of EROFS images can be generated: (un)compressed.
 
  - For uncompressed images, there will be none of compression
    files in these images. However, it can decide whether the tail
@@ -61,8 +61,8 @@ two main kinds of erofs images can be generated: (un)compressed.
    saved with compression. If not, fallback to an uncompressed
    file.
 
-How to generate erofs images
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to generate EROFS images (Linux 5.3+)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Currently lz4 and lz4hc are available for compression, e.g.
  $ mkfs.erofs -zlz4hc foo.erofs.img foo/
@@ -70,17 +70,24 @@ Currently lz4 and lz4hc are available for compression, e.g.
 Or leave all files uncompressed as an option:
  $ mkfs.erofs foo.erofs.img foo/
 
-How to generate legacy erofs images
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In addition, you could specify a higher compression level to get a
+(slightly) better compression ratio than the default level, e.g.
+ $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
+
+How to generate legacy EROFS images (Linux 4.19+)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Decompression inplace and compacted indexes have been introduced in
 linux-5.3, which are not forward-compatible with older kernels.
 
-In order to generate _legacy_ erofs images for old kernels,
+In order to generate _legacy_ EROFS images for old kernels,
 consider adding "-E legacy-compress" to the command line, e.g.
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
+For Linux kernel >= 5.3, legacy EROFS images are _NOT recommended_
+due to runtime performance loss compared with non-legacy images.
+
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -94,7 +101,7 @@ PLEASE NOTE: This version is highly _NOT recommended_ now.
 erofsfuse (experimental, unstable)
 ----------------------------------
 
-erofsfuse is introduced to support erofs format for various platforms
+erofsfuse is introduced to support EROFS format for various platforms
 (including older linux kernels) and new on-disk features iteration.
 It can also be used as an unpacking tool for unprivileged users.
 
@@ -120,7 +127,7 @@ and build it manually:
 
 erofsfuse binary will be generated under fuse folder.
 
-How to mount an erofs image with erofsfuse
+How to mount an EROFS image with erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 As the other FUSE implementations, it's quite simple to mount with
@@ -139,7 +146,7 @@ To unmount an erofsfuse mountpoint as a non-root user:
 Contribution
 ------------
 
-erofs-utils is under GPLv2+ as a part of erofs project,
+erofs-utils is under GPLv2+ as a part of EROFS filesystem project,
 feel free to send patches or feedback to us.
 
 To:
@@ -155,7 +162,7 @@ Cc:
 Comments
 --------
 
-[1] According to the erofs on-disk format, the tail block of files
+[1] According to the EROFS on-disk format, the tail block of files
     could be inlined aggressively with its metadata in order to reduce
     the I/O overhead and save the storage space (called tail-packing).
 
-- 
2.20.1

