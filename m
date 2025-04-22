Return-Path: <linux-erofs+bounces-209-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380BA96AAF
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 14:45:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhhm63jpqz304l;
	Tue, 22 Apr 2025 22:45:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745325926;
	cv=none; b=oxHZvk17Pc36tQSuAoDcgUc59KSdfnYlHUeJs4VvAlCTa+geq3CKee2maeR7Gbld5pMP8gwPLuBm5ncEhSONisiB0goZ7c84wUnxjyZtedgsFufK68T8brTPQxGc6hkm94jNIkjbKvYne5g23NTitqXjpqPfXCgBkoOJD5huW4C4ILtKcihWMrWnLpeqtBDCayeT+UG2pijeR4PoclL5F1imUw0PM2zkgVd1DHBFsHKFVHLlEGPRl/rSrTCIKbRy4Kd7pbTUVmO/FH/OgO2HHvO6rs2PVqLbUBlgH2WVMybR49fPj9Rw36SjWkjXcnmMFUW0pip1ZerHfn44kfX/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745325926; c=relaxed/relaxed;
	bh=rjOdWXvhHoga0zVwAkA+ZSF/9pIyAIa2N7QQ7L9hSgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKDgnWHjecwgqbbFGgvDl/W75Esyw7LfFYg/my2NjF40VNQvt8dLeQRNOigGSitiyqflowPovTS60a4SUnsBI7NzLHA0NbUVmSdHT4RZFQvaYAbgOo3Age8+IXZ0CWTbEsAHffaB72hAnEVzR8q0wkhK01sU8c+XMImHyFoqb8fh+1aUaCQRt0Fi1yBVbXxuI7SCAaKMKK7Yv66Ssr+D8TVRNoAbftGATXs5zaybjNby5oIJXILh9LiACBG4YFHaogu9nBYMvQoZ93vOnDdC6hpyzM02KqdtZRiiVrLzTm6OHjFjFG4qqgQ8uu/sBve1zsEmOWjRD/zSzjaiQemGqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhhm36HJVz3bmk
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 22:45:22 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zhhjg5z3Dz1R7Xp;
	Tue, 22 Apr 2025 20:43:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 29EB51A016C;
	Tue, 22 Apr 2025 20:45:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:45:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC 2/4] erofs-utils: lib: Implement the main logic for --meta_fix option
Date: Tue, 22 Apr 2025 12:36:10 +0000
Message-ID: <20250422123612.261764-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250422123612.261764-1-lihongbo22@huawei.com>
References: <20250422123612.261764-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The option --meta_fix will fix the metadata area, so for the data
area, we first dump them into a temporary file to avoid alloc buffer
from @g_sbi.bmgr. Then we remmap the blkaddr based on the offset in
@g_sbi.bmgr after metadata finishing, and dump it into @g_sbi.bmgr
directly.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/erofs/blobraw.h |  28 ++++++++++
 lib/Makefile.am         |   3 +-
 lib/blobraw.c           | 121 ++++++++++++++++++++++++++++++++++++++++
 lib/inode.c             |   6 ++
 mkfs/main.c             |  15 +++++
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100755 include/erofs/blobraw.h
 create mode 100755 lib/blobraw.c

diff --git a/include/erofs/blobraw.h b/include/erofs/blobraw.h
new file mode 100755
index 0000000..d56bb46
--- /dev/null
+++ b/include/erofs/blobraw.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * erofs-utils/lib/blobraw.h
+ *
+ * Copyright (C) 2025, HUAWEI, Inc.
+ */
+#ifndef __EROFS_BLOBRAW_H
+#define __EROFS_BLOBRAW_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "erofs/internal.h"
+
+void erofs_blobraw_remap_blkaddr(struct erofs_inode *inode);
+int erofs_blobraw_write_file(struct erofs_inode *inode, int fd);
+int erofs_blobraw_init();
+void erofs_blobraw_exit();
+int erofs_mkfs_dump_rawblob(struct erofs_sb_info *sbi, bool drop_blob);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index bdc74ad..c0804b3 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,6 +3,7 @@
 noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/blobchunk.h \
+      $(top_srcdir)/include/erofs/blobraw.h \
       $(top_srcdir)/include/erofs/block_list.h \
       $(top_srcdir)/include/erofs/cache.h \
       $(top_srcdir)/include/erofs/compress.h \
@@ -33,7 +34,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
+		      compress_hints.c hashmap.c sha256.c blobchunk.c blobraw.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c
 
