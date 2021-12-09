Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5F46E033
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 02:21:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J8bpk1MD3z307C
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 12:21:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639012894;
	bh=TclOBkLce1W+s9SeSdOj8YE7DhDtI64tC2aqDPLRMts=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=d7tz+EDLkuyjhDjQ9ztXTqCk0bCovXAnUkNTzIz0Qzc500JsTglJnXcSbjcElgmx2
	 zQyovGRnN18u25MoBh1rrJjYm1/yKWAi+FbeSzeikK2CNT2sFcx2tTKyg7uQ9v5QB1
	 DFn+X+SdxuX+PHEN7tgxaj4s4twaSLxmApGMcvqIl2pc5OiKoZOC90nZCM8p3aMHUQ
	 egXbud2LafFRkCuWm74ZVhEmCYIImhHBn59deq44wyGn9dyriVq6hEYWfSfzjB0YJV
	 M35dwt7Zo3V0ycC6vCNGYnAchJWsmMlComsRyaH9qIW/DQCLamfKaUgEAENUo/JECy
	 bUOKOnLlCGvpA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3flqxyqskc6mckdqjnhoylqjrrjoh.frpolqxa-hurivolvwv.rcodev.ruj@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Dn8Zfjz/; dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J8bpc543dz300S
 for <linux-erofs@lists.ozlabs.org>; Thu,  9 Dec 2021 12:21:28 +1100 (AEDT)
Received: by mail-qk1-x74a.google.com with SMTP id
 bp17-20020a05620a459100b0045e893f2ed8so5285125qkb.11
 for <linux-erofs@lists.ozlabs.org>; Wed, 08 Dec 2021 17:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=TclOBkLce1W+s9SeSdOj8YE7DhDtI64tC2aqDPLRMts=;
 b=0SSwh333+dMpdLaW+HVh8UxF2S/gfsctYFWQciSbBtw5tXbvtppt73Cb0gn1ymdgmB
 pynffqUMoZCGjR1RrVzOWV05cpxNA10nl0nssXi2oUWiahQcx2ReV3pW298fNU7MP3ag
 Rsh3SU4FryxBqv3PhqUnEkLZslHtW8RK/WX3RBF/jg2r0JtjeK0BA6Dz4CxPVrS4NpVk
 Emhxuv+EQrgASzdHgEh/mtfq1TK0bwk3MHR9Rvl6fjdrKDW3cU94liiuFj9FTExlIBnk
 fIY5tpyc77IQgxcVoa2waDacrS0JvG0mI3noDsM55OOg22amA+L5yaL1MsKbwqjD17At
 m4yA==
X-Gm-Message-State: AOAM530re252q/MpqZEyFv5RJSlHGRWILtYlsF8gcdo7cIC6qJnyEAY2
 YEZNA0NSw6pQEFB7CRO3p0rEam0MQ2xXJEfmIs9FtM4E3Ld7VgZrSP12lmFlvLl5ffuuy8ytTSL
 tazzoa9KIOmN2Yx/RAERmPpaYKkxmyIcDMIanwCZwvHO+PDy5jSNLDZwtUIkjds3lV0O4kkawV1
 r9p87uccQ=
X-Google-Smtp-Source: ABdhPJyxixz0gvWKCOjYBZohvwcup+ckIYV+cfpPKsoqUlx70sSxv2/1hJYJRuE7K/XiXSUJM652hx2DDLh0rT34mw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:1055:: with SMTP id
 f21mr12597572qte.421.1639012886531; Wed, 08 Dec 2021 17:21:26 -0800 (PST)
Date: Wed,  8 Dec 2021 17:21:18 -0800
In-Reply-To: <20211209012118.4175351-1-zhangkelvin@google.com>
Message-Id: <20211209012118.4175351-3-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211209004659.4161847-1-zhangkelvin@google.com>
 <20211209012118.4175351-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 2/2] Add API to iterate over inodes in EROFS
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
 include/erofs/iterate.h |  57 +++++++++++++
 lib/Makefile.am         |   2 +-
 lib/iterate.c           | 173 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/iterate.h
 create mode 100644 lib/iterate.c

diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
new file mode 100644
index 0000000..96171a7
--- /dev/null
+++ b/include/erofs/iterate.h
@@ -0,0 +1,57 @@
+//
+// Copyright (C) 2021 The Android Open Source Project
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+//      http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+//
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
+  uint64_t inode_id;
+  const char* name;
+  bool is_reg_file;
+  u64 compressed_size;
+  u64 uncompressed_size;
+  struct erofs_inode* inode;
+  void* arg;
+};
+// Callback function for iterating over inodes of EROFS
+
+typedef bool (*ErofsIterCallback)(struct erofs_inode_info);
+
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,
+                   erofs_nid_t nid,
+                   erofs_nid_t parent_nid,
+                   ErofsIterCallback cb,
+                   void* arg);
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
+                        ErofsIterCallback cbg,
+                        void* arg);
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  // ITERATE_ITERATE
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
index 0000000..1a10ec1
--- /dev/null
+++ b/lib/iterate.c
@@ -0,0 +1,173 @@
+//
+// Copyright (C) 2021 The Android Open Source Project
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+//      http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+//
+
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+#include "erofs/print.h"
+#include "erofs/iterate.h"
+
+static int erofs_read_dirent(const struct erofs_sb_info* sbi,
+                             const struct erofs_dirent* de,
+                             erofs_nid_t nid,
+                             erofs_nid_t parent_nid,
+                             const char* dname,
+                             ErofsIterCallback cb,
+                             void* arg) {
+  int err;
+  erofs_off_t occupied_size = 0;
+  struct erofs_inode inode = {.nid = de->nid};
+  err = erofs_read_inode_from_disk(&inode);
+  if (err) {
+    erofs_err("read file inode from disk failed!");
+    return err;
+  }
+  err = erofs_get_occupied_size(&inode, &occupied_size);
+  if (err) {
+    erofs_err("get file size failed\n");
+    return err;
+  }
+  char buf[PATH_MAX + 1];
+  erofs_get_inode_name(sbi, de->nid, buf, PATH_MAX + 1);
+  struct erofs_inode_info info = {
+      .inode_id = de->nid,
+      .name = buf,
+      .is_reg_file = de->file_type == EROFS_FT_REG_FILE,
+      .compressed_size = occupied_size,
+      .uncompressed_size = inode.i_size,
+      .inode = &inode,
+      .arg = arg};
+  cb(info);
+  if ((de->file_type == EROFS_FT_DIR) && de->nid != nid &&
+      de->nid != parent_nid) {
+    err = erofs_iterate_dir(sbi, de->nid, nid, cb, arg);
+    if (err) {
+      erofs_err("parse dir nid %u error occurred\n",
+                (unsigned int)(de->nid));
+      return err;
+    }
+  }
+  return 0;
+}
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
+    erofs_err("invalid file type %u", (unsigned int)(de->nid));
+    return -EFSCORRUPTED;
+  }
+  return dname_len;
+}
+
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,
+                   erofs_nid_t nid,
+                   erofs_nid_t parent_nid,
+                   ErofsIterCallback cb,
+                   void* arg) {
+  int err;
+  erofs_off_t offset;
+  char buf[EROFS_BLKSIZ];
+  struct erofs_inode vi = {.nid = nid};
+  err = erofs_read_inode_from_disk(&vi);
+  if (err)
+    return err;
+  struct erofs_inode_info inode_info = {
+      .inode_id = nid,
+      .name = buf,
+      .is_reg_file = false,
+      .compressed_size = vi.i_size,
+      .uncompressed_size = vi.i_size,
+      .inode = &vi,
+      .arg = arg,
+  };
+  err = erofs_get_inode_name(sbi, nid, buf, EROFS_BLKSIZ);
+  cb(inode_info);
+  if (err) {
+    return err;
+  }
+  offset = 0;
+  while (offset < vi.i_size) {
+    erofs_off_t maxsize = min_t(erofs_off_t, vi.i_size - offset, EROFS_BLKSIZ);
+    const struct erofs_dirent* de = (const struct erofs_dirent*)(buf);
+    struct erofs_dirent* end;
+    unsigned int nameoff;
+    err = erofs_pread(&vi, buf, maxsize, offset);
+    if (err)
+      return err;
+    nameoff = le16_to_cpu(de->nameoff);
+    end = (struct erofs_dirent*)(buf + nameoff);
+    while (de < end) {
+      const char* dname;
+      int ret;
+      /* skip "." and ".." dentry */
+      if (de->nid == nid || de->nid == parent_nid) {
+        de++;
+        continue;
+      }
+      dname = (char*)buf + nameoff;
+      ret = erofs_checkdirent(de, end, maxsize, dname);
+      if (ret < 0)
+        return ret;
+      ret = erofs_read_dirent(sbi, de, nid, parent_nid, dname, cb, arg);
+      if (ret < 0)
+        return ret;
+      ++de;
+    }
+    offset += maxsize;
+  }
+  return 0;
+}
+
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size) {
+  *size = 0;
+  switch (inode->datalayout) {
+    case EROFS_INODE_FLAT_INLINE:
+    case EROFS_INODE_FLAT_PLAIN:
+    case EROFS_INODE_CHUNK_BASED:
+      *size = inode->i_size;
+      break;
+    case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+    case EROFS_INODE_FLAT_COMPRESSION:
+      *size = inode->u.i_blocks * EROFS_BLKSIZ;
+      break;
+    default:
+      erofs_err("unknown datalayout");
+      return -1;
+  }
+  return 0;
+}
+
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
+                        ErofsIterCallback cb,
+                        void* arg) {
+  return erofs_iterate_dir(sbi, sbi->root_nid, sbi->root_nid, cb, arg);
+}
+
-- 
2.34.1.173.g76aa8bc2d0-goog

