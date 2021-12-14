Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A2474990
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 18:35:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JD5BP37znz3bXR
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 04:35:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639503341;
	bh=9Do+vd7kIE0rQ2eGWUUwjxuAS+fy0942My47M9HROag=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cypx6S51JeK6xohxfYn33M9WhCozITwodn7wn78Je/kXoYT82np5PkiiYJcIujB0/
	 V3pwtF9CyH8Q9JkEkN4FaifBpPXN9b6t1RNUf6LLIAVu/E+jFEhicbLA1Ke/IZgvRS
	 wxBygrWcUzB9EvyhMnqt4WmYWBTRTQmwJrWgnw1lxzzIMw27AvIDMFec2oXr5tFUaS
	 Vjsp0JlWmmZs/+lIQXODW6irodzdWPw//RblPHrhOAtQXourZfQchXaZKnzsq+7pM1
	 kL+uNGswFqhkgAqxB6iXfSkmlWZI6o+RpBrfGXUD6RnOXE85SItlM+VyLljRhilaoj
	 ikycpqLiqouyw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=33nw4yqskc382kdqjnhoylqjrrjoh.frpolqx0-hurivolvwv.r2odev.ruj@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Ps5na1rn; dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JD5BC0wRwz302C
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 04:35:29 +1100 (AEDT)
Received: by mail-qk1-x74a.google.com with SMTP id
 az44-20020a05620a172c00b0046a828b4684so17336626qkb.22
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 09:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=9Do+vd7kIE0rQ2eGWUUwjxuAS+fy0942My47M9HROag=;
 b=acirpGIl8E6iB6/uwx/FwibSYFamabFjPtXIyWvSGl0uProilPjsqstH8QMMVVS119
 8IXl6zh3q/SnyHmEKIDinyEaFcQfD8d2zxXvuftRPoNyDIGtIrj+rfbwdyH258NJT8Sm
 f2x0HIjP7RDfsdYLpTsz6p+X12Y9LC8L0XAX70cdqSW2R7Na261r0QOUt7BWztj3KDd8
 bmKc+rQglIH7OfCe1k7HL02ZqaYAoB7cKXBF4sT90VED/jq8BwzaIazjW8jNyjSIPy7q
 3rdTJkEQeH79D4uAuSMWYYNdcUX38hwmHDVv46KHgmLhc5rGI4OMIf34OsAcM0Xdl0xK
 fg+A==
X-Gm-Message-State: AOAM530BXUgnlqn9/YPFqyzJ8OQym2SZCRaOiRtXcnkIYOFonD7JXYiv
 WL+HjizGaiWck2FWwgxNuFQsQk4OOK0Zec4016N0sXmFEpplaVfT33dIvysUnDSZUH0juZGonip
 52s1uoTwLRx6Yk8nNv3hDtFT9rSV9kFEdecwY4Dq79PfP0ISWpQb0QLKWmtLEpr4DJYXYrEXTHJ
 bA2yclBck=
X-Google-Smtp-Source: ABdhPJxMqD9IuGqlCzGVsw+6ndeHwSkXZ8ItQzH/re8iTlVLVzLjG1cy8nvMyeBsArvJhBpYDf1GKY/TzVaxPqsDtQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:15c6:: with SMTP id
 d6mr7322810qty.439.1639503324739; Tue, 14 Dec 2021 09:35:24 -0800 (PST)
Date: Tue, 14 Dec 2021 09:35:19 -0800
In-Reply-To: <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
Message-Id: <20211214173520.1944792-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 1/2] Add API to get full pathname of an inode
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
index 072d726..85695ee 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -11,6 +11,7 @@
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
+#include "erofs/internal.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -366,71 +367,6 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
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
-			if (le64_to_cpu(de->nid) == target) {
-				memcpy(path + pos, dname, len);
-				path[pos + len] = '\0';
-				return 0;
-			}
-
-			if (de->file_type == EROFS_FT_DIR &&
-			    le64_to_cpu(de->nid) != parent_nid &&
-			    le64_to_cpu(de->nid) != nid) {
-				memcpy(path + pos, dname, len);
-				err = erofs_get_pathname(le64_to_cpu(de->nid),
-						nid, target, path, pos + len);
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
@@ -479,12 +415,12 @@ static void erofsdump_show_fileinfo(bool show_extent)
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
index e6beb8c..59ecdd8 100644
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
index 4124170..2be6215 100644
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

