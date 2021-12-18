Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C913A479BDF
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 18:27:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JGXpc4yQbz3053
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Dec 2021 04:27:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=F86RZxOO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a;
 helo=mail-ed1-x52a.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=F86RZxOO; dkim-atps=neutral
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JGXpS1mJsz2yS3
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 Dec 2021 04:26:54 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so20625012edd.0
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbhs36WdTC296FuoEeiNR8FU9e69Qb+6/JKPhSDon8w=;
 b=F86RZxOOTgZYlqWr4rBq2DpENOUk3T2/cX6geLRlGUKxQVLtWyWhKaF/v/Ic52jsHm
 Pu88f0xI59kDdbAgaripaWH+HTpARRCAfHGzLwUi3Do4xQkHULto4s6Ueq74sPzr6pub
 WJeIElDrjKya/TxogDZXPugvgIUZ+C81XmmuCbSwySu/WbPEKcWbTVlt/Sv5NP/hRZ/R
 zjmY+gxyQQcken2qO5UOXWgvDF0OKN0LxjpXZzau6mK9ld2fWoAXll7r/9+NX9pTeSlW
 Cvzb3Oa8OrD4g9Fex0rXV2wE9D6eJMp5SYmL2Bfa/MWT6JLAWJfocPmiqtg6btA93Ebr
 tFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbhs36WdTC296FuoEeiNR8FU9e69Qb+6/JKPhSDon8w=;
 b=nFdG3wXsMUw3kYDXoa6pRg+oy6uhhdMJs50P7ne4TvK8GduWhwuH/PP1Vvwi8DLkTi
 dQI5uHhmSRRlrLKHktI1j5iuZJvZUnIB28DHSYIxrdmXLvkHnauGw9kBbk0MTzhaT0I7
 JJ3Gp/Exgn4WWCoRgxKo7q5p0jhu7RWa0Byfh/HaFpkZGIhe1Y25x7d0Nt7sJf9bxHQR
 C8CM8C5HSU4WquYMcwAQ4PyPAKHYEXpZaeIEmDViYQqeKDTpmp2xsaKWlumZsB82fKQP
 QKmmFWHmrO+VRqbvdGQGtW6eB2PCziK1Lq+uph+7bZH7BgUBnHTdFjfVvfKt9sVSXxiv
 QRSA==
X-Gm-Message-State: AOAM530PtuxjbieKOF4SkJa7jGdbRfyaG4+GmnO5OPJ41AMmohKG2gji
 EHpYcdL9BdgNgk1r5EF9g8nfCb86IhZBKg==
X-Google-Smtp-Source: ABdhPJyRF82vyVoYVIkR1cOKToqZkc07wbbNqCb+hl1AWBunQDR5EXOzgjeIL0+geu9M/7YlJHhYqg==
X-Received: by 2002:a17:906:4789:: with SMTP id
 cw9mr7170539ejc.518.1639848405756; 
 Sat, 18 Dec 2021 09:26:45 -0800 (PST)
Received: from Iceberg-PC.localdomain ([141.226.246.67])
 by smtp.gmail.com with ESMTPSA id qw20sm609066ejc.185.2021.12.18.09.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Dec 2021 09:26:45 -0800 (PST)
From: IgorEisberg <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck support for --extract=X to extract to path X
Date: Sat, 18 Dec 2021 19:26:36 +0200
Message-Id: <20211218172636.1153-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
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
Cc: IgorEisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Extracts dirs, regular files and symlinks (overwrite enabled with warnings,
mainly for use with WSL for debugging, in case certain files overlap,
i.e. "path/to/file/alarm" and "path/to/file/Alarm").
Allocation for extract_path is done only once, then the buffer is reused.
Raw and compressed data chunks are handled with a unified function to avoid
repeats, compressed data is verified lineary (with EROFS_GET_BLOCKS_FIEMAP)
instead of lookback, as it's problematic to extract data when looping
backwards.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 482 ++++++++++++++++++++++++++++++++++++----------------
 mkfs/main.c |   2 +-
 2 files changed, 339 insertions(+), 145 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 30d0a1b..c1ec25e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -6,6 +6,8 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include <utime.h>
+#include <unistd.h>
 #include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/io.h"
