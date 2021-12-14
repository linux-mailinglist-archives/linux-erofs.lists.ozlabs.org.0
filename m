Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2F473AB4
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:20:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCht548Pzz306j
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639448413;
	bh=t8lOznuTRA7ypgTOx7W336IzWh6sjj6J1AuPeBrkzdQ=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=df/DXIyxNOws8Ky/HaUvRBGzf0xDVrknUjVpAdp62+4wE5dviYCkVWVQGupkKcLH2
	 D4LiI4xdaoEJg7c7Vx9rbCZOWHziFamxi1EOOvlwru0HVDNQmU3h3bJ8oCBnuI/oO4
	 8kSIKrykxqWXABrrxgFh4yxHZPx/EmEb9gVl1EUAIJ9HvaiEhgPKkfyQNg5Gn3Fpo4
	 m33b+iZbUtJr61DG2GOB5tV7Fu9ahNWFKBYPEhOJ16DdvQKWXL4ozyrrCSQ5edX+My
	 +9PAqkdGpT8gOISpA8DPKId9gODcZFEsgc56bwkrHubEZzB0Q1/58rH3RrH0mEgu2r
	 ffdpj8yLcOWkw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::949; helo=mail-ua1-x949.google.com;
 envelope-from=3up-3yqskc0m4mfslpjq0nslttlqj.htrqnsz2-jwtkxqnxyx.t4qfgx.twl@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=iZOUrZAE; dkim-atps=neutral
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com
 [IPv6:2607:f8b0:4864:20::949])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JChsz6prmz2yHj
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:20:06 +1100 (AEDT)
Received: by mail-ua1-x949.google.com with SMTP id
 l1-20020ab07381000000b002d3cab2370aso11947814uap.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 18:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=t8lOznuTRA7ypgTOx7W336IzWh6sjj6J1AuPeBrkzdQ=;
 b=zvsxE3oS7WvGCOaLxuGT90f75QqDCX64AB4bYJCYjU9KTpFbD8tBn5XVco8i1f29bV
 ZgljZx01k/m56ALa1p6KkSvIrLe27bfMH+vYaty1he5L+B7Wfce5EyGRYd4/Wt3gjyS3
 oZ9VtkLwpu+hXlJv4oNGkgNB/OmJO9YllKNhmGdjEumV/BJP8T5QjDWKlWistsdBsFM4
 E3OMIxTfaF3bTLfpfey1QpEPJvUaJOQONtwd9Rn0cA2+A+rFGrcwvtTKYR031WXfYox3
 xBltq14QwCWX1EchiOswiQ/OW0C5LalC0pQt5cwDBki9Esefv6eRsJPcjsWN3dXMndav
 /h4g==
X-Gm-Message-State: AOAM532jsHg9R3sF2mCY1wneFaGadnDoyzCQjdGIVtCDAPWp2+IpIXTW
 5DqBk8SkljKXPSTwtIvRNKQv/VrOIu5zp3J+TLJ6UaN5VrxuZOdQMw6YAV/sV11Oe8qxWhpeuoE
 Meo8OLbgOgdJ9iqykwPAL+a6FZjqM8JI1BQeMdIJtsq22LkaSAk6Vn90pYX3QSVRrjk2KEjQKih
 EfmH0QezY=
X-Google-Smtp-Source: ABdhPJxuEDMeegTRTvdYulNbg2VM6bqzNIaqecPlenXg/ahLTndxwkGPUOCRI92qyVKpmRjbw6ipGG7WcMedoNKdug==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6122:d09:: with SMTP id
 az9mr3690543vkb.23.1639448400877; Mon, 13 Dec 2021 18:20:00 -0800 (PST)
Date: Mon, 13 Dec 2021 18:19:54 -0800
In-Reply-To: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-Id: <20211214021955.992899-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 1/2] Add API to get full pathname of an inode
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

Change-Id: Iba99e590f051638285d1d1949311a08f5a5f1a82
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c              |  70 ++-----------------------
 include/erofs/internal.h |   5 ++
 lib/namei.c              | 108 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 67 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 71b44b4..b728703 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -11,6 +11,7 @@
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
+#include "erofs/internal.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -365,71 +366,6 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 	return 0;
 }
 
