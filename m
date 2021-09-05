Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E89401116
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Sep 2021 20:00:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H2fT32HjXz2yHq
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 04:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WghqN1yy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WghqN1yy; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H2fSw3Xg8z2xrx
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Sep 2021 04:00:16 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB6E760EC0;
 Sun,  5 Sep 2021 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630864813;
 bh=RBx5H8d86ccdlNM7LkBMcI4K9cRsJQjamrEbvQGVG04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WghqN1yyVACiNX7Ka7J0/SoFHMVRi3CwAq4AtDsQr7LAuG0aJQf6bsgjbiSL5FlEw
 mTpVqY+jwrTepT6tNwyUI6lmO6vykmASifDimUNJpdpOwKUubAdhBjCidMN9n0T7Lw
 /FcvYqS7djED4OkVeDTdxI/ya7zbNlqzEj0W+TXswFoAbi/9+SUzxXnqHIZpsP9ViJ
 Ju6tNdd7HEBSolYaYQlsPztChqQI8VtqF4+/Sbxox3q7+JsrqD+aIduinI/1Ttvn+L
 mnmnjFuzPS3al9HvAU9fkVZZeFpRICETPSu5Q2l1mexxe0nzTrZHE1wNNhALpLV7On
 fHyxYDo/07XLw==
Date: Mon, 6 Sep 2021 01:59:30 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v3] erofs-utils: support per-inode compress pcluster
Message-ID: <20210905175919.GA24755@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210818042715.24416-1-huangjianan@oppo.com>
 <20210825033523.20058-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825033523.20058-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 25, 2021 at 11:35:23AM +0800, Huang Jianan via Linux-erofs wrote:
> Add an option to configure per-inode compression strategy. Each line
> of the file should be in the following form:
> 
> <Regular-expression> <pcluster-in-bytes>
> 
> When pcluster is 0, it means that the file shouldn't be compressed.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
> changes since v2:
>  - change compress_rule to compress_hints for better understanding. (Gao Xiang)
>  - use default "-C" value when input physical clustersize is invalid. (Gao Xiang)
>  - change the val of WITH_ANDROID option to a separated patch. (Gao Xiang)
> 
> changes since v1:
>  - rename c_pclusterblks to c_physical_clusterblks and place it in union.
>  - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster() since
>    it's per-inode compression strategy.
> 

Hi Jianan,

I sorted out a version this weekend (e.g. bump up max pclustersize if
needed and update the man page), would you mind confirm on your side
as well?

Also, it'd be better to add some functionality testcases to cover this
if you have extra time:

Thanks,
Gao Xiang

From 0e675d679c8732bd39699e5a9b1b6d9d742fb728 Mon Sep 17 00:00:00 2001
From: Huang Jianan <huangjianan@oppo.com>
Date: Wed, 25 Aug 2021 11:35:23 +0800
Subject: [PATCH v4] erofs-utils: support per-inode compress pcluster

Add an option to configure per-inode compression strategy.

Each line of the file should be in the following form:
<pcluster-in-bytes> <match-pattern>

Note that <match-pattern> can be as a regular expression.
If pcluster size is 0, it means that files shouldn't be compressed.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/compress_hints.h |  23 ++++++
 include/erofs/config.h         |   3 +-
 include/erofs/internal.h       |   1 +
 lib/Makefile.am                |   5 +-
 lib/compress.c                 |  24 ++++---
 lib/compress_hints.c           | 128 +++++++++++++++++++++++++++++++++
 lib/config.c                   |   3 +-
 lib/inode.c                    |   4 ++
 man/mkfs.erofs.1               |  11 +++
 mkfs/main.c                    |  19 ++++-
 10 files changed, 205 insertions(+), 16 deletions(-)
 create mode 100644 include/erofs/compress_hints.h
 create mode 100644 lib/compress_hints.c

diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
new file mode 100644
index 000000000000..a5772c72b1c4
--- /dev/null
+++ b/include/erofs/compress_hints.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#ifndef __EROFS_COMPRESS_HINTS_H
+#define __EROFS_COMPRESS_HINTS_H
+
+#include "erofs/internal.h"
+#include <sys/types.h>
+#include <regex.h>
+
+struct erofs_compress_hints {
+	struct list_head list;
+
+	regex_t reg;
+	unsigned int physical_clusterblks;
+};
+
+bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
+void erofs_cleanup_compress_hints(void);
+int erofs_load_compress_hints(void);
+#endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 95fc23e79e26..d5d9b5a751c0 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -50,13 +50,14 @@ struct erofs_configure {
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
 	char *c_src_path;
