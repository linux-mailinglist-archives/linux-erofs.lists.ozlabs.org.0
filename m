Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F63B2822
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 09:02:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9WL83YPVz304j
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 17:02:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=jluM+OMo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jluM+OMo; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9WL51mC6z2xZK
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 17:02:52 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id a127so4358105pfa.10
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 00:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aclLBl5lLKsTtRbUF7KUFoygHmEFdqnEKvbu9ysNa1Q=;
 b=jluM+OMo5NoXurZj4bLd2utdD4lSVmjS3Bj0W+50itwPpQXFRc6eF/4J1RZMMxl6eT
 tsQnMrESG1uiYLUZEoulxNw6sgoWBvO4hBXkt3mCEB/685LxIR87W9DW+4DceU3IT1Jf
 g1Kw9/3twfujruhwEZk7dlqRiMoU5BFwH79dlbi1CnAiUw0EwIawE2+yBn/ciU9suAz5
 Av5v5sKJ0ouDEdfjiJvcAJf21o7R9Z6B+CPMLHDqJgKOtB7y5hS3skij64+sYY5zu9CQ
 2zCimkccXCy24stl+sbj+0rqu9zWTxWqI/6aY7BMmSL2EuvwGSn76hDa1DZ7irAm4kZI
 gWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aclLBl5lLKsTtRbUF7KUFoygHmEFdqnEKvbu9ysNa1Q=;
 b=GAN2Ig7ynFO0ufqzF1iiQB7E81UlqlGxmH3mfrvqzP2yv/skWTIHR1o5zznMdzXrbV
 eB1lIcglNCs033r2Mr4g+KD+u7QVBHOaWelKjXq9k1Y9BzCqhGjtVenHoBr+lSIfZL9m
 Rpqbbz3zKy95uKU020epX0sKyRxW84sHUdOsAshjjse41bkS6FhKOuuaJKtI8N+S7cft
 f7LmVkN3bRt8UW9F46FaB08bg2jZD38opWBg7j63qTrB2xpPMWCfwIWc6anuVWrXx22A
 akHSq2nV58hbffjEKeXWwvXzM1uI+wN3uvTdrpjqigmyKOQr8DIdHJ5qEjIE5i9l6aHO
 ZKiw==
X-Gm-Message-State: AOAM5333JFC+SJHImRK1cm3JV/1qg3LO7+FtGAOlR51l9oRKHvxUMVji
 Ce5HXYWYGPSVPeovd4y0AAk=
X-Google-Smtp-Source: ABdhPJxH5ozGD+wAyvV9d7juG4KeCLZbh1gvrnkdp37KiMm2DPZfl7D9ehVxsJl8T6oKnNOAB276JA==
X-Received: by 2002:a63:e309:: with SMTP id f9mr3402207pgh.443.1624518168954; 
 Thu, 24 Jun 2021 00:02:48 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id q4sm1409254pgg.0.2021.06.24.00.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 00:02:48 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v4] AOSP: erofs-utils: add block list support
