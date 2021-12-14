Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1BD473AB3
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:20:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCht35DvQz3017
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:20:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639448411;
	bh=fwlgTKnzudxbB+wcO5PAvpJi5nStcfctIMK0gvWcHpw=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bSsxnhZIXWT7OsofHh006bbwijMM8OENkd408dFth1P7/36SJ0jhFnPOxNGBpY9fd
	 oVbyB6zaV5yFIx8dHYz5XSDZj7DtzCW6q6ude7PApS5YfLonZUE05fzzoRlI3PxrqH
	 Pu+Zz3PGmaTO/CEQdRtg7WwcY3/ax2ZFSAHAqT5W5IA2RYw2BZx00EF70NX9wUV38t
	 4tISIBlzltl5TULXYYYVwbU89sxh6yXG01S9qt8AMDca3sRUb+4UGObqxUti+2jiDt
	 G/VbBfrSKLJr96kkjORl6qaHewUwRMEBwwLYBJZ+5H0dHi6hLBrI6GCUhl+xITU/y1
	 Zbt9MjnXKwVEg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3uv-3yqskc0u6ohunrls2punvvnsl.jvtspu14-lyvmzspz0z.v6shiz.vyn@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=mMq1/nQY; dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JChsz6VLhz2xtj
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:20:06 +1100 (AEDT)
Received: by mail-qt1-x849.google.com with SMTP id
 v17-20020a05622a131100b002aea167e24aso25298467qtk.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 18:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=fwlgTKnzudxbB+wcO5PAvpJi5nStcfctIMK0gvWcHpw=;
 b=ftiZGy7V/OJc1ZPNz3wSTXIZ2VL6M368T3S5B0JiphYi20lGzHwKvcO8GNKnS+F3CU
 bxc5RZYLnCeKWykxwTVzg8GAhCQcqD+SGIBkP7kPKXRjKIjjdOdKateSxSZ8oY2ZwH5L
 fqsOcTDCNV8IL72XE1fuBwb5G2/2YGIyEZ3gELtzmrI2j2iZFro5CjNZniSYXgYWKC0l
 J/s9Yr/67Xeald+vTURRzlhmZYTZTXoa94ltgj2Ragh6VDGXQ780oupsSpfEBmqfcJra
 U254Vyqwlp4VanSvpg4DYbIv2c1GNtAmnYOu720I5WxDnIcovJUrmYJwq82l5MYQPzNK
 W0xQ==
X-Gm-Message-State: AOAM530XZ3UVhuXDXDj309B1Fuk4Fpm+1ildBQG+mqcGe7OkugrkmyNA
 oatPop8ACbWyMkNODhErVdkJNghxBCQwb+2i/6dHk7EQjhFAL6UUUmkyRiKGSO6E+cuU40XDOiH
 8EiWkddoWYKIRZcV3AaWxga4elFYfFx2sm6FMKf0FDhwUr5612+OKOsisrrAKwSVCaS7IZ/K7xQ
 xaYIcaDh0=
X-Google-Smtp-Source: ABdhPJwkpNiH1CGRWxW/5RYTzToFatXnXWYULm1Hr5F/HkDcuYRCFBE0kCrCJTdXHcpSwnlYBjpTvP2k0hiu9uLlyQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:5f52:: with SMTP id
 y18mr2871792qta.534.1639448402972; Mon, 13 Dec 2021 18:20:02 -0800 (PST)
Date: Mon, 13 Dec 2021 18:19:55 -0800
In-Reply-To: <20211214021955.992899-1-zhangkelvin@google.com>
Message-Id: <20211214021955.992899-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211214021955.992899-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 2/2] Add API to iterate over inodes in EROFS
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

Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/iterate.h |  40 +++++++++++
 include/erofs_fs.h      |   4 +-
 lib/Makefile.am         |   2 +-
 lib/iterate.c           | 148 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 3 deletions(-)
 create mode 100644 include/erofs/iterate.h
 create mode 100644 lib/iterate.c

diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
new file mode 100644
index 0000000..af29e14
--- /dev/null
+++ b/include/erofs/iterate.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: Apache-2.0
+
+#ifndef ITERATE_ITERATE
+#define ITERATE_ITERATE
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+
+struct erofs_inode_info {
+	const char* name;
+	enum erofs_ftype ftype;
+	struct erofs_inode* inode;
+	void* arg;
+};
+// Callback function for iterating over inodes of EROFS
+
+typedef bool (*erofs_readdir_cb)(struct erofs_inode_info*);
+
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,
+									 erofs_nid_t nid,
+									 erofs_nid_t parent_nid,
+									 erofs_readdir_cb cb,
+									 void* arg);
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
+												erofs_readdir_cb cbg,
+												void* arg);
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  // ITERATE_ITERATE
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..7ee8251 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -389,8 +389,8 @@ struct erofs_dirent {
 } __packed;
 
 /* file types used in inode_info->flags */
