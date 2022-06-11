Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C9547445
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 13:37:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKwm73tpmz3bx5
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 21:37:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MZPiVVEh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MZPiVVEh;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKwm328Nzz3bkW
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 21:37:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8AE05B80B2E
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 11:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE07C34116;
	Sat, 11 Jun 2022 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654947421;
	bh=pXvLxGUlFS6yhp9GxnZZKHDo/818lpJwiogbUhTA0rU=;
	h=From:To:Cc:Subject:Date:From;
	b=MZPiVVEhmyB/eGB516Ug8UlkX9JNBlzX2eizRK60G2diQvLVkxN0oHEw5Jcl0V9NB
	 FRZV+eY0XEBjJYfEiwu8FObtoFSdruGcI5WZGDL1K+KS2mfdSZOXVWh6Oe6HPsE7Lb
	 iPrH6Thzby7lJm4y1oMeVOZ22qvABc/s4qbFlzivOAvcPCW9bw+xkNC1bGxZe7AV5k
	 7h1crkgeiQn/aeWkII6Gob2TdXP1a4bb3hqpGzr3MAjUAnhxq7Gj2aDCOP4gws7EP9
	 A4PIW+m8sFhAyzZS5CT9EHPttqcILBCs1tfW1vQB54/GGDz9xuIpEVYdFeEZKYMBT1
	 EeB3fMtVr2c0w==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update README
Date: Sat, 11 Jun 2022 19:36:21 +0800
Message-Id: <20220611113621.359723-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

update README for the upcoming erofs-utils v1.5, such as:

 - Image extraction with fsck.erofs;

 - Container image use cases.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 README | 71 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/README b/README
index aadd880..92b3128 100644
--- a/README
+++ b/README
@@ -1,9 +1,13 @@
 erofs-utils
 ===========
 
-erofs-utils includes user-space tools for EROFS filesystem.
-Currently mkfs.erofs, (experimental) erofsfuse, dump.erofs, fsck.erofs
-are available.
+userspace tools for EROFS filesystem, currently including:
+
+  mkfs.erofs    filesystem formatter
+  erofsfuse     FUSE daemon alternative
+  dump.erofs    filesystem analyzer
+  fsck.erofs    filesystem compatibility & consistency checker as well
+                as extractor
 
 Dependencies & build
 --------------------
@@ -59,6 +63,7 @@ In order to enable LZMA support, build with the following commands:
 Additionally, you could specify liblzma build paths with:
 	--with-liblzma-incdir and --with-liblzma-libdir
 
+
 mkfs.erofs
 ----------
 
@@ -133,8 +138,9 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
 
 PLEASE NOTE: This version is highly _NOT recommended_ now.
 
-erofsfuse (experimental)
-------------------------
+
+erofsfuse
+---------
 
 erofsfuse is introduced to support EROFS format for various platforms
 (including older linux kernels) and new on-disk features iteration.
@@ -147,9 +153,9 @@ significant I/O overhead, double caching, etc.)
 
 Therefore, NEVER use it if performance is the top concern.
 
-Note that xattr & ACL aren't implemented yet due to the current Android
-use-case vs limited time. If you have some interest, contribution is,
-as always, welcome.
+Note that extended attributes and ACLs aren't implemented yet due to
+the current Android use case vs limited time. If you are interested,
+contribution is, as always, welcome.
 
 How to build erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -178,24 +184,52 @@ To debug erofsfuse (also automatically run in foreground):
 To unmount an erofsfuse mountpoint as a non-root user:
  $ fusermount -u foo/
 
-dump.erofs and fsck.erofs (experimental)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-dump.erofs and fsck.erofs are two new experimental tools to analyse
-and check EROFS file systems.
+dump.erofs and fsck.erofs
+-------------------------
+
+dump.erofs and fsck.erofs are used to analyze, check, and extract
+EROFS filesystems. Note that extended attributes and ACLs are still
+unsupported when extracting images with fsck.erofs.
+
+Container images
+----------------
+
+EROFS filesystem is well-suitably used for container images with
+advanced features like chunk-based files, multi-devices (blobs)
+and new fscache backend for lazy pulling and cache management, etc.
+
+For example, CNCF Dragonfly Nydus image service [7] introduces an
+(EROFS-compatible) RAFS v6 image format to overcome flaws of the
+current OCIv1 tgz images so that:
 
-They are still incomplete and actively under development by the
-community. But you could check them out if needed in advance.
+ - Images can be downloaded on demand in chunks aka lazy pulling with
+   new fscache backend (5.19+) or userspace block devices (5.16+);
+
+ - Finer chunk-based content-addressable data deduplication to minimize
+   storage, transmission and memory footprints;
+
+ - Merged filesystem tree to remove all metadata of intermediate layers
+   as an option;
+
+ - (e)stargz, zstd::chunked and other formats can be converted and run
+   on the fly;
+
+ - and more.
+
+Apart from Dragonfly Nydus, a native user daemon is planned to be added
+to erofs-utils to parse EROFS, (e)stargz and zstd::chunked images from
+network too as a real part of EROFS filesystem project.
 
-Report, feedback and/or contribution are welcomed.
 
 Contribution
 ------------
 
-erofs-utils is under GPLv2+ as a part of EROFS filesystem project,
-feel free to send patches or feedback to:
+erofs-utils is a part of EROFS filesystem project, feel free to send
+patches or feedback to:
   linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
+
 Comments
 --------
 
@@ -251,3 +285,6 @@ Comments
     which is also resolved in lz4-1.9.3.
 
 [6] https://tukaani.org/xz/xz-5.3.2alpha.tar.xz
+
+[7] https://nydus.dev
+    https://github.com/dragonflyoss/image-service
-- 
2.30.2

