Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B4A1656B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 03:35:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YbvbG47Ghz3011
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 13:35:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737340552;
	cv=none; b=KF3GznyPbokpnqYptedPWsdIG+clEPzoahtw93wUW1Pf3Dp8nCu2KovWSPO4y3tnF4lYw8wnsLsWfXsVCIZNcpVhACs67SYMHFU7pgWxwuFQ37MVWBZXzYYmWyACuEl6O/ZG9LqFhbM+maxzkAJIFpo7t/RGw76cxpmAJsXJ2g4MCFMNmIbaIVFYLS6M5066wLS6QiBFiL/dUrnbgO49Du+/wdcB4Gt27UKODY7Ou0scWKd7a7ZglhKzLpa3H/rLErjWedf7+c1LFV/NpLLZl4rNj/n74iSFh3NQNZ06MccjpRgWgt9Y2uKm0i7jI9C4/W0tP0WI3WlnMHiD12QKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737340552; c=relaxed/relaxed;
	bh=g2vAsOgCx8mavLhrWtTj3RguEp4x7MqvBbWWuwa7fW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD4MDYFrp5YLmogJLKBuGtXih7OrbgomWffMgwQbmSKm+QRo5KNRaAYt9zTnTA5iHxdF81CMXl00JbUNmjpJiAnaZ/12+hv4DwMR2J3gJFPUwAkHJ2QeIiTXZ+2Gp/bPDYBAbojf879Ta1WsihVuFh4Ds03XBrPUhXILEEKd/ReVUbBW6S9SgnsW2ZzgcVehDRPMaJvRkHCY44XAqdWCyV0MLclpGpx4QxAEg6r7c4LWNu6/Lx+69FQZ5Tcg4vOurj9DV+/i6P932Qw8z62OA9iSsG0CFQPx9AE0ArLmf8A92dVk3oF0Xq1BZOhnRHwNyCAOfMmqSLE91Wt1avJmnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H6EehOPk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H6EehOPk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybvb96tVCz2yDp
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 13:35:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737340545; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=g2vAsOgCx8mavLhrWtTj3RguEp4x7MqvBbWWuwa7fW0=;
	b=H6EehOPkSYyqqkU+dP+6AWCNlhpWwiydW4zWbFDRIre4twl2TKMnmsuClyJ+hoKxsMbvF0DmUIC+RTGt6WZJ6tFzce5Pildx/di7dDtX6hFF5lwMZSyJrLGE8i36UHDrfKeZcWyhbixTuEwWvU0ioGnf/e1VsaPfKRlwQ140o5o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNvBCtX_1737340539 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 10:35:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: introduce fragment cache
Date: Mon, 20 Jan 2025 10:35:38 +0800
Message-ID: <20250120023538.3156606-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250117074602.2223094-3-hsiangkao@linux.alibaba.com>
References: <20250117074602.2223094-3-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Li Yiyan <lyy0627@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Difference from the previous Yiyan's version [1], it just uses
a tmpfile to keep all decompressed data for fragments.

Dataset: linux 5.4.140
mkfs.erofs command line:
	mkfs.erofs -zlzma -C131072 -T0 -Eall-fragments,fragdedupe=inode foo.erofs <dir>
Test command line:
	hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "fsck/fsck.erofs --extract foo.erofs"

Vanilla:
  Time (mean ± σ):     362.309 s ±  0.406 s   [User: 360.298 s, System: 0.956 s]

After:
  Time (mean ± σ):     20.880 s ±  0.026 s    [User: 19.751 s, System: 1.058 s]

An in-memory LRU cache could also be implemented later to meet
different needs.

[1] https://lore.kernel.org/r/20231023071528.1912105-1-lyy0627@sjtu.edu.cn

Cc: Li Yiyan <lyy0627@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix CI error: https://github.com/erofs/erofsnightly/actions/runs/12840095401/job/35808271964
fragments.c: In function ‘erofs_packedfile_preload’:
fragments.c:489:25: error: ignoring return value of ‘ftruncate’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
  489 |                         ftruncate(fileno(epi->file), 0);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
   but we just ftruncate the used space for ENOSPC as an attempt,
   so don't bother with the result really.

 fsck/main.c               |  12 ++-
 fuse/main.c               |  16 +++-
 include/erofs/fragments.h |   3 +
 lib/data.c                |  14 +--
 lib/fragments.c           | 192 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 222 insertions(+), 15 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index f56a812..d375835 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -16,6 +16,7 @@
 #include "erofs/dir.h"
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
+#include "erofs/fragments.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -1079,10 +1080,17 @@ int main(int argc, char *argv[])
 		erofsfsck_hardlink_init();
 
 	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
+		err = erofs_packedfile_init(&g_sbi, false);
+		if (err) {
+			erofs_err("failed to initialize packedfile: %s",
+				  erofs_strerror(err));
+			goto exit_hardlink;
+		}
+
 		err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
 		if (err) {
 			erofs_err("failed to verify packed file");
-			goto exit_hardlink;
+			goto exit_packedinode;
 		}
 	}
 