@@ -18,6 +20,10 @@ struct erofsfsck_cfg {
 	bool corrupted;
 	bool print_comp_ratio;
 	bool check_decomp;
+	char *extract_path;
+	size_t extract_pos;
+	int extract_fd;
+	bool preserve;
 	u64 physical_blocks;
 	u64 logical_blocks;
 };
@@ -25,8 +31,9 @@ static struct erofsfsck_cfg fsckcfg;
 
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
-	{"extract", no_argument, 0, 2},
-	{"device", required_argument, 0, 3},
+	{"extract", optional_argument, 0, 2},
+	{"preserve", no_argument, 0, 3},
+	{"device", required_argument, 0, 4},
 	{0, 0, 0, 0},
 };
 
@@ -34,12 +41,13 @@ static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 	      "Check erofs filesystem integrity of IMAGE, and [options] are:\n"
-	      " -V              print the version number of fsck.erofs and exit.\n"
+	      " -V              print the version number of fsck.erofs and exit\n"
 	      " -d#             set output message level to # (maximum 9)\n"
 	      " -p              print total compression ratio of all files\n"
 	      " --device=X      specify an extra device to be used together\n"
-	      " --extract       check if all files are well encoded\n"
-	      " --help          display this help and exit.\n",
+	      " --extract[=X]   check if all files are well encoded, optionally extract to X\n"
+	      " --preserve      preserve mode, owner and group (--extract=X is required)\n"
+	      " --help          display this help and exit\n",
 	      stderr);
 }
 
@@ -74,8 +82,29 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			exit(0);
 		case 2:
 			fsckcfg.check_decomp = true;
+			if (optarg) {
+				size_t len = strlen(optarg);
+				if (len == 0)
+					return -EINVAL;
+				/* remove trailing slashes except root */
+				while (len > 1 && optarg[len - 1] == '/')
+					len--;
+
+				fsckcfg.extract_path = malloc(PATH_MAX);
+				if (!fsckcfg.extract_path)
+					return -ENOMEM;
+
+				strncpy(fsckcfg.extract_path, optarg, len);
+				fsckcfg.extract_path[len] = '\0';
+				if (len == 1 && fsckcfg.extract_path[0] == '/')
+					len = 0;
+				fsckcfg.extract_pos = len;
+			}
 			break;
 		case 3:
+			fsckcfg.preserve = true;
+			break;
+		case 4:
 			ret = blob_open_ro(optarg);
 			if (ret)
 				return ret;
@@ -89,6 +118,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	if (optind >= argc)
 		return -EINVAL;
 
+	if (fsckcfg.preserve && !fsckcfg.extract_path)
+		return -EINVAL;
+
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
@@ -100,6 +132,25 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static void erofsfsck_restore_stat(struct erofs_inode *inode, char *path)
+{
+	int ret;
+	struct utimbuf ut;
+
+	ret = chmod(path, inode->i_mode);
+	if (ret < 0)
+		erofs_warn("failed to set permissions: %s", path);
+
+	ret = chown(path, inode->i_uid, inode->i_gid);
+	if (ret < 0)
+		erofs_warn("failed to change ownership: %s", path);
+
+	ut.actime = inode->i_ctime;
+	ut.modtime = inode->i_ctime;
+	if (utime(path, &ut) < 0)
+		erofs_warn("failed to set times: %s", path);
+}
+
 static int erofs_check_sb_chksum(void)
 {
 	int ret;
@@ -127,137 +178,6 @@ static int erofs_check_sb_chksum(void)
 	return 0;
 }
 
