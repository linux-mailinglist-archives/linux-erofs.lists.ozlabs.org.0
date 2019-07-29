Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB37855A
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 08:52:57 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xr3p08grzDqFL
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 16:52:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xr3K2MfTzDqC7
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2019 16:52:29 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 11FA1FD40DBE7A999088;
 Mon, 29 Jul 2019 14:52:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:18 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH 04/22] staging: erofs: keep up erofs_fs.h with
 erofs-outofstaging patchset
Date: Mon, 29 Jul 2019 14:51:41 +0800
Message-ID: <20190729065159.62378-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The main change is to reserve all checksums except for superblock,
since it's more useful to do block-based verity for read-only fs.

Some comments change as well, which is minor.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/erofs_fs.h | 39 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 9cd749d56920..e82e833985e4 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -96,7 +96,7 @@ struct erofs_inode_v1 {
 /* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
 /* 24 */__le16 i_uid;
 /* 26 */__le16 i_gid;
-/* 28 */__le32 i_checksum;
+/* 28 */__le32 i_reserved2;
 } __packed;
 
 /* 32 bytes on-disk inode */
@@ -105,14 +105,14 @@ struct erofs_inode_v1 {
 #define EROFS_INODE_LAYOUT_V2   1
 
 struct erofs_inode_v2 {
-	__le16 i_advise;
+/*  0 */__le16 i_advise;
 
-	/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-	__le16 i_xattr_icount;
-	__le16 i_mode;
-	__le16 i_reserved;      /* 8 bytes */
-	__le64 i_size;          /* 16 bytes */
-	union {
+/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+/*  2 */__le16 i_xattr_icount;
+/*  4 */__le16 i_mode;
+/*  6 */__le16 i_reserved;
+/*  8 */__le64 i_size;
+/* 16 */union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -122,16 +122,15 @@ struct erofs_inode_v2 {
 	} i_u __packed;
 
 	/* only used for 32-bit stat compatibility */
-	__le32 i_ino;           /* 24 bytes */
-
-	__le32 i_uid;
-	__le32 i_gid;
-	__le64 i_ctime;         /* 32 bytes */
-	__le32 i_ctime_nsec;
-	__le32 i_nlink;
-	__u8   i_reserved2[12];
-	__le32 i_checksum;      /* 64 bytes */
-} __packed;
+/* 20 */__le32 i_ino;
+
+/* 24 */__le32 i_uid;
+/* 28 */__le32 i_gid;
+/* 32 */__le64 i_ctime;
+/* 40 */__le32 i_ctime_nsec;
+/* 44 */__le32 i_nlink;
+/* 48 */__u8   i_reserved2[16];
+} __packed;                     /* 64 bytes */
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -149,9 +148,9 @@ struct erofs_inode_v2 {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_checksum;
+	__le32 h_reserved;
 	__u8   h_shared_count;
-	__u8   h_reserved[7];
+	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
 } __packed;
 
-- 
2.17.1

