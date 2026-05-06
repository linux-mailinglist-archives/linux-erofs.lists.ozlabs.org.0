Return-Path: <linux-erofs+bounces-3380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CNpB1T0+mkTUwMAu9opvQ
	(envelope-from <linux-erofs+bounces-3380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 06 May 2026 09:57:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B14D7803
	for <lists+linux-erofs@lfdr.de>; Wed, 06 May 2026 09:57:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9SQL0VFHz2xdh;
	Wed, 06 May 2026 17:56:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778054217;
	cv=none; b=ktbfXnno3Ajqceajyco5/YhAkgTqvUGjqYfnL5X2kIDSDxJRXq2BPzA7KzUURuCwnAsbUg6/xXI5exWOXS5gHZ8r1aZT2Wtt0ON6Nj8w2qkxtO+4ivURLP9WKd5nZT00dyr64f9wE6v/7PuSKpn0RW/c7kKWeI613vYW6ocHZltZoFCBikNv1CROAxJ1CVFjhO2C5d2xjEsGi2mYAP1ZOBjj8gNa0j0MvjBvs3cJdpkTbvKRZdyaQSd3csbb8wr1qamuwxNk99iRPXamUHZZqM/CgQAXI0SQ46ulRtkgRcS0IUuaHwQ+uvKg099ntVrRwabwSJk/Ki8c8HzAIwfR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778054217; c=relaxed/relaxed;
	bh=nefVz6XmyvZZiFiqBHeWERxgVVHnkHd6KO2TbUNbDxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI4o5P1NNS+CEhIDi79utePoywSCYh5JFCLQPUgkwoSOpTsuKK0paxvraQD+Mzzn9vmbLVt+pmG7fG7GfwDttR5+puyALevF6jYtIHZSPSbN1FCCKKl07NINK+m8Yq1Ph8eQnHfoU4xF5E0yA4iCsUAYIgRp8C8LmsTtW98Cqh8Va4rgUhT9na56i3BoAaIWc3Waftsee584GBP165gOZAXbA2jRg+GlTuuApF+8W6PuygXu1zTkr8yDEAzW0WbKpxm0wm6QvZIOFcQX+UoF3t+br+FuwFQCNRNiRl8G3RxhyU4LY20NrVdrvhEJoGf//e0nuIL+lkcGj9sOjpV3NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=yanmengdie24@mails.ucas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mails.ucas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mails.ucas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=yanmengdie24@mails.ucas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 431 seconds by postgrey-1.37 at boromir; Wed, 06 May 2026 17:56:54 AEST
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9SQG3bmDz2xdL
	for <linux-erofs@lists.ozlabs.org>; Wed, 06 May 2026 17:56:54 +1000 (AEST)
Received: from localhost.localdomain (unknown [14.22.11.163])
	by APP-05 (Coremail) with SMTP id zQCowAAXqg158vppy_6HDw--.2333S2;
	Wed, 06 May 2026 15:49:27 +0800 (CST)
From: Mengdie Yan <yanmengdie24@mails.ucas.ac.cn>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	chao@kernel.org,
	hudsonzhu@tencent.com,
	Mengdie Yan <yanmengdie24@mails.ucas.ac.cn>
Subject: [PATCH] erofs-utils: mkfs: add hot file list support
Date: Wed,  6 May 2026 15:49:12 +0800
Message-ID: <20260506074912.896563-1-yanmengdie24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.43.7
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqg158vppy_6HDw--.2333S2
X-Coremail-Antispam: 1UD129KBjvAXoWDAr15WF4kGF18JrWDuw48Zwb_yoW7JF47Wo
	WxZa13WF1rKF15Ga1UCF17Xa47Z3yxCw18ArZxWryqgF97Wr1UC3s7W3W5X34fXr4FgrWf
	A3s7Zas8tr48tryfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYS7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUfnY7UUUUU=
X-Originating-IP: [14.22.11.163]
X-CM-SenderInfo: 51dqzv5qjgxvysu6ztxlovh3xfdvhtffof0/
X-Spam-Status: No, score=-0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 464B14D7803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3380-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_NEQ_ENVFROM(0.00)[yanmengdie24@mails.ucas.ac.cn,linux-erofs@lists.ozlabs.org];
	DMARC_DNSFAIL(0.00)[ucas.ac.cn : query timed out];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,ucas.ac.cn:email]

Add --hot-file-list to let mkfs prioritize image-relative hot paths
for local directory builds. The option loads newline-separated hot paths,
resolves symlink aliases in local rootfs builds, prioritizes ancestor
directory metadata, and keeps hot regular files out of fragment packing
and cross-file dedupe so their physical layout remains stable.

Add layout coverage for hot files, hot directories, symlink aliases,
hardlinks, and large root-directory data.

Signed-off-by: Mengdie Yan <yanmengdie24@mails.ucas.ac.cn>
---
 include/erofs/hotfile.h  |  25 ++
 include/erofs/internal.h |   9 +
 lib/Makefile.am          |   2 +
 lib/compress.c           |  20 +-
 lib/hotfile.c            | 641 +++++++++++++++++++++++++++++++++++++++
 lib/inode.c              | 313 ++++++++++++++++++-
 man/mkfs.erofs.1         |  13 +
 mkfs/main.c              |  32 ++
 tests/hotfile-layout.sh  | 321 ++++++++++++++++++++
 9 files changed, 1359 insertions(+), 17 deletions(-)
 create mode 100644 include/erofs/hotfile.h
 create mode 100644 lib/hotfile.c
 create mode 100755 tests/hotfile-layout.sh

