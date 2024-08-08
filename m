Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE294B612
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 07:08:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ETDsLyyi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfZnk1kFwz3dKG
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 15:08:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ETDsLyyi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfZnd0Bpzz2xWV
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 15:08:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723093709; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OEH8Uc1CUtUX4e6BkJEPNHDv3uXUJVvRdg4AGU332dw=;
	b=ETDsLyyiM1JZv6LLURYrQCCEiErEmHKb4Osq7aqxU37B3WSW93jGPrsRpr2SAfqAOjfT6afEjeU7kpsab2bGkN+fWJPgghIoyeVWa08fLkVtOM14k8himUmOmdBkZzfeQdvY9Mqoh/8dFjjebqsW3RNFCZRJGSqMxY+3uyvVJo4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCLJTtq_1723093699;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCLJTtq_1723093699)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 13:08:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update README for the upcoming 1.8
Date: Thu,  8 Aug 2024 13:08:18 +0800
Message-ID: <20240808050818.1822583-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add descriptions to multi-threaded compression and reproducible builds.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 README | 94 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/README b/README
index e224b23..077b62b 100644
--- a/README
+++ b/README
@@ -54,51 +54,91 @@ mkfs.erofs
 
 Two main kinds of EROFS images can be generated: (un)compressed images.
 
- - For uncompressed images, there will be none of compresssed files in
-   these images.  However, it can decide whether the tail block of a
-   file should be inlined or not properly [1].
+ - For uncompressed images, there will be no compressed files in these
+   images.  However, an EROFS image can contain files which consist of
+   various aligned data blocks and then a tail that is stored inline in
+   order to compact images [1].
 
- - For compressed images, it'll try to use the given algorithms first
+ - For compressed images, it will try to use the given algorithms first
    for each regular file and see if storage space can be saved with
-   compression. If not, fallback to an uncompressed file.
+   compression. If not, it will fall back to an uncompressed file.
 
-How to generate EROFS images (LZ4 for Linux 5.3+, LZMA for Linux 5.16+)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Note that EROFS supports per-file compression configuration, proper
+configuration options need to be enabled to parse compressed files by
+the Linux kernel.
 
-Currently lz4(hc) and lzma are available for compression, e.g.
+How to generate EROFS images
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Compression algorithms could be specified with the command-line option
+`-z` to build a compressed EROFS image from a local directory:
  $ mkfs.erofs -zlz4hc foo.erofs.img foo/
 
-Or leave all files uncompressed as an option:
+Supported algorithms by the Linux kernel:
+ - LZ4 (Linux 5.3+);
+ - LZMA (Linux 5.16+);
+ - DEFLATE (Linux 6.6+);
+ - Zstandard (Linux 6.10+).
+
+Alternatively, generate an uncompressed EROFS from a local directory:
  $ mkfs.erofs foo.erofs.img foo/
 
-In addition, you could specify a higher compression level to get a
-(slightly) better compression ratio than the default level, e.g.
+Additionally, you can specify a higher compression level to get a
+(slightly) smaller image than the default level:
  $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
 
-Note that all compressors are still single-threaded for now, thus it
-could take more time on the multiprocessor platform. Multi-threaded
-approach is already in our TODO list.
+Multi-threaded support can be explicitly enabled with the ./configure
+option `--enable-multithreading`; otherwise, single-threaded compression
+will be used for now.  It may take more time on multiprocessor platforms
+if multi-threaded support is not enabled.
+
+Currently, both `-Efragments` (not `-Eall-fragments`) and `-Ededupe`
+don't support multi-threading due to time limitations.
+
+Reproducible builds
+~~~~~~~~~~~~~~~~~~~
+
+Reproducible builds are typically used for verification and security,
+ensuring the same binaries/distributions to be reproduced in a
+deterministic way.
+
+Images generated by the same version of `mkfs.erofs` will be identical
+to previous runs if the same input is specified, and the same options
+are used.
+
+Specifically, variable timestamps and filesystem UUIDs can result in
+unreproducible EROFS images.  `-T` and `-U` can be used to fix them.
 
 How to generate EROFS big pcluster images (Linux 5.13+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In order to get much better compression ratios (thus better sequential
-read performance for common storage devices), big pluster feature has
-been introduced since linux-5.13, which is not forward-compatible with
-old kernels.
-
-In details, -C is used to specify the maximum size of each big pcluster
-in bytes, e.g.
+By default, EROFS formatter compresses data into separate one-block
+(e.g. 4KiB) filesystem physical clusters for outstanding random read
+performance.  In other words, each EROFS filesystem block can be
+independently decompressed.  However, other similar filesystems
+typically compress data into "blocks" of 128KiB or more for much smaller
+images.  Users may prefer smaller images for archiving purposes, even if
+random performance is compromised with those configurations, and even
+worse when using 4KiB blocks.
+
+In order to fulfill users' needs, big plusters has been introduced
+since Linux 5.13, in which each physical clusters will be more than one
+blocks.
+
+Specifically, `-C` is used to specify the maximum size of each pcluster
+in bytes:
  $ mkfs.erofs -zlz4hc -C65536 foo.erofs.img foo/
 
-So in that case, pcluster size can be 64KiB at most.
+Thus, in this case, pcluster sizes can be up to 64KiB.
 
-Note that large pcluster size can cause bad random performance, so
-please evaluate carefully in advance. Or make your own per-(sub)file
-compression strategies according to file access patterns if needed.
+Note that large pcluster size can degrade random performance (though it
+may improve sequential read performance for typical storage devices), so
+please evaluate carefully in advance.  Alternatively, you can make
+per-(sub)file compression strategies according to file access patterns
+if needed.
 
-How to generate EROFS images with multiple algorithms (Linux 5.16+)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to generate EROFS images with multiple algorithms
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 It's possible to generate an EROFS image with files in different
 algorithms due to various purposes.  For example, LZMA for archival
-- 
2.43.5