-static int verify_uncompressed_inode(struct erofs_inode *inode)
-{
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
-	int ret;
-	erofs_off_t ptr = 0;
-	u64 i_blocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-
-	while (ptr < inode->i_size) {
-		map.m_la = ptr;
-		ret = erofs_map_blocks(inode, &map, 0);
-		if (ret)
-			return ret;
-
-		if (map.m_plen != map.m_llen || ptr != map.m_la) {
-			erofs_err("broken data chunk layout m_la %" PRIu64 " ptr %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
-				  map.m_la, ptr, map.m_llen, map.m_plen);
-			return -EFSCORRUPTED;
-		}
-
-		if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen) {
-			/* reached EOF */
-			ptr = inode->i_size;
-			continue;
-		}
-
-		ptr += map.m_llen;
-	}
-
-	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += i_blocks;
-		fsckcfg.physical_blocks += i_blocks;
-	}
-
-	return 0;
-}
-
-static int verify_compressed_inode(struct erofs_inode *inode)
-{
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
-	struct erofs_map_dev mdev;
-	int ret = 0;
-	u64 pchunk_len = 0;
-	erofs_off_t end = inode->i_size;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
-
-	while (end > 0) {
-		map.m_la = end - 1;
-
-		ret = z_erofs_map_blocks_iter(inode, &map, 0);
-		if (ret)
-			goto out;
-
-		if (end > map.m_la + map.m_llen) {
-			erofs_err("broken compressed chunk layout m_la %" PRIu64 " m_llen %" PRIu64 " end %" PRIu64,
-				  map.m_la, map.m_llen, end);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		pchunk_len += map.m_plen;
-		end = map.m_la;
-
-		if (!fsckcfg.check_decomp || !(map.m_flags & EROFS_MAP_MAPPED))
-			continue;
-
-		if (map.m_plen > raw_size) {
-			raw_size = map.m_plen;
-			raw = realloc(raw, raw_size);
-			BUG_ON(!raw);
-		}
-
-		if (map.m_llen > buffer_size) {
-			buffer_size = map.m_llen;
-			buffer = realloc(buffer, buffer_size);
-			BUG_ON(!buffer);
-		}
-
-		mdev = (struct erofs_map_dev) {
-			.m_deviceid = map.m_deviceid,
-			.m_pa = map.m_pa,
-		};
-		ret = erofs_map_dev(&sbi, &mdev);
-		if (ret) {
-			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
-				  map.m_pa, map.m_deviceid, inode->nid | 0ULL, ret);
-			goto out;
-		}
-
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
-		if (ret < 0) {
-			erofs_err("failed to read compressed data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
-			goto out;
-		}
-
-		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
-					.in = raw,
-					.out = buffer,
-					.decodedskip = 0,
-					.inputsize = map.m_plen,
-					.decodedlength = map.m_llen,
-					.alg = map.m_algorithmformat,
-					.partial_decoding = 0
-					 });
-
-		if (ret < 0) {
-			erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
-			goto out;
-		}
-	}
-
-	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks +=
-			DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-		fsckcfg.physical_blocks +=
-			DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
-	}
-out:
-	if (raw)
-		free(raw);
-	if (buffer)
-		free(buffer);
-	return ret < 0 ? ret : 0;
-}
-
 static int erofs_verify_xattr(struct erofs_inode *inode)
 {
 	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
@@ -338,7 +258,16 @@ out:
 
 static int erofs_verify_inode_data(struct erofs_inode *inode)
 {
-	int ret;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	struct erofs_map_dev mdev;
+	int ret = 0;
+	bool compressed;
+	erofs_off_t ptr = 0;
+	u64 pchunk_len = 0;
+	unsigned int raw_size = 0, buffer_size = 0;
+	char *raw = NULL, *buffer = NULL;
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
 		  inode->nid | 0ULL, inode->datalayout);
@@ -347,30 +276,275 @@ static int erofs_verify_inode_data(struct erofs_inode *inode)
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
-		ret = verify_uncompressed_inode(inode);
+		compressed = false;
 		break;
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		ret = verify_compressed_inode(inode);
+		compressed = true;
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		erofs_err("unknown datalayout");
+		return -EINVAL;
 	}
 
