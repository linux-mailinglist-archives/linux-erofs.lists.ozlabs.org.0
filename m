Return-Path: <linux-erofs+bounces-841-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E540DB2D3A2
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 07:38:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6Fc34K5Kz2ydj;
	Wed, 20 Aug 2025 15:38:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755668307;
	cv=none; b=ECRyBPNq5rx/BiMMv8UJzXg6G3XHElVfuEx0DottS5vW9NytCQ9uNE7rrvQKIiul+FJ4pCKeUuWvyiNBENMW0lhJY5SVHdPNCySDl7WsAPBORMY5L76BZA0Z2WFNvyeYBdQq274XgqAknSMsJ1XBFcEVqS4KKzgUxHRcVXqNxoEpchh7VDHr+rHpu0AYQf6uvO57ub4WRYYs2GMB9krdyih9JpnVN8/kMxH62mdsd5DkfShttZbkMe1ZSTJua01PpWAKKWRlVIcN386ESAt0OMgqncnMEJhMqMwasPjRh8ABfBmNqVTydxx/kADkXIzRrD70MvgJaQM4J8eq1hqsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755668307; c=relaxed/relaxed;
	bh=I3KQDBAecACPKB09T0QISmXrIH5MAt82wUInVy4OjwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCzqb7GwBgcg5GsqYlp8/as+ssxLE3JZg8sR+je0nipNiVcWb0JCYwSnfv5TMw3FIsDV11Mk9MMuJaLdkq83+mN/GDHiXDXKYTMYr3heuacjJrBhxUjFjwUMCBoGGyLxnMAy4ioVzjfeU9iPvFOeWPpj7r0tJ0zsg3TbCrLecIsHExU+oCTsgkmfvZ9s/fpQ+UmcZCASjOUwHqHzxD2BUFvzOVKbPnw6p+pxZGEN0VZqeakFI8djIaxI/GWefAyMDM5Tk7i9EXuFp47iFZl3Gt4GgKj4TLvoz6pdwfEGvCytAe0Wrnj0Pk1BRoNZfGAVr+gNPIEso8UJagQc9s1McA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QHHNubvQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QHHNubvQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6Fc20JhPz2xQ0
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 15:38:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755668300; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I3KQDBAecACPKB09T0QISmXrIH5MAt82wUInVy4OjwA=;
	b=QHHNubvQCKaTgl+gJXm4o01fsFVNI9UuIIS1JR5g9qgrKpQAmTRZ6erIPvm74bUKBatYRZaz/jVzjnIn+Wy61CJH0boWC/yWy5e7u5p0Rfo8wpxBPHmaGVfGws+JcwjafxFyySolQ35cn6ed5J4w2knrE2CXfa4oYPdmSBa3NOs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmAOfQY_1755668292 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 13:38:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: lib: introduce erofs_importer_flush_all()
Date: Wed, 20 Aug 2025 13:38:04 +0800
Message-ID: <20250820053806.1441397-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

