Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D065479510
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 20:47:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFzz869wHz3cDr
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 06:47:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639770452;
	bh=GhJZRCJd0X3HQbXQOCs+YGsmTGKJ30ELrQpSS/hl4c8=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aGWPUJyxkEOMFo0CYDLNSQwC0d/I5Arp/sM4AcqiSim2pA9icbKrWhgVyBjHFeCsW
	 4Byy0if/Q4bU8yS+ZgpLol4hc4KkpBk5tULZMd/8OaNtq9MHY2Qd39gU8LiC2+s/fH
	 odqPXnCiLD9tGMifjv4PcrKm0gl1r/S5VidZpsFRO78VlW4+RM6mweY98yPu+tRwoo
	 jG0DzSIgBPlSEuWCcgpX0d/cUGB0Ze0nKL0LkOvhnoCO5L7LAUZCMaGzs8o/l6qYbz
	 CR/oAuQseGLZ0HIHHHvxaVbueg/E0bXuOzoHewN2bgx5KsR27BsYNjyAYZ5iFWv2tK
	 MTgQfOnmXzs8Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3sem8yqskcyqzhangkelvingoogle.comlinux-erofslists.ozlabs.org@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Q+VWVv5L; dkim-atps=neutral
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFzz472zXz3cCr
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 06:47:26 +1100 (AEDT)
Received: by mail-qk1-x749.google.com with SMTP id
 bs14-20020a05620a470e00b0046b1e29f53cso1611153qkb.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 11:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GhJZRCJd0X3HQbXQOCs+YGsmTGKJ30ELrQpSS/hl4c8=;
 b=daFIHptfVofmJI2tH5XAq8dyyNLwjC+2EDYKo9Q2lSve4+owGj02xA9a0lQumvOxt2
 +9TlHVRpov8JhJw+lWBDxHP2s5WBHWN6xt8b4UJKBtZLXcRKPwhkrHRcm+m6f6Q8OZsK
 NTFTmTosJkgS1I2LZKOYmeIK/2Mnb1ZWc+0VsRWijdnxAlO6rmIif478e3H58rKFTkji
 JPNeiDjiU0NrZLFqch1BM/HWQ55ShkXTfpLzNbSHXNYKcSDvRk04UFe1Uyz8O8uqCPl1
 kwH6XWEuz1UmkwOjCktwY/QgSSBkEYmRXhZ9EzbUt5c66MZnBPS35D4kZYSCJEb7YIdq
 XhKQ==
X-Gm-Message-State: AOAM530vmn5zq2Aq1Rc2M2yVulzuoZRhmwQcYq3EnXVoy5t4au1VJuuh
 452FPtWi1RYlmwnfvb6AZTmfSB+cf6l8Hmnlw9MlPltVJ9IBh7j2Yeg8IZ9XW4+iK+b4ErNGy2I
 mUO2SQ2ibL7mYvipToQ3SPOEEG16kJEeoCjXjYlMXXaK9Ivopo+8m26Vs3nQO5pR62gEA+ashHt
 UP0SXgGtQ=
X-Google-Smtp-Source: ABdhPJwRK+CPycMjZv2CvwmGWtIFrJ9MwCCOxH+3k2fApwoQu0vog4AE+quQ6WolO7T7X4Jm5mevdhDE86qfaYrqYw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:103:: with SMTP id
 u3mr3843700qtw.187.1639770441878; Fri, 17 Dec 2021 11:47:21 -0800 (PST)
Date: Fri, 17 Dec 2021 11:47:19 -0800
In-Reply-To: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
Message-Id: <20211217194720.3219630-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 1/2] Add API to get full pathname of an inode
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

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c              |  70 +----------------------
 include/erofs/internal.h |   5 ++
 lib/namei.c              | 120 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 124 insertions(+), 71 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 71b44b4..7dbb6e4 100644
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
+	printf("Path: %s\n", path);
 
 	strftime(timebuf, sizeof(timebuf),
 		 "%Y-%m-%d %H:%M:%S", localtime((time_t *)&inode.i_ctime));
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a68de32..e5454ee 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -305,6 +305,11 @@ int erofs_read_superblock(void);
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
+// Get full path name of an inode, return 0 if success
+int erofs_get_inode_name(const struct erofs_sb_info *sbi,
+			 erofs_nid_t target,
+			 char *output_buffer,
+			 size_t capacity);
 
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..88d2f6d 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -48,7 +48,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
 		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
-			       sizeof(*die) - sizeof(*dic));
+				   sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
 			return -EIO;
 
@@ -169,7 +169,7 @@ struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 
 		/* a corrupted entry is found */
 		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
+			de_namelen > EROFS_NAME_LEN) {
 			erofs_err("bogus dirent @ nid %llu", pnid | 0ULL);
 			DBG_BUGON(1);
 			return ERR_PTR(-EFSCORRUPTED);
@@ -203,7 +203,7 @@ int erofs_namei(struct nameidata *nd,
 	offset = 0;
 	while (offset < vi.i_size) {
 		erofs_off_t maxsize = min_t(erofs_off_t,
-					    vi.i_size - offset, EROFS_BLKSIZ);
+						vi.i_size - offset, EROFS_BLKSIZ);
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
@@ -213,7 +213,7 @@ int erofs_namei(struct nameidata *nd,
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
+			nameoff >= PAGE_SIZE) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
 			return -EFSCORRUPTED;
@@ -274,3 +274,115 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi)
 	vi->nid = nd.nid;
 	return erofs_read_inode_from_disk(vi);
 }
+
+static inline int erofs_checkdirent(const struct erofs_dirent *de,
+				    const struct erofs_dirent *last_de,
+				    u32 maxsize,
+				    const char *dname)
+{
+	int dname_len;
+	unsigned int nameoff = le16_to_cpu(de->nameoff);
+
+	if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
+		erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff, de->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+	dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
+					: le16_to_cpu(de[1].nameoff) - nameoff;
+	/* a corrupted entry is found */
+	if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
+		erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid) | 0ULL);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	if (de->file_type >= EROFS_FT_MAX) {
+		erofs_err("invalid file type %llu", de->nid);
+		return -EFSCORRUPTED;
+	}
+	return dname_len;
+}
+
+int erofs_get_pathname(const struct erofs_sb_info *sbi,
+		       erofs_nid_t nid,
+		       erofs_nid_t parent_nid,
+		       erofs_nid_t target,
+		       char *path,
+		       size_t capacity)
+{
+	if (capacity <= 1) {
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
+int erofs_get_inode_name(const struct erofs_sb_info *sbi,
+			 erofs_nid_t target,
+			 char *path,
+			 size_t capacity)
+{
+	return erofs_get_pathname(sbi, sbi->root_nid, sbi->root_nid, target, path, capacity);
+}
+
-- 
2.34.1.173.g76aa8bc2d0-goog