+	while (ptr < inode->i_size) {
+		map.m_la = ptr;
+		if (compressed)
+			ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+		else
+			ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+		if (ret)
+			goto out;
+
+		if (compressed) {
+			if (ptr != map.m_la || map.m_la + map.m_llen > inode->i_size) {
+				erofs_err("broken compressed chunk layout ptr %" PRIu64 " m_la %" PRIu64 " m_llen %" PRIu64 " i_size %" PRIu64,
+					  ptr, map.m_la, map.m_llen, inode->i_size);
+				ret = -EFSCORRUPTED;
+				goto out;
+			}
+		} else {
+			if (ptr != map.m_la || map.m_llen != map.m_plen) {
+				erofs_err("broken data chunk layout ptr %" PRIu64 " m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
+					  ptr, map.m_la, map.m_llen, map.m_plen);
+				ret = -EFSCORRUPTED;
+				goto out;
+			}
+
+			if (map.m_la + map.m_llen > inode->i_size)
+				map.m_llen = inode->i_size - map.m_la;
+		}
+
+		pchunk_len += map.m_plen;
+		ptr += map.m_llen;
+
+		/* reached EOF? */
+		if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen)
+			break;
+
+		/* should skip decomp? */
+		if (!fsckcfg.check_decomp)
+			continue;
+
+		if (map.m_plen > raw_size) {
+			raw_size = map.m_plen;
+			raw = realloc(raw, raw_size);
+			BUG_ON(!raw);
+		}
+
+		if (compressed && map.m_llen > buffer_size) {
+			buffer_size = map.m_llen;
+			buffer = realloc(buffer, buffer_size);
+			BUG_ON(!buffer);
+		}
+
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(&sbi, &mdev);
+		if (ret) {
+			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
+				  map.m_pa, map.m_deviceid, inode->nid | 0ULL, ret);
+			goto out;
+		}
+
+		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		if (ret < 0) {
+			erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
+				  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+			goto out;
+		}
+
+		if (compressed) {
+			ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+						.in = raw,
+						.out = buffer,
+						.decodedskip = 0,
+						.inputsize = map.m_plen,
+						.decodedlength = map.m_llen,
+						.alg = map.m_algorithmformat,
+						.partial_decoding = 0
+						 });
+
+			if (ret < 0) {
+				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
+					  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+				goto out;
+			}
+		}
+
+		if (fsckcfg.extract_fd != -1 &&
+			  write(fsckcfg.extract_fd, compressed ? buffer : raw, map.m_llen) < 0) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	if (fsckcfg.print_comp_ratio) {
+		fsckcfg.logical_blocks +=
+			DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+		fsckcfg.physical_blocks +=
+			DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
+	}
+out:
+	if (raw)
+		free(raw);
+	if (buffer)
+		free(buffer);
 	if (ret == -EIO)
 		erofs_err("I/O error occurred when verifying data chunk of nid(%llu)",
 			  inode->nid | 0ULL);
+	return ret < 0 ? ret : 0;
+}
+
+static inline int erofs_extract_dir(struct erofs_inode *inode)
+{
+	int ret;
+	struct stat sb;
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode);
+	if (ret)
+		return ret;
+
+	erofs_dbg("create directory on path: %s", fsckcfg.extract_path);
+
+	if (!lstat(fsckcfg.extract_path, &sb)) {
+		if (!S_ISDIR(sb.st_mode)) {
+			erofs_err("path is not a directory: %s", fsckcfg.extract_path);
+			return -EIO;
+		}
+	} else if (errno != ENOENT || mkdir(fsckcfg.extract_path, S_IRWXU) < 0) {
+		erofs_err("failed to create directory: %s", fsckcfg.extract_path);
+		return -EIO;
+	}
+
+	if (fsckcfg.preserve)
+		erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+	return 0;
+}
+
+static inline int erofs_extract_file(struct erofs_inode *inode)
+{
+	int ret;
+	struct stat sb;
+	int fsync_fail, close_fail;
+
+	erofs_dbg("extract file to path: %s", fsckcfg.extract_path);
+
+	if (!lstat(fsckcfg.extract_path, &sb)) {
+		if (S_ISDIR(sb.st_mode)) {
+			erofs_err("path is a directory: %s", fsckcfg.extract_path);
+			return -EIO;
+		}
+		erofs_warn("overwriting: %s", fsckcfg.extract_path);
+		if (unlink(fsckcfg.extract_path) < 0) {
+			erofs_err("failed to remove file: %s", fsckcfg.extract_path);
+			return -EIO;
+		}
+	}
+
+	fsckcfg.extract_fd = open(fsckcfg.extract_path, O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
+	if (fsckcfg.extract_fd < 0) {
+		erofs_err("failed to open file: %s", fsckcfg.extract_path);
+		return -EIO;
+	}
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode);
+
+	fsync_fail = fsync(fsckcfg.extract_fd) != 0;
+	close_fail = close(fsckcfg.extract_fd) != 0;
+	fsckcfg.extract_fd = -1;
+
+	if (ret)
+		return ret;
+	if (fsync_fail || close_fail)
+		return -EIO;
+	if (fsckcfg.preserve)
+		erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+	return ret;
+}
+
+static inline int erofs_extract_symlink(struct erofs_inode *inode)
+{
+	int ret;
+	struct stat sb;
+	char *buf = NULL;
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode);
+	if (ret)
+		return ret;
 
