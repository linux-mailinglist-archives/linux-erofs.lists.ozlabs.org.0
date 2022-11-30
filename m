Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52363D29A
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 10:57:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMZPD4K57z3fhY
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 20:57:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.1; helo=out30-1.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMZNJ3sfxz3gHg
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 20:56:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW2qBWd_1669802166;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VW2qBWd_1669802166)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 17:56:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: update documentation
Date: Wed, 30 Nov 2022 17:56:05 +0800
Message-Id: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

- Refine highlights for main features;

- Add multi-reference pclusters and fragment description.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 35 ++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 05e03d54af1a..82af67fdaf99 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -30,12 +30,17 @@ It is implemented to be a better choice for the following scenarios:
    especially for those embedded devices with limited memory and high-density
    hosts with numerous containers.
 
-Here is the main features of EROFS:
+Here are the main features of EROFS:
 
  - Little endian on-disk design;
 
- - 4KiB block size and 32-bit block addresses, therefore 16TiB address space
-   at most for now;
+ - Block-based and file-based distribution over fscache are supported;
+
+ - Support multiple devices to refer to external blobs, which can be used
+   for container images;
+
+ - 4KiB block size and 32-bit block addresses for each device, therefore
+   16TiB address space at most for now;
 
  - Two inode layouts for different requirements:
 
@@ -50,28 +55,29 @@ Here is the main features of EROFS:
    Metadata reserved      8 bytes       18 bytes
    =====================  ============  ======================================
 
- - Metadata and data could be mixed as an option;
-
- - Support extended attributes (xattrs) as an option;
+ - Support extended attributes as an option;
 
- - Support tailpacking data and xattr inline compared to byte-addressed
-   unaligned metadata or smaller block size alternatives;
-
- - Support POSIX.1e ACLs by using xattrs;
+ - Support POSIX.1e ACLs by using extended attributes;
 
  - Support transparent data compression as an option:
    LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
    inplace decompression is also supported to avoid bounce compressed buffers
    and page cache thrashing.
 
+ - Support chunk-based data deduplication and rolling-hash compressed data
+   deduplication;
+
+ - Support tailpacking inline compared to byte-addressed unaligned metadata
+   or smaller block size alternatives;
+
+ - Support merging tail-end data into a special inode as fragments.
+
  - Support direct I/O on uncompressed files to avoid double caching for loop
    devices;
 
  - Support FSDAX on uncompressed images for secure containers and ramdisks in
    order to get rid of unnecessary page cache.
 
- - Support multiple devices for multi blob container images;
-
  - Support file-based on-demand loading with the Fscache infrastructure.
 
 The following git tree provides the file system user-space tools under
@@ -259,7 +265,7 @@ By the way, chunk-based files are all uncompressed for now.
 
 Data compression
 ----------------
-EROFS implements LZ4 fixed-sized output compression which generates fixed-sized
+EROFS implements fixed-sized output compression which generates fixed-sized
 compressed data blocks from variable-sized input in contrast to other existing
 fixed-sized input solutions. Relatively higher compression ratios can be gotten
 by using fixed-sized output compression since nowadays popular data compression
@@ -314,3 +320,6 @@ to understand its delta0 is constantly 1, as illustrated below::
 
 If another HEAD follows a HEAD lcluster, there is no room to record CBLKCNT,
 but it's easy to know the size of such pcluster is 1 lcluster as well.
+
+Since Linux v6.1, each pcluster can be used for multiple variable-sized extents,
+therefore it can be used for compressed data deduplication.
-- 
2.24.4

