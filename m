Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB545B0B7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 01:26:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzMJ90nmyz2ymP
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 11:26:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637713593;
	bh=X3XR1HRDUlnpEDYNgNAmV5nii8eS1g8RsE9GRa/Z8os=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ksB+SZuHWFkGNkOd+MXGtpuzwdxz0FATYvrIbLdrpW4XC/RJ1n/JlkBrZAj/l0htX
	 4LvObinHBJh0ZoDrKhYzAK85QLEPnMF1jSlKILz3h6GBBPZmfhxWm+PImjJ0z4yyJ/
	 aHNFB5FosUR1oqaCquqF4s3hLJC+T7z0mS4IczB8LCKgYUgjR0AdSHG7evpC2nUz0M
	 mk84vh7uNlSlFVqOQzhhgmjQJBBfTBS8vfFC8IO0LYxD5jfxPPWmQSFiDGM5XszVYU
	 9pPwnuEyoyHPIR2Y4Le5vFXGBS9M78+zAvBVFZk7Wbb3RqVnPXZE9m01ATqrJkxXNZ
	 eC+9Ie675FUwg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3riadyqskc0m4mfslpjq0nslttlqj.htrqnsz2-jwtkxqnxyx.t4qfgx.twl@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=EAIfbXbE; dkim-atps=neutral
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzMJ23cgcz2yPT
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 11:26:24 +1100 (AEDT)
Received: by mail-qk1-x749.google.com with SMTP id
 bl6-20020a05620a1a8600b0046803c08cccso687859qkb.15
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 16:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=X3XR1HRDUlnpEDYNgNAmV5nii8eS1g8RsE9GRa/Z8os=;
 b=z4jSd1vW2x/QFBAryEkru/37RkFyVna7swhIYGYNlQKLJR8Y+4o8lahMDZ6mb89kq9
 kmg5ipHLZFGtYQrQXfsIePctiyqUqADthABW1zpp1rzY0Hsi0ceBsgQ6/aYq5FRgVmUQ
 vYSu+Cl15RYo6tKgokPN3vwBNXiMlwXhGvqv36DkN6Qc2gwUEJEtpqWwfrxH/waY8wGG
 pUdvtKCWiXcGhaii/UkFxGx0wGNDqCEMIznpz8vbPK64RSurXdOo8oIBuyNFNK8h7nEy
 CSKjmvOKxDRjl/6ubWILUtQItaps6LXpAiravhEaVOSR4m/gtuWy2nwl9oVFC2VG4U2M
 h2WQ==
X-Gm-Message-State: AOAM531HNq/hT9hZd0ikwOoKwQfVbl4ImoLlxgTngS6PWi5t2FgyhD0/
 yo2xSfpByHAjU7B4NaqDbo7TUmhyifGgIOYGM4/L2D1n7gCMtTWE//B7bBTiyCbGrKp9fY32tfw
 9ciRF7wPcs1dnjEFjEuk6pR0ajxk6YTVyMpRY5/WqD1rVuL3mwTPpF/ZgyanHcnokq/q3Utynm0
 7Ppi+EmZk=
X-Google-Smtp-Source: ABdhPJzTyF9J7uoq1P68tJc4VBub1zI6fvlSj4B+shFuFBnqMo8GvoMhPW0qXceyMtPokSoIvxxHB1juRoy16pPe4w==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:5fc2:: with SMTP id
 k2mr1965446qta.310.1637713580651; Tue, 23 Nov 2021 16:26:20 -0800 (PST)
Date: Tue, 23 Nov 2021 16:26:13 -0800
Message-Id: <20211124002614.1303130-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1] Refactor out some I/O logic into separate function
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Li Guifu <bluce.liguifu@huawei.com>, 
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>, Chao Yu <yuchao0@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Many of the global variables are for I/O purposes. To make the codebase
more library friendly, decouple I/O and parsing into separate functions.

Change-Id: I7dbb3dcd6e82b075205891f9a06b80e1191fa5d6
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/defs.h  | 19 ++++++++++++
 include/erofs/parse.h | 23 +++++++++++++++
 include/erofs_fs.h    | 12 ++++++++
 lib/io.c              |  1 +
 lib/namei.c           | 34 +++++++++++++++-------
 lib/super.c           | 67 ++++++++++++++++++++++++++-----------------
 6 files changed, 118 insertions(+), 38 deletions(-)
 create mode 100644 include/erofs/parse.h

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 6398cbb..16376dc 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -8,6 +8,11 @@
 #ifndef __EROFS_DEFS_H
 #define __EROFS_DEFS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <stddef.h>
 #include <stdint.h>
 #include <assert.h>
@@ -82,12 +87,18 @@ typedef int64_t         s64;
 #endif
 #endif
 
+#ifdef __cplusplus
+#define BUILD_BUG_ON(condition) static_assert(!condition)
+#else
+
 #ifndef __OPTIMIZE__
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
 #else
 #define BUILD_BUG_ON(condition) assert(!(condition))
 #endif
 
+#endif
+
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
 #define __round_mask(x, y)      ((__typeof__(x))((y)-1))
@@ -110,6 +121,8 @@ typedef int64_t         s64;
 }							\
 )
 
+// Defining min/max macros in C++ will cause conflicts with std::min/max
+#ifndef __cplusplus
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
@@ -121,6 +134,7 @@ typedef int64_t         s64;
 	typeof(y) _max2 = (y);			\
 	(void) (&_max1 == &_max2);		\
 	_max1 > _max2 ? _max1 : _max2; })
