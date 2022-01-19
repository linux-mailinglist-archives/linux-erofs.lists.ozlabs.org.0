Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0A4932C4
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 03:14:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jdq3F53phz30MG
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 13:14:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B0fZ8TA7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B0fZ8TA7; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jdq372S25z2xRp
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jan 2022 13:14:43 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 15BF4B816D9;
 Wed, 19 Jan 2022 02:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E17BC340E0;
 Wed, 19 Jan 2022 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642558477;
 bh=IsKtXzIJDDsfCSbrurGPM9mzA/WVzbhui4iXsa+Nm2E=;
 h=From:To:Cc:Subject:Date:From;
 b=B0fZ8TA7W/llodXfrJk+KcLBzs2QMyaci5NFHzo5butQtUMWFFJrRbbQJaQRHNAkw
 tNKEV2fqzzaT+1ivorX9RqMaISdPfFNZC7hFWXDZzsnidSmZS9Q+rdDrDd0mmhuAPE
 Su8oF9F6cVdjZhXJXuA7QgHi+8eEjKWFSMD40O5E/ezHgaCwbPNmJ/86TJ/u/JE1M7
 rwSnDEPCtIrUScu5pFkf1l5BPuNniLzmNsuqJ3zOtNKZO7oPePvieBWp42b2LmuInQ
 QQhcxU4983StqRTdbYsyrjb45qD+niwjAUb95sQrWd3AlTgZ+oJuUlxuFiNyIHDITG
 FktNcPCZyXv8w==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] [WIP] erofs-utils: fsck support for --extract=X to
 extract to path X
Date: Wed, 19 Jan 2022 10:13:48 +0800
Message-Id: <20220119021348.7303-1-xiang@kernel.org>
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
Cc: Igor Ostapenko <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Igor Ostapenko <igoreisberg@gmail.com>

Add support to extract directories, regular files and symlinks.
Allocation for extract_path is done only once, then the buffer is
reused.

Raw and compressed data chunks are handled with a unified function
to avoid code duplication, compressed data is verified linearly (with
EROFS_GET_BLOCKS_FIEMAP) instead of lookback, as it's problematic to
extract data when looking backwards.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fsck/main.c | 483 ++++++++++++++++++++++++++++++++++++----------------
 mkfs/main.c |   2 +-
 2 files changed, 337 insertions(+), 148 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 30d0a1b..94cacfd 100644
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
@@ -18,6 +20,9 @@ struct erofsfsck_cfg {
 	bool corrupted;
 	bool print_comp_ratio;
 	bool check_decomp;
+	char *extract_path;
+	size_t extract_pos;
+	bool force;
 	u64 physical_blocks;
 	u64 logical_blocks;
 };
@@ -25,8 +30,9 @@ static struct erofsfsck_cfg fsckcfg;
 
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
-	{"extract", no_argument, 0, 2},
+	{"extract", optional_argument, 0, 2},
 	{"device", required_argument, 0, 3},
+	{"force", no_argument, 0, 4},
 	{0, 0, 0, 0},
 };
 
@@ -34,12 +40,13 @@ static void usage(void)
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
+	      " --force         if file already exists then overwrite (--extract=X is required)\n"
+	      " --help          display this help and exit\n",
 	      stderr);
 }
 
@@ -74,6 +81,22 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			exit(0);
 		case 2:
 			fsckcfg.check_decomp = true;
+			if (optarg) {
+				size_t len = strlen(optarg);
+				if (len == 0)
+					return -EINVAL;
+
+				/* remove trailing slashes except root */
+				while (len > 1 && optarg[len - 1] == '/')
+					len--;
+
+				fsckcfg.extract_path = malloc(PATH_MAX);
+				if (!fsckcfg.extract_path)
+					return -ENOMEM;
+				strncpy(fsckcfg.extract_path, optarg, len);
+				fsckcfg.extract_path[len] = '\0';
+				fsckcfg.extract_pos = len;
+			}
 			break;
 		case 3:
 			ret = blob_open_ro(optarg);