Date: Thu, 24 Jun 2021 15:02:34 +0800
Message-Id: <20210624070234.1340-1-zbestahu@gmail.com>
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
Cc: yh@oppo.com, huyue2@yulong.com, xiang@kernel.org, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Android update engine will treat EROFS filesystem image as one single
file. Let's add block list support to optimize OTA size.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Yue Hu <huyue2@yulong.com>
---
 include/erofs/block_list.h | 27 ++++++++++++++
 include/erofs/config.h     |  1 +
 lib/block_list.c           | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/compress.c             |  2 ++
 lib/inode.c                |  6 ++++
 mkfs/main.c                | 14 ++++++++
 6 files changed, 139 insertions(+)
 create mode 100644 include/erofs/block_list.h
 create mode 100644 lib/block_list.c

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
new file mode 100644
index 0000000..7756d8a
--- /dev/null
+++ b/include/erofs/block_list.h
@@ -0,0 +1,27 @@
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
+#ifdef WITH_ANDROID
+int erofs_droid_blocklist_fopen(void);
+void erofs_droid_blocklist_fclose(void);
+void erofs_droid_blocklist_write(struct erofs_inode *inode,
+				 erofs_blk_t blk_start, erofs_blk_t nblocks);
+void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
+					  erofs_blk_t blkaddr);
+#else
+static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
+				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
+static inline
+void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
+					  erofs_blk_t blkaddr) {}
+#endif
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
index 0000000..959f9bc
--- /dev/null
+++ b/lib/block_list.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/block_list.c
+ *
+ * Copyright (C), 2021, Coolpad Group Limited.
+ * Created by Yue Hu <huyue2@yulong.com>
+ */
+#ifdef WITH_ANDROID
+#include <stdio.h>
+#include <sys/stat.h>
+#include "erofs/block_list.h"
+
+#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
+#include "erofs/print.h"
+
+static FILE *block_list_fp = NULL;
+
+int erofs_droid_blocklist_fopen(void)
+{
+	if (block_list_fp)
+		return 0;
+
+	block_list_fp = fopen(cfg.block_list_file, "w");
+
+	if (!block_list_fp)
+		return -1;
+	return 0;
+}
+
+void erofs_droid_blocklist_fclose(void)
+{
+	if (!block_list_fp)
+		return;
+
+	fclose(block_list_fp);
+	block_list_fp = NULL;
+}
+
+static void blocklist_write(const char *path, erofs_blk_t blk_start,
+			    erofs_blk_t nblocks, bool has_tail)
+{
+	const char *fspath = erofs_fspath(path);
+
+	fprintf(block_list_fp, "/%s", cfg.mount_point);
+
+	if (fspath[0] != '/')
+		fprintf(block_list_fp, "/");
+
+	if (nblocks == 1)
+		fprintf(block_list_fp, "%s %u", fspath, blk_start);
+	else
+		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
+			blk_start + nblocks - 1);
+
+	if (!has_tail)
+		fprintf(block_list_fp, "\n");
+}
+
+void erofs_droid_blocklist_write(struct erofs_inode *inode,
+				 erofs_blk_t blk_start, erofs_blk_t nblocks)
+{
+	if (!block_list_fp || !cfg.mount_point || !nblocks)
+		return;
+
+	blocklist_write(inode->i_srcpath, blk_start, nblocks,
+			!!inode->idata_size);
+}
+
+void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
+					  erofs_blk_t blkaddr)
+{
+	if (!block_list_fp || !cfg.mount_point)
+		return;
+
+	/* XXX: a bit hacky.. may need a better approach */
+	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
+		return;
+
+	if (erofs_blknr(inode->i_size)) { // its block list has been output before
+		if (blkaddr == NULL_ADDR)
+			fprintf(block_list_fp, "\n");
+		else
+			fprintf(block_list_fp, " %u\n", blkaddr);
+		return;
+	}
+	if (blkaddr != NULL_ADDR)
+		blocklist_write(inode->i_srcpath, blkaddr, 1, false);
+}
+#endif
diff --git a/lib/compress.c b/lib/compress.c
index 2093bfd..af0c720 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/compress.h"
 #include "compressor.h"
+#include "erofs/block_list.h"
 
 static struct erofs_compress compresshandle;
 static int compressionlevel;
@@ -571,6 +572,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
+	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
 err_bdrop:
diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4..4134f8a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -21,6 +21,7 @@
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
+#include "erofs/block_list.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -369,6 +370,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EIO;
 		}
 	}
+	erofs_droid_blocklist_write(inode, inode->u.i_blkaddr, nblocks);
 	return 0;
 }
 
@@ -638,6 +640,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
+
+		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
 	} else {
 		int ret;
 		erofs_off_t pos;
@@ -657,6 +661,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
+
+		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(pos));
 	}
 out:
 	/* now bh_data can drop directly */
diff --git a/mkfs/main.c b/mkfs/main.c
index e476189..28539da 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,7 @@
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
+#include "erofs/block_list.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -47,6 +48,7 @@ static struct option long_options[] = {
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
 	{"fs-config-file", required_argument, NULL, 12},
+	{"block-list-file", required_argument, NULL, 13},
 #endif
 	{0, 0, 0, 0},
 };
@@ -95,6 +97,7 @@ static void usage(void)
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 	      " --product-out=X       X=product_out directory\n"
 	      " --fs-config-file=X    X=fs_config file\n"
+	      " --block-list-file=X    X=block_list file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -293,6 +296,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 12:
 			cfg.fs_config_file = optarg;
 			break;
+		case 13:
+			cfg.block_list_file = optarg;
+			break;
 #endif
 		case 'C':
 			i = strtoull(optarg, &endptr, 0);
@@ -541,6 +547,11 @@ int main(int argc, char **argv)
 		erofs_err("failed to load fs config %s", cfg.fs_config_file);
 		return 1;
 	}
+
+	if (cfg.block_list_file && erofs_droid_blocklist_fopen() < 0) {
+		erofs_err("failed to open %s", cfg.block_list_file);
+		return 1;
+	}
 #endif
 
 	erofs_show_config();
@@ -607,6 +618,9 @@ int main(int argc, char **argv)
 		err = erofs_mkfs_superblock_csum_set();
 exit:
 	z_erofs_compress_exit();
+#ifdef WITH_ANDROID
+	erofs_droid_blocklist_fclose();
+#endif
 	dev_close();
 	erofs_cleanup_exclude_rules();
 	erofs_exit_configure();
-- 
1.9.1