diff --git a/include/erofs/hotfile.h b/include/erofs/hotfile.h
new file mode 100644
index 0000000..5f43e41
--- /dev/null
+++ b/include/erofs/hotfile.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_HOTFILE_H
+#define __EROFS_HOTFILE_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include <limits.h>
+#include "defs.h"
+
+#define EROFS_HOT_RANK_NONE	UINT_MAX
+
+int erofs_hotfile_load(const char *path);
+bool erofs_hotfile_enabled(void);
+unsigned int erofs_get_hot_file_rank(const char *path);
+unsigned int erofs_get_hot_dir_rank(const char *path);
+void erofs_hotfile_exit(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 450e264..d658c36 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -265,6 +265,10 @@ struct erofs_inode {
 	bool compressed_idata;
 	bool lazy_tailblock;
 	bool opaque;
+	bool hotfile;
+	bool hotdir;
+	bool hotdir_deferred;
+	u32 hot_rank;
 	/* OVL: non-merge dir that may contain whiteout entries */
 	bool whiteouts;
 	bool dot_omitted;
@@ -574,6 +578,11 @@ static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 	return inode->i_srcpath == EROFS_PACKED_INODE;
 }
 
+static inline bool erofs_inode_is_hotfile(struct erofs_inode *inode)
+{
+	return inode->hotfile;
+}
+
 int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
 void erofs_packedfile_exit(struct erofs_sb_info *sbi);
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 27bf710..07282e2 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -12,6 +12,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/exclude.h \
       $(top_srcdir)/include/erofs/flex-array.h \
       $(top_srcdir)/include/erofs/hashmap.h \
+      $(top_srcdir)/include/erofs/hotfile.h \
       $(top_srcdir)/include/erofs/inode.h \
       $(top_srcdir)/include/erofs/internal.h \
       $(top_srcdir)/include/erofs/io.h \
@@ -45,6 +46,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
+		      hotfile.c \
 		      vmdk.c metabox.c global.c importer.c base64.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
diff --git a/lib/compress.c b/lib/compress.c
index 62d2672..9d55cbc 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -301,7 +301,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 	 * No need dedupe for packed inode since it is composed of
 	 * fragments which have already been deduplicated.
 	 */
-	if (erofs_is_packed_inode(inode))
+	if (erofs_is_packed_inode(inode) || erofs_inode_is_hotfile(inode))
 		goto out;
 
 	do {
@@ -573,7 +573,8 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (params->fragments && tsg && final && !is_packed_inode &&
-			    !erofs_is_metabox_inode(inode));
+			    !erofs_is_metabox_inode(inode) &&
+			    !erofs_inode_is_hotfile(inode));
 	bool data_unaligned = ictx->data_unaligned;
 	bool may_inline = (params->ztailpacking && !data_unaligned && tsg &&
 			   final && !may_packing);
@@ -742,7 +743,8 @@ frag_packing:
 	e->pstart = ctx->pstart;
 	if (ctx->pstart != EROFS_NULL_ADDR)
 		ctx->pstart += e->plen;
-	if (!may_inline && !may_packing && !is_packed_inode)
+	if (!may_inline && !may_packing && !is_packed_inode &&
+	    !erofs_inode_is_hotfile(inode))
 		(void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
 	ctx->head += e->length;
 	return 0;
@@ -1256,6 +1258,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	struct erofs_inode *inode = ictx->inode;
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode) &&
+		!erofs_inode_is_hotfile(inode) &&
 		ctx->seg_idx >= ictx->seg_num - 1;
 	struct erofs_vfile *vf = ictx->vf;
 	int ret;
@@ -1551,7 +1554,8 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 	struct z_erofs_extent_item *ei, *n;
 	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
-	bool dedupe_ext = params->fragments;
+	bool dedupe_ext = params->fragments &&
+		!erofs_inode_is_hotfile(ictx->inode);
 	erofs_off_t off = 0;
 	int ret = 0, ret2;
 	erofs_off_t dpo;
@@ -1802,7 +1806,8 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_compress_ictx *ictx;
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
-		!erofs_is_metabox_inode(inode);
+		!erofs_is_metabox_inode(inode) &&
+		!erofs_inode_is_hotfile(inode);
 	bool all_fragments = params->all_fragments && frag;
 
 	/* initialize per-file compression setting */
@@ -1888,7 +1893,7 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 		ictx->data_unaligned = false;
 	}
 	if (params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_ON &&
-	    !ictx->data_unaligned)
+	    !ictx->data_unaligned && !erofs_inode_is_hotfile(inode))
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	init_list_head(&ictx->extents);
@@ -1911,7 +1916,8 @@ int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx)
 	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_inode *inode = ictx->inode;
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
-		!erofs_is_metabox_inode(inode);
+		!erofs_is_metabox_inode(inode) &&
+		!erofs_inode_is_hotfile(inode);
 	bool all_fragments = params->all_fragments && frag;
 	int ret;
 
