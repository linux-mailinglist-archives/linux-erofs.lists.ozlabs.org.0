Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E666765E2D4
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 03:14:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NnVQY3DsQz3c6Q
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 13:14:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mGDpQZvf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mGDpQZvf;
	dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NnVQV1xY1z30RS
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Jan 2023 13:14:08 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id r18so23593695pgr.12
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Jan 2023 18:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E97Qm0EClI30XTk5Ppm0/+8jiA9OPH3YXdFgrM/o1BE=;
        b=mGDpQZvf0Mmlv9humF6qePL/XQ5IZMSvDkpvD5lETGwZ0f/mzXMVZm3lvlkzr4sN3q
         7Fu1av0AXf/1OGSholcncFBb5ulLvZ4kB8pTe5EsasOCrc4GNgbV3QiPAPqMxs2NAkUk
         gytSF8w5hDhvip2uB+ryh1e/mmLDrTKJoZ8v+Mfwy1j5dcMEI+4NP1Odt5GHQi8j5q6N
         qw27sUFaai4dGky3esOHxRYhD05PkZPmvGLHvW1tODjJRrrrScgd4qe/jTr63jCyW9JH
         lERF6XRgmbVQABLOi73kG/psA83KA6b+iHGA6lZYyJv82Gc/ZfkSRvm8yLGnTVnV8Xk5
         Ojhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E97Qm0EClI30XTk5Ppm0/+8jiA9OPH3YXdFgrM/o1BE=;
        b=rFYBnqCtC/kiV2ejiiooJa2hsf83e2e38OG3nbUb81tlgrbInbc9lJgjHhFz+LhDMz
         idtWG9lPE19PcaNbKrJ1eWjq2RlxNhPxA9cocq2lOYtMTgtp1iyUKO97qmRUKBpCIdb5
         vKZHhHh8aN4MrjzoYNFhc/BC907PWIco2gFvwNfyXP//kOFl6yAYvrUfEl4bpYx3Y3ki
         l/n5aCGMjreryVp7DcAcC71boDJfOomx+cY/K784N1xkqhRTvyFCe6SqHavmCQNInCEA
         im+hG/qfrQWWpUwP2bjan6DB3HEFIY3ABtaCZSs7u24QFotnk5QFowoEh8koqk0ySyG9
         ieLw==
X-Gm-Message-State: AFqh2kqfk0Zc5hq2dbRUQ6YKBlN99GfeLe/EGhwgeStFXraqovnMcNou
	Iaq4sspZ4OLvpDxiavl/Pp4=
X-Google-Smtp-Source: AMrXdXv5J3aAEnE0LAUsrPAiHOX24Sow/ll021vuzNgpDa/t6ACDniuDCFHy569K2fhTgpawuD3DQw==
X-Received: by 2002:a05:6a00:430a:b0:582:ca4d:f6a7 with SMTP id cb10-20020a056a00430a00b00582ca4df6a7mr7594046pfb.4.1672884843639;
        Wed, 04 Jan 2023 18:14:03 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b005810a54fdefsm18671852pfa.114.2023.01.04.18.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:14:03 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: dump: support fragments
Date: Thu,  5 Jan 2023 10:13:43 +0800
Message-Id: <20230105021343.23419-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, mpiglet@outlook.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add compressed fragments support for dump feature.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v3:
- set path="(not found)" and go on if get pathname fails
- packed_file -> (packed file)

v2:
- get rid of frag_ext_fmt
- remove z_erofs_fill_inode_lazy call and related
- record pathname for !packed_file
- use 0..0 | 0 for fragment extent's physical part
- add a new helper erofsdump_read_packed_inode instead of calling
  erofsdump_readdir(sbi.packed_nid)
- show "File :" -> "Path :"
- improve the print format for packed nid

 dump/main.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index bc4f047..a34b6e3 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -14,6 +14,8 @@
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/dir.h"
+#include "erofs/compress.h"
+#include "erofs/fragments.h"
 #include "../lib/liberofs_private.h"
 
 #ifdef HAVE_LIBUUID