diff --git a/lib/blobraw.c b/lib/blobraw.c
new file mode 100755
index 0000000..248fc30
--- /dev/null
+++ b/lib/blobraw.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * erofs-utils/lib/blobraw.c
+ *
+ * Copyright (C) 2025, HUAWEI, Inc.
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "erofs/blobraw.h"
+#include "erofs/print.h"
+#include "erofs/cache.h"
+#include "liberofs_private.h"
+
+static int blobfile = -1;		/* tmp fd for blob buffer */
+static erofs_blk_t remapped_base;	/* metadata block end address */
+static erofs_off_t bloboff;		/* current blob file offset */
+
+void erofs_blobraw_remap_blkaddr(struct erofs_inode *inode)
+{
+	if (inode->i_size > 0)
+		inode->u.i_blkaddr += remapped_base;
+}
+
+int erofs_blobraw_write_file(struct erofs_inode *inode, int fd)
+{
+	static u8 zeroed[EROFS_MAX_BLOCK_SIZE];
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int padding;
+	erofs_off_t foff;
+	ssize_t length, ret, isize = inode->i_size;
+	u64 pos_in, pos_out = bloboff;
+
+	pos_in = 0;
+	do {
+		length = min_t(erofs_off_t, isize,  SSIZE_MAX);
+		ret = erofs_copy_file_range(fd, &pos_in,
+				blobfile, &pos_out, length);
+	} while (ret > 0 && (isize -= ret));
+
+	foff = lseek(blobfile, inode->i_size, SEEK_CUR);
+	DBG_BUGON(foff != bloboff + inode->i_size);
+
+	padding = erofs_blkoff(sbi, inode->i_size);
+	if (padding) {
+		padding = erofs_blksiz(sbi) - padding;
+		ret = __erofs_io_write(blobfile, zeroed, padding);
+		if (ret > 0 && ret != padding)
+			return -EIO;
+	}
+
+	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+	inode->u.i_blkaddr = erofs_blknr(sbi, bloboff);
+	bloboff += round_up(inode->i_size, erofs_blksiz(sbi));
+
+	return 0;
+}
+
+int erofs_mkfs_dump_rawblob(struct erofs_sb_info *sbi, bool drop_blob)
+{
+	struct erofs_buffer_head *bh;
+	erofs_off_t blob_size;
+	ssize_t length, ret = 0;
+	u64 pos_in, pos_out;
+
+	if (blobfile < 0) {
+		erofs_err("dump rawblob failed");
+		return -1;
+	}
+
+	blob_size = bloboff;
+
+	bh = erofs_balloc(sbi->bmgr, DATA, blob_size, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	erofs_mapbh(NULL, bh->block);
+
+	pos_out = erofs_btell(bh, false);
+	remapped_base = erofs_blknr(sbi, pos_out);
+	pos_out += sbi->bdev.offset;
+
+	/* copy the raw blob data */
+	if (!drop_blob) {
+		pos_in = 0;
+		do {
+			length = min_t(erofs_off_t, blob_size,  SSIZE_MAX);
+			ret = erofs_copy_file_range(blobfile, &pos_in,
+					sbi->bdev.fd, &pos_out, length);
+		} while (ret > 0 && (blob_size -= ret));
+
+		if (ret >= 0) {
+			if (blob_size) {
+				erofs_err("failed to append the remaining %llu-byte blob data",
+					  blob_size);
+				ret = -EIO;
+			} else {
+				ret = 0;
+			}
+		}
+	}
+
+	erofs_bdrop(bh, false);
+	return ret;
+}
+
+int erofs_blobraw_init()
+{
+	blobfile = erofs_tmpfile();
+	if (blobfile < 0)
+		return -errno;
+
+	return 0;
+}
+
+void erofs_blobraw_exit()
+{
+	if (blobfile >= 0)
+		close(blobfile);
+}
diff --git a/lib/inode.c b/lib/inode.c
index 108aa9e..39257c7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -28,6 +28,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/blobraw.h"
 #include "erofs/fragments.h"
 #include "liberofs_private.h"
 
@@ -579,6 +580,8 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
+	if (cfg.c_meta_fix)
+		return erofs_blobraw_write_file(inode, fd);
 	/* fallback to all data uncompressed */
 	return write_uncompressed_file_from_fd(inode, fd);
 }
@@ -600,6 +603,9 @@ int erofs_iflush(struct erofs_inode *inode)
 	else
 		off = erofs_iloc(inode);
 
+	if (S_ISREG(inode->i_mode) && cfg.c_meta_fix)
+		erofs_blobraw_remap_blkaddr(inode);
+
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
 		u1.rdev = cpu_to_le32(inode->u.i_rdev);
diff --git a/mkfs/main.c b/mkfs/main.c
index 42635c6..82db452 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,6 +26,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/blobraw.h"
 #include "erofs/fragments.h"
 #include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
@@ -1422,6 +1423,12 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
+	if (cfg.c_meta_fix) {
+		err = erofs_blobraw_init();
+		if (err)
+			return -1;
+	}
+
 	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
 	    !erofstar.mapfile) || cfg.c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&g_sbi, 1);
@@ -1498,6 +1505,12 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
+	if (cfg.c_meta_fix) {
+		err = erofs_mkfs_dump_rawblob(&g_sbi, cfg.c_meta_fix);
+		if (err)
+			goto exit;
+	}
+
 	/* flush all buffers except for the superblock */
 	err = erofs_bflush(g_sbi.bmgr, NULL);
 	if (err)
@@ -1537,6 +1550,8 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
+	if (cfg.c_meta_fix)
+		erofs_blobraw_exit();
 	erofs_packedfile_exit(&g_sbi);
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
-- 
2.22.0


