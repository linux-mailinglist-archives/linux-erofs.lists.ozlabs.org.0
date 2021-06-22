Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7B3AFB42
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jun 2021 05:06:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8BB83sR7z3060
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jun 2021 13:06:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ubvUQuH/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ubvUQuH/; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8BB32j0Zz2yXs
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jun 2021 13:06:18 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id m17so6506577plx.7
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jun 2021 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qqkWgAEUNfhvxjFICGkWZFyAshRlzhgUOl1+phduIgc=;
 b=ubvUQuH/ocqyBeEumUpnwPjJuAXijpnq18SLbXcbFuVKcSyk71wYbtco720hgN5xh1
 GXctwR+bGrnZfPjL58EhluWKWV4QhW9Klrya9oWyIF2P7pAgUNBQmRDPB5SOsuy6du67
 zB70PttYQmy9I0mG12Ho9Abwu3rwzLJMiHsPhVM2NL8QD8LWzHxeWwSmt7sl1P6Wdx2C
 BPgb5pq+wiUQ1E7MAtbRKlbr4IJLOZses/3+QiXtwEF5akxmvTwgWWY2l0IVMKwlpmvX
 h2dttMBf7dGQhArMIOEfUBMZ07gxiWx9DUTB5pZ0cmirkd9RpLRMnVeZwWMGWlU2Q9JU
 Gf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qqkWgAEUNfhvxjFICGkWZFyAshRlzhgUOl1+phduIgc=;
 b=Lix5PinI5N8Q9YIaarzj4O0n4HM/N21dnteUkvJvBgsmYCfwBAnyJ8qaEGkg0UsX7x
 H+DxQB9Ew3kbT/4CmA4/OeoJisWaAeFpXtBvxd/wd1NWSf6x3doHG0eppAUGmm5NR+lN
 PkRAD9chQsOPyoJ/IKjCwtNobTF0GyMDP2KbE8GvVjqu0X/lhDfxPYxJoY0p9+sH6x0K
 k8HDeFJ5waZ3DYxkxO0HB+zRl+22uvQaZxR1TRZbO4sKzdS0X1fid69VuUtiuB24H07b
 AfEPAeYVm9IoFiud43GfdhbFDc0VtvfX7uHR1HADppCK8HuZ9VkvFtXFbT7TELA9vAgF
 zoAA==
X-Gm-Message-State: AOAM530Z4ZpiYqn/gOBt374Is2SOe5RGqKqpv+l8x5oYMqlZLDM1fW4M
 yzeA7lcI2sXMEwM2Izi+ntDpu6p2x5oPFw==
X-Google-Smtp-Source: ABdhPJycds/pyIk9Cbm5iKy7HOXmSC+V8jhWVyatlkQMfpXviQjI1bamZYM0NObKXbjh9KLpyxKnig==
X-Received: by 2002:a17:90b:30c3:: with SMTP id
 hi3mr1354526pjb.188.1624331174135; 
 Mon, 21 Jun 2021 20:06:14 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p19sm513750pjv.21.2021.06.21.20.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 20:06:13 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] AOSP: erofs-utils: add block list support
Date: Tue, 22 Jun 2021 11:02:32 +0800
Message-Id: <20210622030232.1176-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Android update engine will treat EROFS filesystem image as one single
file. Let's add block list support to optimize OTA size.

Change-Id: I21d6177dff0ee65d3c57023b102e991d40873f0d
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 include/erofs/block_list.h | 19 ++++++++++
 include/erofs/config.h     |  1 +
 lib/block_list.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/compress.c             |  8 +++++
 lib/inode.c                | 21 ++++++++++-
 mkfs/main.c                | 17 +++++++++
 6 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/block_list.h
 create mode 100644 lib/block_list.c

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
new file mode 100644
index 0000000..cbf1050
--- /dev/null
+++ b/include/erofs/block_list.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/include/erofs/block_list.h
+ *
+ * Copyright (C), 2021, Coolpad Group Limited.
+ * Created by Yue Hu <huyue2@yulong.com>
+ */
+#ifndef __EROFS_BLOCK_LIST_H
+#define __EROFS_BLOCK_LIST_H
+
+#include "internal.h"
+
+int block_list_fopen(void);
+void block_list_fclose(void);
+void write_block_list(const char *path, erofs_blk_t blk_start,
+                      erofs_blk_t nblocks, bool has_tail);
+void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
+                               bool inline_data, erofs_blk_t blkaddr);
+#endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index d140a73..67e7a0f 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -65,6 +65,7 @@ struct erofs_configure {
 	char *mount_point;
 	char *target_out_path;
 	char *fs_config_file;
+	char *block_list_file;
 #endif
 };
 
