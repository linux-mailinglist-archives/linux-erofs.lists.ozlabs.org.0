Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B541440104
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 19:13:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgpt20KzFz2ywT
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 04:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BHVJvjft;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=BHVJvjft; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgpsv0Cdkz2y6F
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 04:13:20 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id x66so9789384pfx.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JEtAEuKiCGqfpO6+7Lg2tY+pozpxCRIUTO5v9RbVaFM=;
 b=BHVJvjftR3OBC9bbMYLoHssJlyu5Z3tJ2FWAPFBKItJela5MAp66A+/6ae8jgo2ras
 wf9JkpRLvjWWQS5lpAV5D51R16MdD1GV2V3nT/5Cfj+PxtOxeE6W3hiGZbUeDfOIsiwg
 PIHIuNDOlpHvwuibDYZaYOsx2rGynAtHBb42zrpW/jTHTlkKquG15mimHfpZaaiGV+ng
 aeAX7WuvU5nilhJlPIog5lv2MvlMwr09AwKpoPZtxTFzM+9yYnwYUIT5mBN9iuE/74Ag
 xfAK73yRp+Yq2PGbvwadgMZXSMglwyvEjwL7KLawbjs12B8yOMkmH5jYWfSXuDdsYnIK
 tZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JEtAEuKiCGqfpO6+7Lg2tY+pozpxCRIUTO5v9RbVaFM=;
 b=gdLY2ZPseud5FE5becTVU49ViGwJWGnZISvrfAosGc/RhaGlctEBmxPUisE5TMHNlw
 Jue7EYxvXmzMOdh8e8985Cg9YeVBSndWo9pwI03uk+N3mr2rS+J7QE1A6eZ80K3rZlnk
 uY1b2JfXjUUTyHnhmrESRARj/M5Xd13HUuo/Y18ELLLN3gqDSp14M6vu48gjeOKTI7eM
 OApskJh8qKetYkHjJH9eaEM3oVze/uDB70vpmW9Ws56idGnqJGjW6ytJdoqhBznXncYd
 1rT8saVXMRjoTfBcu9ket4+bfcw2aLFb0lMr52emaq3A8yQaZw5a6iv8Bnsa67rEt4lf
 Y+ZA==
X-Gm-Message-State: AOAM530YrUphLzzM0gaNUchY+ElvsLtDssw0KqeWx0WK7l+R/mSTfC2I
 x6S1jmFhtdxeJC6GrgeWuV7SMSZmXMv96g==
X-Google-Smtp-Source: ABdhPJyGgIPTgJK1kaT1yr+2gVlrRF/ytTA4tydpglkKXzmphQ/4nyLNThzFj7XK/8CCn61tW9lUKA==
X-Received: by 2002:a63:8bc1:: with SMTP id j184mr9027103pge.385.1635527596966; 
 Fri, 29 Oct 2021 10:13:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:2aa6:59db:a642:9fdc])
 by smtp.gmail.com with ESMTPSA id t2sm6028766pgf.35.2021.10.29.10.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 10:13:16 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.lee@aliyun.com, xiang@kernel.org,
 chao@kernel.org, miaoxie@huawei.com, fangwei1@huawei.com
Subject: [PATCH v3] erofs-utils: introduce fsck.erofs
Date: Fri, 29 Oct 2021 10:13:12 -0700
Message-Id: <20211029171312.2189648-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Daeho Jeong <daehojeong@google.com>

I made a fsck.erofs tool to check erofs filesystem image integrity
and calculate filesystem compression ratio.
Here are options to support now.

fsck.erofs [options] IMAGE
-V      print the version number of fsck.erofs and exit.
-d#     set output message level to # (maximum 9)
-p      print total compression ratio of all files
-c      check if all compressed files are well decompressed

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: added man page
v2: merged options printing compression ratio into "-p"
    added "-c" option to check if compressed files are well decompressed
    added alphabetical order of dirent entries
    changed the way to calculate compression rate
    changed the way to check special named dirent entries