+	char *c_compress_hints_file;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 
-	u32 c_physical_clusterblks;
+	u32 c_pclusterblks_max, c_pclusterblks_def;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b939155ac951..f5eacea5d4d7 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -164,6 +164,7 @@ struct erofs_inode {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
+			uint8_t  z_physical_clusterblks;
 		};
 	};
 #ifdef WITH_ANDROID
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b5127c439e43..5a33e297c194 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -16,11 +16,12 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/list.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/trace.h \
-      $(top_srcdir)/include/erofs/xattr.h
+      $(top_srcdir)/include/erofs/xattr.h \
+      $(top_srcdir)/include/erofs/compress_hints.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c zmap.c decompress.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c compress_hints.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
index 6df30ea564a3..2806a7edfcb6 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -17,6 +17,7 @@
 #include "erofs/compress.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 static struct erofs_compress compresshandle;
 static int compressionlevel;
@@ -89,8 +90,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	}
 
 	do {
-		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && cfg.c_physical_clusterblks > 1) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
@@ -149,14 +149,18 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	return count;
 }
 
-/* TODO: apply per-(sub)file strategies here */
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
-		return 1 + rand() % cfg.c_physical_clusterblks;
+		return 1 + rand() % cfg.c_pclusterblks_max;
 #endif
-	return cfg.c_physical_clusterblks;
+	if (cfg.c_compress_hints_file) {
+		z_erofs_apply_compress_hints(inode);
+		DBG_BUGON(!inode->z_physical_clusterblks);
+		return inode->z_physical_clusterblks;
+	}
+	return cfg.c_pclusterblks_def;
 }
 
 static int vle_compress_one(struct erofs_inode *inode,
@@ -493,7 +497,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	}
 
-	if (cfg.c_physical_clusterblks > 1) {
+	if (erofs_sb_has_big_pcluster()) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
@@ -603,7 +607,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			.lz4 = {
 				.max_distance =
 					cpu_to_le16(sbi.lz4_max_distance),
-				.max_pclusterblks = cfg.c_physical_clusterblks,
+				.max_pclusterblks = cfg.c_pclusterblks_max,
 			}
 		};
 