diff --git a/lib/block_list.c b/lib/block_list.c
new file mode 100644
index 0000000..6ebe0f9
--- /dev/null
+++ b/lib/block_list.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/block_list.c
+ *
+ * Copyright (C), 2021, Coolpad Group Limited.
+ * Created by Yue Hu <huyue2@yulong.com>
+ */
+#ifdef WITH_ANDROID
+#include <stdio.h>
+
+#include "erofs/block_list.h"
+
+#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
+#include "erofs/print.h"
+
+static FILE *block_list_fp = NULL;
+
+int block_list_fopen(void)
+{
+	if (block_list_fp)
+		return 0;
+
+	block_list_fp = fopen(cfg.block_list_file, "w");
+
+	if (block_list_fp == NULL)
+		return -1;
+
+	return 0;
+}
+
+void block_list_fclose(void)
+{
+	if (block_list_fp) {
+		fclose(block_list_fp);
+		block_list_fp = NULL;
+	}
+}
+
+void write_block_list(const char *path, erofs_blk_t blk_start,
+		      erofs_blk_t nblocks, bool has_tail)
+{
+	const char *fspath = erofs_fspath(path);
+
+	if (!block_list_fp || !cfg.mount_point)
+		return;
+
+	/* only tail-end data */
+	if (!nblocks)
+		return;
+
+	fprintf(block_list_fp, "/%s", cfg.mount_point);
+
+	if (fspath[0] != '/')
+		fprintf(block_list_fp, "/");
+
+	if (nblocks == 1) {
+		fprintf(block_list_fp, "%s %u", fspath, blk_start);
+	} else {
+		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
+			blk_start + nblocks - 1);
+	}
+
+	if (!has_tail)
+		fprintf(block_list_fp, "\n");
+}
+
+void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
+			       bool inline_data, erofs_blk_t blkaddr)
+{
+	if (!block_list_fp || !cfg.mount_point)
+		return;
+
+	if (!nblocks && !inline_data) {
+		erofs_dbg("%s : only tail-end non-inline data", path);
+		write_block_list(path, blkaddr, 1, false);
+		return;
+	}
+
+	if (nblocks) {
+		if (!inline_data)
+			fprintf(block_list_fp, " %u", blkaddr);
+
+		fprintf(block_list_fp, "\n");
+	}
+}
+#endif
diff --git a/lib/compress.c b/lib/compress.c
index 2093bfd..5dec0c3 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -19,6 +19,10 @@
 #include "erofs/compress.h"
 #include "compressor.h"
 
+#ifdef WITH_ANDROID
+#include "erofs/block_list.h"
+#endif
+
 static struct erofs_compress compresshandle;
 static int compressionlevel;
 
@@ -553,6 +557,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		   inode->i_srcpath, (unsigned long long)inode->i_size,
 		   compressed_blocks);
 
+#ifdef WITH_ANDROID
+	write_block_list(inode->i_srcpath, blkaddr, compressed_blocks, false);
+#endif
+
 	/*
 	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
 	 *       when both mkfs & kernel support compression inline.
diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4..6be23cb 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -22,6 +22,10 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 
+#ifdef WITH_ANDROID
+#include "erofs/block_list.h"
+#endif
+
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
@@ -369,6 +373,12 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EIO;
 		}
 	}
+
+#ifdef WITH_ANDROID
+	if (nblocks)
+		write_block_list(inode->i_srcpath, inode->u.i_blkaddr,
+				 nblocks, inode->idata_size ? true : false);
+#endif
 	return 0;
 }
 
@@ -626,6 +636,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 int erofs_write_tail_end(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh, *ibh;
+	erofs_off_t pos;
 
 	bh = inode->bh_data;
 
@@ -640,7 +651,6 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->op = &erofs_write_inline_bhops;
 	} else {
 		int ret;
-		erofs_off_t pos;
 
 		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
@@ -658,6 +668,15 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		free(inode->idata);
 		inode->idata = NULL;
 	}
+
+#ifdef WITH_ANDROID
+	if (!S_ISDIR(inode->i_mode) && !S_ISLNK(inode->i_mode))
+		write_block_list_tail_end(inode->i_srcpath,
+					  inode->i_size / EROFS_BLKSIZ,
+					  inode->bh_inline ? true: false,
+					  erofs_blknr(pos));
+#endif
+
 out:
 	/* now bh_data can drop directly */
 	if (bh) {
diff --git a/mkfs/main.c b/mkfs/main.c
index e476189..d5a5e07 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -27,6 +27,10 @@
 #include <uuid.h>
 #endif
 
+#ifdef WITH_ANDROID
+#include "erofs/block_list.h"
+#endif
+
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
 static struct option long_options[] = {
@@ -47,6 +51,7 @@ static struct option long_options[] = {
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
 	{"fs-config-file", required_argument, NULL, 12},
+	{"block-list-file", required_argument, NULL, 13},
 #endif
 	{0, 0, 0, 0},
 };
@@ -95,6 +100,7 @@ static void usage(void)
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 	      " --product-out=X       X=product_out directory\n"
 	      " --fs-config-file=X    X=fs_config file\n"
+	      " --block-list-file=X    X=block_list file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -293,6 +299,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 12:
 			cfg.fs_config_file = optarg;
 			break;
+		case 13:
+			cfg.block_list_file = optarg;
+			break;
 #endif
 		case 'C':
 			i = strtoull(optarg, &endptr, 0);
@@ -541,6 +550,11 @@ int main(int argc, char **argv)
 		erofs_err("failed to load fs config %s", cfg.fs_config_file);
 		return 1;
 	}
+
+	if (cfg.block_list_file && block_list_fopen() < 0) {
+		erofs_err("failed to open %s", cfg.block_list_file);
+		return 1;
+	}
 #endif
 
 	erofs_show_config();
@@ -607,6 +621,9 @@ int main(int argc, char **argv)
 		err = erofs_mkfs_superblock_csum_set();
 exit:
 	z_erofs_compress_exit();
+#ifdef WITH_ANDROID
+	block_list_fclose();
+#endif
 	dev_close();
 	erofs_cleanup_exclude_rules();
 	erofs_exit_configure();
-- 
1.9.1