+	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
+
+	if (!lstat(fsckcfg.extract_path, &sb)) {
+		if (S_ISDIR(sb.st_mode)) {
+			erofs_err("path is a directory: %s", fsckcfg.extract_path);
+			return -EIO;
+		}
+		erofs_warn("overwriting: %s", fsckcfg.extract_path);
+		if (unlink(fsckcfg.extract_path) < 0) {
+			erofs_err("failed to remove file: %s", fsckcfg.extract_path);
+			return -EIO;
+		}
+	}
+
+	buf = malloc(inode->i_size + 1);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = erofs_pread(inode, buf, inode->i_size, 0);
+	if (ret) {
+		erofs_err("I/O error occurred when reading symlink @ nid %llu: %d",
+			  inode->nid | 0ULL, ret);
+		goto out;
+	}
+
+	buf[inode->i_size] = '\0';
+	if (symlink(buf, fsckcfg.extract_path) < 0) {
+		erofs_err("failed to create symlink: %s", fsckcfg.extract_path);
+		ret = -EIO;
+		goto out;
+	}
+
+	if (fsckcfg.preserve)
+		erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+out:
+	if (buf)
+		free(buf);
 	return ret;
 }
 
 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
+	int ret;
+	size_t prev_pos = fsckcfg.extract_pos;
+
 	if (ctx->dot_dotdot)
 		return 0;
 
-	return erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+	if (fsckcfg.extract_path) {
+		size_t curr_pos = prev_pos;
+
+		fsckcfg.extract_path[curr_pos++] = '/';
+		strncpy(fsckcfg.extract_path + curr_pos, ctx->dname, ctx->de_namelen);
+		curr_pos += ctx->de_namelen;
+		fsckcfg.extract_path[curr_pos] = '\0';
+		fsckcfg.extract_pos = curr_pos;
+	}
+
+	ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+
+	if (fsckcfg.extract_path) {
+		fsckcfg.extract_path[prev_pos] = '\0';
+		fsckcfg.extract_pos = prev_pos;
+	}
+	return ret;
 }
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
@@ -394,8 +568,25 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	if (ret)
 		goto out;
 
-	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(&inode);
+	if (fsckcfg.extract_path) {
+		switch (inode.i_mode & S_IFMT) {
+		case S_IFDIR:
+			ret = erofs_extract_dir(&inode);
+			break;
+		case S_IFREG:
+			ret = erofs_extract_file(&inode);
+			break;
+		case S_IFLNK:
+			ret = erofs_extract_symlink(&inode);
+			break;
+		default:
+			goto verify;
+		}
+	} else {
+verify:
+		/* verify data chunk layout */
+		ret = erofs_verify_inode_data(&inode);
+	}
 	if (ret)
 		goto out;
 
@@ -425,6 +616,9 @@ int main(int argc, char **argv)
 	fsckcfg.corrupted = false;
 	fsckcfg.print_comp_ratio = false;
 	fsckcfg.check_decomp = false;
+	fsckcfg.extract_path = NULL;
+	fsckcfg.extract_pos = 0;
+	fsckcfg.extract_fd = -1;
 	fsckcfg.logical_blocks = 0;
 	fsckcfg.physical_blocks = 0;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 90cedde..1787b2c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -589,7 +589,7 @@ int main(int argc, char **argv)
 	err = lstat64(cfg.c_src_path, &st);
 	if (err)
 		return 1;
-	if ((st.st_mode & S_IFMT) != S_IFDIR) {
+	if (!S_ISDIR(st.st_mode)) {
 		erofs_err("root of the filesystem is not a directory - %s",
 			  cfg.c_src_path);
 		usage();
-- 
2.30.2