+#endif
 
 /*
  * ..and if you can't take the strict types, you can specify one yourself.
@@ -308,4 +322,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define stat64		stat
 #define lstat64		lstat
 #endif
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/parse.h b/include/erofs/parse.h
new file mode 100644
index 0000000..65948a1
--- /dev/null
+++ b/include/erofs/parse.h
@@ -0,0 +1,23 @@
+
+#ifndef __EROFS_PARSE_H
+#define __EROFS_PARSE_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "erofs_fs.h"
+#include "internal.h"
+
+int erofs_parse_inode_from_buffer(const char buf[EROFS_MAX_INODE_SIZE],
+                                  struct erofs_inode *vi);
+
+int erofs_parse_superblock(const char data[EROFS_BLKSIZ],
+                           struct erofs_sb_info *sbi);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..3f1f645 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -9,6 +9,12 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
+#ifdef __cplusplus
+#define inline constexpr
+extern "C"
+{
+#endif
+
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
@@ -189,6 +195,8 @@ struct erofs_inode_extended {
 	__u8   i_reserved2[16];
 };
 
+#define EROFS_MAX_INODE_SIZE sizeof(struct erofs_inode_extended)
+
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
 #define EROFS_SHARED_XATTR_EXTENT       (255)
@@ -425,4 +433,8 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
 }
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/lib/io.c b/lib/io.c
index a0d366a..9ee754b 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -12,6 +12,7 @@
 #endif
 #include <sys/stat.h>
 #include <sys/ioctl.h>
+#include <sys/fcntl.h>
 #include "erofs/io.h"
 #ifdef HAVE_LINUX_FS_H
 #include <linux/fs.h>
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..95c379c 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,18 +22,15 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_parse_inode_from_buffer(
+	const char buf[EROFS_MAX_INODE_SIZE],
+	struct erofs_inode *vi)
 {
 	int ret, ifmt;
-	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
 	const erofs_off_t inode_loc = iloc(vi->nid);
 
-	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
-	if (ret < 0)
-		return -EIO;
-
 	dic = (struct erofs_inode_compact *)buf;
 	ifmt = le16_to_cpu(dic->i_format);
 
@@ -47,11 +44,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
-			       sizeof(*die) - sizeof(*dic));
-		if (ret < 0)
-			return -EIO;
-
 		die = (struct erofs_inode_extended *)buf;
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(die->i_mode);
@@ -144,6 +136,26 @@ bogusimode:
 	return -EFSCORRUPTED;
 }
 
+int erofs_read_inode_from_disk(struct erofs_inode *vi)
+{
+	char buf[sizeof(struct erofs_inode_extended)];
+	struct erofs_inode_compact *dic;
+	struct erofs_inode_extended *die;
+	const erofs_off_t inode_loc = iloc(vi->nid);
+
+	int ret = dev_read(0, buf, inode_loc, sizeof(*dic));
+	if (ret < 0)
+		return -EIO;
+	int ifmt = le16_to_cpu(dic->i_format);
+	if (erofs_inode_version(ifmt)) {
+		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
+			       sizeof(*die) - sizeof(*dic));
+		if (ret < 0)
+			return -EIO;	
+	}
+	return erofs_parse_inode_from_buffer(buf, vi);
+}
+
 
 struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 					void *dentry_blk,
diff --git a/lib/super.c b/lib/super.c
index 3ccc551..0e26992 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -4,6 +4,7 @@
  */
 #include <string.h>
 #include <stdlib.h>
+#include "erofs/internal.h"
 #include "erofs/io.h"
 #include "erofs/print.h"
 
@@ -62,29 +63,21 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_read_superblock(void)
-{
-	char data[EROFS_BLKSIZ];
-	struct erofs_super_block *dsb;
-	unsigned int blkszbits;
-	int ret;
+int erofs_parse_superblock(
+	const char data[EROFS_BLKSIZ],
+	struct erofs_sb_info *sbi
+) {
+	struct erofs_super_block *dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
-	ret = blk_read(0, data, 0, 1);
-	if (ret < 0) {
-		erofs_err("cannot read erofs superblock: %d", ret);
-		return -EIO;
-	}
-	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-
-	ret = -EINVAL;
+	int ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err("cannot find valid erofs superblock");
 		return ret;
 	}
 
-	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 
-	blkszbits = dsb->blkszbits;
+	unsigned int blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
 		erofs_err("blksize %u isn't supported on this platform",
@@ -92,20 +85,40 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	if (!check_layout_compatibility(&sbi, dsb))
+	if (!check_layout_compatibility(sbi, dsb))
 		return ret;
 
-	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
-	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
-	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
-	sbi.islotbits = EROFS_ISLOTBITS;
-	sbi.root_nid = le16_to_cpu(dsb->root_nid);
-	sbi.inos = le64_to_cpu(dsb->inos);
-	sbi.checksum = le32_to_cpu(dsb->checksum);
+	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi->islotbits = EROFS_ISLOTBITS;
+	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->inos = le64_to_cpu(dsb->inos);
+	sbi->checksum = le32_to_cpu(dsb->checksum);
 
-	sbi.build_time = le64_to_cpu(dsb->build_time);
-	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->build_time);
+	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+
+	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
+	return 0;
+}
 
-	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
+int erofs_read_superblock(void)
+{
+	char data[EROFS_BLKSIZ];
+	struct erofs_super_block *dsb;
+	unsigned int blkszbits;
+	int ret;
+
+	ret = blk_read(0, data, 0, 1);
+	if (ret < 0) {
+		erofs_err("cannot read erofs superblock: %d", ret);
+		return -EIO;
+	}
+	ret = erofs_parse_superblock(data, &sbi);
+	if (ret) {
+		return ret;
+	}
+	
 	return erofs_init_devices(&sbi, dsb);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

