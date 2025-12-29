Return-Path: <linux-erofs+bounces-1645-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A2CE7CBB
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 19:07:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dg41P6sVTz2xgv;
	Tue, 30 Dec 2025 05:07:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767031625;
	cv=none; b=DmOEYG7lU+lB41kue0A4oKWUt8/Y54gptz4tx9uvh2djMlBeijf5b7kZ5zZGjgc3QDGCOKEeTfo84pn/hGhGU5CDzOcCoetPBoZuQXZDf7L2O7Kjf2u7f3JWEQCzoTO6FNicJ6+07HOLqm1mNGySpZGH8APlytPdbjT7sk5tf4paYzsLso2kW8bx3plYtZUE+ezv0zgf+0l9c0mrXCdgZyjdSDddDEftyEURcdv2HQkhN0NgulGK3+7fx5Ojgmn4wlI8NLC+1NeF5Sgh/FaHs4JaG+jPUZvfYKR5NmzM7VI3gAoP9Ur5QzmPE5kr3SVXOcL6Y94lESbFr+s7KSvFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767031625; c=relaxed/relaxed;
	bh=m2RIcCF56h2EX6adagpTTwxoXR1RFG3ZSgexhrNP28o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2m6TfNG59lHMGxl/EpUDyqqP5SjB2RzP6ubFrDPqBv4gCyX/sCQVGcOZ30PZqqnyzU/nfKXb56HOLiTm75AmGUHUoebq5n1VACLMSWHXZCUuRIjniiNAv/jeToQWtB5rfMbVxMSODsK5YuxjKogF0nojE0bzjm9aVicm+CrUo6urW+nHTKpZyORFv1SLWj7aecqK2zvbKWZGetvSWOlBv5PtPn6sEECtA7xkCZEpqAoZc0wPz3fp9nPUZ/1bxfXIsqqYiMISfWzudG4EXNhIIbETH4l5XkmZ7vqGrQdy/xS19MjgBynuUNLGdZlbv4jMJ1LzUkVN/H1UhWvSZavGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RC9fmbmt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RC9fmbmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dg41L3MV8z2xqj
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 05:07:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767031617; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m2RIcCF56h2EX6adagpTTwxoXR1RFG3ZSgexhrNP28o=;
	b=RC9fmbmtL/+iI4S2n4K2CgMLqEd6CcsX/Wtf2t486kOySFuZTriiRcPdlquxl6uifntiSX95p8leqvDkj04CZ3QYJ0glaXmDe+pYrLkneidZEp0TIhBCW5iYh6WskwK/OoV45J6llPGfcyy6meKpppZkyJND0smRRNu/NLq/gng=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvwyKvT_1767031614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 02:06:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH v2 4/4] erofs-utils: mkfs: add `--inode-digest-xattr` option
Date: Tue, 30 Dec 2025 02:06:46 +0800
Message-ID: <20251229180646.3017326-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
References: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Based on the original Hongbo's version [1], it enables storing the
SHA-256 digest of each inode as an extended attribute, in preparation
for the upcoming page cache sharing feature.

Example usage:
 $ mkfs.erofs --xattr-inode-digest=trusted.erofs.fingerprint [-zlz4hc] foo.erofs foo/

Co-developed-by: Hongbo Li <lihongbo22@huawei.com>
[1] https://lore.kernel.org/r/20251118015849.228939-1-lihongbo22@huawei.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 - address Hongbo's comment:
    https://lore.kernel.org/r/9b732162-18a4-442a-b862-50a2cdd4a1a9@huawei.com

 include/erofs/internal.h |   2 +
 include/erofs/xattr.h    |   2 +
 include/erofs_fs.h       |   4 +-
 lib/inode.c              |  46 +++++++++-
 lib/super.c              |  13 ++-
 lib/xattr.c              |  14 ++-
 mkfs/main.c              | 186 ++++++++++++++++++++++-----------------
 7 files changed, 178 insertions(+), 89 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 62594b877151..5798f10e89c2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -130,6 +130,7 @@ struct erofs_sb_info {
 
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_prefix_id;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
 	struct erofs_vfile bdev;
@@ -189,6 +190,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
+EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
 
 #define EROFS_I_EA_INITED_BIT	0
 #define EROFS_I_Z_INITED_BIT	1
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 941bed778956..96546364f316 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -33,6 +33,8 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode);
 int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path,
 				       long inlinexattr_tolerance);
 int erofs_xattr_insert_name_prefix(const char *prefix);