---
 Makefile.am              |   2 +-
 configure.ac             |   3 +-
 fsck/Makefile.am         |   9 +
 fsck/main.c              | 606 +++++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h |   5 +
 include/erofs_fs.h       |  13 +
 lib/data.c               |   4 +-
 lib/namei.c              |   2 +-
 lib/super.c              |   1 +
 man/fsck.erofs.1         |  38 +++
 mkfs/main.c              |  13 -
 11 files changed, 678 insertions(+), 18 deletions(-)
 create mode 100644 fsck/Makefile.am
 create mode 100644 fsck/main.c
 create mode 100644 man/fsck.erofs.1

diff --git a/Makefile.am b/Makefile.am
index 24e1d38..fc464e8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,7 +2,7 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs dump
+SUBDIRS = man lib mkfs dump fsck
 if ENABLE_FUSE
 SUBDIRS += fuse
 endif
diff --git a/configure.ac b/configure.ac
index b2c3225..5698b2e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,5 +298,6 @@ AC_CONFIG_FILES([Makefile
 		 lib/Makefile
 		 mkfs/Makefile
 		 dump/Makefile
-		 fuse/Makefile])
+		 fuse/Makefile
+		 fsck/Makefile])
 AC_OUTPUT
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
new file mode 100644
index 0000000..82973ba
--- /dev/null
+++ b/fsck/Makefile.am
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = fsck.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS}
+fsck_erofs_SOURCES = main.c
+fsck_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${liblz4_LIBS}
diff --git a/fsck/main.c b/fsck/main.c
new file mode 100644
index 0000000..7cc3763
--- /dev/null
+++ b/fsck/main.c
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Google LLC
+ * Author: Daeho Jeong <daehojeong@google.com>
+ */
+#include <stdlib.h>
+#include <getopt.h>
+#include <time.h>
+#include "erofs/print.h"
+#include "erofs/io.h"
+#include "erofs/decompress.h"
+
+static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
+
+struct erofsfsck_cfg {
+	bool corrupted;
+	bool print_comp_ratio;
+	bool check_decomp;
+	u64 physical_blocks;
+	u64 logical_blocks;
+};
+static struct erofsfsck_cfg fsckcfg;
+
+static struct option long_options[] = {
+	{"help", no_argument, 0, 1},
+	{0, 0, 0, 0},
+};
+
+static void usage(void)
+{
+	fputs("usage: [options] IMAGE\n\n"
+	      "Check erofs filesystem integrity of IMAGE, and [options] are:\n"
+	      " -V      print the version number of fsck.erofs and exit.\n"
+	      " -d#     set output message level to # (maximum 9)\n"
+	      " -p      print total compression ratio of all files\n"
+	      " -c      check if all compressed files are well decompressed\n"
+	      " --help  display this help and exit.\n",
+	      stderr);
+}
+
+static void erofsfsck_print_version(void)
+{
+	fprintf(stderr, "fsck.erofs %s\n", cfg.c_version);
+}
+
+static int erofsfsck_parse_options_cfg(int argc, char **argv)
+{
+	int opt, i;
+
+	while ((opt = getopt_long(argc, argv, "Vd:pc",
+				  long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'V':
+			erofsfsck_print_version();
+			exit(0);
+		case 'd':
+			i = atoi(optarg);
+			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
+				erofs_err("invalid debug level %d", i);
+				return -EINVAL;
+			}
+			cfg.c_dbg_lvl = i;
+			break;
+		case 'p':
+			fsckcfg.print_comp_ratio = true;
+			break;
+		case 'c':
+			fsckcfg.check_decomp = true;
+			break;
+		case 1:
+			usage();
+			exit(0);
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (optind >= argc)
+		return -EINVAL;
+
+	cfg.c_img_path = strdup(argv[optind++]);
+	if (!cfg.c_img_path)
+		return -ENOMEM;
+
+	if (optind < argc) {
+		erofs_err("unexpected argument: %s\n", argv[optind]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int erofs_check_sb_chksum(void)
+{
+	int ret;
+	u8 buf[EROFS_BLKSIZ];
+	u32 crc;
+	struct erofs_super_block *sb;
+
+	ret = blk_read(buf, 0, 1);
+	if (ret) {
+		erofs_err("failed to read superblock to check checksum: "
+			  "errno(%d)", ret);
+		return -1;
+	}
+
+	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
+	sb->checksum = 0;
+
+	crc = crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	if (crc != sbi.checksum) {
+		erofs_err("superblock checksum doesn't match: saved(0x%08x) "
+			  "calculated(0x%08x)", sbi.checksum, crc);
+		fsckcfg.corrupted = true;
+		return -1;
+	}
+	return 0;
+}
+
+static int check_special_dentry(struct erofs_dirent *de,
+				unsigned int de_namelen, erofs_nid_t nid,
+				erofs_nid_t pnid)
+{
+	if (de_namelen == 2 && de->nid != pnid) {
+		erofs_err("wrong parent dir nid(%llu): pnid(%llu) @ nid(%llu)",
+			  de->nid | 0ULL, pnid | 0ULL, nid | 0ULL);
+		return -1;
+	}
+
+	if (de_namelen == 1 && de->nid != nid) {
+		erofs_err("wrong current dir nid(%llu) @ nid(%llu)",
+			  de->nid | 0ULL, nid | 0ULL);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
+			    void *dentry_blk, erofs_off_t offset,
+			    unsigned int next_nameoff, unsigned int maxsize)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	unsigned int idx = 0;
+	char *prev_name = NULL, *cur_name = NULL;
+	int ret = 0;
+
+	erofs_dbg("traversing pnid(%llu), nid(%llu)", pnid | 0ULL, nid | 0ULL);
+
+	if (offset == 0 && (next_nameoff < 2 * sizeof(struct erofs_dirent))) {
+		erofs_err("too small dirents of size(%d) in nid(%llu)",
+			  next_nameoff, nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		if (prev_name)
+			free(prev_name);
+		prev_name = cur_name;
+		cur_name = strndup(de_name, de_namelen);
+		BUG_ON(!cur_name);
+
+		erofs_dbg("traversed filename(%s)", cur_name);
+
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			erofs_err("bogus dirent with nameoff(%u): expected(%d) "
+				  "@ nid(%llu), offset(%llu), idx(%u)",
+				  nameoff, next_nameoff, nid | 0ULL,
+				  offset | 0ULL, idx);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		if (nameoff + de_namelen > maxsize ||
+				de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent with namelen(%u) @ nid(%llu), "
+				  "offset(%llu), idx(%u)",
+				  de_namelen, nid | 0ULL, offset | 0ULL, idx);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		if (prev_name && (strcmp(prev_name, cur_name) >= 0)) {
+			erofs_err("wrong dirent name order @ nid(%llu), "
+				  "offset(%llu), idx(%u): prev(%s), cur(%s)",
+				  nid | 0ULL, offset | 0ULL, idx,
+				  prev_name, cur_name);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		if (is_dot_dotdot(cur_name)) {
+			if (check_special_dentry(de, de_namelen, nid, pnid)) {
+				ret = -EFSCORRUPTED;
+				goto out;
+			}
+		} else {
+			erofs_check_inode(nid, de->nid);
+		}
+
+		if (fsckcfg.corrupted) {
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		next_nameoff += de_namelen;
+		++de;
+		++idx;
+	}
+
+out:
+	if (prev_name)
+		free(prev_name);
+	if (cur_name)
+		free(cur_name);
+
+	erofs_dbg("traversing ... done nid(%llu)", nid | 0ULL);
+	return ret;
+}
+
+static int verify_raw_data_chunk(struct erofs_inode *inode)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret;
+	erofs_off_t ptr = 0;
+	u64 i_blocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+
+	while (ptr < inode->i_size) {
+		map.m_la = ptr;
+		ret = erofs_map_blocks(inode, &map, 0);
+		if (ret)
+			return ret;
+
+		if (map.m_plen != map.m_llen || ptr != map.m_la) {
+			erofs_err("broken data chunk layout m_la %" PRIu64
+				  " ptr %" PRIu64 " m_llen %" PRIu64 " m_plen %"
+				  PRIu64, map.m_la, ptr, map.m_llen,
+				  map.m_plen);
+			return -EFSCORRUPTED;
+		}
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen) {
+			/* readched EOF */
+			ptr = inode->i_size;
+			continue;
+		}
+
+		ptr += map.m_llen;
+	}
+
+	if (fsckcfg.print_comp_ratio) {
+		fsckcfg.logical_blocks += i_blocks;
+		fsckcfg.physical_blocks += i_blocks;
+	}
+
+	return 0;
+}
+
+static int verify_compressed_chunk(struct erofs_inode *inode)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret = 0;
+	u64 pchunk_len = 0;
+	erofs_off_t end = inode->i_size;
+	unsigned int algorithmformat, raw_size = 0, buffer_size = 0;
+	char *raw = NULL, *buffer = NULL;
+
+	while (end > 0) {
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(inode, &map);
+		if (ret)
+			goto out;
+
+		if (end > map.m_la + map.m_llen) {
+			erofs_err("broken compressed chunk layout m_la %" PRIu64
+				  " m_llen %" PRIu64 " end %" PRIu64,
+				  map.m_la, map.m_llen, end);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		pchunk_len += map.m_plen;
+		end = map.m_la;
+
+		if (!fsckcfg.check_decomp || !(map.m_flags & EROFS_MAP_MAPPED))
+			continue;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
+		if (map.m_plen > raw_size) {
+			raw_size = map.m_plen;
+			raw = realloc(raw, raw_size);
+			BUG_ON(!raw);
+		}
+
+		if (map.m_llen > buffer_size) {
+			buffer_size = map.m_llen;
+			buffer = realloc(buffer, buffer_size);
+			BUG_ON(!buffer);
+		}
+
+		ret = dev_read(raw, map.m_pa, map.m_plen);
+		if (ret < 0) {
+			erofs_err("an error occurred when reading compressed "
+				  "data of nid(%" PRIu64 "), m_pa %" PRIu64
+				  ", m_plen %" PRIu64 ": errno(%d)",
+				  inode->nid, map.m_pa, map.m_plen, ret);
+			goto out;
+		}
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer,
+					.decodedskip = 0,
+					.inputsize = map.m_plen,
+					.decodedlength = map.m_llen,
+					.alg = algorithmformat,
+					.partial_decoding = 0
+					 });
+
+		if (ret < 0) {
+			erofs_err("an error occurred when decompressing "
+				  "data of nid(%" PRIu64 "), m_pa %" PRIu64
+				  ", m_plen %" PRIu64 ": errno(%d)",
+				  inode->nid, map.m_pa, map.m_plen, ret);
+			goto out;
+		}
+	}
+
+	if (fsckcfg.print_comp_ratio) {
+		fsckcfg.logical_blocks += DIV_ROUND_UP(inode->i_size,
+						       EROFS_BLKSIZ);
+		fsckcfg.physical_blocks += DIV_ROUND_UP(pchunk_len,
+							EROFS_BLKSIZ);
+	}
+out:
+	if (raw)
+		free(raw);
+	if (buffer)
+		free(buffer);
+	return ret < 0 ? ret : 0;
+}
+
+static int erofs_verify_xattr(struct erofs_inode *inode)
+{
+	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
+	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
+	erofs_off_t addr;
+	unsigned int ofs, xattr_shared_count;
+	struct erofs_xattr_ibody_header *ih;
+	struct erofs_xattr_entry *entry;
+	int i, remaining = inode->xattr_isize, ret = 0;
+	char *buf = calloc(EROFS_BLKSIZ, 1);
+
+	BUG_ON(!buf);
+
+	if (inode->xattr_isize == xattr_hdr_size) {
+		erofs_err("xattr_isize %d of nid %llu is not supported yet",
+			  inode->xattr_isize, inode->nid | 0ULL);
+		ret = -EFSCORRUPTED;
+		goto out;
+	} else if (inode->xattr_isize < xattr_hdr_size) {
+		if (inode->xattr_isize) {
+			erofs_err("bogus xattr ibody @ nid %llu",
+				  inode->nid | 0ULL);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+	}
+
+	addr = iloc(inode->nid) + inode->inode_isize;
+	ret = dev_read(buf, addr, xattr_hdr_size);
+	if (ret < 0) {
+		erofs_err("an error occurred when reading xattr header "
+			  "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
+		goto out;
+	}
+	ih = (struct erofs_xattr_ibody_header *)buf;
+	xattr_shared_count = ih->h_shared_count;
+
+	ofs = erofs_blkoff(addr) + xattr_hdr_size;
+	addr += xattr_hdr_size;
+	remaining -= xattr_hdr_size;
+	for (i = 0; i < xattr_shared_count; ++i) {
+		if (ofs >= EROFS_BLKSIZ) {
+			if (ofs != EROFS_BLKSIZ) {
+				erofs_err("unaligned xattr entry in "
+					  "xattr shared area of nid(%llu)",
+					  inode->nid | 0ULL);
+				ret = -EFSCORRUPTED;
+				goto out;
+			}
+			ofs = 0;
+		}
+		ofs += xattr_entry_size;
+		addr += xattr_entry_size;
+		remaining -= xattr_entry_size;
+	}
+
+	while (remaining > 0) {
+		unsigned int entry_sz;
+
+		ret = dev_read(buf, addr, xattr_entry_size);
+		if (ret) {
+			erofs_err("an error occurred when reading xattr entry "
+				  "of nid(%llu): errno(%d)",
+				  inode->nid | 0ULL, ret);
+			goto out;
+		}
+
+		entry = (struct erofs_xattr_entry *)buf;
+		entry_sz = erofs_xattr_entry_size(entry);
+		if (remaining < entry_sz) {
+			erofs_err("xattr on-disk corruption: xattr entry "
+				  "beyond xattr_isize of nid(%llu)",
+				  inode->nid | 0ULL);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		addr += entry_sz;
+		remaining -= entry_sz;
+	}
+out:
+	free(buf);
+	return ret;
+}
+
+static int erofs_verify_data_chunk(struct erofs_inode *inode)
+{
+	int ret;
+
+	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
+		  inode->nid | 0ULL, inode->datalayout);
+
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_CHUNK_BASED:
+		ret = verify_raw_data_chunk(inode);
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		ret = verify_compressed_chunk(inode);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret == -EIO)
+		erofs_err("I/O error occurred when verifying "
+			  "data chunk of nid(%llu)", inode->nid | 0ULL);
+
+	return ret;
+}
+
+static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+{
+	int ret;
+	struct erofs_inode *inode;
+	char *buf;
+	erofs_off_t offset;
+
+	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
+	inode = calloc(1, sizeof(struct erofs_inode));
+	BUG_ON(!inode);
+	buf = calloc(EROFS_BLKSIZ, 1);
+	BUG_ON(!buf);
+
+	inode->nid = nid;
+	ret = erofs_read_inode_from_disk(inode);
+	if (ret) {
+		if (ret == -EIO)
+			erofs_err("I/O error occurred when reading nid(%llu)",
+				  nid | 0ULL);
+		goto out;
+	}
+
+	/* verify xattr field */
+	ret = erofs_verify_xattr(inode);
+	if (ret)
+		goto out;
+
+	/* verify data chunk layout */
+	ret = erofs_verify_data_chunk(inode);
+	if (ret)
+		goto out;
+
+	if ((inode->i_mode & S_IFMT) != S_IFDIR)
+		goto out;
+
+	offset = 0;
+	while (offset < inode->i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					inode->i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		unsigned int nameoff;
+
+		ret = erofs_pread(inode, buf, maxsize, offset);
+		if (ret) {
+			erofs_err("I/O error occurred when reading dirents: "
+				  "nid(%llu), offset(%llu), size(%llu)",
+				  nid | 0ULL, offset | 0ULL, maxsize | 0ULL);
+			goto out;
+		}
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+				nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid(%llu), "
+				  "offset(%llu)",
+				  nameoff, nid | 0ULL, offset | 0ULL);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		ret = traverse_dirents(pnid, nid, buf, offset,
+				       nameoff, maxsize);
+		if (ret)
+			goto out;
+
+		offset += maxsize;
+	}
+out:
+	free(buf);
+	free(inode);
+	if (ret && ret != -EIO)
+		fsckcfg.corrupted = true;
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+
+	erofs_init_configure();
+
+	fsckcfg.corrupted = false;
+	fsckcfg.print_comp_ratio = false;
+	fsckcfg.check_decomp = false;
+	fsckcfg.logical_blocks = 0;
+	fsckcfg.physical_blocks = 0;
+
+	err = erofsfsck_parse_options_cfg(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			usage();
+		goto exit;
+	}
+
+	err = dev_open_ro(cfg.c_img_path);
+	if (err) {
+		erofs_err("failed to open image file");
+		goto exit;
+	}
+
+	err = erofs_read_superblock();
+	if (err) {
+		erofs_err("failed to read superblock");
+		goto exit;
+	}
+
+	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
+		erofs_err("failed to verify superblock checksum");
+		goto exit;
+	}
+
+	erofs_check_inode(sbi.root_nid, sbi.root_nid);
+
+	if (fsckcfg.corrupted) {
+		fprintf(stderr, "Found some filesystem corruption\n");
+	} else {
+		fprintf(stderr, "No error found\n");
+		if (fsckcfg.print_comp_ratio) {
+			double comp_ratio =
+				(double)fsckcfg.physical_blocks * 100 /
+				(double)fsckcfg.logical_blocks;
+			fprintf(stderr, "Compression Ratio: %.2f(%%)\n",
+				comp_ratio);
+		}
+	}
+
+exit:
+	erofs_exit_configure();
+	return err;
+}
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8b154ed..80065b2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -82,6 +82,8 @@ struct erofs_sb_info {
 
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
+
+	u32 checksum;
 };
 
 /* global sbi */
@@ -264,10 +266,13 @@ int erofs_read_superblock(void);
 
 /* namei.c */
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
+int erofs_read_inode_from_disk(struct erofs_inode *vi);
 
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
+int erofs_map_blocks(struct erofs_inode *inode,
+		     struct erofs_map_blocks *map, int flags);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 66a68e3..62e9981 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -400,4 +400,17 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
 }
 
+#define CRC32C_POLY_LE	0x82F63B78
+static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
+{
+	int i;
+
+	while (len--) {
+		crc ^= *in++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
+	}
+	return crc;
+}
+
 #endif
diff --git a/lib/data.c b/lib/data.c
index 641d840..6cb7eeb 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -61,8 +61,8 @@ err_out:
 	return err;
 }
 
-static int erofs_map_blocks(struct erofs_inode *inode,
-			    struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct erofs_inode *inode,
+		     struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_inode_chunk_index *idx;
diff --git a/lib/namei.c b/lib/namei.c
index b4bdabf..56f199a 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-static int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
diff --git a/lib/super.c b/lib/super.c
index 0fa69ab..0c30403 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -62,6 +62,7 @@ int erofs_read_superblock(void)
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
 	sbi.inos = le64_to_cpu(dsb->inos);
+	sbi.checksum = le32_to_cpu(dsb->checksum);
 
 	sbi.build_time = le64_to_cpu(dsb->build_time);
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
new file mode 100644
index 0000000..c1481d3
--- /dev/null
+++ b/man/fsck.erofs.1
@@ -0,0 +1,38 @@
+.\" Copyright (c) 2021 Daeho Jeong <daehojeong@google.com>
+.\"
+.TH FSCK.EROFS 1
+.SH NAME
+fsck.erofs \- tool to check the EROFS filesystem's integrity
+.SH SYNOPSIS
+\fBfsck.erofs\fR [\fIOPTIONS\fR] \fIIMAGE\fR
+.SH DESCRIPTION
+fsck.erofs is used to scan an EROFS filesystem \fIIMAGE\fR and check the
+integrity of it.
+.SH OPTIONS
+.TP
+.BI "\-V "
+Print the version number of fsck.erofs and exit.
+.TP
+.BI "\-d " #
+Specify the level of debugging messages. The default is 2, which shows basic
+warning messages.
+.TP
+.BI "\-p "
+Print total compression ratio of all files including compressed and
+non-compressed files.
+.TP
+.BI "\-c "
+Check if all the compressed files are well decompressed. This will induce more
+I/Os to read compressed file data, so it might take too much time depending on
+the image.
+.TP
+.B \-\-help
+Display this help and exit.
+.SH AUTHOR
+This version of \fBfsck.erofs\fR is written by
+Daeho Jeong <daehojeong@google.com>.
+.SH AVAILABILITY
+\fBfsck.erofs\fR is part of erofs-utils package and is available from
+git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
+.SH SEE ALSO
+.BR fsck (8).
diff --git a/mkfs/main.c b/mkfs/main.c
index 1c8dea5..b9b46f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -424,19 +424,6 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
-#define CRC32C_POLY_LE	0x82F63B78
-static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
-{
-	int i;
-
-	while (len--) {
-		crc ^= *in++;
-		for (i = 0; i < 8; i++)
-			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
-	}
-	return crc;
-}
-
 static int erofs_mkfs_superblock_csum_set(void)
 {
 	int ret;
-- 
2.33.1.1089.g2158813163f-goog