@@ -655,11 +659,11 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (cfg.c_physical_clusterblks > 1) {
-		if (cfg.c_physical_clusterblks >
+	if (cfg.c_pclusterblks_max > 1) {
+		if (cfg.c_pclusterblks_max >
 		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
 			erofs_err("unsupported clusterblks %u (too large)",
-				  cfg.c_physical_clusterblks);
+				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster();
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
new file mode 100644
index 000000000000..81a8ac9ef04f
--- /dev/null
+++ b/lib/compress_hints.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/compress_hints.h"
+
+static LIST_HEAD(compress_hints_head);
+
+static void dump_regerror(int errcode, const char *s, const regex_t *preg)
+{
+	char str[512];
+
+	regerror(errcode, preg, str, sizeof(str));
+	erofs_err("invalid regex %s (%s)\n", s, str);
+}
+
+static int erofs_insert_compress_hints(const char *s, unsigned int blks)
+{
+	struct erofs_compress_hints *r;
+	int ret;
+
+	r = malloc(sizeof(struct erofs_compress_hints));
+	if (!r)
+		return -ENOMEM;
+
+	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+	if (ret) {
+		dump_regerror(ret, s, &r->reg);
+		goto err_out;
+	}
+	r->physical_clusterblks = blks;
+
+	list_add_tail(&r->list, &compress_hints_head);
+	erofs_info("compress hint %s (%u) is inserted", s, blks);
+	return ret;
+
+err_out:
+	free(r);
+	return ret;
+}
+
+bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
+{
+	const char *s;
+	struct erofs_compress_hints *r;
+	unsigned int pclusterblks;
+
+	if (inode->z_physical_clusterblks)
+		return true;
+
+	s = erofs_fspath(inode->i_srcpath);
+	pclusterblks = cfg.c_pclusterblks_def;
+
+	list_for_each_entry(r, &compress_hints_head, list) {
+		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
+
+		if (!ret) {
+			pclusterblks = r->physical_clusterblks;
+			break;
+		}
+		if (ret != REG_NOMATCH)
+			dump_regerror(ret, s, &r->reg);
+	}
+	inode->z_physical_clusterblks = pclusterblks;
+
+	/* pclusterblks is 0 means this file shouldn't be compressed */
+	return !!pclusterblks;
+}
+
+void erofs_cleanup_compress_hints(void)
+{
+	struct erofs_compress_hints *r, *n;
+
+	list_for_each_entry_safe(r, n, &compress_hints_head, list) {
+		list_del(&r->list);
+		free(r);
+	}
+}
+
+int erofs_load_compress_hints(void)
+{
+	char buf[PATH_MAX + 100];
+	FILE *f;
+	unsigned int line, max_pclustersize = 0;
+
+	if (!cfg.c_compress_hints_file)
+		return 0;
+
+	f = fopen(cfg.c_compress_hints_file, "r");
+	if (!f)
+		return -errno;
+
+	for (line = 1; fgets(buf, sizeof(buf), f); ++line) {
+		unsigned int pclustersize;
+		char *pattern;
+
+		pclustersize = atoi(strtok(buf, "\t "));
+		pattern = strtok(NULL, "\n");
+		if (!pattern || *pattern == '\0') {
+			erofs_err("cannot find a match pattern at line %u",
+				  line);
+			return -EINVAL;
+		}
+		if (pclustersize % EROFS_BLKSIZ) {
+			erofs_warn("invalid physical clustersize %u, "
+				   "use default pclusterblks %u",
+				   pclustersize, cfg.c_pclusterblks_def);
+			continue;
+		}
+		erofs_insert_compress_hints(pattern,
+					    pclustersize / EROFS_BLKSIZ);
+
+		if (pclustersize > max_pclustersize)
+			max_pclustersize = pclustersize;
+	}
+	fclose(f);
+	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
+		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
+		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
+	}
+	return 0;
+}
diff --git a/lib/config.c b/lib/config.c
index 4757dbbfdd4c..cc2aa7d0112f 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -24,7 +24,8 @@ void erofs_init_configure(void)
 	cfg.c_unix_timestamp = -1;
 	cfg.c_uid = -1;
 	cfg.c_gid = -1;
-	cfg.c_physical_clusterblks = 1;
+	cfg.c_pclusterblks_max = 1;
+	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 6024e8c593dd..5bad75e1c550 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -23,6 +23,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -327,6 +328,8 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
+	if (cfg.c_compress_hints_file)
+		return z_erofs_apply_compress_hints(inode);
 	return true;
 }
 
@@ -849,6 +852,7 @@ static struct erofs_inode *erofs_new_inode(void)
 
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
+	inode->z_physical_clusterblks = 0;
 	return inode;
 }
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index bc0a10be72a1..1446cb56db30 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -88,6 +88,17 @@ Display this help and exit.
 .TP
 .B \-\-max-extent-bytes #
 Specify maximum decompressed extent size # in bytes.
+.TP
+.BI "\-\-compress-hints " file
+If the optional
+.BI "\-\-compress-hints " file
+argument is given,
+.B mkfs.erofs
+uses it to apply the per-file compression strategy. Each line is defined by
+tokens separated by spaces in the following form:
+.RS 1.2i
+<pcluster-in-bytes> <match-pattern>
+.RE
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index 40ca94ff8db9..addefcefea38 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -21,6 +21,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -42,6 +43,7 @@ static struct option long_options[] = {
 	{"random-pclusterblks", no_argument, NULL, 8},
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
+	{"compress-hints", required_argument, NULL, 10},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -87,6 +89,7 @@ static void usage(void)
 	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -95,7 +98,7 @@ static void usage(void)
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 	      " --product-out=X       X=product_out directory\n"
 	      " --fs-config-file=X    X=fs_config file\n"
-	      " --block-list-file=X    X=block_list file\n"
+	      " --block-list-file=X   X=block_list file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -286,6 +289,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 10:
+			cfg.c_compress_hints_file = optarg;
+			break;
 #ifdef WITH_ANDROID
 		case 512:
 			cfg.mount_point = optarg;
@@ -312,7 +318,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			cfg.c_physical_clusterblks = i / EROFS_BLKSIZ;
+			cfg.c_pclusterblks_max = i / EROFS_BLKSIZ;
+			cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
 			break;
 
 		case 1:
@@ -578,6 +585,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	err = erofs_load_compress_hints();
+	if (err) {
+		erofs_err("Failed to load compress hints %s",
+			  cfg.c_compress_hints_file);
+		goto exit;
+	}
+
 	err = z_erofs_compress_init(sb_bh);
 	if (err) {
 		erofs_err("Failed to initialize compressor: %s",
@@ -626,6 +640,7 @@ exit:
 	erofs_droid_blocklist_fclose();
 #endif
 	dev_close();
+	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	erofs_exit_configure();
 
-- 
2.20.1