+int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
+				  const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 887f37faba59..8b0d155f8c4c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -17,6 +17,7 @@
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
 #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX	0x00000010
+#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS	0x00000020
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -82,7 +83,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/lib/inode.c b/lib/inode.c
index 7ee16f4db183..fa0665c4faca 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -31,6 +31,7 @@
 #include "liberofs_metabox.h"
 #include "liberofs_private.h"
 #include "liberofs_rebuild.h"
+#include "sha256.h"
 
 static inline bool erofs_is_special_identifier(const char *path)
 {
@@ -1898,6 +1899,37 @@ static int erofs_prepare_dir_inode(const struct erofs_mkfs_btctx *ctx,
 	return 0;
 }
 
+static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
+				       erofs_off_t pos)
+{
+	u8 ishare_xattr_prefix_id = inode->sbi->ishare_xattr_prefix_id;
+	erofs_off_t remaining = inode->i_size;
+	struct erofs_vfile vf = { .fd = fd };
+	struct sha256_state md;
+	u8 out[32 + sizeof("sha256:") - 1];
+	int ret;
+
+	if (!ishare_xattr_prefix_id)
+		return 0;
+	erofs_sha256_init(&md);
+	do {
+		u8 buf[32768];
+
+		ret = erofs_io_pread(&vf, buf,
+				     min_t(u64, remaining, sizeof(buf)), pos);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			erofs_sha256_process(&md, buf, ret);
+		remaining -= ret;
+		pos += ret;
+	} while (remaining);
+	erofs_sha256_done(&md, out + sizeof("sha256:") - 1);
+	memcpy(out, "sha256:", sizeof("sha256:") - 1);
+	return erofs_setxattr(inode, ishare_xattr_prefix_id, "",
+			      out, sizeof(out));
+}
+
 static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 					 struct erofs_inode *inode)
 {
@@ -1917,11 +1949,18 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 			if (ctx.fd < 0)
 				return -errno;
-			__erofs_fallthrough;
-		default:
 			break;
+		default:
+			goto out;
 		}
-		if (ctx.fd >= 0 && cfg.c_compr_opts[0].alg &&
+
+		if (S_ISREG(inode->i_mode) && inode->i_size) {
+			ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (cfg.c_compr_opts[0].alg &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
@@ -1933,6 +1972,7 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 				return ret;
 		}
 	}
+out:
 	return erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 }
 
diff --git a/lib/super.c b/lib/super.c
index e54aff2d4ab7..a4837e5702ed 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -146,7 +146,15 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->build_time = le32_to_cpu(dsb->build_time);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
-
+	if (erofs_sb_has_ishare_xattrs(sbi)) {
+		if (dsb->ishare_xattr_prefix_id >= sbi->xattr_prefix_count) {
+			erofs_err("invalid ishare xattr prefix id %d",
+				  dsb->ishare_xattr_prefix_id);
+			return -EFSCORRUPTED;
+		}
+		sbi->ishare_xattr_prefix_id =
+			dsb->ishare_xattr_prefix_id | EROFS_XATTR_LONG_PREFIX;
+	}
 	ret = z_erofs_parse_cfgs(sbi, dsb);
 	if (ret)
 		return ret;
@@ -160,7 +168,6 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		free(sbi->devs);
 		sbi->devs = NULL;
 	}
-
 	sbi->sb_valid = !ret;
 	return ret;
 }
@@ -206,6 +213,8 @@ int erofs_writesb(struct erofs_sb_info *sbi)
 		.extra_devices = cpu_to_le16(sbi->extra_devices),
 		.devt_slotoff = cpu_to_le16(sbi->devt_slotoff),
 		.packed_nid = cpu_to_le64(sbi->packed_nid),
+		.ishare_xattr_prefix_id = sbi->ishare_xattr_prefix_id &
+			EROFS_XATTR_LONG_PREFIX_MASK,
 	};
 	char *buf;
 	int ret;
diff --git a/lib/xattr.c b/lib/xattr.c
index b6b1a5e600fb..764aee3be3c3 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1495,9 +1495,21 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
 	}
 
 	tnode->index = EROFS_XATTR_LONG_PREFIX | ea_prefix_count;
