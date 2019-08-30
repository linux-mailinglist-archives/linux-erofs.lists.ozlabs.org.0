Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBCBA2D23
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 05:02:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KPQy6hGJzF0Qb
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 13:02:18 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KPQW0BjmzF0QC
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 13:01:54 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0A39FB23C1BB72C1EBBA;
 Fri, 30 Aug 2019 11:01:51 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:01:40 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Joe Perches <joe@perches.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 3/7] erofs: use a better form for complicated on-disk fields
Date: Fri, 30 Aug 2019 11:00:36 +0800
Message-ID: <20190830030040.10599-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830030040.10599-1-gaoxiang25@huawei.com>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
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

As Joe Perches [1] suggested, let's use a better
form to describe complicated on-disk fields.

p.s. it has different tab alignment looking between
     the real file and patch file.
p.p.s. due to changing a different form, some lines
       have to exceed 80 characters.
[1] https://lore.kernel.org/r/67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com/
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
new patch.

 fs/erofs/erofs_fs.h | 100 ++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 41e53b49a11b..76edc595cc4a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,27 +17,27 @@
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
-struct erofs_super_block {
-/*  0 */__le32 magic;           /* in the little endian */
-/*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;        /* (aka. feature_compat) */
-/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-/* 13 */__u8 reserved;
-
-/* 14 */__le16 root_nid;
-/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-/* 24 */__le64 build_time;      /* inode v1 time derivation */
-/* 32 */__le32 build_time_nsec;
-/* 36 */__le32 blocks;          /* used for statfs */
-/* 40 */__le32 meta_blkaddr;
-/* 44 */__le32 xattr_blkaddr;
-/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
-/* 64 */__u8 volume_name[16];   /* volume name */
-/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
-
-/* 84 */__u8 reserved2[44];
-} __packed;                     /* 128 bytes */
+struct erofs_super_block {	/* off description */
+	__le32 magic;		/*  0  file system magic number */
+	__le32 checksum;	/*  4  crc32c(super_block) */
+	__le32 features;	/*  8  (aka. feature_compat) */
+	__u8 blkszbits;		/* 12  support PAGE_SIZE only currently */
+	__u8 reserved;		/* 13  */
+
+	__le16 root_nid;	/* 14  nid of root directory */
+	__le64 inos;		/* 16  total valid ino # (== f_files - f_favail) */
+
+	__le64 build_time;	/* 24  inode v1 time derivation */
+	__le32 build_time_nsec;	/* 32  inode v1 time derivation in nano scale */
+	__le32 blocks;		/* 36  used for statfs */
+	__le32 meta_blkaddr;	/* 40  start block address of metadata area */
+	__le32 xattr_blkaddr;	/* 44  start block address of shared xattr area */
+	__u8 uuid[16];		/* 48  128-bit uuid for volume */
+	__u8 volume_name[16];	/* 64  volume name */
+	__le32 requirements;	/* 80  (aka. feature_incompat) */
+
+	__u8 reserved2[44];	/* 84 */
+} __packed;			/* 128 bytes */
 
 /*
  * erofs inode data mapping:
@@ -73,16 +73,16 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATA_MAPPING_BIT        1
 
-struct erofs_inode_v1 {
-/*  0 */__le16 i_advise;
+struct erofs_inode_v1 {		/* off description */
+	__le16 i_advise;	/*  0  file hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_nlink;
-/*  8 */__le32 i_size;
-/* 12 */__le32 i_reserved;
-/* 16 */union {
+	__le16 i_xattr_icount;	/*  2  encoding for xattr ibody size */
+	__le16 i_mode;		/*  4 */
+	__le16 i_nlink;		/*  6 */
+	__le32 i_size;		/*  8 */
+	__le32 i_reserved;	/* 12 */
+	union {			/* 16 */
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -90,26 +90,26 @@ struct erofs_inode_v1 {
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
 	} i_u __packed;
-/* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
-/* 24 */__le16 i_uid;
-/* 26 */__le16 i_gid;
-/* 28 */__le32 i_reserved2;
-} __packed;
+	__le32 i_ino;		/* 20 only used for 32-bit stat compatibility */
+	__le16 i_uid;		/* 24 */
+	__le16 i_gid;		/* 26 */
+	__le32 i_reserved2;	/* 28 */
+} __packed;			/* 32 bytes */
 
 /* 32 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V1   0
 /* 64 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V2   1
 
-struct erofs_inode_v2 {
-/*  0 */__le16 i_advise;
+struct erofs_inode_v2 {		/* off description */
+	__le16 i_advise;	/*  0  file hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_reserved;
-/*  8 */__le64 i_size;
-/* 16 */union {
+	__le16 i_xattr_icount;	/*  2  encoding for xattr ibody size */
+	__le16 i_mode;		/*  4 */
+	__le16 i_reserved;	/*  6 */
+	__le64 i_size;		/*  8 */
+	union {			/* 16 */
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -119,15 +119,15 @@ struct erofs_inode_v2 {
 	} i_u __packed;
 
 	/* only used for 32-bit stat compatibility */
-/* 20 */__le32 i_ino;
-
-/* 24 */__le32 i_uid;
-/* 28 */__le32 i_gid;
-/* 32 */__le64 i_ctime;
-/* 40 */__le32 i_ctime_nsec;
-/* 44 */__le32 i_nlink;
-/* 48 */__u8   i_reserved2[16];
-} __packed;                     /* 64 bytes */
+	__le32 i_ino;		/* 20 only used for 32-bit stat compatibility */
+
+	__le32 i_uid;		/* 24 */
+	__le32 i_gid;		/* 28 */
+	__le64 i_ctime;		/* 32 */
+	__le32 i_ctime_nsec;	/* 40 */
+	__le32 i_nlink;		/* 44 */
+	__u8   i_reserved2[16];	/* 48 */
+} __packed;			/* 64 bytes */
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
-- 
2.17.1