diff --git a/lib/hotfile.c b/lib/hotfile.c
new file mode 100644
index 0000000..9e0878a
--- /dev/null
+++ b/lib/hotfile.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#define _GNU_SOURCE
+
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "erofs/config.h"
+#include "erofs/hotfile.h"
+#include "erofs/print.h"
+
+struct erofs_hotfile_manifest {
+	struct erofs_hotfile_entry {
+		char *path;
+		unsigned int rank;
+	} *file_paths;
+	unsigned int nr_files;
+	unsigned int cap_files;
+	struct erofs_hotfile_entry *dir_paths;
+	unsigned int nr_dirs;
+	unsigned int cap_dirs;
+};
+
+static struct erofs_hotfile_manifest hotfile_manifest;
+
+static bool erofs_hotfile_is_local_rootfs(char **root)
+{
+	struct stat st;
+
+	if (!cfg.c_src_path)
+		return false;
+	if (stat(cfg.c_src_path, &st))
+		return false;
+	if (!S_ISDIR(st.st_mode))
+		return false;
+	if (root)
+		*root = cfg.c_src_path;
+	return true;
+}
+
+static int erofs_hotfile_cmp(const void *a, const void *b)
+{
+	const struct erofs_hotfile_entry *lhs = a;
+	const struct erofs_hotfile_entry *rhs = b;
+
+	return strcmp(lhs->path, rhs->path);
+}
+
+static int erofs_hotfile_path_cmp(const void *a, const void *b)
+{
+	const char *lhs = a;
+	const struct erofs_hotfile_entry *rhs = b;
+
+	return strcmp(lhs, rhs->path);
+}
+
+static char *erofs_hotfile_normalize(const char *path)
+{
+	const unsigned char *src = (const unsigned char *)path;
+	const unsigned char *end;
+	char *out;
+	size_t len = 0;
+	bool slash = false;
+
+	while (*src && isspace(*src))
+		++src;
+	end = src + strlen((const char *)src);
+	while (end > src && isspace(end[-1]))
+		--end;
+
+	while (src < end && *src == '/')
+		++src;
+
+	out = malloc((end - src) + 1);
+	if (!out)
+		return NULL;
+
+	while (src < end) {
+		if (*src == '/') {
+			if (!slash)
+				out[len++] = '/';
+			slash = true;
+		} else {
+			out[len++] = *src;
+			slash = false;
+		}
+		++src;
+	}
+
+	while (len > 0 && out[len - 1] == '/')
+		--len;
+	out[len] = '\0';
+	return out;
+}
+
+static bool erofs_hotfile_line_is_dir(const char *path)
+{
+	const unsigned char *src = (const unsigned char *)path;
+	const unsigned char *end;
+
+	while (*src && isspace(*src))
+		++src;
+	if (*src == '#')
+		return false;
+
+	end = src + strlen((const char *)src);
+	while (end > src && isspace(end[-1]))
+		--end;
+
+	return end > src && end[-1] == '/';
+}
+
+static int erofs_hotfile_add_file(char *path, unsigned int rank);
+static int erofs_hotfile_add_dir(char *path, unsigned int rank);
+static int erofs_hotfile_collect_parent_dirs(const char *path,
+					     unsigned int rank);
+
+static char *erofs_hotfile_clean_path(const char *path)
+{
+	char **stack;
+	char *normalized, *token, *saveptr;
+	char *out;
+	size_t len, depth = 0, i, pos = 0;
+
+	normalized = erofs_hotfile_normalize(path);
+	if (!normalized)
+		return NULL;
+
+	len = strlen(normalized);
+	stack = calloc(len + 1, sizeof(*stack));
+	if (!stack) {
+		free(normalized);
+		return NULL;
+	}
+
+	for (token = strtok_r(normalized, "/", &saveptr); token;
+	     token = strtok_r(NULL, "/", &saveptr)) {
+		if (!strcmp(token, "."))
+			continue;
+		if (!strcmp(token, "..")) {
+			if (!depth) {
+				free(stack);
+				free(normalized);
+				errno = EXDEV;
+				return NULL;
+			}
+			--depth;
+			continue;
+		}
+		stack[depth++] = token;
+	}
+
+	out = malloc(len + 1);
+	if (!out) {
+		free(stack);
+		free(normalized);
+		return NULL;
+	}
+
+	for (i = 0; i < depth; ++i) {
+		size_t n = strlen(stack[i]);
+
+		if (i)
+			out[pos++] = '/';
+		memcpy(out + pos, stack[i], n);
+		pos += n;
+	}
+	out[pos] = '\0';
+	free(stack);
+	free(normalized);
+	return out;
+}
+
+static char *erofs_hotfile_join_symlink_target(const char *linkpath,
+					       const char *target,
+					       const char *suffix)
+{
+	char *joined, *parent = NULL, *slash;
+	int ret;
+
+	if (target[0] == '/') {
+		char *cleaned;
+
+		ret = asprintf(&joined, "%s%s%s", target,
+			       suffix && suffix[0] ? "/" : "",
+			       suffix && suffix[0] ? suffix : "");
+		if (ret < 0)
+			return NULL;
+		cleaned = erofs_hotfile_clean_path(joined);
+		free(joined);
+		return cleaned;
+	}
+
+	parent = strdup(linkpath);
+	if (!parent)
+		return NULL;
+	slash = strrchr(parent, '/');
+	if (slash)
+		*slash = '\0';
+	else
+		parent[0] = '\0';
+
+	ret = asprintf(&joined, "%s%s%s%s%s",
+		       parent,
+		       parent[0] ? "/" : "",
+		       target,
+		       suffix && suffix[0] ? "/" : "",
+		       suffix && suffix[0] ? suffix : "");
+	free(parent);
+	if (ret < 0)
+		return NULL;
+	parent = erofs_hotfile_clean_path(joined);
+	free(joined);
+	return parent;
+}
+
+static int erofs_hotfile_add_file_path(const char *path, unsigned int rank)
+{
+	char *dup;
+	int err;
+
+	dup = strdup(path);
+	if (!dup)
+		return -ENOMEM;
+	err = erofs_hotfile_add_file(dup, rank);
+	if (err) {
+		free(dup);
+		return err;
+	}
+	return erofs_hotfile_collect_parent_dirs(path, rank);
+}
+
+static int erofs_hotfile_add_dir_path(const char *path, unsigned int rank)
+{
+	char *dup;
+	int err;
+
+	dup = strdup(path);
+	if (!dup)
+		return -ENOMEM;
+	err = erofs_hotfile_add_dir(dup, rank);
+	if (err) {
+		free(dup);
+		return err;
+	}
+	return erofs_hotfile_collect_parent_dirs(path, rank);
+}
+
+static int erofs_hotfile_add_plain_path(const char *path, bool dir_entry,
+					unsigned int rank)
+{
+	if (!path[0])
+		return 0;
+	return dir_entry ? erofs_hotfile_add_dir_path(path, rank) :
+		erofs_hotfile_add_file_path(path, rank);
+}
+
+static int erofs_hotfile_add_resolved_path(const char *path, bool dir_entry,
+					   unsigned int rank)
+{
+	char *root, *current;
+	int depth, err;
+
+	if (!path[0])
+		return 0;
+
+	if (!erofs_hotfile_is_local_rootfs(&root))
+		return erofs_hotfile_add_plain_path(path, dir_entry, rank);
+
+	current = erofs_hotfile_clean_path(path);
+	if (!current)
+		return erofs_hotfile_add_plain_path(path, dir_entry, rank);
+
+	for (depth = 0; depth < 32; ++depth) {
+		char *walk, *saveptr, *part, *prefix = NULL;
+		bool redirected = false;
+		size_t prefix_len = 0;
+
+		walk = strdup(current);
+		if (!walk) {
+			free(current);
+			return -ENOMEM;
+		}
+
+		for (part = strtok_r(walk, "/", &saveptr); part;
+		     part = strtok_r(NULL, "/", &saveptr)) {
+			char *fullpath, *next, *target;
+			const char *suffix = saveptr;
+			struct stat st;
+
+			if (prefix_len) {
+				if (asprintf(&next, "%s/%s", prefix, part) < 0) {
+					free(prefix);
+					free(walk);
+					free(current);
+					return -ENOMEM;
+				}
+				free(prefix);
+				prefix = next;
+			} else {
+				prefix = strdup(part);
+				if (!prefix) {
+					free(walk);
+					free(current);
+					return -ENOMEM;
+				}
+			}
+			prefix_len = strlen(prefix);
+
+			if (asprintf(&fullpath, "%s/%s", root, prefix) < 0) {
+				free(prefix);
+				free(walk);
+				free(current);
+				return -ENOMEM;
+			}
+			if (lstat(fullpath, &st)) {
+				free(fullpath);
+				free(prefix);
+				free(walk);
+				err = erofs_hotfile_add_plain_path(current,
+								   dir_entry,
+								   rank);
+				free(current);
+				return err;
+			}
+			if (!S_ISLNK(st.st_mode)) {
+				free(fullpath);
+				continue;
+			}
+
+			err = erofs_hotfile_add_file_path(prefix, rank);
+			if (err) {
+				free(fullpath);
+				free(prefix);
+				free(walk);
+				free(current);
+				return err;
+			}
+
+			target = malloc(st.st_size + 1);
+			if (!target) {
+				free(fullpath);
+				free(prefix);
+				free(walk);
+				free(current);
+				return -ENOMEM;
+			}
+			err = readlink(fullpath, target, st.st_size);
+			free(fullpath);
+			if (err < 0) {
+				err = -errno;
+				free(target);
+				free(prefix);
+				free(walk);
+				free(current);
+				return err;
+			}
+			target[err] = '\0';
+
+			next = erofs_hotfile_join_symlink_target(prefix, target,
+								 suffix);
+			free(target);
+			free(prefix);
+			free(walk);
+			free(current);
+			if (!next)
+				return -ENOMEM;
+			current = next;
+			redirected = true;
+			break;
+		}
+
+		if (!redirected) {
+			free(prefix);
+			free(walk);
+			err = erofs_hotfile_add_plain_path(current, dir_entry,
+							   rank);
+			free(current);
+			return err;
+		}
+	}
+	free(current);
+	return -ELOOP;
+}
+
+static int erofs_hotfile_add(struct erofs_hotfile_entry **paths,
+			     unsigned int *nr, unsigned int *cap,
+			     char *path, unsigned int rank)
+{
+	struct erofs_hotfile_entry *npaths;
+
+	if (*nr >= *cap) {
+		unsigned int ncap = *cap ? *cap * 2 : 64;
+
+		npaths = realloc(*paths, ncap * sizeof(*npaths));
+		if (!npaths)
+			return -ENOMEM;
+		*paths = npaths;
+		*cap = ncap;
+	}
+	(*paths)[*nr].path = path;
+	(*paths)[*nr].rank = rank;
+	++(*nr);
+	return 0;
+}
+
+static int erofs_hotfile_add_file(char *path, unsigned int rank)
+{
+	return erofs_hotfile_add(&hotfile_manifest.file_paths,
+				 &hotfile_manifest.nr_files,
+				 &hotfile_manifest.cap_files,
+				 path, rank);
+}
+
+static int erofs_hotfile_add_dir(char *path, unsigned int rank)
+{
+	return erofs_hotfile_add(&hotfile_manifest.dir_paths,
+				 &hotfile_manifest.nr_dirs,
+				 &hotfile_manifest.cap_dirs,
+				 path, rank);
+}
+
+static int erofs_hotfile_collect_parent_dirs(const char *path,
+					     unsigned int rank)
+{
+	char *dir = strdup(path);
+	int err = 0;
+
+	if (!dir)
+		return -ENOMEM;
+
+	while (1) {
+		char *slash = strrchr(dir, '/');
+
+		if (!slash)
+			break;
+		*slash = '\0';
+		if (!dir[0])
+			break;
+
+		slash = strdup(dir);
+		if (!slash) {
+			err = -ENOMEM;
+			break;
+		}
+		err = erofs_hotfile_add_dir(slash, rank);
+		if (err)
+			break;
+	}
+	free(dir);
+	return err;
+}
+
+static unsigned int erofs_hotfile_sort_dedupe(struct erofs_hotfile_entry *paths,
+					      unsigned int nr)
+{
+	unsigned int i, out = 0;
+
+	if (!nr)
+		return 0;
+
+	qsort(paths, nr, sizeof(paths[0]), erofs_hotfile_cmp);
+	for (i = 0; i < nr; ++i) {
+		if (out && !strcmp(paths[out - 1].path, paths[i].path)) {
+			if (paths[i].rank < paths[out - 1].rank) {
+				free(paths[out - 1].path);
+				paths[out - 1] = paths[i];
+			} else {
+				free(paths[i].path);
+			}
+			continue;
+		}
+		paths[out++] = paths[i];
+	}
+	return out;
+}
+
+int erofs_hotfile_load(const char *path)
+{
+	FILE *fp;
+	char *line = NULL;
+	size_t linesz = 0;
+	ssize_t nread;
+	unsigned int rank = 0;
+	int err = 0;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return -errno;
+
+	while ((nread = getline(&line, &linesz, fp)) >= 0) {
+		char *normalized;
+		bool dir_entry;
+
+		if (!nread)
+			continue;
+		dir_entry = erofs_hotfile_line_is_dir(line);
+		normalized = erofs_hotfile_normalize(line);
+		if (!normalized) {
+			err = -ENOMEM;
+			break;
+		}
+		if ((!normalized[0] && !dir_entry) || normalized[0] == '#') {
+			free(normalized);
+			continue;
+		}
+		err = erofs_hotfile_add_resolved_path(normalized, dir_entry,
+						      rank);
+		free(normalized);
+		if (err)
+			break;
+		++rank;
+	}
+	free(line);
+	fclose(fp);
+	if (err)
+		goto err_out;
+
+	if (!hotfile_manifest.nr_files && !hotfile_manifest.nr_dirs)
+		return 0;
+
+	hotfile_manifest.nr_files = erofs_hotfile_sort_dedupe(
+		hotfile_manifest.file_paths, hotfile_manifest.nr_files);
+	hotfile_manifest.nr_dirs = erofs_hotfile_sort_dedupe(
+		hotfile_manifest.dir_paths, hotfile_manifest.nr_dirs);
+	erofs_info("loaded %u hot files and %u hot ancestor dirs from %s",
+		   hotfile_manifest.nr_files, hotfile_manifest.nr_dirs, path);
+	return 0;
+
+err_out:
+	erofs_hotfile_exit();
+	return err;
+}
+
+bool erofs_hotfile_enabled(void)
+{
+	return hotfile_manifest.nr_files || hotfile_manifest.nr_dirs;
+}
+
+unsigned int erofs_get_hot_file_rank(const char *path)
+{
+	char *normalized;
+	struct erofs_hotfile_entry *found;
+	const char *fspath;
+	unsigned int rank = EROFS_HOT_RANK_NONE;
+
+	if (!erofs_hotfile_enabled())
+		return EROFS_HOT_RANK_NONE;
+
+	fspath = erofs_fspath(path);
+	normalized = erofs_hotfile_normalize(fspath);
+	if (!normalized)
+		return EROFS_HOT_RANK_NONE;
+
+	found = bsearch(normalized, hotfile_manifest.file_paths,
+			hotfile_manifest.nr_files,
+			sizeof(hotfile_manifest.file_paths[0]),
+			erofs_hotfile_path_cmp);
+	if (found)
+		rank = found->rank;
+
+	if (rank != 0 && hotfile_manifest.nr_files) {
+		char *root = NULL;
+		char *fullpath = NULL;
+		struct stat st;
+
+		if (erofs_hotfile_is_local_rootfs(&root) &&
+		    asprintf(&fullpath, "%s/%s", root, normalized) >= 0 &&
+		    lstat(fullpath, &st) == 0 && S_ISLNK(st.st_mode)) {
+			char *resolved = realpath(fullpath, NULL);
+
+			if (resolved && !strncmp(resolved, root, strlen(root)) &&
+			    resolved[strlen(root)] == '/') {
+				char *resolved_norm =
+					erofs_hotfile_normalize(resolved + strlen(root));
+
+				if (resolved_norm) {
+					struct erofs_hotfile_entry *resolved_found;
+
+					resolved_found = bsearch(resolved_norm,
+						hotfile_manifest.file_paths,
+						hotfile_manifest.nr_files,
+						sizeof(hotfile_manifest.file_paths[0]),
+						erofs_hotfile_path_cmp);
+					if (resolved_found && resolved_found->rank < rank)
+						rank = resolved_found->rank;
+					free(resolved_norm);
+				}
+			}
+			free(resolved);
+		}
+		free(fullpath);
+	}
+	free(normalized);
+	return rank;
+}
+
+unsigned int erofs_get_hot_dir_rank(const char *path)
+{
+	char *normalized;
+	struct erofs_hotfile_entry *found;
+	const char *fspath;
+
+	if (!erofs_hotfile_enabled())
+		return EROFS_HOT_RANK_NONE;
+
+	fspath = erofs_fspath(path);
+	normalized = erofs_hotfile_normalize(fspath);
+	if (!normalized)
+		return EROFS_HOT_RANK_NONE;
+
+	found = bsearch(normalized, hotfile_manifest.dir_paths,
+			hotfile_manifest.nr_dirs,
+			sizeof(hotfile_manifest.dir_paths[0]),
+			erofs_hotfile_path_cmp);
+	free(normalized);
+	return found ? found->rank : EROFS_HOT_RANK_NONE;
+}
+
+void erofs_hotfile_exit(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < hotfile_manifest.nr_files; ++i)
+		free(hotfile_manifest.file_paths[i].path);
+	for (i = 0; i < hotfile_manifest.nr_dirs; ++i)
+		free(hotfile_manifest.dir_paths[i].path);
+	free(hotfile_manifest.file_paths);
+	free(hotfile_manifest.dir_paths);
+	hotfile_manifest.file_paths = NULL;
+	hotfile_manifest.nr_files = 0;
+	hotfile_manifest.cap_files = 0;
+	hotfile_manifest.dir_paths = NULL;
+	hotfile_manifest.nr_dirs = 0;
+	hotfile_manifest.cap_dirs = 0;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 95fd93b..cabe085 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -24,6 +24,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/hotfile.h"
 #include "erofs/importer.h"
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
@@ -661,10 +662,20 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	remaining = inode->i_size - inode->idata_size;
 