As a new formal API for external users, it flushes all dirty metadata
except the superblock.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  1 +
 include/erofs/importer.h |  2 ++
 lib/importer.c           | 39 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              | 29 ++---------------------------
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index d5618c0..c248b73 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -13,6 +13,7 @@ extern "C"
 {
 #endif
 
+#include <stdlib.h>
 #include "internal.h"
 
 struct erofs_buffer_head;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index e83c3e3..28d29bd 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -19,6 +19,7 @@ struct erofs_importer_params {
 	u32 fixed_gid;
 	u32 uid_offset;
 	u32 gid_offset;
+	u32 fsalignblks;
 	bool no_datainline;
 	bool hard_dereference;
 	bool ovlfs_strip;
@@ -33,6 +34,7 @@ struct erofs_importer {
 
 void erofs_importer_preset(struct erofs_importer_params *params);
 int erofs_importer_init(struct erofs_importer *im);
+int erofs_importer_flush_all(struct erofs_importer *im);
 void erofs_importer_exit(struct erofs_importer *im);
 
 #ifdef __cplusplus
diff --git a/lib/importer.c b/lib/importer.c
index 8e86993..a65fa39 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -4,6 +4,7 @@
  */
 #include "erofs/fragments.h"
 #include "erofs/importer.h"
+#include "erofs/cache.h"
 #include "erofs/config.h"
 #include "erofs/dedupe.h"
 #include "erofs/inode.h"
@@ -19,6 +20,7 @@ void erofs_importer_preset(struct erofs_importer_params *params)
 	*params = (struct erofs_importer_params) {
 		.fixed_uid = -1,
 		.fixed_gid = -1,
+		.fsalignblks = 1,
 	};
 }
 
@@ -72,6 +74,43 @@ out_err:
 	return err;
 }
 
+int erofs_importer_flush_all(struct erofs_importer *im)
+{
+	struct erofs_sb_info *sbi = im->sbi;
+	unsigned int fsalignblks;
+	int err;
+
+	if (erofs_sb_has_metabox(sbi)) {
+		erofs_update_progressinfo("Handling metabox ...");
+		err = erofs_metabox_iflush(im);
+		if (err)
+			return err;
+	}
+
+	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
+	    erofs_sb_has_fragments(sbi)) {
+		erofs_update_progressinfo("Handling packed data ...");
+		err = erofs_flush_packed_inode(im);
+		if (err)
+			return err;
+	}
+
+	fsalignblks = im->params->fsalignblks ?
+		roundup_pow_of_two(im->params->fsalignblks) : 1;
+	sbi->primarydevice_blocks = roundup(erofs_mapbh(sbi->bmgr, NULL),
+					    fsalignblks);
+	err = erofs_write_device_table(sbi);
+	if (err)
+		return err;
+
+	/* flush all buffers except for the superblock */
+	err = erofs_bflush(sbi->bmgr, NULL);
+	if (err)
+		return err;
+
+	return erofs_fixup_root_inode(im->root);
+}
+
 void erofs_importer_exit(struct erofs_importer *im)
 {
 	struct erofs_sb_info *sbi = im->sbi;
diff --git a/mkfs/main.c b/mkfs/main.c
index a11134e..0a8f477 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -281,7 +281,6 @@ static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
 static unsigned int dsunit;
-static unsigned int fsalignblks = 1;
 static int tarerofs_decoder;
 static FILE *vmdk_dcf;
 
@@ -1203,7 +1202,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 #endif
 		case 531:
-			fsalignblks = strtoul(optarg, &endptr, 0);
+			params->fsalignblks = strtoul(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid fsalignblks %s", optarg);
 				return -EINVAL;
@@ -1760,39 +1759,15 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (erofs_sb_has_metabox(&g_sbi)) {
-		erofs_update_progressinfo("Handling metabox ...");
-		erofs_metabox_iflush(&importer);
-		if (err)
-			goto exit;
-	}
-
-	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
-	    erofs_sb_has_fragments(&g_sbi)) {
-		erofs_update_progressinfo("Handling packed data ...");
-		err = erofs_flush_packed_inode(&importer);
-		if (err)
-			goto exit;
-	}
-
 	if (erofstar.index_mode || cfg.c_chunkbits || g_sbi.extra_devices) {
 		err = erofs_mkfs_dump_blobs(&g_sbi);
 		if (err)
 			goto exit;
 	}
 
-	g_sbi.primarydevice_blocks =
-		roundup(erofs_mapbh(g_sbi.bmgr, NULL), fsalignblks);
-	err = erofs_write_device_table(&g_sbi);
-	if (err)
-		goto exit;
-
-	/* flush all buffers except for the superblock */
-	err = erofs_bflush(g_sbi.bmgr, NULL);
+	err = erofs_importer_flush_all(&importer);
 	if (err)
 		goto exit;
-
-	erofs_fixup_root_inode(root);
 	erofs_iput(root);
 	root = NULL;
 
-- 
2.43.5