-	ea_prefix_count++;
 	init_list_head(&tnode->list);
 	list_add_tail(&tnode->list, &ea_name_prefixes);
+	return ea_prefix_count++;
+}
+
+int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
+				  const char *prefix)
+{
+	int err;
+
+	err = erofs_xattr_insert_name_prefix(prefix);
+	if (err < 0)
+		return err;
+	sbi->ishare_xattr_prefix_id = EROFS_XATTR_LONG_PREFIX | err;
+	erofs_sb_set_ishare_xattrs(sbi);
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index aaa0300bca1b..b7cd3a6b986f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,7 +61,6 @@ static struct option long_options[] = {
 	{"tar", optional_argument, NULL, 20},
 	{"aufs", no_argument, NULL, 21},
 	{"mount-point", required_argument, NULL, 512},
-	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
@@ -102,6 +101,8 @@ static struct option long_options[] = {
 #endif
 	{"zD", optional_argument, NULL, 536},
 	{"ZI", optional_argument, NULL, 537},
+	{"xattr-prefix", required_argument, NULL, 538},
+	{"xattr-inode-digest", required_argument, NULL, 539},
 	{0, 0, 0, 0},
 };
 
@@ -167,95 +168,96 @@ static void usage(int argc, char **argv)
 		}
 	}
 	printf(
-		" -C#                   specify the size of compress physical cluster in bytes\n"
-		" -EX[,...]             X=extended options\n"
-		" -L volume-label       set the volume label (maximum 15 bytes)\n"
-		" -m#[:X]               enable metadata compression (# = physical cluster size in bytes;\n"
-		"                                                    X = another compression algorithm for metadata)\n"
-		" -T#                   specify a fixed UNIX timestamp # as build time\n"
-		"    --all-time         the timestamp is also applied to all files (default)\n"
-		"    --mkfs-time        the timestamp is applied as build time only\n"
-		" -UX                   use a given filesystem UUID\n"
-		" --zD[=<0|1>]          specify directory compression: 0=disable [default], 1=enable\n"
-		" --ZI[=<0|1>]          specify the separate inode metadata zone availability: 0=disable [default], 1=enable\n"
-		" --all-root            make all files owned by root\n"
+		" -C#                    specify the size of compress physical cluster in bytes\n"
+		" -EX[,...]              X=extended options\n"
+		" -L volume-label        set the volume label (maximum 15 bytes)\n"
+		" -m#[:X]                enable metadata compression (# = physical cluster size in bytes;\n"
+		"                                                     X = another compression algorithm for metadata)\n"
+		" -T#                    specify a fixed UNIX timestamp # as build time\n"
+		"    --all-time          the timestamp is also applied to all files (default)\n"
+		"    --mkfs-time         the timestamp is applied as build time only\n"
+		" -UX                    use a given filesystem UUID\n"
+		" --zD[=<0|1>]           specify directory compression: 0=disable [default], 1=enable\n"
+		" --ZI[=<0|1>]           specify the separate inode metadata zone availability: 0=disable [default], 1=enable\n"
+		" --all-root             make all files owned by root\n"
 #ifdef EROFS_MT_ENABLED
-		" --async-queue-limit=# specify the maximum number of entries in the multi-threaded job queue\n"
+		" --async-queue-limit=#  specify the maximum number of entries in the multi-threaded job queue\n"
 #endif
-		" --blobdev=X           specify an extra device X to store chunked data\n"
-		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
-		" --clean=X             run full clean build (default) or:\n"
-		" --incremental=X       run incremental build\n"
-		"                       X = data|rvsp|0 (data: full data, rvsp: space fallocated\n"
-		"                                        0: inodes zeroed)\n"
-		" --compress-hints=X    specify a file to configure per-file compression strategy\n"
-		" --dsunit=#            align all data block addresses to multiples of #\n"
-		" --exclude-path=X      avoid including file X (X = exact literal path)\n"
-		" --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
+		" --blobdev=X            specify an extra device X to store chunked data\n"
+		" --chunksize=#          generate chunk-based files with #-byte chunks\n"
+		" --clean=X              run full clean build (default) or:\n"
+		" --incremental=X        run incremental build\n"
+		"                        X = data|rvsp|0 (data: full data, rvsp: space fallocated\n"
+		"                                         0: inodes zeroed)\n"
+		" --compress-hints=X     specify a file to configure per-file compression strategy\n"
+		" --dsunit=#             align all data block addresses to multiples of #\n"
+		" --exclude-path=X       avoid including file X (X = exact literal path)\n"
+		" --exclude-regex=X      avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
-		" --file-contexts=X     specify a file contexts file to setup selinux labels\n"
+		" --file-contexts=X      specify a file contexts file to setup selinux labels\n"
 #endif
-		" --force-uid=#         set all file uids to # (# = UID)\n"
-		" --force-gid=#         set all file gids to # (# = GID)\n"
-		" --fsalignblks=#       specify the alignment of the primary device size in blocks\n"
-		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
-		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
-		" --hard-dereference    dereference hardlinks, add links as separate inodes\n"
-		" --ignore-mtime        use build time instead of strict per-file modification time\n"
-		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
-		" --mount-point=X       X=prefix of target fs path (default: /)\n"
-		" --preserve-mtime      keep per-file modification time strictly\n"
-		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
-		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
-		" --aufs                replace aufs special files with overlayfs metadata\n"
-		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
+		" --force-uid=#          set all file uids to # (# = UID)\n"
+		" --force-gid=#          set all file gids to # (# = GID)\n"
+		" --fsalignblks=#        specify the alignment of the primary device size in blocks\n"
+		" --uid-offset=#         add offset # to all file uids (# = id offset)\n"
+		" --gid-offset=#         add offset # to all file gids (# = id offset)\n"
+		" --hard-dereference     dereference hardlinks, add links as separate inodes\n"
+		" --ignore-mtime         use build time instead of strict per-file modification time\n"
+		" --max-extent-bytes=#   set maximum decompressed extent size # in bytes\n"
+		" --mount-point=X        X=prefix of target fs path (default: /)\n"
+		" --preserve-mtime       keep per-file modification time strictly\n"
+		" --offset=#             skip # bytes at the beginning of IMAGE.\n"
+		" --root-xattr-isize=#   ensure the inline xattr size of the root directory is # bytes at least\n"
+		" --aufs                 replace aufs special files with overlayfs metadata\n"
+		" --sort=<path,none>     data sorting order for tarballs as input (default: path)\n"
 #ifdef S3EROFS_ENABLED
-		" --s3=X                generate an image from S3-compatible object store\n"
-		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
-		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
-		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
-		"   [,region=W]         W=region code in which endpoint belongs to (required for sig=4)\n"
+		" --s3=X                 generate an image from S3-compatible object store\n"
+		"   [,passwd_file=Y]     X=endpoint, Y=s3fs-compatible password file\n"
+		"   [,urlstyle=Z]        S3 API calling style (Z = vhost|path) (default: vhost)\n"
+		"   [,sig=<2,4>]         S3 API signature version (default: 2)\n"
+		"   [,region=W]          W=region code in which endpoint belongs to (required for sig=4)\n"
 #endif
 #ifdef OCIEROFS_ENABLED
-		" --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
-		"   [,platform=X]       X=platform (default: linux/amd64)\n"
-		"   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
-		"   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
-		"   [,username=Z]       Z=username for authentication (optional)\n"
-		"   [,password=W]       W=password for authentication (optional)\n"
-		"   [,insecure]         use HTTP instead of HTTPS (optional)\n"
+		" --oci=[f|i]            generate a full (f) or index-only (i) image from OCI remote source\n"
+		"   [,platform=X]        X=platform (default: linux/amd64)\n"
+		"   [,layer=#]           #=layer index to extract (0-based; omit to extract all layers)\n"
+		"   [,blob=Y]            Y=blob digest to extract (omit to extract all layers)\n"
+		"   [,username=Z]        Z=username for authentication (optional)\n"
+		"   [,password=W]        W=password for authentication (optional)\n"
+		"   [,insecure]          use HTTP instead of HTTPS (optional)\n"
 #endif
-		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
-		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
-		"                                            headerball=file data is omited in the source stream)\n"
-		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
-		" --quiet               quiet execution (do not write anything to standard output.)\n"
+		" --tar=X                generate a full or index-only image from a tarball(-ish) source\n"
+		"                        (X = f|i|headerball; f=full mode, i=index mode,\n"
+		"                                             headerball=file data is omitted in the source stream)\n"
+		" --ovlfs-strip=<0,1>    strip overlayfs metadata in the target image (e.g. whiteouts)\n"
+		" --quiet                quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
-		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
-		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
+		" --random-pclusterblks  randomize pclusterblks for big pcluster (debugging only)\n"
+		" --random-algorithms    randomize per-file algorithms (debugging only)\n"
 #endif
 #ifdef HAVE_ZLIB
-		" --ungzip[=X]          try to filter the tarball stream through gzip\n"
-		"                       (and optionally dump the raw stream to X together)\n"
+		" --ungzip[=X]           try to filter the tarball stream through gzip\n"
+		"                        (and optionally dump the raw stream to X together)\n"
 #endif
 #ifdef HAVE_LIBLZMA
-		" --unxz[=X]            try to filter the tarball stream through xz/lzma/lzip\n"
-		"                       (and optionally dump the raw stream to X together)\n"
+		" --unxz[=X]             try to filter the tarball stream through xz/lzma/lzip\n"
+		"                        (and optionally dump the raw stream to X together)\n"
 #endif
 #ifdef HAVE_ZLIB
-		" --gzinfo[=X]          generate AWS SOCI-compatible zinfo in order to support random gzip access\n"
+		" --gzinfo[=X]           generate AWS SOCI-compatible zinfo in order to support random gzip access\n"
 #endif
-		" --vmdk-desc=X         generate a VMDK descriptor file to merge sub-filesystems\n"
+		" --vmdk-desc=X          generate a VMDK descriptor file to merge sub-filesystems\n"
 #ifdef EROFS_MT_ENABLED
-		" --workers=#           set the number of worker threads to # (default: %u)\n"
+		" --workers=#            set the number of worker threads to # (default: %u)\n"
 #endif
-		" --xattr-prefix=X      X=extra xattr name prefix\n"
-		" --zfeature-bits=#     toggle filesystem compression features according to given bits #\n"
+		" --xattr-inode-digest=X specify extended attribute name X to record inode digests\n"
+		" --xattr-prefix=X       X=extra xattr name prefix\n"
+		" --zfeature-bits=#      toggle filesystem compression features according to given bits #\n"
 #ifdef WITH_ANDROID
 		"\n"
 		"Android-specific options:\n"
-		" --product-out=X       X=product_out directory\n"
-		" --fs-config-file=X    X=fs_config file\n"
+		" --product-out=X        X=product_out directory\n"
+		" --fs-config-file=X     X=fs_config file\n"
 #endif
 #ifdef EROFS_MT_ENABLED
 		, erofs_get_available_processors() /* --workers= */
@@ -1259,16 +1261,6 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				return -EINVAL;
 			}
 			break;
