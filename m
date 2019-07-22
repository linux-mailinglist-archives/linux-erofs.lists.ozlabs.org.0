Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E76F7B1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 04:58:16 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sRBD6yj1zDqVk
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 12:58:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sR2X5M8pzDqMr
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 12:51:31 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6BAC64CF3FF124CDE215;
 Mon, 22 Jul 2019 10:51:29 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:22 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: [PATCH v3 24/24] erofs: add document
Date: Mon, 22 Jul 2019 10:50:43 +0800
Message-ID: <20190722025043.166344-25-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This documents key features, usage, and
on-disk design of erofs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/erofs.txt | 211 ++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 Documentation/filesystems/erofs.txt

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
new file mode 100644
index 000000000000..b7ff62fb61a4
--- /dev/null
+++ b/Documentation/filesystems/erofs.txt
@@ -0,0 +1,211 @@
+Overview
+========
+
+EROFS file-system stands for Enhanced Read-Only File System. Different
+from other read-only file systems, it aims to be designed for flexibility,
+scalability, but be kept simple and high performance.
+
+It is designed as a better filesystem solution for the following scenarios:
+ - read-only storage media or
+
+ - part of a fully trusted read-only solution, which means it needs to be
+   immutable and bit-for-bit identical to the official golden image for
+   their releases due to security and other considerations and
+
+ - hope to save some extra storage space with guaranteed end-to-end performance
+   by using reduced metadata and transparent file compression, especially
+   for those embedded devices with limited memory (ex, smartphone);
+
+Here is the main features of EROFS:
+ - Little endian on-disk design;
+
+ - Currently 4KB block size (nobh) and therefore maximum 16TB address space;
+
+ - Metadata & data could be mixed by design;
+
+ - 2 inode versions for different requirements:
+                          v1            v2
+   Inode metadata size:   32 bytes      64 bytes
+   Max file size:         4 GB          16 EB (also limited by max. vol size)
+   Max uids/gids:         65536         4294967296
+   File creation time:    no            yes (64 + 32-bit timestamp)
+   Max hardlinks:         65536         4294967296
+   Metadata reserved:     4 bytes       14 bytes
+
+ - Support extended attributes (xattrs) as an option;
+
+ - Support xattr inline and tail-end data inline for all files;
+
+ - Support POSIX.1e ACLs by using xattrs;
+
+ - Support statx();
+
+ - Support transparent file compression as an option:
+   LZ4 algorithm with 4 KB fixed-output compression for high performance;
+
+The following git tree provides the file system user-space tools under
+development (ex, formatting tool mkfs.erofs):
+>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+Bugs and patches are welcome, please kindly help us and send to the following
+linux-erofs mailing list:
+>> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
+
+Note that EROFS is still working in progress as a Linux staging driver,
+Cc the staging mailing list as well is highly recommended:
+>> Linux Driver Project Developer List <devel@driverdev.osuosl.org>
+
+Mount options
+=============
+
+fault_injection=%d     Enable fault injection in all supported types with
+                       specified injection rate. Supported injection type:
+                       Type_Name                Type_Value
+                       FAULT_KMALLOC            0x000000001
+                       FAULT_READ_IO            0x000000002
+(no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
+                       by default if CONFIG_EROFS_FS_XATTR is selected.
+(no)acl                Setup POSIX Access Control List. Note: acl is enabled
+                       by default if CONFIG_EROFS_FS_POSIX_ACL is selected.
+
+On-disk details
+===============
+
+Summary
+-------
+Different from other read-only file systems, an EROFS volume is designed
+to be as simple as possible:
+
+                                |-> aligned with the block size
+   ____________________________________________________________
+  | |SB| | ... | Metadata | ... | Data | Metadata | ... | Data |
+  |_|__|_|_____|__________|_____|______|__________|_____|______|
+  0 +1K
+
+All data areas should be aligned with the block size, but metadata areas
+may not. All metadatas can be now observed in two different spaces (views):
+ 1. Inode metadata space
+    Each valid inode should be aligned with an inode slot, which is a fixed
+    value (32 bytes) and designed to be kept in line with v1 inode size.
+
+    Each inode can be directly found with the following formula:
+         inode offset = meta_blkaddr * block_size + 32 * nid
+
+                                |-> aligned with 8B
+                                           |-> followed closely
+    + meta_blkaddr blocks                                      |-> another slot
+     _____________________________________________________________________
+    |  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
+    |________|_______|(optional)|(optional)|__(optional)_|_____|__________
+             |-> aligned with the inode slot size
+                  .                   .
+                .                         .
+              .                              .
+            .                                    .
+          .                                         .
+        .                                              .
+      .____________________________________________________|-> aligned with 4B
+      | xattr_ibody_header | shared xattrs | inline xattrs |
+      |____________________|_______________|_______________|
+      |->    12 bytes    <-|->x * 4 bytes<-|               .
+                          .                .                 .
+                    .                      .                   .
+               .                           .                     .
+           ._______________________________.______________________.
+           | id | id | id | id |  ... | id | ent | ... | ent| ... |
+           |____|____|____|____|______|____|_____|_____|____|_____|
+                                           |-> aligned with 4B
+                                                       |-> aligned with 4B
+
+    Inode could be 32 or 64 bytes, which can be distinguished from a common
+    field which all inode versions have -- i_advise:
+
+        __________________               __________________
+       |     i_advise     |             |     i_advise     |
+       |__________________|             |__________________|
+       |        ...       |             |        ...       |
+       |                  |             |                  |
+       |__________________| 32 bytes    |                  |
+                                        |                  |
+                                        |__________________| 64 bytes
+
+    Xattrs, extents, data inline are followed by the corresponding inode with
+    proper alignes, and they could be optional for different data mappings,
+    _currently_ there are totally 3 valid data mappings supported:
+
+     1) flat file data without data inline (no extent);
+     2) fixed-output size data compression (must have extents);
+     3) flat file data with tail-end data inline (no extent);
+
+    The size of the optional xattrs is indicated by i_xattr_count in inode
+    header. Large xattrs or xattrs shared by many different files can be
+    stored in shared xattrs metadata rather than inlined right after inode.
+
+ 2. Shared xattrs metadata space
+    Shared xattrs space is similar to the above inode space, started with
+    a specific block indicated by xattr_blkaddr, organized one by one with
+    proper align.
+
+    Each share xattr can also be directly found by the following formula:
+         xattr offset = xattr_blkaddr * block_size + 4 * xattr_id
+
+                           |-> aligned by  4 bytes
+    + xattr_blkaddr blocks                     |-> aligned with 4 bytes
+     _________________________________________________________________________
+    |  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
+    |________|_____________|_____________|_____|______________|_______________
+
+Directories
+-----------
+All directories are now organized in a compact on-disk format. Note that
+each directory block is divided into index and name areas in order to support
+random file lookup, and all directory entries are _strictly_ recorded in
+alphabetical order in order to support improved prefix binary search
+algorithm (could refer to the related source code).
+
+                 ___________________________
+                /                           |
+               /              ______________|________________
+              /              /              | nameoff1       | nameoffN-1
+ ____________.______________._______________v________________v__________
+| dirent | dirent | ... | dirent | filename | filename | ... | filename |
+|___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
+     \                           ^
+      \                          |                           * could have
+       \                         |                             trailing '\0'
+        \________________________| nameoff0
+
+                             Directory block
+
+Note that apart from the offset of the first filename, nameoff0 also indicates
+the total number of directory entries in this block since it is no need to
+introduce another on-disk field at all.
+
+Compression
+-----------
+Currently, EROFS supports 4KB fixed-output clustersize transparent file
+compression, as illustrated below:
+
+         |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
+         clusterofs                      clusterofs            clusterofs
+         |                               |                     |   logical data
+_________v_______________________________v_____________________v_______________
+... |    .        |             |        .    |             |  .          | ...
+____|____.________|_____________|________.____|_____________|__.__________|____
+    |-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
+         size          size          size          size          size
+          .                             .                .                   .
+           .                       .               .                  .
+            .                  .              .                .
+      _______._____________._____________._____________._____________________
+         ... |             |             |             | ... physical data
+      _______|_____________|_____________|_____________|_____________________
+             |-> cluster <-|-> cluster <-|-> cluster <-|
+                  size          size          size
+
+Currently each on-disk physical cluster can contain 4KB (un)compressed data
+at most. For each logical cluster, there is a corresponding on-disk index to
+describe its cluster type, physical cluster address, etc.
+
+See "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
+
-- 
2.17.1

