Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA337A267
	for <lists+linux-erofs@lfdr.de>; Tue, 11 May 2021 10:44:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FfWgb3SkKz2yZ2
	for <lists+linux-erofs@lfdr.de>; Tue, 11 May 2021 18:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZJ0nTuRx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZJ0nTuRx; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FfWgW6lLJz2yZ2
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 May 2021 18:44:23 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E82A616EC;
 Tue, 11 May 2021 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620722661;
 bh=xEiioIKEggYsi6Ybd6NdEUUdijVlS/WSIIQ209kfXF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZJ0nTuRxzGyV+6Zb3RLmMJc0n+Ps4MHUHPvGK52o8Exo0zEE5t0PQJdqwZCaiNLE4
 a57gwxndPMOs7NstJh3fjhEW21XN781008/r+EyF1s/beIgztLNHvbeMbyrpdik4Yd
 19Wh41kIXs3Ofka3Xig+//LsFas9XKvur6rkuoSLtiLSH7WzyJIytlt53g+EnMauzF
 4X3Ky8zMFydC/vzEJ9r67g/J/JJrTW1zzYfKxbZqWbFY3VM7bqLVgsHhXUr6Yx9eD4
 ViItM4gcgtQcuBKMKh5+7Ai96dDUldrxJ3KGfvkrVn9QauDpcZQIuxdzNwdmbjFZTG
 BgGAHjRmeGfew==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v1.1 2/2] erofs: update documentation about data compression
Date: Tue, 11 May 2021 16:44:14 +0800
Message-Id: <20210511084414.21305-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510162506.28637-2-xiang@kernel.org>
References: <20210510162506.28637-2-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add more description about (NON)HEAD lclusters, and the new big
pcluster feature.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
changes since v1:
 - update "a pcluster with 1" to "a lcluster-sized pcluster
   (without CBLKCNT)"

 Documentation/filesystems/erofs.rst | 68 +++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 869b183ff215..43550c5d0fc6 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -50,8 +50,8 @@ Here is the main features of EROFS:
 
  - Support POSIX.1e ACLs by using xattrs;
 
- - Support transparent file compression as an option:
-   LZ4 algorithm with 4 KB fixed-sized output compression for high performance.
+ - Support transparent data compression as an option:
+   LZ4 algorithm with the fixed-sized output compression for high performance.
 
 The following git tree provides the file system user-space tools under
 development (ex, formatting tool mkfs.erofs):
@@ -210,10 +210,21 @@ Note that apart from the offset of the first filename, nameoff0 also indicates
 the total number of directory entries in this block since it is no need to
 introduce another on-disk field at all.
 
-Compression
------------
-Currently, EROFS supports 4KB fixed-sized output transparent file compression,
-as illustrated below::
+Data compression
+----------------
+EROFS implements LZ4 fixed-sized output compression which generates fixed-sized
+compressed data blocks from variable-sized input in contrast to other existing
+fixed-sized input solutions. Relatively higher compression ratios can be gotten
+by using fixed-sized output compression since nowadays popular data compression
+algorithms are mostly LZ77-based and such fixed-sized output approach can be
+benefited from the historical dictionary (aka. sliding window).
+
+In details, original (uncompressed) data is turned into several variable-sized
+extents and in the meanwhile, compressed into physical clusters (pclusters).
+In order to record each variable-sized extent, logical clusters (lclusters) are
+introduced as the basic unit of compress indexes to indicate whether a new
+extent is generated within the range (HEAD) or not (NONHEAD). Lclusters are now
+fixed in block size, as illustrated below::
 
           |<-    variable-sized extent    ->|<-       VLE         ->|
         clusterofs                        clusterofs              clusterofs
@@ -222,18 +233,37 @@ as illustrated below::
  ... |    .         |              |        .     |              |  .   ...
  ____|____._________|______________|________.___ _|______________|__.________
      |-> lcluster <-|-> lcluster <-|-> lcluster <-|-> lcluster <-|
-          size           size           size           size   .             .
-           .                            .                .              .
-            .                       .               .               .
-             .                   .              .               .
-       _______.______________.______________.______________._________________
+          (HEAD)        (NONHEAD)       (HEAD)        (NONHEAD)    .
+           .             CBLKCNT            .                    .
+            .                               .                  .
+             .                              .                .
+       _______._____________________________.______________._________________
           ... |              |              |              | ...
        _______|______________|______________|______________|_________________
-              |-> pcluster <-|-> pcluster <-|-> pcluster <-|
-                    size           size           size
-
-Currently each on-disk physical cluster can contain 4KB (un)compressed data
-at most. For each logical cluster, there is a corresponding on-disk index to
-describe its cluster type, physical cluster address, etc.
-
-See "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
+              |->      big pcluster       <-|-> pcluster <-|
+
+A physical cluster can be seen as a container of physical compressed blocks
+which contains compressed data. Previously, only lcluster-sized (4KB) pclusters
+were supported. After big pcluster feature is introduced (available since
+Linux v5.13), pcluster can be a multiple of lcluster size.
+
+For each HEAD lcluster, clusterofs is recorded to indicate where a new extent
+starts and blkaddr is used to seek the compressed data. For each NONHEAD
+lcluster, delta0 and delta1 are available instead of blkaddr to indicate the
+distance to its HEAD lcluster and the next HEAD lcluster. A PLAIN lcluster is
+also a HEAD lcluster except that its data is uncompressed. See the comments
+around "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
+
+If big pcluster is enabled, pcluster size in lclusters needs to be recorded as
+well. Let the delta0 of the first NONHEAD lcluster store the compressed block
+count with a special flag as a new called CBLKCNT NONHEAD lcluster. It's easy
+to understand its delta0 is constantly 1, as illustrated below::
+
+   __________________________________________________________
+  | HEAD |  NONHEAD  | NONHEAD | ... | NONHEAD | HEAD | HEAD |
+  |__:___|_(CBLKCNT)_|_________|_____|_________|__:___|____:_|
+     |<----- a big pcluster (with CBLKCNT) ------>|<--  -->|
+           a lcluster-sized pcluster (without CBLKCNT) ^
+
+If another HEAD follows a HEAD lcluster, there is no room to record CBLKCNT,
+but it's easy to know the size of such pcluster is 1 lcluster as well.
-- 
2.20.1