-		case 19:
-			errno = 0;
-			opt = erofs_xattr_insert_name_prefix(optarg);
-			if (opt) {
-				erofs_err("failed to parse xattr name prefix: %s",
-					  erofs_strerror(opt));
-				return opt;
-			}
-			cfg.c_extra_ea_name_prefixes = true;
-			break;
 		case 20:
 			mkfs_parse_tar_cfg(optarg);
 			break;
@@ -1424,6 +1416,24 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			else
 				mkfscfg.inode_metazone = false;
 			break;
+		case 538:
+			errno = 0;
+			opt = erofs_xattr_insert_name_prefix(optarg);
+			if (opt < 0) {
+				erofs_err("failed to parse xattr name prefix: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			cfg.c_extra_ea_name_prefixes = true;
+			break;
+		case 539:
+			err = erofs_xattr_set_ishare_prefix(&g_sbi, optarg);
+			if (err < 0) {
+				erofs_err("failed to parse ishare name: %s",
+					  erofs_strerror(err));
+				return err;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1878,9 +1888,13 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 
-		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_flush_name_prefixes(&importer,
-							mkfs_plain_xattr_pfx);
+		err = erofs_xattr_flush_name_prefixes(&importer,
+						      mkfs_plain_xattr_pfx);
+		if (err) {
+			erofs_err("failed to flush long xattr prefixes: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
 
 		root = erofs_new_inode(&g_sbi);
 		if (IS_ERR(root)) {
@@ -1888,6 +1902,14 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 	} else {
+		err = erofs_xattr_flush_name_prefixes(&importer,
+						      mkfs_plain_xattr_pfx);
+		if (err) {
+			erofs_err("failed to flush long xattr prefixes: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
+
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
-- 
2.43.5


