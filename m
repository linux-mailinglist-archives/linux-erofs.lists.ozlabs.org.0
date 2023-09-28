Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306287B1D78
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 15:16:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RxDWf74kfz3c4R
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 23:16:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RxDWZ1YWgz3bP4
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Sep 2023 23:16:07 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vt1nuL3_1695906960;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vt1nuL3_1695906960)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 21:16:01 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: update documentation
Date: Thu, 28 Sep 2023 21:16:00 +0800
Message-Id: <20230928131600.84701-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: huyue2@coolpad.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 - update new features like bloom filter and DEFLATE.

 - add documentation for the long xattr name prefixes, which was
   landed upstream since v6.4.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4654ee57c1d5..522183737be6 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -58,12 +58,14 @@ Here are the main features of EROFS:
 
  - Support extended attributes as an option;
 
+ - Support a bloom filter that speeds up negative extended attribute lookups;
+
  - Support POSIX.1e ACLs by using extended attributes;
 
  - Support transparent data compression as an option:
-   LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
-   inplace decompression is also supported to avoid bounce compressed buffers
-   and page cache thrashing.
+   LZ4, MicroLZMA and DEFLATE algorithms can be used on a per-file basis; In
+   addition, inplace decompression is also supported to avoid bounce compressed
+   buffers and unnecessary page cache thrashing.
 
  - Support chunk-based data deduplication and rolling-hash compressed data
    deduplication;
@@ -268,6 +270,38 @@ details.)
 
 By the way, chunk-based files are all uncompressed for now.
 
+Long extended attribute name prefixes
+-------------------------------------
+There are use cases that extended attributes with different values can have
+only a few common prefixes (such as overlayfs xattrs).  The predefined prefixes
+works inefficiently in both image size and runtime performance in such cases.
+
+The long xattr name prefixes feature is introduced to address this issue.  The
+overall idea is that, apart from the existing predefined prefixes, the xattr
+entry could also refer to user specified long xattr name prefixes, e.g.
+"trusted.overlay.".
+
+When referring to a long xattr name prefix, the highest bit (bit 7) of
+erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
+represents the index of the referred long name prefix among all long name
+prefixes.  Therefore, only the trailing part of the name apart from the long
+xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
+the full xattr name matches exactly as its long xattr name prefix.
+
+All long xattr prefixes are stored one by one in the packed inode as long as
+the packed inode is valid, or meta inode otherwise.  The xattr_prefix_count (of
+on-disk superblock) indicates the total number of the long xattr name prefixes,
+while (xattr_prefix_start * 4) indicates the start offset of long name prefixes
+in the packed/meta inode.  Note that, long extended attribute name prefixes is
+disabled if xattr_prefix_count is 0.
+
+Each long name prefix is stored in the format: ALIGN({__le16 len, data}, 4),
+where len represents the total size of the data part.  The data part is actually
+represented by 'struct erofs_xattr_long_prefix', where base_index represents the
+index of the predefined xattr name prefix, e.g. EROFS_XATTR_INDEX_TRUSTED for
+"trusted.overlay." long name prefix, while the infix string kepts the string
+after stripping the short prefix, e.g. "overlay." for the example above.
+
 Data compression
 ----------------
 EROFS implements fixed-sized output compression which generates fixed-sized
-- 
2.19.1.6.gb485710b