-	ret = erofs_allocate_inode_bh_data(inode, remaining >> sbi->blkszbits,
-					   in_metazone);
-	if (ret)
-		return ret;
+	/*
+	 * Hot directories may have their main data block pre-allocated
+	 * during hot-queue processing so that its physical offset is
+	 * placed inside the hot region. Reuse it rather than re-balloc,
+	 * which would leak the pre-allocated buffer and defeat the
+	 * layout intent.
+	 */
+	if (!inode->bh_data) {
+		ret = erofs_allocate_inode_bh_data(inode,
+						   remaining >> sbi->blkszbits,
+						   in_metazone);
+		if (ret)
+			return ret;
+	}
 
 	bh = inode->bh_data;
 	if (bh) {
@@ -1008,7 +1019,8 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 		goto noinline;
 
 	if (!is_inode_layout_compression(inode)) {
-		if (params->no_datainline && S_ISREG(inode->i_mode)) {
+		if (S_ISREG(inode->i_mode) &&
+		    (params->no_datainline || erofs_inode_is_hotfile(inode))) {
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			goto noinline;
 		}
@@ -1351,6 +1363,15 @@ static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode
 		if (!inode->i_srcpath)
 			return -ENOMEM;
 	}
+	inode->hot_rank = EROFS_HOT_RANK_NONE;
+	if (!erofs_is_special_identifier(path)) {
+		inode->hot_rank = erofs_get_hot_file_rank(path);
+		inode->hotfile = inode->hot_rank != EROFS_HOT_RANK_NONE;
+		if (!inode->hotfile && S_ISDIR(st->st_mode)) {
+			inode->hot_rank = erofs_get_hot_dir_rank(path);
+			inode->hotdir = inode->hot_rank != EROFS_HOT_RANK_NONE;
+		}
+	}
 
 	if (erofs_should_use_inode_extended(im, inode, path)) {
 		if (params->force_inodeversion == EROFS_FORCE_INODE_COMPACT) {
@@ -1410,11 +1431,28 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 	 * lookup in hash table first, if it already exists we have a
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
+	 *
+	 * When a hard-linked inode has already been created via another
+	 * name, only that first name's hotfile rank was recorded. If the
+	 * current name is listed in the hotlist with a lower rank (= hotter
+	 * priority), adopt it so the shared inode gets the hottest rank
+	 * across all of its hard-links. Without this, an inode shared by
+	 * cold + hot paths (e.g. /usr/share/zoneinfo/Asia/Chongqing shared
+	 * with .../Shanghai, only Shanghai is hot) ends up with no hot rank
+	 * and gets placed in the cold region, blowing up the hot-zone end
+	 * to near the full image size.
 	 */
 	if (!S_ISDIR(st.st_mode) && !params->hard_dereference) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
-		if (inode)
+		if (inode) {
+			u32 rank = erofs_get_hot_file_rank(path);
+
+			if (rank != EROFS_HOT_RANK_NONE && rank < inode->hot_rank) {
+				inode->hot_rank = rank;
+				inode->hotfile = true;
+			}
 			return inode;
+		}
 	}
 
 	/* cannot find in the inode cache */
@@ -1612,6 +1650,42 @@ static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
 	if (ret)
 		return ret;
 	inode->bh->op = &erofs_skip_write_bhops;
+
+	/*
+	 * For hot directories, also pre-allocate the main dentry data
+	 * block right now (while we are still in the hot-queue stage),
+	 * so that its physical offset falls inside the hot region.
+	 * Otherwise the main dentry block would be ballocated lazily by
+	 * erofs_write_unencoded_data() during the later cold-dir dump
+	 * pass, landing well past the hot prefix and breaking path
+	 * lookups such as /usr/bin/sh when the image is head-truncated
+	 * to the hot prefix.
+	 *
+	 * A directory is treated as hot here when it has any hot rank,
+	 * either because it was listed as a hot dir (trailing slash) or
+	 * because a caller accidentally listed it as a hot file (no
+	 * trailing slash). In both cases the user signalled that the
+	 * lookup path passes through this directory, so its dentry
+	 * block must be reachable from the hot prefix.
+	 *
+	 * Only uncompressed FLAT_{INLINE,PLAIN} dirs have a separate
+	 * main data extent; compressed dirs carry all bytes via the
+	 * compression path and do not go through erofs_balloc(DIRA).
+	 */
+	if ((inode->hotdir || inode->hotfile) &&
+	    inode->hot_rank != EROFS_HOT_RANK_NONE &&
+	    (inode->datalayout == EROFS_INODE_FLAT_INLINE ||
+	     inode->datalayout == EROFS_INODE_FLAT_PLAIN)) {
+		u64 remaining = inode->i_size - inode->idata_size;
+
+		if (remaining) {
+			ret = erofs_allocate_inode_bh_data(inode,
+					remaining >> inode->sbi->blkszbits,
+					ctx->im->params->dirdata_in_metazone);
+			if (ret)
+				return ret;
+		}
+	}
 	return 0;
 }
 
@@ -2129,18 +2203,176 @@ static void erofs_mark_parent_inode(struct erofs_inode *inode,
 	inode->i_parent = (void *)((unsigned long)dir | 1);
 }
 
+struct erofs_mkfs_hot_item {
+	struct erofs_mkfs_hot_item *next;
+	struct erofs_inode *parent;
+	struct erofs_inode *inode;
+	unsigned int priority;
+	unsigned int rank;
+	unsigned int order;
+};
+
+static unsigned int erofs_mkfs_inode_rank(struct erofs_inode *inode)
+{
+	/*
+	 * A directory that the user listed without a trailing slash
+	 * ends up with hotfile=true/hotdir=false but still carries a
+	 * valid hot_rank. Treat it as a hot directory here so its
+	 * metadata (including the pre-allocated dentry data block)
+	 * participates in the hot-queue layout. Otherwise the dentry
+	 * block is emitted during the later cold-dir pass and falls
+	 * outside the hot prefix.
+	 */
+	if ((!S_ISDIR(inode->i_mode) && erofs_inode_is_hotfile(inode)) ||
+	    (S_ISDIR(inode->i_mode) &&
+	     (inode->hotdir || inode->hotfile)))
+		return inode->hot_rank;
+	return EROFS_HOT_RANK_NONE;
+}
+
+static unsigned int erofs_mkfs_hot_item_priority(struct erofs_inode *inode)
+{
+	/* Path lookup needs hot directory and symlink metadata before file data. */
+	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
+		return 0;
+	return 1;
+}
+
+static int erofs_mkfs_enqueue_hot_item(struct erofs_mkfs_hot_item **queue,
+				       struct erofs_inode *parent,
+				       struct erofs_inode *inode,
+				       unsigned int *order)
+{
+	struct erofs_mkfs_hot_item *item, **pos = queue;
+
+	item = malloc(sizeof(*item));
+	if (!item)
+		return -ENOMEM;
+
+	item->parent = parent;
+	item->inode = inode;
+	item->priority = erofs_mkfs_hot_item_priority(inode);
+	item->rank = erofs_mkfs_inode_rank(inode);
+	item->order = (*order)++;
+	item->next = NULL;
+
+	while (*pos) {
+		if (item->priority < (*pos)->priority)
+			break;
+		if (item->priority > (*pos)->priority) {
+			pos = &(*pos)->next;
+			continue;
+		}
+		if (item->rank < (*pos)->rank)
+			break;
+		if (item->rank == (*pos)->rank &&
+		    item->order < (*pos)->order)
+			break;
+		pos = &(*pos)->next;
+	}
+	item->next = *pos;
+	*pos = item;
+	return 0;
+}
+
+static int erofs_mkfs_enqueue_hot_children(struct erofs_inode *dir,
+					   struct erofs_mkfs_hot_item **queue,
+					   unsigned int *order)
+{
+	struct erofs_dentry *d;
+
+	list_for_each_entry(d, &dir->i_subdirs, d_child) {
+		struct erofs_inode *inode = d->inode;
+		int err;
+
+		if (is_dot_dotdot(d->name) ||
+		    (d->flags & EROFS_DENTRY_FLAG_VALIDNID))
+			continue;
+		if (erofs_mkfs_inode_rank(inode) == EROFS_HOT_RANK_NONE)
+			continue;
+		err = erofs_mkfs_enqueue_hot_item(queue, dir, inode, order);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int erofs_mkfs_dump_tree_default(const struct erofs_mkfs_btctx *ctx,
+					struct erofs_inode *dumpdir,
+					struct list_head *pending_dirs,
+					bool grouped_dirdata)
+{
+	int err = 0, err2;
+
+	do {
+		struct erofs_inode *dir = dumpdir;
+		/* used for adding sub-directories in reverse order due to FIFO */
+		struct erofs_inode *head, **last = &head;
+		struct erofs_dentry *d;
+
+		dumpdir = dir->next_dirwrite;
+		list_for_each_entry(d, &dir->i_subdirs, d_child) {
+			struct erofs_inode *inode = d->inode;
+
+			if (is_dot_dotdot(d->name) ||
+			    (d->flags & EROFS_DENTRY_FLAG_VALIDNID))
+				continue;
+
+			if (!erofs_inode_visited(inode)) {
+				DBG_BUGON(ctx->rebuild && (inode->i_nlink == 1 ||
+					  S_ISDIR(inode->i_mode)) &&
+					  erofs_parent_inode(inode) != dir);
+				erofs_mark_parent_inode(inode, dir);
+
+				err = erofs_mkfs_handle_inode(ctx, inode);
+				if (err)
+					break;
+				if (S_ISDIR(inode->i_mode)) {
+					inode->next_dirwrite = NULL;
+					*last = inode;
+					last = &inode->next_dirwrite;
+					(void)erofs_igrab(inode);
+				}
+			} else if (!ctx->rebuild) {
+				++inode->i_nlink;
+			}
+		}
+		*last = dumpdir;	/* fixup the last (or the only) one */
+		dumpdir = head;
+		err2 = grouped_dirdata ?
+			erofs_mkfs_push_pending_job(pending_dirs,
+				EROFS_MKFS_JOB_DIR_BH, &dir, sizeof(dir)) :
+			erofs_mkfs_go(ctx, EROFS_MKFS_JOB_DIR_BH,
+				      &dir, sizeof(dir));
+		if (err || err2) {
+			if (!err)
+				err = err2;
+			break;
+		}
+	} while (dumpdir);
+	err2 = erofs_mkfs_flush_pending_jobs(ctx, pending_dirs);
+	return err ? err : err2;
+}
+
 static int erofs_mkfs_dump_tree(const struct erofs_mkfs_btctx *ctx)
 {
 	struct erofs_importer *im = ctx->im;
 	struct erofs_inode *root = im->root;
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
+	struct erofs_inode *deferdir = NULL, **deferlast = &deferdir;
+	struct erofs_mkfs_hot_item *hot_queue = NULL;
 	bool grouped_dirdata = im->params->grouped_dirdata;
 	LIST_HEAD(pending_dirs);
+	unsigned int hot_order = 0;
 	int err, err2;
 
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
+	if (erofs_hotfile_enabled()) {
+		root->hotdir = true;
+		root->hot_rank = 0;
+	}
 	/* update dev/i_ino[1] to keep track of the base image */
 	if (ctx->incremental) {
 		root->dev = root->sbi->dev;
@@ -2168,13 +2400,46 @@ static int erofs_mkfs_dump_tree(const struct erofs_mkfs_btctx *ctx)
 		sbi->root_nid = root->nid;
 	}
 
+	if (!erofs_hotfile_enabled())
+		return erofs_mkfs_dump_tree_default(ctx, dumpdir, &pending_dirs,
+						    grouped_dirdata);
+
+	err = erofs_mkfs_enqueue_hot_children(root, &hot_queue, &hot_order);
+	if (err)
+		goto out_hot;
+
+	while (hot_queue) {
+		struct erofs_mkfs_hot_item *item = hot_queue;
+		struct erofs_inode *inode = item->inode;
+		struct erofs_inode *parent = item->parent;
+
+		hot_queue = item->next;
+		free(item);
+
+		if (!erofs_inode_visited(inode)) {
+			erofs_mark_parent_inode(inode, parent);
+			err = erofs_mkfs_handle_inode(ctx, inode);
+			if (err)
+				goto out_hot;
+			if (S_ISDIR(inode->i_mode)) {
+				err = erofs_mkfs_enqueue_hot_children(inode,
+								      &hot_queue,
+								      &hot_order);
+				if (err)
+					goto out_hot;
+				inode->hotdir_deferred = true;
+			}
+		}
+	}
+
 	do {
 		struct erofs_inode *dir = dumpdir;
-		/* used for adding sub-directories in reverse order due to FIFO */
 		struct erofs_inode *head, **last = &head;
 		struct erofs_dentry *d;
 
+		err2 = 0;
 		dumpdir = dir->next_dirwrite;
+		dir->next_dirwrite = NULL;
 		list_for_each_entry(d, &dir->i_subdirs, d_child) {
 			struct erofs_inode *inode = d->inode;
 
@@ -2192,16 +2457,37 @@ static int erofs_mkfs_dump_tree(const struct erofs_mkfs_btctx *ctx)
 				if (err)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
+					inode->next_dirwrite = NULL;
 					*last = inode;
 					last = &inode->next_dirwrite;
 					(void)erofs_igrab(inode);
 				}
-			} else if (!ctx->rebuild) {
-				++inode->i_nlink;
+			} else {
+				if (S_ISDIR(inode->i_mode) &&
+				    inode->hotdir_deferred) {
+					inode->hotdir_deferred = false;
+					inode->next_dirwrite = NULL;
+					/*
+					 * A hot directory means its own metadata is hot;
+					 * it must not recursively promote all cold
+					 * children beneath it.
+					 */
+					*deferlast = inode;
+					deferlast = &inode->next_dirwrite;
+					(void)erofs_igrab(inode);
+				}
+				if (!ctx->rebuild &&
+				    erofs_parent_inode(inode) != dir)
+					++inode->i_nlink;
 			}
 		}
-		*last = dumpdir;	/* fixup the last (or the only) one */
+		*last = dumpdir;
 		dumpdir = head;
+		if (!dumpdir && deferdir) {
+			dumpdir = deferdir;
+			deferdir = NULL;
+			deferlast = &deferdir;
+		}
 		err2 = grouped_dirdata ?
 			erofs_mkfs_push_pending_job(&pending_dirs,
 				EROFS_MKFS_JOB_DIR_BH, &dir, sizeof(dir)) :
@@ -2214,6 +2500,13 @@ static int erofs_mkfs_dump_tree(const struct erofs_mkfs_btctx *ctx)
 		}
 	} while (dumpdir);
 	err2 = erofs_mkfs_flush_pending_jobs(ctx, &pending_dirs);
+out_hot:
+	while (hot_queue) {
+		struct erofs_mkfs_hot_item *item = hot_queue;
+
+		hot_queue = item->next;
+		free(item);
+	}
 	return err ? err : err2;
 }
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 65ec807..393a293 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -310,6 +310,19 @@ random gzip access. Source file must be a gzip-compressed tarball.
 .BI "\-\-hard-dereference"
 Dereference hardlinks and add links as separate inodes.
 .TP
+.BI "\-\-hot-file-list=" path
+Read a newline-delimited list of image-relative hot file paths for local
+directory sources.
+Hot regular files are scheduled before cold files while keeping compression
+enabled.  Parent directories of listed files are also prioritized so hot
+subtrees are traversed earlier than cold sibling subtrees.  Entries ending in
+\fI/\fR are treated as hot directories: the directory inode and directory data
+are prioritized, but children are not recursively marked hot.  Hot files do not
+participate in fragment packing or cross-file dedupe.  Symlink aliases in the
+source tree are resolved before matching, so merged-usr compatibility paths such
+as \fI/lib/...\fR can match their real payloads under \fI/usr/lib/...\fR while
+preserving the user-provided order.
+.TP
 .B "\-\-ignore-mtime"
 Ignore the file modification time whenever it would cause \fBmkfs.erofs\fR to
 use extended inodes over compact inodes. When not using a fixed timestamp, this
diff --git a/mkfs/main.c b/mkfs/main.c
index 31fea7c..c154247 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/hotfile.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "../lib/compressor.h"
@@ -103,9 +104,12 @@ static struct option long_options[] = {
 	{"MZ", optional_argument, NULL, 537},
 	{"xattr-prefix", required_argument, NULL, 538},
 	{"xattr-inode-digest", required_argument, NULL, 539},
+	{"hot-file-list", required_argument, NULL, 540},
 	{0, 0, 0, 0},
 };
 
+static char *hotfile_list_path;
+
 static void print_available_compressors(FILE *f, const char *delim)
 {
 	int i = 0;
@@ -208,6 +212,11 @@ static void usage(int argc, char **argv)
 		" --uid-offset=#         add offset # to all file uids (# = id offset)\n"
 		" --gid-offset=#         add offset # to all file gids (# = id offset)\n"
 		" --hard-dereference     dereference hardlinks, add links as separate inodes\n"
+		" --hot-file-list=X      specify newline-separated hot file paths for\n"
+		"                        local directory sources; local rootfs builds\n"
+		"                        resolve symlink aliases\n"
+		"                        (e.g. /lib/... -> /usr/lib/...) and prioritize\n"
+		"                        ancestor directories as well\n"
 		" --ignore-mtime         use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#   set maximum decompressed extent size # in bytes\n"
 		" --mount-point=X        X=prefix of target fs path (default: /)\n"
@@ -1487,6 +1496,12 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				return err;
 			}
 			break;
+		case 540:
+			free(hotfile_list_path);
+			hotfile_list_path = strdup(optarg);
+			if (!hotfile_list_path)
+				return -ENOMEM;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1542,6 +1557,11 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			return err;
 	}
 