@@ -1108,6 +1116,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
+exit_packedinode:
+	erofs_packedfile_exit(&g_sbi);
 exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
diff --git a/fuse/main.c b/fuse/main.c
index f6c04e8..cb2759e 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,6 +12,7 @@
 #include "erofs/print.h"
 #include "erofs/dir.h"
 #include "erofs/inode.h"
+#include "erofs/fragments.h"
 
 #include <float.h>
 #include <fuse.h>
@@ -688,11 +689,20 @@ int main(int argc, char *argv[])
 		goto err_dev_close;
 	}
 
+	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
+		ret = erofs_packedfile_init(&g_sbi, false);
+		if (ret) {
+			erofs_err("failed to initialize packedfile: %s",
+				  erofs_strerror(ret));
+			goto err_super_put;
+		}
+	}
+
 #if FUSE_MAJOR_VERSION >= 3
 	se = fuse_session_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
 			      NULL);
 	if (!se)
-		goto err_super_put;
+		goto err_packedinode;
 
 	if (fuse_session_mount(se, opts.mountpoint) >= 0) {
 		EROFSFUSE_MOUNT_MSG
@@ -722,7 +732,7 @@ int main(int argc, char *argv[])
 #else
 	ch = fuse_mount(opts.mountpoint, &args);
 	if (!ch)
-		goto err_super_put;
+		goto err_packedinode;
 	EROFSFUSE_MOUNT_MSG
 	se = fuse_lowlevel_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
 			       NULL);
@@ -743,6 +753,8 @@ int main(int argc, char *argv[])
 	fuse_unmount(opts.mountpoint, ch);
 #endif
 
+err_packedinode:
+	erofs_packedfile_exit(&g_sbi);
 err_super_put:
 	erofs_put_super(&g_sbi);
 err_dev_close:
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index e92b7c7..14a1b4a 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -27,6 +27,9 @@ FILE *erofs_packedfile(struct erofs_sb_info *sbi);
 int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
 void erofs_packedfile_exit(struct erofs_sb_info *sbi);
 
+int erofs_packedfile_read(struct erofs_sb_info *sbi,
+			  void *buf, erofs_off_t len, erofs_off_t pos);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/data.c b/lib/data.c
index 8033208..fd9c21a 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -8,6 +8,7 @@
 #include "erofs/internal.h"
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
+#include "erofs/fragments.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -248,18 +249,7 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	int ret = 0;
 
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
-		struct erofs_inode packed_inode = {
-			.sbi = sbi,
-			.nid = sbi->packed_nid,
-		};
-
-		ret = erofs_read_inode_from_disk(&packed_inode);
-		if (ret) {
-			erofs_err("failed to read packed inode from disk");
-			return ret;
-		}
-
-		return erofs_pread(&packed_inode, buffer, length - skip,
+		return erofs_packedfile_read(sbi, buffer, length - skip,
 				   inode->fragmentoff + skip);
 	}
 
diff --git a/lib/fragments.c b/lib/fragments.c
index 43cebe0..6eaf5b6 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -24,6 +24,7 @@
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "erofs/fragments.h"
+#include "erofs/bitops.h"
 
 struct erofs_fragment_dedupe_item {
 	struct list_head	list;
@@ -40,6 +41,11 @@ struct erofs_fragment_dedupe_item {
 struct erofs_packed_inode {
 	struct list_head *hash;
 	FILE *file;
+	unsigned long *uptodate;
+#if EROFS_MT_ENABLED
+	pthread_mutex_t mutex;
+#endif
+	unsigned int uptodate_size;
 };
 
 const char *erofs_frags_packedname = "packed_file";
@@ -340,6 +346,9 @@ void erofs_packedfile_exit(struct erofs_sb_info *sbi)
 	if (!epi)
 		return;
 
+	if (epi->uptodate)
+		free(epi->uptodate);
+
 	if (epi->hash) {
 		for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
 			list_for_each_entry_safe(di, n, &epi->hash[i], list)
@@ -386,9 +395,192 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 		err = -errno;
 		goto err_out;
 	}
+
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid > 0) {
+		struct erofs_inode ei = {
+			.sbi = sbi,
+			.nid = sbi->packed_nid,
+		};
+
+		err = erofs_read_inode_from_disk(&ei);
+		if (err) {
+			erofs_err("failed to read packed inode from disk: %s",
+				  erofs_strerror(-errno));
+			goto err_out;
+		}
+
+		err = fseek(epi->file, ei.i_size, SEEK_SET);
+		if (err) {
+			err = -errno;
+			goto err_out;
+		}
+		epi->uptodate_size = BLK_ROUND_UP(sbi, ei.i_size) / 8;
+		epi->uptodate = calloc(1, epi->uptodate_size);
+		if (!epi->uptodate) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	}
 	return 0;
 
 err_out:
 	erofs_packedfile_exit(sbi);
 	return err;
 }