@@ -81,6 +104,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return ret;
 			++sbi.extra_devices;
 			break;
+		case 4:
+			fsckcfg.force = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -89,6 +115,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	if (optind >= argc)
 		return -EINVAL;
 
+	if (fsckcfg.force && !fsckcfg.extract_path)
+		return -EINVAL;
+
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
@@ -100,6 +129,25 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
+{
+	int ret;
+	struct utimbuf ut;
+
+	ut.actime = inode->i_ctime;
+	ut.modtime = inode->i_ctime;
+	if (utime(path, &ut) < 0)
+		erofs_warn("failed to set times: %s", path);
+
+	ret = chmod(path, inode->i_mode);
+	if (ret < 0)
+		erofs_warn("failed to set permissions: %s", path);
+
+	ret = chown(path, inode->i_uid, inode->i_gid);
+	if (ret < 0)
+		erofs_warn("failed to change ownership: %s", path);
+}
+
 static int erofs_check_sb_chksum(void)
 {
 	int ret;
@@ -127,137 +175,6 @@ static int erofs_check_sb_chksum(void)
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
@@ -336,9 +253,18 @@ out:
 	return ret;
 }
 
-static int erofs_verify_inode_data(struct erofs_inode *inode)
+static int erofs_verify_inode_data(struct erofs_inode *inode, int extract_fd)
 {
-	int ret;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	struct erofs_map_dev mdev;
+	int ret = 0;
+	bool compressed;
+	erofs_off_t pos = 0;
+	u64 pchunk_len = 0;
+	unsigned int raw_size = 0, buffer_size = 0;
+	char *raw = NULL, *buffer = NULL;
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
 		  inode->nid | 0ULL, inode->datalayout);
