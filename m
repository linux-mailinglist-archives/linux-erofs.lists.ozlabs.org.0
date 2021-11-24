Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2845B0CA
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 01:36:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzMX43Qvlz2ym7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 11:36:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637714212;
	bh=OdnTPLZ/89vAzByBj2larrevUcPATNsmYOKoKfC9Z88=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BuFHIG6m3Upid51A7e//UUdcxzRd7293hR0QQX/TzNYuH1hxqU0rgYpPfOLx/EWjN
	 0sVgzR3AREAv5XYvMKIkHh8XvZ3qGm6eBEJFufvpWsROr0FzLbZgrdo4kOep7fvLIO
	 mweCgf9NCG5Tm+TvrPrF7j9vRLPiQS9t9VSOq1FW9TamTdCKNlPcFuXIzg2HeerUGS
	 2MRKqd0JcPzs58h7CcPAu1Vms6YTGYBnOO/1ysxcvHPOUCL2PR7ML/AQzuEC2XkYyb
	 OSx9EnPmbOOtd0ljIaRPcZkK5Lbn8h/WJhdpq+o1uj8fIhOU8+IF5wqRuvgI9wNcKy
	 Em656PmyNs+/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3g4mdyqskc7yvdwjcgahrejckkcha.ykihejqt-ankboheopo.kvhwxo.knc@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=DeZLwxY6; dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzMX1073xz2yPT
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 11:36:47 +1100 (AEDT)
Received: by mail-qt1-x849.google.com with SMTP id
 z10-20020ac83e0a000000b002a732692afaso854427qtf.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 16:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=OdnTPLZ/89vAzByBj2larrevUcPATNsmYOKoKfC9Z88=;
 b=OufW/xEaPV1AdiOHeMQDDih0KVsQyLXf+rUK9T4lOumBEVpHP37p8qtT4Agx2+g6zr
 OlS09NkXS6eOocyv+oRrG1moZcDeFUIqBYUlonJz3JnBx44EzX9tcQLsU6r+KDvTrupf
 Wbl4Lx6PMRwDTJw8TsGri8B2B+nlJxnDQSqGHl4JK4CHgYQs2DjDTG8qdHTZdUc7PVX7
 lwhKkADuoeM5zoKyNoHXaCHieMLc1hep87qMgy7UQ6Ja+v3Z3obkABoYKhTf3auC+dN1
 VyUy3WnnGwkV+sY93jGczhGwV4RZruP9AG4reMNobSLjdhedqWQcypAPYzRlahL85ZF8
 PGbQ==
X-Gm-Message-State: AOAM531agFJNsdELaHE917rONlfuBKN9kb4pBPlNW6nATgUfi4ezvTYF
 u2+r/kcqGPvao1hW32GgU3ietmdW8sv2kBhQ8VoKhFTsMHh5TJaFOfwiTF1LkgV+j5zgv4Y4eVB
 m2R4A9f2g+lYBMmCDVogSQaWeSC4K24hgNc4V/vxCb6jJQY2D8IW8bhu3LQFNnFfA7U/+ES1V4C
 2EZk+W58o=
X-Google-Smtp-Source: ABdhPJzdUAwLBVh1IR+kCedcFHu63R3IBR9UwDJy46x7Ano/nd/vQbrqb15wlNd9GXAMyR1tmVur1exZB1AteRnYKQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:5a51:: with SMTP id
 o17mr1999729qta.180.1637714203632; Tue, 23 Nov 2021 16:36:43 -0800 (PST)
Date: Tue, 23 Nov 2021 16:36:40 -0800
In-Reply-To: <20211124002614.1303130-1-zhangkelvin@google.com>
Message-Id: <20211124003640.1319587-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211124002614.1303130-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] Refactor out some I/O logic into separate function
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
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
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Many of the global variables are for I/O purposes. To make the codebase
more library friendly, decouple I/O and parsing into separate functions.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/defs.h  | 19 +++++++++++++
 include/erofs/parse.h | 23 +++++++++++++++
 include/erofs_fs.h    | 12 ++++++++
 lib/io.c              |  1 +
 lib/namei.c           | 38 ++++++++++++++++---------
 lib/super.c           | 66 +++++++++++++++++++++++++------------------
 6 files changed, 119 insertions(+), 40 deletions(-)
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
index 7377e74..d94baad 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,17 +22,13 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_parse_inode_from_buffer(
+	const char buf[EROFS_MAX_INODE_SIZE],
+	struct erofs_inode *vi)
 {
-	int ret, ifmt;
-	char buf[sizeof(struct erofs_inode_extended)];
+	int ifmt;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	const erofs_off_t inode_loc = iloc(vi->nid);
-
-	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
-	if (ret < 0)
-		return -EIO;
 
 	dic = (struct erofs_inode_compact *)buf;
 	ifmt = le16_to_cpu(dic->i_format);
@@ -47,11 +43,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
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
@@ -144,6 +135,27 @@ bogusimode:
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
+	dic = (struct erofs_inode_compact *)buf;
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
index 3ccc551..f15aaf1 100644
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
-
-	ret = blk_read(0, data, 0, 1);
-	if (ret < 0) {
-		erofs_err("cannot read erofs superblock: %d", ret);
-		return -EIO;
-	}
-	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
+int erofs_parse_superblock(
+	const char data[EROFS_BLKSIZ],
+	struct erofs_sb_info *sbi
+) {
+	struct erofs_super_block *dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
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
@@ -92,20 +85,39 @@ int erofs_read_superblock(void)
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