+	if (hotfile_list_path && source_mode != EROFS_MKFS_SOURCE_LOCALDIR) {
+		erofs_err("--hot-file-list is only supported for local directory sources");
+		return -EOPNOTSUPP;
+	}
+
 	if (quiet) {
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
@@ -1778,6 +1798,15 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (hotfile_list_path) {
+		err = erofs_hotfile_load(hotfile_list_path);
+		if (err) {
+			erofs_err("failed to load hot-file list %s: %s",
+				  hotfile_list_path, erofs_strerror(err));
+			goto exit;
+		}
+	}
+
 	err = parse_source_date_epoch();
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
@@ -2065,6 +2094,9 @@ exit:
 		fclose(blklst);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
+	erofs_hotfile_exit();
+	free(hotfile_list_path);
+	hotfile_list_path = NULL;
 	if (cfg.c_chunkbits || source_mode == EROFS_MKFS_SOURCE_REBUILD)
 		erofs_blob_exit();
 	erofs_xattr_cleanup_name_prefixes();
diff --git a/tests/hotfile-layout.sh b/tests/hotfile-layout.sh
new file mode 100755
index 0000000..6af3f41
--- /dev/null
+++ b/tests/hotfile-layout.sh
@@ -0,0 +1,321 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+set -eu
+
+MKFS=${MKFS:-./mkfs/mkfs.erofs}
+DUMP=${DUMP:-./dump/dump.erofs}
+
+tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/erofs-hotfile-layout.XXXXXX")
+cleanup() {
+	rm -rf "$tmpdir"
+}
+trap cleanup EXIT
+
+extent_start() {
+	"$DUMP" -e --path="$1" "$2" |
+		awk '
+			/^[[:space:]]+[0-9]+:/ {
+				line = $0
+				sub(/^.*\|[[:space:]]*[0-9]+[[:space:]]*:[[:space:]]*/, "", line)
+				sub(/\.\..*$/, "", line)
+				gsub(/[[:space:]]/, "", line)
+				print line
+				exit
+			}
+		'
+}
+
+inode_links() {
+	"$DUMP" --path="$1" "$2" |
+		awk '
+			/Links:/ {
+				for (i = 1; i <= NF; ++i) {
+					if ($i == "Links:") {
+						print $(i + 1)
+						exit
+					}
+				}
+			}
+		'
+}
+
+assert_hot_file_nonrecursive_hotdir() {
+	img="$1"
+
+	hot=$(extent_start /a/hot "$img")
+	hotdir_cold=$(extent_start /a/cold "$img")
+	outside_cold=$(extent_start /c/cold "$img")
+
+	if [ "$hot" -ge "$hotdir_cold" ]; then
+		echo "hot file was not placed before cold sibling: hot=$hot cold=$hotdir_cold" >&2
+		exit 1
+	fi
+
+	if [ "$outside_cold" -ge "$hotdir_cold" ]; then
+		echo "hot directory promoted cold child recursively: outside=$outside_cold hotdir_cold=$hotdir_cold" >&2
+		exit 1
+	fi
+}
+
+assert_explicit_hotdir_nonrecursive() {
+	img="$1"
+
+	hotdir_cold=$(extent_start /a/cold "$img")
+	outside_cold=$(extent_start /c/cold "$img")
+
+	if [ "$outside_cold" -ge "$hotdir_cold" ]; then
+		echo "explicit hot directory promoted cold child recursively: outside=$outside_cold hotdir_cold=$hotdir_cold" >&2
+		exit 1
+	fi
+}
+
+assert_symlink_chain_metadata_hot() {
+	img="$1"
+	log="$2"
+
+	parent_link=$(extent_start /lib64 "$img")
+	parent_cold=$(extent_start /aaa-cold "$img")
+	symlink=$(extent_start /usr/lib64/ld-linux-x86-64.so.2 "$img")
+	cold=$(extent_start /usr/lib64/aaa-cold "$img")
+	real=$(extent_start /usr/lib/x86_64-linux-gnu/ld-real "$img")
+
+	if ! grep -q 'loaded 3 hot files' "$log"; then
+		echo "hot symlink chain did not preserve parent link, symlink, and target as hot files" >&2
+		cat "$log" >&2
+		exit 1
+	fi
+
+	if [ "$parent_link" -ge "$parent_cold" ]; then
+		echo "hot parent symlink metadata was not placed before cold sibling: parent_link=$parent_link parent_cold=$parent_cold" >&2
+		exit 1
+	fi
+
+	if [ "$symlink" -ge "$cold" ]; then
+		echo "hot symlink metadata was not placed before cold sibling: symlink=$symlink cold=$cold" >&2
+		exit 1
+	fi
+
+	if [ "$real" -ge "$cold" ]; then
+		echo "hot symlink target was not placed before cold sibling: real=$real cold=$cold" >&2
+		exit 1
+	fi
+}
+
+assert_hot_metadata_precedes_regular_data() {
+	img="$1"
+
+	hotfile=$(extent_start /a/hot "$img")
+	hotdir=$(extent_start /z "$img")
+
+	if [ "$hotdir" -ge "$hotfile" ]; then
+		echo "hot metadata was not placed before regular hot file data: hotdir=$hotdir hotfile=$hotfile" >&2
+		exit 1
+	fi
+}
+
+assert_late_hotdirs_precede_regular_hotfile() {
+	img="$1"
+
+	sysdir=$(extent_start /sys "$img")
+	devdir=$(extent_start /dev "$img")
+	liblink=$(extent_start /lib "$img")
+	lib64link=$(extent_start /lib64 "$img")
+	node=$(extent_start /usr/local/bin/node "$img")
+
+	if [ "$liblink" -ge "$node" ]; then
+		echo "late hot /lib symlink metadata was placed after node data: lib=$liblink node=$node" >&2
+		exit 1
+	fi
+
+	if [ "$lib64link" -ge "$node" ]; then
+		echo "late hot /lib64 symlink metadata was placed after node data: lib64=$lib64link node=$node" >&2
+		exit 1
+	fi
+
+	if [ "$sysdir" -ge "$node" ]; then
+		echo "late hot /sys metadata was placed after node data: sys=$sysdir node=$node" >&2
+		exit 1
+	fi
+
+	if [ "$devdir" -ge "$node" ]; then
+		echo "late hot /dev metadata was placed after node data: dev=$devdir node=$node" >&2
+		exit 1
+	fi
+}
+
+assert_late_symlink_alias_inherits_target_rank() {
+	img="$1"
+
+	alias=$(extent_start /usr/lib/x86_64-linux-gnu/libfoo.so.1 "$img")
+	node=$(extent_start /usr/local/bin/node "$img")
+
+	if [ "$alias" -ge "$node" ]; then
+		echo "late hot symlink alias was placed after node data: alias=$alias node=$node" >&2
+		exit 1
+	fi
+}
+
+assert_hot_hardlinks_keep_real_link_count() {
+	img="$1"
+
+	links=$(inode_links /a/hot "$img")
+
+	if [ "$links" -ne 2 ]; then
+		echo "hot hardlink aliases changed link count: links=$links" >&2
+		exit 1
+	fi
+}
+
+assert_root_dirdata_precedes_hot_file() {
+	img="$1"
+
+	rootdir=$(extent_start / "$img")
+	hotfile=$(extent_start /zz/hot "$img")
+
+	if [ "$rootdir" -ge "$hotfile" ]; then
+		echo "root directory data was placed after hot file data: root=$rootdir hotfile=$hotfile" >&2
+		exit 1
+	fi
+}
+
+root="$tmpdir/root"
+mkdir -p "$root/a" "$root/c"
+printf hot > "$root/a/hot"
+dd if=/dev/zero bs=4096 count=16 of="$root/a/cold" status=none
+dd if=/dev/zero bs=4096 count=16 of="$root/c/cold" status=none
+
+printf '/a/hot\n' > "$tmpdir/hotlist.file"
+"$MKFS" -zlz4hc,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.file" \
+	"$tmpdir/img.file.erofs" "$root" >/dev/null
+assert_hot_file_nonrecursive_hotdir "$tmpdir/img.file.erofs"
+
+printf '/a/\n' > "$tmpdir/hotlist.dir"
+"$MKFS" -zlz4hc,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.dir" \
+	"$tmpdir/img.dir.erofs" "$root" >/dev/null
+assert_explicit_hotdir_nonrecursive "$tmpdir/img.dir.erofs"
+
+mkdir -p "$root/usr/lib/x86_64-linux-gnu" "$root/usr/lib64"
+printf real > "$root/usr/lib/x86_64-linux-gnu/ld-real"
+dd if=/dev/zero bs=4096 count=16 of="$root/aaa-cold" status=none
+dd if=/dev/zero bs=4096 count=16 of="$root/usr/lib64/aaa-cold" status=none
+ln -s usr/lib64 "$root/lib64"
+ln -s /lib/x86_64-linux-gnu/ld-real "$root/usr/lib64/ld-linux-x86-64.so.2"
+
+printf '/lib64/ld-linux-x86-64.so.2\n' > "$tmpdir/hotlist.symlink"
+"$MKFS" -d9 -zlz4hc,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.symlink" \
+	"$tmpdir/img.symlink.erofs" "$root" >"$tmpdir/mkfs.symlink.log" 2>&1
+assert_symlink_chain_metadata_hot "$tmpdir/img.symlink.erofs" "$tmpdir/mkfs.symlink.log"
+
+root_meta="$tmpdir/root-meta-first"
+mkdir -p "$root_meta/a" "$root_meta/z"
+dd if=/dev/urandom bs=4096 count=256 of="$root_meta/a/hot" status=none
+printf '/a/hot\n/z/\n' > "$tmpdir/hotlist.meta-first"
+"$MKFS" -d9 -zzstd,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.meta-first" \
+	"$tmpdir/img.meta-first.erofs" "$root_meta" >"$tmpdir/mkfs.meta-first.log" 2>&1
+assert_hot_metadata_precedes_regular_data "$tmpdir/img.meta-first.erofs"
+
+root_usrmerge="$tmpdir/root-usrmerge"
+mkdir -p \
+	"$root_usrmerge/dev" \
+	"$root_usrmerge/etc/ssl" \
+	"$root_usrmerge/proc" \
+	"$root_usrmerge/sys" \
+	"$root_usrmerge/usr/bin" \
+	"$root_usrmerge/usr/lib/x86_64-linux-gnu" \
+	"$root_usrmerge/usr/lib64" \
+	"$root_usrmerge/usr/local/bin" \
+	"$root_usrmerge/usr/local/sbin"
+ln -s usr/bin "$root_usrmerge/bin"
+ln -s usr/lib "$root_usrmerge/lib"
+ln -s usr/lib64 "$root_usrmerge/lib64"
+ln -s dash "$root_usrmerge/usr/bin/sh"
+ln -s /lib/x86_64-linux-gnu/ld-real "$root_usrmerge/usr/lib64/ld-linux-x86-64.so.2"
+for file in \
+	etc/passwd \
+	etc/ld.so.cache \
+	etc/ssl/openssl.cnf \
+	usr/bin/dash \
+	usr/lib/x86_64-linux-gnu/ld-real \
+	usr/lib/x86_64-linux-gnu/libc.so.6 \
+	usr/lib/x86_64-linux-gnu/libdl.so.2 \
+	usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
+	usr/lib/x86_64-linux-gnu/libm.so.6 \
+	usr/lib/x86_64-linux-gnu/libgcc_s.so.1 \
+	usr/lib/x86_64-linux-gnu/libpthread.so.0 \
+	usr/local/bin/docker-entrypoint.sh \
+	usr/local/bin/node \
+	usr/local/sbin/docker-entrypoint.sh; do
+	printf x > "$root_usrmerge/$file"
+done
+cat > "$tmpdir/hotlist.usrmerge" <<'EOF'
+/etc/passwd
+/proc/
+/usr/local/sbin/docker-entrypoint.sh
+/usr/local/bin/docker-entrypoint.sh
+/bin/sh
+/lib64/ld-linux-x86-64.so.2
+/etc/ld.so.preload
+/etc/ld.so.cache
+/lib/x86_64-linux-gnu/libc.so.6
+/usr/local/sbin/node
+/usr/local/bin/node
+/lib/x86_64-linux-gnu/libdl.so.2
+/lib/x86_64-linux-gnu/libstdc++.so.6
+/lib/x86_64-linux-gnu/libm.so.6
+/lib/x86_64-linux-gnu/libgcc_s.so.1
+/lib/x86_64-linux-gnu/libpthread.so.0
+/etc/ssl/openssl.cnf
+/sys/
+/dev/
+EOF
+"$MKFS" -d9 -zzstd,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.usrmerge" \
+	"$tmpdir/img.usrmerge.erofs" "$root_usrmerge" >"$tmpdir/mkfs.usrmerge.log" 2>&1
+assert_late_hotdirs_precede_regular_hotfile "$tmpdir/img.usrmerge.erofs"
+
+root_alias="$tmpdir/root-alias-rank"
+mkdir -p "$root_alias/usr/lib/x86_64-linux-gnu" "$root_alias/usr/local/bin"
+dd if=/dev/zero bs=4096 count=64 of="$root_alias/usr/local/bin/node" status=none
+dd if=/dev/zero bs=4096 count=64 of="$root_alias/usr/lib/x86_64-linux-gnu/libfoo.so.1.2.3" status=none
+ln -s libfoo.so.1.2.3 "$root_alias/usr/lib/x86_64-linux-gnu/libfoo.so.1"
+cat > "$tmpdir/hotlist.alias-rank" <<'EOF'
+/usr/lib/x86_64-linux-gnu/libfoo.so.1.2.3
+/usr/local/bin/node
+/usr/lib/x86_64-linux-gnu/libfoo.so.1
+EOF
+"$MKFS" -d9 -zzstd,level=9 --workers=1 \
+	--hot-file-list="$tmpdir/hotlist.alias-rank" \
+	"$tmpdir/img.alias-rank.erofs" "$root_alias" >"$tmpdir/mkfs.alias-rank.log" 2>&1
+assert_late_symlink_alias_inherits_target_rank "$tmpdir/img.alias-rank.erofs"
+
+root_hardlink="$tmpdir/root-hardlink"
+mkdir -p "$root_hardlink/a" "$root_hardlink/b"
+printf data > "$root_hardlink/a/hot"
+ln "$root_hardlink/a/hot" "$root_hardlink/b/alias"
+cat > "$tmpdir/hotlist.hardlink" <<'EOF'
+/a/hot
+/b/alias
+EOF
+"$MKFS" -d9 --hot-file-list="$tmpdir/hotlist.hardlink" \
+	"$tmpdir/img.hardlink.erofs" "$root_hardlink" >"$tmpdir/mkfs.hardlink.log" 2>&1
+assert_hot_hardlinks_keep_real_link_count "$tmpdir/img.hardlink.erofs"
+
+root_wide="$tmpdir/root-wide"
+mkdir -p "$root_wide/zz"
+printf hot > "$root_wide/zz/hot"
+i=0
+while [ "$i" -lt 420 ]; do
+	dir=$(printf 'cold%04d' "$i")
+	mkdir -p "$root_wide/$dir"
+	printf x > "$root_wide/$dir/file"
+	i=$((i + 1))
+done
+printf '/zz/hot\n' > "$tmpdir/hotlist.wide-root"
+"$MKFS" -d9 --hot-file-list="$tmpdir/hotlist.wide-root" \
+	"$tmpdir/img.wide-root.erofs" "$root_wide" >"$tmpdir/mkfs.wide-root.log" 2>&1
+assert_root_dirdata_precedes_hot_file "$tmpdir/img.wide-root.erofs"

base-commit: 8a579d4d692689eee0af40df91d91d4e632d4c0e
-- 
2.43.7