-enum {
-	EROFS_FT_UNKNOWN,
+enum erofs_ftype {
+	EROFS_FT_UNKNOWN = 0,
 	EROFS_FT_REG_FILE,
 	EROFS_FT_DIR,
 	EROFS_FT_CHRDEV,
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 67ba798..20c0e4f 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c iterate.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/iterate.c b/lib/iterate.c
new file mode 100644
index 0000000..ec44217
--- /dev/null
+++ b/lib/iterate.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: Apache-2.0
+
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+#include "erofs/print.h"
+#include "erofs/iterate.h"
+
+static int erofs_read_dirent(const struct erofs_sb_info* sbi,
+														 const struct erofs_dirent* de,
+														 erofs_nid_t nid,
+														 erofs_nid_t parent_nid,
+														 const char* dname,
+														 erofs_readdir_cb cb,
+														 void* arg) {
+	int err;
+	erofs_off_t occupied_size = 0;
+	struct erofs_inode inode = {.nid = de->nid};
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read file inode from disk failed!");
+		return err;
+	}
+	char buf[PATH_MAX + 1];
+	erofs_get_inode_name(sbi, de->nid, buf, PATH_MAX + 1);
+	struct erofs_inode_info info = {
+			.name = buf,
+			.ftype = de->file_type,
+			.inode = &inode,
+			.arg = arg};
+	cb(&info);
+	if ((de->file_type == EROFS_FT_DIR) && de->nid != nid &&
+			de->nid != parent_nid) {
+		err = erofs_iterate_dir(sbi, de->nid, nid, cb, arg);
+		if (err) {
+			erofs_err("parse dir nid %u error occurred\n",
+								(unsigned int)(de->nid));
+			return err;
+		}
+	}
+	return 0;
+}
+
+static inline int erofs_checkdirent(const struct erofs_dirent* de,
+																		const struct erofs_dirent* last_de,
+																		u32 maxsize,
+																		const char* dname) {
+	int dname_len;
+	unsigned int nameoff = le16_to_cpu(de->nameoff);
+	if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
+		erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff, de->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+	dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
+																	: le16_to_cpu(de[1].nameoff) - nameoff;
+	/* a corrupted entry is found */
+	if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
+		erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid) | 0ULL);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	if (de->file_type >= EROFS_FT_MAX) {
+		erofs_err("invalid file type %u", (unsigned int)(de->nid));
+		return -EFSCORRUPTED;
+	}
+	return dname_len;
+}
+
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,
+									 erofs_nid_t nid,
+									 erofs_nid_t parent_nid,
+									 erofs_readdir_cb cb,
+									 void* arg) {
+	int err;
+	erofs_off_t offset;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode vi = {.nid = nid};
+	err = erofs_read_inode_from_disk(&vi);
+	if (err)
+		return err;
+	struct erofs_inode_info inode_info = {
+			.name = buf,
+			.ftype = EROFS_FT_DIR,
+			.inode = &vi,
+			.arg = arg,
+	};
+	err = erofs_get_inode_name(sbi, nid, buf, EROFS_BLKSIZ);
+	cb(&inode_info);
+	if (err) {
+		return err;
+	}
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t, vi.i_size - offset, EROFS_BLKSIZ);
+		const struct erofs_dirent* de = (const struct erofs_dirent*)(buf);
+		struct erofs_dirent* end;
+		unsigned int nameoff;
+		err = erofs_pread(&vi, buf, maxsize, offset);
+		if (err)
+			return err;
+		nameoff = le16_to_cpu(de->nameoff);
+		end = (struct erofs_dirent*)(buf + nameoff);
+		while (de < end) {
+			const char* dname;
+			int ret;
+			/* skip "." and ".." dentry */
+			if (de->nid == nid || de->nid == parent_nid) {
+				de++;
+				continue;
+			}
+			dname = (char*)buf + nameoff;
+			ret = erofs_checkdirent(de, end, maxsize, dname);
+			if (ret < 0)
+				return ret;
+			ret = erofs_read_dirent(sbi, de, nid, parent_nid, dname, cb, arg);
+			if (ret < 0)
+				return ret;
+			++de;
+		}
+		offset += maxsize;
+	}
+	return 0;
+}
+
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size) {
+	*size = 0;
+	switch (inode->datalayout) {
+		case EROFS_INODE_FLAT_INLINE:
+		case EROFS_INODE_FLAT_PLAIN:
+		case EROFS_INODE_CHUNK_BASED:
+			*size = inode->i_size;
+			break;
+		case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+		case EROFS_INODE_FLAT_COMPRESSION:
+			*size = inode->u.i_blocks * EROFS_BLKSIZ;
+			break;
+		default:
+			erofs_err("unknown datalayout");
+			return -1;
+	}
+	return 0;
+}
+
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
+												erofs_readdir_cb cb,
+												void* arg) {
+	return erofs_iterate_dir(sbi, sbi->root_nid, sbi->root_nid, cb, arg);
+}
+
-- 
2.34.1.173.g76aa8bc2d0-goog

