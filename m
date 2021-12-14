Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230047498F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 18:35:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JD5BK6kXNz305p
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 04:35:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639503337;
	bh=eWI7YA3xamnJAQV2v9ogdYqScmWz3xvGHgE65mKA8D8=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NltvffXD5d9OqSKdIyQgNKW9tB3MQ6EzOTwx+RzwP1aoNuRmjW6w+1Y7k6bl0+Qiu
	 hzLRJQwruHxEF26yVsHda63eqI010p4a121HJhB9DSxoDuWPXGjmqrjZ5bQCVgdP4t
	 mm6icVyn4H0EDiQfISPDyW6H3gJFx8ziYbsThFCUeXSRfOxSuB5Au7Ju5OVPQaPtof
	 zDfZo37neJxcYfyV9SJ9xEnFslYNCl8ppeaZq3hij6ZJLOy7AHFJPOMP+80knQiD8z
	 jwZr5c7CCig6Xd/qH57JRXU0pRO5ENXhtJQJ6miyGl4QzTpHMQfhbo65GpFrozzdfi
	 cBPD9YceQXKOA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=33tw4yqskc4e4mfslpjq0nslttlqj.htrqnsz2-jwtkxqnxyx.t4qfgx.twl@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=BozOCQ+G; dkim-atps=neutral
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JD5BC0ZWRz3017
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 04:35:29 +1100 (AEDT)
Received: by mail-qt1-x84a.google.com with SMTP id
 u14-20020a05622a198e00b002b2f35a6dcfso27283574qtc.21
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 09:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=eWI7YA3xamnJAQV2v9ogdYqScmWz3xvGHgE65mKA8D8=;
 b=VwqDP38Peq6Gw/DZiEj7tkMLKjq27h83/05HKdv6Pvc+CUTjCzVq/mXKTi8sdS3AJ+
 dSrf3U1N6Kwq1LK996GuBUqPr+CWdkM1T2lVbtDLBjEm+fkJqHsOBW2TcXs+3LpRkJx7
 ip9rcvZv2gnKaU6so4Kx5Lm+2vNYrBFqHI50IqUwER9wczYMDrAoutpYKkjuKxB8H9Nz
 1cex4P6uRBMsMk8uI3TWzeIoQe2219LuWlXhiaW/Y3nAWpv+/sSEKYf/3Mu2yElCwBfL
 4YYcQtejHfASUbHbK9lxJoEhw0wFrv/CRQ/qO7tn92D/V7n/UZEjByHrir/zCgGojIWk
 iFOg==
X-Gm-Message-State: AOAM531bgTlVkTsBKL7HEAsEyzTnFVVYRcyalYAQDQ2wh8d6V0IEz4hA
 oD4j9MgU82w7C8TSCJAlCX1Pbcu6IR9lKuLCtLGWsRi3Ddypj6urZ3W+K7NYaqBLkHORHOyzSPO
 LmZDAIHB5dvkZ2jS3h82oOz9fBIV3va8B2i6AMVNYhBpaevKsd2xfvWQhuAqZ53rciNPERvBDQe
 ixV5yMTWI=
X-Google-Smtp-Source: ABdhPJxgGQsopIZqqPlRn70p+h63eb0oQNmmt+iPJK2c5tbU0DM3WZ60haCEuPOn1T/CmEyNPsj5hi1iWfV4OoJg4A==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:293:: with SMTP id
 z19mr7617055qtw.46.1639503326700; Tue, 14 Dec 2021 09:35:26 -0800 (PST)
Date: Tue, 14 Dec 2021 09:35:20 -0800
In-Reply-To: <20211214173520.1944792-1-zhangkelvin@google.com>
Message-Id: <20211214173520.1944792-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
 <20211214173520.1944792-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 2/2] Add API to iterate over inodes in EROFS
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
 include/erofs/iterate.h |  46 ++++++++++++
 include/erofs_fs.h      |   4 +-
 lib/Makefile.am         |   2 +-
 lib/iterate.c           | 154 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 include/erofs/iterate.h
 create mode 100644 lib/iterate.c

diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
new file mode 100644
index 0000000..4e2c783
--- /dev/null
+++ b/include/erofs/iterate.h
@@ -0,0 +1,46 @@
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
+// Iterate over inodes that are in directory specified by |nid|.
+// |parent_nid| is optional, if specified, additional sanity checks will
+// be performed.
+// |cb| will be called for every inode, regardless of type of inode.
+// |arg| will be passed to the callback in |erofs_readdir_cb| struct's
+// |arg| field.
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,
+									 erofs_nid_t nid,
+									 erofs_nid_t parent_nid,
+									 erofs_readdir_cb cb,
+									 void* arg);
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
+												erofs_readdir_cb cbg,
+												void* arg);
+int erofs_get_occupied_size(const struct erofs_inode* inode, erofs_off_t* size);
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
index c745e49..99fcfa1 100644
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
index 0000000..e01eadf
--- /dev/null
+++ b/lib/iterate.c
@@ -0,0 +1,154 @@
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
+			const char * const dname = (char*)buf + nameoff;
+			int ret;
+			/* skip "." and ".." dentry */
+			if (is_dot_dotdot(dname)) {
+				if (dname[1] == '.' && parent_nid > 0) {
+					// Directory ".." should have nid == parent_nid.
+					// But parent_nid parameter is optional, so only perform the check
+					// if parent_nid is specified.
+					if (parent_nid != de->nid) {
+						return EFSCORRUPTED;
+					}
+				}
+				de++;
+				continue;
+			}
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
+int erofs_get_occupied_size(const struct erofs_inode* inode, erofs_off_t* size) {
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