@@ -96,6 +98,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
+	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -264,6 +267,32 @@ static int erofsdump_dirent_iter(struct erofs_dir_context *ctx)
 	return erofsdump_readdir(ctx);
 }
 
+static int erofsdump_read_packed_inode(void)
+{
+	int err;
+	erofs_off_t occupied_size = 0;
+	struct erofs_inode vi = { .nid = sbi.packed_nid };
+
+	if (!erofs_sb_has_fragments())
+		return 0;
+
+	err = erofs_read_inode_from_disk(&vi);
+	if (err) {
+		erofs_err("failed to read packed file inode from disk");
+		return err;
+	}
+
+	err = erofsdump_get_occupied_size(&vi, &occupied_size);
+	if (err) {
+		erofs_err("get packed file size failed");
+		return err;
+	}
+
+	stats.files_total_size += occupied_size;
+	update_file_size_statistics(occupied_size, false);
+	return 0;
+}
+
 static int erofsdump_readdir(struct erofs_dir_context *ctx)
 {
 	int err;
@@ -356,8 +385,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
 
 	err = erofs_get_pathname(inode.nid, path, sizeof(path));
 	if (err < 0) {
-		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
-		return;
+		strncpy(path, "(not found)", sizeof(path) - 1);
+		path[sizeof(path) - 1] = '\0';
 	}
 
 	strftime(timebuf, sizeof(timebuf),
@@ -366,7 +395,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	for (i = 8; i >= 0; i--)
 		if (((access_mode >> i) & 1) == 0)
 			access_mode_str[8 - i] = '-';
-	fprintf(stdout, "File : %s\n", path);
+	fprintf(stdout, "Path : %s\n",
+		erofs_is_packed_inode(&inode) ? "(packed file)" : path);
 	fprintf(stdout, "Size: %" PRIu64"  On-disk size: %" PRIu64 "  %s\n",
 		inode.i_size, size,
 		file_category_types[erofs_mode_to_ftype(inode.i_mode)]);
@@ -425,13 +455,21 @@ static void erofsdump_show_fileinfo(bool show_extent)
 			return;
 		}
 
-		fprintf(stdout, ext_fmt[!!mdev.m_deviceid], extent_count++,
-			map.m_la, map.m_la + map.m_llen, map.m_llen,
-			mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
-			mdev.m_deviceid);
+		if (map.m_flags & EROFS_MAP_FRAGMENT)
+			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
+				extent_count++,
+				map.m_la, map.m_la + map.m_llen, map.m_llen,
+				0, 0, 0, mdev.m_deviceid);
+		else
+			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
+				extent_count++,
+				map.m_la, map.m_la + map.m_llen, map.m_llen,
+				mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
+				mdev.m_deviceid);
 		map.m_la += map.m_llen;
 	}
-	fprintf(stdout, "%s: %d extents found\n", path, extent_count);
+	fprintf(stdout, "%s: %d extents found\n",
+		erofs_is_packed_inode(&inode) ? "(packed file)" : path, extent_count);
 }
 
 static void erofsdump_filesize_distribution(const char *title,
@@ -537,6 +575,11 @@ static void erofsdump_print_statistic(void)
 		erofs_err("read dir failed");
 		return;
 	}
+	err = erofsdump_read_packed_inode();
+	if (err) {
+		erofs_err("read packed inode failed");
+		return;
+	}
 	erofsdump_file_statistic();
 	erofsdump_filesize_distribution("Original",
 			stats.file_original_size,
@@ -563,6 +606,9 @@ static void erofsdump_show_superblock(void)
 			sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
 			sbi.root_nid | 0ULL);
+	if (erofs_sb_has_fragments())
+		fprintf(stdout, "Filesystem packed nid:                %14llu\n",
+			sbi.packed_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
 			sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
-- 
2.17.1