+
+static int erofs_load_packedinode_from_disk(struct erofs_inode *pi)
+{
+	struct erofs_sb_info *sbi = pi->sbi;
+	int err;
+
+	if (pi->nid)
+		return 0;
+
+	pi->nid = sbi->packed_nid;
+	err = erofs_read_inode_from_disk(pi);
+	if (err) {
+		erofs_err("failed to read packed inode from disk: %s",
+			  erofs_strerror(err));
+		return err;
+	}
+	return 0;
+}
+
+static void *erofs_packedfile_preload(struct erofs_inode *pi,
+				      struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = pi->sbi;
+	struct erofs_packed_inode *epi = sbi->packedinode;
+	unsigned int bsz = erofs_blksiz(sbi);
+	char *buffer;
+	erofs_off_t pos, end;
+	ssize_t err;
+
+	err = erofs_load_packedinode_from_disk(pi);
+	if (err)
+		return ERR_PTR(err);
+
+	pos = map->m_la;
+	err = erofs_map_blocks(pi, map, EROFS_GET_BLOCKS_FIEMAP);
+	if (err)
+		return ERR_PTR(err);
+
+	end = round_up(map->m_la + map->m_llen, bsz);
+	if (map->m_la < pos)
+		map->m_la = round_up(map->m_la, bsz);
+	else
+		DBG_BUGON(map->m_la > pos);
+
+	map->m_llen = end - map->m_la;
+	DBG_BUGON(!map->m_llen);
+	buffer = malloc(map->m_llen);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+
+	err = erofs_pread(pi, buffer, map->m_llen, map->m_la);
+	if (err)
+		goto err_out;
+
+	fflush(epi->file);
+	err = pwrite(fileno(epi->file), buffer, map->m_llen, map->m_la);
+	if (err < 0) {
+		err = -errno;
+		if (err == -ENOSPC) {
+			(void)ftruncate(fileno(epi->file), 0);
+			memset(epi->uptodate, 0, epi->uptodate_size);
+		}
+		goto err_out;
+	}
+	if (err != map->m_llen) {
+		err = -EIO;
+		goto err_out;
+	}
+	for (pos = map->m_la; pos < end; pos += bsz)
+		__erofs_set_bit(erofs_blknr(sbi, pos), epi->uptodate);
+	return buffer;
+
+err_out:
+	free(buffer);
+	map->m_llen = 0;
+	return ERR_PTR(err);
+}
+
+int erofs_packedfile_read(struct erofs_sb_info *sbi,
+			  void *buf, erofs_off_t len, erofs_off_t pos)
+{
+	struct erofs_packed_inode *epi = sbi->packedinode;
+	struct erofs_inode pi = {
+		.sbi = sbi,
+	};
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	unsigned int bsz = erofs_blksiz(sbi);
+	erofs_off_t end = pos + len;
+	char *buffer = NULL;
+	int err;
+
+	if (!epi) {
+		err = erofs_load_packedinode_from_disk(&pi);
+		if (!err)
+			err = erofs_pread(&pi, buf, len, pos);
+		return err;
+	}
+
+	err = 0;
+	while (pos < end) {
+		if (pos >= map.m_la && pos < map.m_la + map.m_llen) {
+			len = min_t(erofs_off_t, end - pos,
+				    map.m_la + map.m_llen - pos);
+			memcpy(buf, buffer + pos - map.m_la, len);
+		} else {
+			erofs_blk_t bnr = erofs_blknr(sbi, pos);
+			bool uptodate;
+
+			map.m_la = round_down(pos, bsz);
+			len = min_t(erofs_off_t, bsz - (pos & (bsz - 1)),
+				    end - pos);
+			uptodate = __erofs_test_bit(bnr, epi->uptodate);
+			if (!uptodate) {
+#if EROFS_MT_ENABLED
+				pthread_mutex_lock(&epi->mutex);
+				uptodate = __erofs_test_bit(bnr, epi->uptodate);
+				if (!uptodate) {
+#endif
+					free(buffer);
+					buffer = erofs_packedfile_preload(&pi, &map);
+					if (IS_ERR(buffer)) {
+						buffer = NULL;
+						goto fallback;
+					}
+
+#if EROFS_MT_ENABLED
+				}
+				pthread_mutex_unlock(&epi->mutex);
+#endif
+			}
+
+			if (!uptodate)
+				continue;
+
+			err = pread(fileno(epi->file), buf, len, pos);
+			if (err < 0)
+				break;
+			if (err == len) {
+				err = 0;
+			} else {
+fallback:
+				err = erofs_load_packedinode_from_disk(&pi);
+				if (!err)
+					err = erofs_pread(&pi, buf, len, pos);
+				if (err)
+					break;
+			}
+			map.m_llen = 0;
+		}
+		buf += len;
+		pos += len;
+	}
+	free(buffer);
+	return err;
+}
-- 
2.43.5