-static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
-		erofs_nid_t target, char *path, unsigned int pos)
-{
-	int err;
-	erofs_off_t offset;
-	char buf[EROFS_BLKSIZ];
-	struct erofs_inode inode = { .nid = nid };
-
-	path[pos++] = '/';
-	if (target == sbi.root_nid)
-		return 0;
-
-	err = erofs_read_inode_from_disk(&inode);
-	if (err) {
-		erofs_err("read inode failed @ nid %llu", nid | 0ULL);
-		return err;
-	}
-
-	offset = 0;
-	while (offset < inode.i_size) {
-		erofs_off_t maxsize = min_t(erofs_off_t,
-					inode.i_size - offset, EROFS_BLKSIZ);
-		struct erofs_dirent *de = (void *)buf;
-		struct erofs_dirent *end;
-		unsigned int nameoff;
-
-		err = erofs_pread(&inode, buf, maxsize, offset);
-		if (err)
-			return err;
-
-		nameoff = le16_to_cpu(de->nameoff);
-		end = (void *)buf + nameoff;
-		while (de < end) {
-			const char *dname;
-			int len;
-
-			nameoff = le16_to_cpu(de->nameoff);
-			dname = (char *)buf + nameoff;
-			len = erofs_checkdirent(de, end, maxsize, dname);
-			if (len < 0)
-				return len;
-
-			if (de->nid == target) {
-				memcpy(path + pos, dname, len);
-				path[pos + len] = '\0';
-				return 0;
-			}
-
-			if (de->file_type == EROFS_FT_DIR &&
-					de->nid != parent_nid &&
-					de->nid != nid) {
-				memcpy(path + pos, dname, len);
-				err = erofs_get_pathname(de->nid, nid,
-						target, path, pos + len);
-				if (!err)
-					return 0;
-				memset(path + pos, 0, len);
-			}
-			++de;
-		}
-		offset += maxsize;
-	}
-	return -1;
-}
-
 static int erofsdump_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags)
 {
@@ -478,12 +414,12 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid,
-				 inode.nid, path, 0);
+	err = erofs_get_inode_name(&sbi, inode.nid, path, PATH_MAX+1);
 	if (err < 0) {
 		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
 		return;
 	}
+  printf("Path: %s\n", path);
 
 	strftime(timebuf, sizeof(timebuf),
 		 "%Y-%m-%d %H:%M:%S", localtime((time_t *)&inode.i_ctime));
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a68de32..632461e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -305,6 +305,11 @@ int erofs_read_superblock(void);
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
+// Get full path name of an inode, return 0 if success
+int erofs_get_inode_name(const struct erofs_sb_info* sbi,
+                         erofs_nid_t target,
+                         char* output_buffer,
+                         size_t capacity);
 
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..ee76e82 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -274,3 +274,111 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi)
 	vi->nid = nd.nid;
 	return erofs_read_inode_from_disk(vi);
 }
+
+static inline int erofs_checkdirent(const struct erofs_dirent* de,
+                                    const struct erofs_dirent* last_de,
+                                    u32 maxsize,
+                                    const char* dname) {
+  int dname_len;
+  unsigned int nameoff = le16_to_cpu(de->nameoff);
+  if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
+    erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff, de->nid | 0ULL);
+    return -EFSCORRUPTED;
+  }
+  dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
+                                  : le16_to_cpu(de[1].nameoff) - nameoff;
+  /* a corrupted entry is found */
+  if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
+    erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid) | 0ULL);
+    DBG_BUGON(1);
+    return -EFSCORRUPTED;
+  }
+  if (de->file_type >= EROFS_FT_MAX) {
+    erofs_err("invalid file type %llu", de->nid);
+    return -EFSCORRUPTED;
+  }
+  return dname_len;
+}
+
+int erofs_get_pathname(const struct erofs_sb_info* sbi,
+                       erofs_nid_t nid,
+                       erofs_nid_t parent_nid,
+                       erofs_nid_t target,
+                       char* path,
+                       size_t capacity) {
+  if (capacity <= 1) {
+		return -2;
+	}
+	int err;
+	erofs_off_t offset;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode inode = { .nid = nid };
+
+	path[0] = '/';
+	if (target == sbi->root_nid)
+		return 0;
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read inode failed @ nid %llu", nid | 0ULL);
+		return err;
+	}
+
+	offset = 0;
+	while (offset < inode.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					inode.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		struct erofs_dirent *end;
+		unsigned int nameoff;
+
+		err = erofs_pread(&inode, buf, maxsize, offset);
+		if (err)
+			return err;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		end = (void *)buf + nameoff;
+		while (de < end) {
+			const char *dname;
+			int len;
+
+			nameoff = le16_to_cpu(de->nameoff);
+			dname = (char *)buf + nameoff;
+			len = erofs_checkdirent(de, end, maxsize, dname);
+			if (len < 0)
+				return len;
+			// First char is '/', last char is '\0'
+			// so usable capacity is |capacity| - 2
+			if (len > capacity - 2) {
+				len = capacity - 2;
+			}
+			if (de->nid == target) {
+				memcpy(path + 1, dname, len);
+				path[1 + len] = '\0';
+				return 0;
+			}
+
+			if (de->file_type == EROFS_FT_DIR &&
+					de->nid != parent_nid &&
+					de->nid != nid) {
+				memcpy(path + 1, dname, len);
+				err = erofs_get_pathname(sbi, de->nid, nid,
+						target, path + 1 + len, capacity - 1 - len);
+				if (!err)
+					return 0;
+				memset(path + 1, 0, len);
+			}
+			++de;
+		}
+		offset += maxsize;
+	}
+	return -1;
+}
+
+int erofs_get_inode_name(const struct erofs_sb_info* sbi,
+                         erofs_nid_t target,
+                         char* path,
+                         size_t capacity) {
+  return erofs_get_pathname(sbi, sbi->root_nid, sbi->root_nid, target, path, capacity);
+}
+
-- 
2.34.1.173.g76aa8bc2d0-goog

