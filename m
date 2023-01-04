Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15F65CEBD
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 09:52:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn3J63CLXz3bZ4
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 19:52:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZWyU+B24;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZWyU+B24;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn3J008tRz2yJT
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 19:51:57 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id 17so35302993pll.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Jan 2023 00:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cv/7YckBmJs3QcDsj0FtdS8BqQd2pdVw47gqNEhlz8=;
        b=ZWyU+B24HRg45fatMSZ/GC/RdU2a8d5jNTdjy7y85GA5jbYV0fToSZEnkMWRpt3/QX
         PYZH5fDpmS6gym6NCEh+ZB/EczzVYjwqIJiXIfKF6Wn/IQfwilRaQ1PPpIOlcMhRcf6q
         hl7qcZygGTMQo6hViE3UZpJZGqdSCg7CQEkXfYfxOD5S/btfui0mzDZsKThxluY6L4RI
         Rhg9fI7zpYmg9+YdmmdVRXKegckc9wJZSdAQOdYT0sXVl5/yLZ6Kv9QDRfCvwoGjiicK
         j33vI0eeZacJWHg4LqV0hJSUxUCT8TIbPz5QeuWArgu8I+UXqtncDljv1/DvY56d9sHS
         YXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cv/7YckBmJs3QcDsj0FtdS8BqQd2pdVw47gqNEhlz8=;
        b=KwOUguYzUTDE7xDII+6zQ7aZwlibe4WDdJyyJcPY9gk2DyfvfU75bDfYkEGubr4Y4r
         32fvqQWbfr9TmSSR1sDE+paCga6/NtzZUnMyNxVrldh3OEO1CbFwfazPGHnBjXKetgew
         Uu0or2BB39yscvU0Vle8ArjjrTtLqZ1WMZ9vCy7d1llLRkfrFqhJzPrAVJu7FXCf4KRh
         XoxwPJFE5uSqjecLuK54JlqKZge8Ba6sHtwd70MlfP8UYHkAlxjuInJU33FupWVA1qXL
         3YIP9yhCdoooHY0XG0E5S2UhuesLCF+rzTQR5ar7IuB+2OpdJEmIUhjFbBaxmn8PPPp2
         sRdw==
X-Gm-Message-State: AFqh2krotcA1KaMbzvcdiFPOMV7zNtTlsplEG/0OeZ/c1EpBrbMkMA4W
	3SDZNWS4lB6BlfclxdHzZ4k=
X-Google-Smtp-Source: AMrXdXsE3Nwjoxl/mACcCxjp6lnNo9EJ4yvpyvdnFXujBUGZKZx5j43YMdzpdc54wxyty8CvRlVciQ==
X-Received: by 2002:a17:90a:fa2:b0:226:e83:659d with SMTP id 31-20020a17090a0fa200b002260e83659dmr27563177pjz.47.1672822314569;
        Wed, 04 Jan 2023 00:51:54 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090a5a8300b00219f1a2eca1sm19870460pji.2.2023.01.04.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:51:54 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: dump: support fragments
Date: Wed,  4 Jan 2023 16:51:30 +0800
Message-Id: <20230104085130.21085-1-zbestahu@gmail.com>
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
v2:
- get rid of frag_ext_fmt
- remove z_erofs_fill_inode_lazy call and related
- record pathname for !packed_file
- use 0..0 | 0 for fragment extent's physical part
- add a new helper erofsdump_read_packed_inode instead of calling
  erofsdump_readdir(sbi.packed_nid)
- show "File :" -> "Path :"
- improve the print format for packed nid

 dump/main.c | 69 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index bc4f047..bdea301 100644
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
@@ -354,10 +383,13 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(inode.nid, path, sizeof(path));
-	if (err < 0) {
-		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
-		return;
+	if (!erofs_is_packed_inode(&inode)) {
+		err = erofs_get_pathname(inode.nid, path, sizeof(path));
+		if (err < 0) {
+			erofs_err("file path not found @ nid %llu",
+				  inode.nid | 0ULL);
+			return;
+		}
 	}
 
 	strftime(timebuf, sizeof(timebuf),
@@ -366,7 +398,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	for (i = 8; i >= 0; i--)
 		if (((access_mode >> i) & 1) == 0)
 			access_mode_str[8 - i] = '-';
-	fprintf(stdout, "File : %s\n", path);
+	fprintf(stdout, "Path : %s\n",
+		erofs_is_packed_inode(&inode) ? "packed_file" : path);
 	fprintf(stdout, "Size: %" PRIu64"  On-disk size: %" PRIu64 "  %s\n",
 		inode.i_size, size,
 		file_category_types[erofs_mode_to_ftype(inode.i_mode)]);
@@ -425,13 +458,21 @@ static void erofsdump_show_fileinfo(bool show_extent)
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
+		erofs_is_packed_inode(&inode) ? "packed_file" : path, extent_count);
 }
 
 static void erofsdump_filesize_distribution(const char *title,
@@ -537,6 +578,11 @@ static void erofsdump_print_statistic(void)
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
@@ -563,6 +609,9 @@ static void erofsdump_show_superblock(void)
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