@@ -347,30 +273,270 @@ static int erofs_verify_inode_data(struct erofs_inode *inode)
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
+	}
+
+	while (pos < inode->i_size) {
+		map.m_la = pos;
+		if (compressed)
+			ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+		else
+			ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+		if (ret)
+			goto out;
+
+		if (!compressed && map.m_llen != map.m_plen) {
+			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
+				  map.m_la, map.m_llen, map.m_plen);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		/* the last lcluster can be devided into 3 parts */
+		if (map.m_la + map.m_llen > inode->i_size)
+			map.m_llen = inode->i_size - map.m_la;
+
+		pchunk_len += map.m_plen;
+		pos += map.m_llen;
+
+		/* should skip decomp? */
+		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
+			continue;
+
+		if (map.m_plen > raw_size) {
+			raw_size = map.m_plen;
+			raw = realloc(raw, raw_size);
+			BUG_ON(!raw);
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
+		if (compressed && map.m_llen > buffer_size) {
+			buffer_size = map.m_llen;
+			buffer = realloc(buffer, buffer_size);
+			BUG_ON(!buffer);
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
+			struct z_erofs_decompress_req rq = {
+				.in = raw,
+				.out = buffer,
+				.decodedskip = 0,
+				.inputsize = map.m_plen,
+				.decodedlength = map.m_llen,
+				.alg = map.m_algorithmformat,
+				.partial_decoding = 0
+			};
+
+			ret = z_erofs_decompress(&rq);
+			if (ret < 0) {
+				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
+					  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+				goto out;
+			}
+		}
+
+		if (extract_fd >= 0 && write(extract_fd,
+					     compressed ? buffer : raw,
+					     map.m_llen) < 0) {
+			erofs_err("I/O error occurred when verifying data chunk of nid(%llu)",
+				  inode->nid | 0ULL);
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
+	return ret < 0 ? ret : 0;
+}
+
+static inline int erofs_extract_dir(struct erofs_inode *inode)
+{
+	int ret;
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode, -1);
+	if (ret)
+		return ret;
+
+	erofs_dbg("create directory %s", fsckcfg.extract_path);
+
+	/*
+	 * Make directory with default user RWX permissions rather than
+	 * the permissions from the filesystem, as these may not have
+	 * write/execute permission.  These are fixed up later in
+	 * erofsfsck_set_attributes().
+	 */
+	if (mkdir(fsckcfg.extract_path, S_IRWXU) < 0) {
+		struct stat st;
+
+		/*
+		 * Skip directory if mkdir fails, unless we're
+		 * forcing and the error is -EEXIST
+		 */
+		if(!fsckcfg.force || errno != EEXIST) {
+			erofs_err("failed to create directory: %s",
+				  fsckcfg.extract_path);
+			return -errno;
+		}
+
+		if (lstat(fsckcfg.extract_path, &st) ||
+		    !S_ISDIR(st.st_mode)) {
+			erofs_err("path is not a directory: %s",
+				  fsckcfg.extract_path);
+			return -ENOTDIR;
+		}
+	}
+	return 0;
+}
+
+static inline int erofs_extract_file(struct erofs_inode *inode)
+{
+	bool tryagain = true;
+	int ret, fd;
+
+	erofs_dbg("extract file to path: %s", fsckcfg.extract_path);
+
+again:
+	fd = open(fsckcfg.extract_path,
+		  O_WRONLY | O_CREAT | (fsckcfg.force ? O_TRUNC : 0),
+		  (mode_t) inode->i_mode & 0777);
+	if (fd < 0) {
+		if (errno == EISDIR && fsckcfg.force && tryagain) {
+			erofs_warn("try to forcely remove directory %s",
+				   fsckcfg.extract_path);
+			if (rmdir(fsckcfg.extract_path) < 0) {
+				erofs_err("failed to remove: %s",
+					  fsckcfg.extract_path);
+				return -EISDIR;
+			}
+			tryagain = false;
+			goto again;
+		}
+		erofs_err("failed to open file: %s", fsckcfg.extract_path);
+		return -errno;
 	}
 
-	if (ret == -EIO)
-		erofs_err("I/O error occurred when verifying data chunk of nid(%llu)",
-			  inode->nid | 0ULL);
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode, fd);
+	if (ret)
+		return ret;
 
+	if (close(fd))
+		return -errno;
+	return ret;
+}
+
+static inline int erofs_extract_symlink(struct erofs_inode *inode)
+{
+	bool tryagain = true;
+	int ret;
+	char *buf = NULL;
+
+	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode, -1);
+	if (ret)
+		return ret;
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
+again:
+	if (symlink(buf, fsckcfg.extract_path) < 0) {
+		if (errno == EEXIST && fsckcfg.force && tryagain) {
+			erofs_warn("try to forcely remove file %s",
+				   fsckcfg.extract_path);
+			if (unlink(fsckcfg.extract_path) < 0) {
+				erofs_err("failed to remove: %s",
+					  fsckcfg.extract_path);
+				ret = -errno;
+				goto out;
+			}
+			tryagain = false;
+			goto again;
+		}
+		erofs_err("failed to create symlink: %s", fsckcfg.extract_path);
+		ret = -errno;
+	}
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
+		strncpy(fsckcfg.extract_path + curr_pos, ctx->dname,
+			ctx->de_namelen);
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
@@ -394,8 +560,25 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
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
+		ret = erofs_verify_inode_data(&inode, -1);
+	}
 	if (ret)
 		goto out;
 
@@ -410,6 +593,10 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 
 		ret = erofs_iterate_dir(&ctx, true);
 	}
+
+	if (!ret)
+		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
+
 out:
 	if (ret && ret != -EIO)
 		fsckcfg.corrupted = true;
@@ -425,6 +612,8 @@ int main(int argc, char **argv)
 	fsckcfg.corrupted = false;
 	fsckcfg.print_comp_ratio = false;
 	fsckcfg.check_decomp = false;
+	fsckcfg.extract_path = NULL;
+	fsckcfg.extract_pos = 0;
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

