Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEBE479BAA
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 17:07:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JGW2T3BtJz2yxW
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Dec 2021 03:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fhCyyZaL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d36;
 helo=mail-io1-xd36.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=fhCyyZaL; dkim-atps=neutral
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JGW2Q3QTCz2ynY
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 Dec 2021 03:07:08 +1100 (AEDT)
Received: by mail-io1-xd36.google.com with SMTP id p23so7326521iod.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 08:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=7Gf8g/dDEMht6DfjoPbcwBLOR9sXRYfWlHyPxi1b0c0=;
 b=fhCyyZaLm6ZxmVxlM+e2VipQOMJpg0hLGv30rRaVc3gBkT4HInhRh+EL99SFkjULGb
 WCsG4XIRSTEhzV06OcBs111HHzrCPhTfIoms++KjrGtLeUIZnXzZAiHgc7dA68Bw2+r9
 SlD9T6P0M3Lb17amYoDz4+vGCPYUGO4DWl1kRXvTbWUribPhTj7mL/olbDnXXA7zwPM9
 zq35KDbfRM8SBxuSsb61pIVU9bB4tXu82Z/CEPGRzmLCaiSzFYiPjNUGb7mkmHMFWUxj
 7dPIQ1uU5Il5f2pRUPvRgTsUhM3kGHREX6EG+AgT1AEsY0gWHTVGa4hoUUvhQYqRH1tp
 O+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7Gf8g/dDEMht6DfjoPbcwBLOR9sXRYfWlHyPxi1b0c0=;
 b=pjMyM62JZlGpbhQC249cNaBferufRKAUmUq60AArfhqyD06twQZi+DGSXdU2hykLyI
 DfYsawjelnDymlJF/c4WSkYdd+/dLLD1+xM06Oom+iST/o219vIhghIsGbo9kQxvDk/G
 xXwdAvFcfzM1DFwi6xMG/B3+r3T0OfvrXzCnR96U6uTD/25Sl0RqHL5SThox0LH6FJvT
 jGYtzordcaDJU5PagqQ8CMa1o67qBO42Vn2ckIZysHiiSxV6rKI7Om9zpbSrE6BITbpr
 PCz4zA9RuNG3Rynie+xo1RBaVv4FlGoofT7FEgIHYLvj5YBZbu260YHLFOMECW7Vk3cz
 Tgpw==
X-Gm-Message-State: AOAM532KdVInjkL6DlMmUbzQOjigOMbR/BtRwKYiHjdNwzRs/5MA3izP
 XkwXJfCKcDppN5o00n2no77LtL1ncbjAT/u2ZgjU3oaaSY4=
X-Google-Smtp-Source: ABdhPJyxvoOkpeIhRB5vVkPzRWsoH6wUBRBAlKPVEvK9i89mtfZIXI8po+tWMuw/SNCx+JK6lcyORddKNR4DMfm2wJA=
X-Received: by 2002:a05:6638:2646:: with SMTP id
 n6mr223490jat.153.1639843624796; 
 Sat, 18 Dec 2021 08:07:04 -0800 (PST)
MIME-Version: 1.0
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Sat, 18 Dec 2021 18:06:54 +0200
Message-ID: <CABjEcnFxwnPWT=n+c6DQ=5czh55=EV=girY-12HbeWmzwAX9Kw@mail.gmail.com>
Subject: erofs-utils: fsck support for --extract=X to extract to path X
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000be467c05d36dd85d"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000be467c05d36dd85d
Content-Type: text/plain; charset="UTF-8"

From 9b3c3256d3a630a7bfe825201e9ba06d67a81618 Mon Sep 17 00:00:00 2001
From: Igor Ostapenko <igoreisberg@gmail.com>
Date: Sat, 18 Dec 2021 18:01:46 +0200
Subject: erofs-utils: fsck support for --extract=X to extract to path X

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
index 30d0a1b..36d5d76 100644
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
+ char *extract_path;
+ size_t extract_pos;
+ int extract_fd;
+ bool preserve;
  u64 physical_blocks;
  u64 logical_blocks;
 };
@@ -25,8 +31,9 @@ static struct erofsfsck_cfg fsckcfg;

 static struct option long_options[] = {
  {"help", no_argument, 0, 1},
- {"extract", no_argument, 0, 2},
- {"device", required_argument, 0, 3},
+ {"extract", optional_argument, 0, 2},
+ {"preserve", no_argument, 0, 3},
+ {"device", required_argument, 0, 4},
  {0, 0, 0, 0},
 };

@@ -34,12 +41,13 @@ static void usage(void)
 {
  fputs("usage: [options] IMAGE\n\n"
        "Check erofs filesystem integrity of IMAGE, and [options] are:\n"
-       " -V              print the version number of fsck.erofs and
exit.\n"
+       " -V              print the version number of fsck.erofs and exit\n"
        " -d#             set output message level to # (maximum 9)\n"
        " -p              print total compression ratio of all files\n"
        " --device=X      specify an extra device to be used together\n"
-       " --extract       check if all files are well encoded\n"
-       " --help          display this help and exit.\n",
+       " --extract[=X]   check if all files are well encoded, optionally
extract to X\n"
+       " --preserve      preserve mode, owner and group (--extract=X is
required)\n"
+       " --help          display this help and exit\n",
        stderr);
 }

@@ -74,8 +82,29 @@ static int erofsfsck_parse_options_cfg(int argc, char
**argv)
  exit(0);
  case 2:
  fsckcfg.check_decomp = true;
+ if (optarg) {
+ size_t len = strlen(optarg);
+ if (len == 0)
+ return -EINVAL;
+ /* remove trailing slashes except root */
+ while (len > 1 && optarg[len - 1] == '/')
+ len--;
+
+ fsckcfg.extract_path = malloc(PATH_MAX);
+ if (!fsckcfg.extract_path)
+ return -ENOMEM;
+
+ strncpy(fsckcfg.extract_path, optarg, len);
+ fsckcfg.extract_path[len] = '\0';
+ if (optarg[0] == '/')
+ len = 0;
+ fsckcfg.extract_pos = len;
+ }
  break;
  case 3:
+ fsckcfg.preserve = true;
+ break;
+ case 4:
  ret = blob_open_ro(optarg);
  if (ret)
  return ret;
@@ -89,6 +118,9 @@ static int erofsfsck_parse_options_cfg(int argc, char
**argv)
  if (optind >= argc)
  return -EINVAL;

+ if (fsckcfg.preserve && !fsckcfg.extract_path)
+ return -EINVAL;
+
  cfg.c_img_path = strdup(argv[optind++]);
  if (!cfg.c_img_path)
  return -ENOMEM;
@@ -100,6 +132,25 @@ static int erofsfsck_parse_options_cfg(int argc, char
**argv)
  return 0;
 }

+static void erofsfsck_restore_stat(struct erofs_inode *inode, char *path)
+{
+ int ret;
+ struct utimbuf ut;
+
+ ret = chmod(path, inode->i_mode);
+ if (ret < 0)
+ erofs_warn("failed to set permissions: %s", path);
+
+ ret = chown(path, inode->i_uid, inode->i_gid);
+ if (ret < 0)
+ erofs_warn("failed to change ownership: %s", path);
+
+ ut.actime = inode->i_ctime;
+ ut.modtime = inode->i_ctime;
+ if (utime(path, &ut) < 0)
+ erofs_warn("failed to set times: %s", path);
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
- struct erofs_map_blocks map = {
- .index = UINT_MAX,
- };
- int ret;
- erofs_off_t ptr = 0;
- u64 i_blocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-
- while (ptr < inode->i_size) {
- map.m_la = ptr;
- ret = erofs_map_blocks(inode, &map, 0);
- if (ret)
- return ret;
-
- if (map.m_plen != map.m_llen || ptr != map.m_la) {
- erofs_err("broken data chunk layout m_la %" PRIu64 " ptr %" PRIu64 "
m_llen %" PRIu64 " m_plen %" PRIu64,
-   map.m_la, ptr, map.m_llen, map.m_plen);
- return -EFSCORRUPTED;
- }
-
- if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen) {
- /* reached EOF */
- ptr = inode->i_size;
- continue;
- }
-
- ptr += map.m_llen;
- }
-
- if (fsckcfg.print_comp_ratio) {
- fsckcfg.logical_blocks += i_blocks;
- fsckcfg.physical_blocks += i_blocks;
- }
-
- return 0;
-}
-
-static int verify_compressed_inode(struct erofs_inode *inode)
-{
- struct erofs_map_blocks map = {
- .index = UINT_MAX,
- };
- struct erofs_map_dev mdev;
- int ret = 0;
- u64 pchunk_len = 0;
- erofs_off_t end = inode->i_size;
- unsigned int raw_size = 0, buffer_size = 0;
- char *raw = NULL, *buffer = NULL;
-
- while (end > 0) {
- map.m_la = end - 1;
-
- ret = z_erofs_map_blocks_iter(inode, &map, 0);
- if (ret)
- goto out;
-
- if (end > map.m_la + map.m_llen) {
- erofs_err("broken compressed chunk layout m_la %" PRIu64 " m_llen %"
PRIu64 " end %" PRIu64,
-   map.m_la, map.m_llen, end);
- ret = -EFSCORRUPTED;
- goto out;
- }
-
- pchunk_len += map.m_plen;
- end = map.m_la;
-
- if (!fsckcfg.check_decomp || !(map.m_flags & EROFS_MAP_MAPPED))
- continue;
-
- if (map.m_plen > raw_size) {
- raw_size = map.m_plen;
- raw = realloc(raw, raw_size);
- BUG_ON(!raw);
- }
-
- if (map.m_llen > buffer_size) {
- buffer_size = map.m_llen;
- buffer = realloc(buffer, buffer_size);
- BUG_ON(!buffer);
- }
-
- mdev = (struct erofs_map_dev) {
- .m_deviceid = map.m_deviceid,
- .m_pa = map.m_pa,
- };
- ret = erofs_map_dev(&sbi, &mdev);
- if (ret) {
- erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid
%llu: %d",
-   map.m_pa, map.m_deviceid, inode->nid | 0ULL, ret);
- goto out;
- }
-
- ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
- if (ret < 0) {
- erofs_err("failed to read compressed data of m_pa %" PRIu64 ", m_plen %"
PRIu64 " @ nid %llu: %d",
-   mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
- goto out;
- }
-
- ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
- .in = raw,
- .out = buffer,
- .decodedskip = 0,
- .inputsize = map.m_plen,
- .decodedlength = map.m_llen,
- .alg = map.m_algorithmformat,
- .partial_decoding = 0
- });
-
- if (ret < 0) {
- erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %"
PRIu64 " @ nid %llu: %d",
-   mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
- goto out;
- }
- }
-
- if (fsckcfg.print_comp_ratio) {
- fsckcfg.logical_blocks +=
- DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
- fsckcfg.physical_blocks +=
- DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
- }
-out:
- if (raw)
- free(raw);
- if (buffer)
- free(buffer);
- return ret < 0 ? ret : 0;
-}
-
 static int erofs_verify_xattr(struct erofs_inode *inode)
 {
  unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
@@ -338,7 +258,16 @@ out:

 static int erofs_verify_inode_data(struct erofs_inode *inode)
 {
- int ret;
+ struct erofs_map_blocks map = {
+ .index = UINT_MAX,
+ };
+ struct erofs_map_dev mdev;
+ int ret = 0;
+ bool compressed;
+ erofs_off_t ptr = 0;
+ u64 pchunk_len = 0;
+ unsigned int raw_size = 0, buffer_size = 0;
+ char *raw = NULL, *buffer = NULL;

  erofs_dbg("verify data chunk of nid(%llu): type(%d)",
    inode->nid | 0ULL, inode->datalayout);
@@ -347,30 +276,275 @@ static int erofs_verify_inode_data(struct
erofs_inode *inode)
  case EROFS_INODE_FLAT_PLAIN:
  case EROFS_INODE_FLAT_INLINE:
  case EROFS_INODE_CHUNK_BASED:
- ret = verify_uncompressed_inode(inode);
+ compressed = false;
  break;
  case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
  case EROFS_INODE_FLAT_COMPRESSION:
- ret = verify_compressed_inode(inode);
+ compressed = true;
  break;
  default:
- ret = -EINVAL;
- break;
+ erofs_err("unknown datalayout");
+ return -EINVAL;
  }

+ while (ptr < inode->i_size) {
+ map.m_la = ptr;
+ if (compressed)
+ ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+ else
+ ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+ if (ret)
+ goto out;
+
+ if (compressed) {
+ if (ptr != map.m_la || map.m_la + map.m_llen > inode->i_size) {
+ erofs_err("broken compressed chunk layout ptr %" PRIu64 " m_la %" PRIu64
" m_llen %" PRIu64 " i_size %" PRIu64,
+   ptr, map.m_la, map.m_llen, inode->i_size);
+ ret = -EFSCORRUPTED;
+ goto out;
+ }
+ } else {
+ if (ptr != map.m_la || map.m_llen != map.m_plen) {
+ erofs_err("broken data chunk layout ptr %" PRIu64 " m_la %" PRIu64 "
m_llen %" PRIu64 " m_plen %" PRIu64,
+   ptr, map.m_la, map.m_llen, map.m_plen);
+ ret = -EFSCORRUPTED;
+ goto out;
+ }
+
+ if (map.m_la + map.m_llen > inode->i_size)
+ map.m_llen = inode->i_size - map.m_la;
+ }
+
+ pchunk_len += map.m_plen;
+ ptr += map.m_llen;
+
+ /* reached EOF? */
+ if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen)
+ break;
+
+ /* should skip decomp? */
+ if (!fsckcfg.check_decomp)
+ continue;
+
+ if (map.m_plen > raw_size) {
+ raw_size = map.m_plen;
+ raw = realloc(raw, raw_size);
+ BUG_ON(!raw);
+ }
+
+ if (compressed && map.m_llen > buffer_size) {
+ buffer_size = map.m_llen;
+ buffer = realloc(buffer, buffer_size);
+ BUG_ON(!buffer);
+ }
+
+ mdev = (struct erofs_map_dev) {
+ .m_deviceid = map.m_deviceid,
+ .m_pa = map.m_pa,
+ };
+ ret = erofs_map_dev(&sbi, &mdev);
+ if (ret) {
+ erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid
%llu: %d",
+   map.m_pa, map.m_deviceid, inode->nid | 0ULL, ret);
+ goto out;
+ }
+
+ ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+ if (ret < 0) {
+ erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @
nid %llu: %d",
+   mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+ goto out;
+ }
+
+ if (compressed) {
+ ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+ .in = raw,
+ .out = buffer,
+ .decodedskip = 0,
+ .inputsize = map.m_plen,
+ .decodedlength = map.m_llen,
+ .alg = map.m_algorithmformat,
+ .partial_decoding = 0
+ });
+
+ if (ret < 0) {
+ erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %"
PRIu64 " @ nid %llu: %d",
+   mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+ goto out;
+ }
+ }
+
+ if (fsckcfg.extract_fd != -1 &&
+   write(fsckcfg.extract_fd, compressed ? buffer : raw, map.m_llen) < 0) {
+ ret = -EIO;
+ goto out;
+ }
+ }
+
+ if (fsckcfg.print_comp_ratio) {
+ fsckcfg.logical_blocks +=
+ DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+ fsckcfg.physical_blocks +=
+ DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
+ }
+out:
+ if (raw)
+ free(raw);
+ if (buffer)
+ free(buffer);
  if (ret == -EIO)
  erofs_err("I/O error occurred when verifying data chunk of nid(%llu)",
    inode->nid | 0ULL);
+ return ret < 0 ? ret : 0;
+}
+
+static inline int erofs_extract_dir(struct erofs_inode *inode)
+{
+ int ret;
+ struct stat sb;
+
+ /* verify data chunk layout */
+ ret = erofs_verify_inode_data(inode);
+ if (ret)
+ return ret;
+
+ erofs_dbg("create directory on path: %s", fsckcfg.extract_path);
+
+ if (!lstat(fsckcfg.extract_path, &sb)) {
+ if (!S_ISDIR(sb.st_mode)) {
+ erofs_err("path is not a directory: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+ } else if (errno != ENOENT || mkdir(fsckcfg.extract_path, S_IRWXU) < 0) {
+ erofs_err("failed to create directory: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+
+ if (fsckcfg.preserve)
+ erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+ return 0;
+}
+
+static inline int erofs_extract_file(struct erofs_inode *inode)
+{
+ int ret;
+ struct stat sb;
+ int fsync_fail, close_fail;
+
+ erofs_dbg("extract file to path: %s", fsckcfg.extract_path);
+
+ if (!lstat(fsckcfg.extract_path, &sb)) {
+ if (S_ISDIR(sb.st_mode)) {
+ erofs_err("path is a directory: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+ erofs_warn("overwriting: %s", fsckcfg.extract_path);
+ if (unlink(fsckcfg.extract_path) < 0) {
+ erofs_err("failed to remove file: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+ }
+
+ fsckcfg.extract_fd = open(fsckcfg.extract_path, O_WRONLY | O_CREAT |
O_TRUNC, S_IRWXU);
+ if (fsckcfg.extract_fd < 0) {
+ erofs_err("failed to open file: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+
+ /* verify data chunk layout */
+ ret = erofs_verify_inode_data(inode);
+
+ fsync_fail = fsync(fsckcfg.extract_fd) != 0;
+ close_fail = close(fsckcfg.extract_fd) != 0;
+ fsckcfg.extract_fd = -1;
+
+ if (ret)
+ return ret;
+ if (fsync_fail || close_fail)
+ return -EIO;
+ if (fsckcfg.preserve)
+ erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+ return ret;
+}
+
+static inline int erofs_extract_symlink(struct erofs_inode *inode)
+{
+ int ret;
+ struct stat sb;
+ char *buf = NULL;
+
+ /* verify data chunk layout */
+ ret = erofs_verify_inode_data(inode);
+ if (ret)
+ return ret;

+ erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
+
+ if (!lstat(fsckcfg.extract_path, &sb)) {
+ if (S_ISDIR(sb.st_mode)) {
+ erofs_err("path is a directory: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+ erofs_warn("overwriting: %s", fsckcfg.extract_path);
+ if (unlink(fsckcfg.extract_path) < 0) {
+ erofs_err("failed to remove file: %s", fsckcfg.extract_path);
+ return -EIO;
+ }
+ }
+
+ buf = malloc(inode->i_size + 1);
+ if (!buf) {
+ ret = -ENOMEM;
+ goto out;
+ }
+
+ ret = erofs_pread(inode, buf, inode->i_size, 0);
+ if (ret) {
+ erofs_err("I/O error occurred when reading symlink @ nid %llu: %d",
+   inode->nid | 0ULL, ret);
+ goto out;
+ }
+
+ buf[inode->i_size] = '\0';
+ if (symlink(buf, fsckcfg.extract_path) < 0) {
+ erofs_err("failed to create symlink: %s", fsckcfg.extract_path);
+ ret = -EIO;
+ goto out;
+ }
+
+ if (fsckcfg.preserve)
+ erofsfsck_restore_stat(inode, fsckcfg.extract_path);
+out:
+ if (buf)
+ free(buf);
  return ret;
 }

 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
+ int ret;
+ size_t prev_pos = fsckcfg.extract_pos;
+
  if (ctx->dot_dotdot)
  return 0;

- return erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+ if (fsckcfg.extract_path) {
+ size_t curr_pos = prev_pos;
+
+ fsckcfg.extract_path[curr_pos++] = '/';
+ strncpy(fsckcfg.extract_path + curr_pos, ctx->dname, ctx->de_namelen);
+ curr_pos += ctx->de_namelen;
+ fsckcfg.extract_path[curr_pos] = '\0';
+ fsckcfg.extract_pos = curr_pos;
+ }
+
+ ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+
+ if (fsckcfg.extract_path) {
+ fsckcfg.extract_path[prev_pos] = '\0';
+ fsckcfg.extract_pos = prev_pos;
+ }
+ return ret;
 }

 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
@@ -394,8 +568,25 @@ static int erofsfsck_check_inode(erofs_nid_t pnid,
erofs_nid_t nid)
  if (ret)
  goto out;

- /* verify data chunk layout */
- ret = erofs_verify_inode_data(&inode);
+ if (fsckcfg.extract_path) {
+ switch (inode.i_mode & S_IFMT) {
+ case S_IFDIR:
+ ret = erofs_extract_dir(&inode);
+ break;
+ case S_IFREG:
+ ret = erofs_extract_file(&inode);
+ break;
+ case S_IFLNK:
+ ret = erofs_extract_symlink(&inode);
+ break;
+ default:
+ goto verify;
+ }
+ } else {
+verify:
+ /* verify data chunk layout */
+ ret = erofs_verify_inode_data(&inode);
+ }
  if (ret)
  goto out;

@@ -425,6 +616,9 @@ int main(int argc, char **argv)
  fsckcfg.corrupted = false;
  fsckcfg.print_comp_ratio = false;
  fsckcfg.check_decomp = false;
+ fsckcfg.extract_path = NULL;
+ fsckcfg.extract_pos = 0;
+ fsckcfg.extract_fd = -1;
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
- if ((st.st_mode & S_IFMT) != S_IFDIR) {
+ if (!S_ISDIR(st.st_mode)) {
  erofs_err("root of the filesystem is not a directory - %s",
    cfg.c_src_path);
  usage();
-- 
2.30.2

--000000000000be467c05d36dd85d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>From 9b3c3256d3a630a7bfe825201e9ba06=
d67a81618 Mon Sep 17 00:00:00 2001</div><div>From: Igor Ostapenko &lt;<a hr=
ef=3D"mailto:igoreisberg@gmail.com">igoreisberg@gmail.com</a>&gt;</div><div=
>Date: Sat, 18 Dec 2021 18:01:46 +0200</div><div>Subject: erofs-utils: fsck=
 support for --extract=3DX to extract to path X</div><div><br></div><div>Ex=
tracts dirs, regular files and symlinks (overwrite enabled with warnings,</=
div><div>mainly for use with WSL for debugging, in case certain files overl=
ap,</div><div>i.e. &quot;path/to/file/alarm&quot; and &quot;path/to/file/Al=
arm&quot;).</div><div>Allocation for extract_path is done only once, then t=
he buffer is reused.</div><div>Raw and compressed data chunks are handled w=
ith a unified function to avoid</div><div>repeats, compressed data is verif=
ied lineary (with EROFS_GET_BLOCKS_FIEMAP)</div><div>instead of lookback, a=
s it&#39;s problematic to extract data when looping</div><div>backwards.</d=
iv><div><br></div><div>Signed-off-by: Igor Ostapenko &lt;<a href=3D"mailto:=
igoreisberg@gmail.com">igoreisberg@gmail.com</a>&gt;</div><div>---</div><di=
v>=C2=A0fsck/main.c | 482 ++++++++++++++++++++++++++++++++++++-------------=
---</div><div>=C2=A0mkfs/main.c |=C2=A0 =C2=A02 +-</div><div>=C2=A02 files =
changed, 339 insertions(+), 145 deletions(-)</div><div><br></div><div>diff =
--git a/fsck/main.c b/fsck/main.c</div><div>index 30d0a1b..36d5d76 100644</=
div><div>--- a/fsck/main.c</div><div>+++ b/fsck/main.c</div><div>@@ -6,6 +6=
,8 @@</div><div>=C2=A0#include &lt;stdlib.h&gt;</div><div>=C2=A0#include &l=
t;getopt.h&gt;</div><div>=C2=A0#include &lt;time.h&gt;</div><div>+#include =
&lt;utime.h&gt;</div><div>+#include &lt;unistd.h&gt;</div><div>=C2=A0#inclu=
de &lt;sys/stat.h&gt;</div><div>=C2=A0#include &quot;erofs/print.h&quot;</d=
iv><div>=C2=A0#include &quot;erofs/io.h&quot;</div><div>@@ -18,6 +20,10 @@ =
struct erofsfsck_cfg {</div><div>=C2=A0<span style=3D"white-space:pre">	</s=
pan>bool corrupted;</div><div>=C2=A0<span style=3D"white-space:pre">	</span=
>bool print_comp_ratio;</div><div>=C2=A0<span style=3D"white-space:pre">	</=
span>bool check_decomp;</div><div>+<span style=3D"white-space:pre">	</span>=
char *extract_path;</div><div>+<span style=3D"white-space:pre">	</span>size=
_t extract_pos;</div><div>+<span style=3D"white-space:pre">	</span>int extr=
act_fd;</div><div>+<span style=3D"white-space:pre">	</span>bool preserve;</=
div><div>=C2=A0<span style=3D"white-space:pre">	</span>u64 physical_blocks;=
</div><div>=C2=A0<span style=3D"white-space:pre">	</span>u64 logical_blocks=
;</div><div>=C2=A0};</div><div>@@ -25,8 +31,9 @@ static struct erofsfsck_cf=
g fsckcfg;</div><div>=C2=A0</div><div>=C2=A0static struct option long_optio=
ns[] =3D {</div><div>=C2=A0<span style=3D"white-space:pre">	</span>{&quot;h=
elp&quot;, no_argument, 0, 1},</div><div>-<span style=3D"white-space:pre">	=
</span>{&quot;extract&quot;, no_argument, 0, 2},</div><div>-<span style=3D"=
white-space:pre">	</span>{&quot;device&quot;, required_argument, 0, 3},</di=
v><div>+<span style=3D"white-space:pre">	</span>{&quot;extract&quot;, optio=
nal_argument, 0, 2},</div><div>+<span style=3D"white-space:pre">	</span>{&q=
uot;preserve&quot;, no_argument, 0, 3},</div><div>+<span style=3D"white-spa=
ce:pre">	</span>{&quot;device&quot;, required_argument, 0, 4},</div><div>=
=C2=A0<span style=3D"white-space:pre">	</span>{0, 0, 0, 0},</div><div>=C2=
=A0};</div><div>=C2=A0</div><div>@@ -34,12 +41,13 @@ static void usage(void=
)</div><div>=C2=A0{</div><div>=C2=A0<span style=3D"white-space:pre">	</span=
>fputs(&quot;usage: [options] IMAGE\n\n&quot;</div><div>=C2=A0<span style=
=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot;Check erofs filesys=
tem integrity of IMAGE, and [options] are:\n&quot;</div><div>-<span style=
=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; -V=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print the version number of fsck.erofs a=
nd exit.\n&quot;</div><div>+<span style=3D"white-space:pre">	</span>=C2=A0 =
=C2=A0 =C2=A0 &quot; -V=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pri=
nt the version number of fsck.erofs and exit\n&quot;</div><div>=C2=A0<span =
style=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; -d#=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set output message level to # (maximu=
m 9)\n&quot;</div><div>=C2=A0<span style=3D"white-space:pre">	</span>=C2=A0=
 =C2=A0 =C2=A0 &quot; -p=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr=
int total compression ratio of all files\n&quot;</div><div>=C2=A0<span styl=
e=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; --device=3DX=C2=
=A0 =C2=A0 =C2=A0 specify an extra device to be used together\n&quot;</div>=
<div>-<span style=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; -=
-extract=C2=A0 =C2=A0 =C2=A0 =C2=A0check if all files are well encoded\n&qu=
ot;</div><div>-<span style=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0=
 &quot; --help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 display this help and exit=
.\n&quot;,</div><div>+<span style=3D"white-space:pre">	</span>=C2=A0 =C2=A0=
 =C2=A0 &quot; --extract[=3DX]=C2=A0 =C2=A0check if all files are well enco=
ded, optionally extract to X\n&quot;</div><div>+<span style=3D"white-space:=
pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; --preserve=C2=A0 =C2=A0 =C2=A0 pre=
serve mode, owner and group (--extract=3DX is required)\n&quot;</div><div>+=
<span style=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 &quot; --help=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 display this help and exit\n&quot;,</div=
><div>=C2=A0<span style=3D"white-space:pre">	</span>=C2=A0 =C2=A0 =C2=A0 st=
derr);</div><div>=C2=A0}</div><div>=C2=A0</div><div>@@ -74,8 +82,29 @@ stat=
ic int erofsfsck_parse_options_cfg(int argc, char **argv)</div><div>=C2=A0<=
span style=3D"white-space:pre">			</span>exit(0);</div><div>=C2=A0<span sty=
le=3D"white-space:pre">		</span>case 2:</div><div>=C2=A0<span style=3D"whit=
e-space:pre">			</span>fsckcfg.check_decomp =3D true;</div><div>+<span styl=
e=3D"white-space:pre">			</span>if (optarg) {</div><div>+<span style=3D"whi=
te-space:pre">				</span>size_t len =3D strlen(optarg);</div><div>+<span st=
yle=3D"white-space:pre">				</span>if (len =3D=3D 0)</div><div>+<span style=
=3D"white-space:pre">					</span>return -EINVAL;</div><div>+<span style=3D"=
white-space:pre">				</span>/* remove trailing slashes except root */</div>=
<div>+<span style=3D"white-space:pre">				</span>while (len &gt; 1 &amp;&am=
p; optarg[len - 1] =3D=3D &#39;/&#39;)</div><div>+<span style=3D"white-spac=
e:pre">					</span>len--;</div><div>+</div><div>+<span style=3D"white-space=
:pre">				</span>fsckcfg.extract_path =3D malloc(PATH_MAX);</div><div>+<spa=
n style=3D"white-space:pre">				</span>if (!fsckcfg.extract_path)</div><div=
>+<span style=3D"white-space:pre">					</span>return -ENOMEM;</div><div>+</=
div><div>+<span style=3D"white-space:pre">				</span>strncpy(fsckcfg.extrac=
t_path, optarg, len);</div><div>+<span style=3D"white-space:pre">				</span=
>fsckcfg.extract_path[len] =3D &#39;\0&#39;;</div><div>+<span style=3D"whit=
e-space:pre">				</span>if (optarg[0] =3D=3D &#39;/&#39;)</div><div>+<span =
style=3D"white-space:pre">					</span>len =3D 0;</div><div>+<span style=3D"=
white-space:pre">				</span>fsckcfg.extract_pos =3D len;</div><div>+<span s=
tyle=3D"white-space:pre">			</span>}</div><div>=C2=A0<span style=3D"white-s=
pace:pre">			</span>break;</div><div>=C2=A0<span style=3D"white-space:pre">=
		</span>case 3:</div><div>+<span style=3D"white-space:pre">			</span>fsckc=
fg.preserve =3D true;</div><div>+<span style=3D"white-space:pre">			</span>=
break;</div><div>+<span style=3D"white-space:pre">		</span>case 4:</div><di=
v>=C2=A0<span style=3D"white-space:pre">			</span>ret =3D blob_open_ro(opta=
rg);</div><div>=C2=A0<span style=3D"white-space:pre">			</span>if (ret)</di=
v><div>=C2=A0<span style=3D"white-space:pre">				</span>return ret;</div><d=
iv>@@ -89,6 +118,9 @@ static int erofsfsck_parse_options_cfg(int argc, char=
 **argv)</div><div>=C2=A0<span style=3D"white-space:pre">	</span>if (optind=
 &gt;=3D argc)</div><div>=C2=A0<span style=3D"white-space:pre">		</span>ret=
urn -EINVAL;</div><div>=C2=A0</div><div>+<span style=3D"white-space:pre">	<=
/span>if (fsckcfg.preserve &amp;&amp; !fsckcfg.extract_path)</div><div>+<sp=
an style=3D"white-space:pre">		</span>return -EINVAL;</div><div>+</div><div=
>=C2=A0<span style=3D"white-space:pre">	</span>cfg.c_img_path =3D strdup(ar=
gv[optind++]);</div><div>=C2=A0<span style=3D"white-space:pre">	</span>if (=
!cfg.c_img_path)</div><div>=C2=A0<span style=3D"white-space:pre">		</span>r=
eturn -ENOMEM;</div><div>@@ -100,6 +132,25 @@ static int erofsfsck_parse_op=
tions_cfg(int argc, char **argv)</div><div>=C2=A0<span style=3D"white-space=
:pre">	</span>return 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>+stati=
c void erofsfsck_restore_stat(struct erofs_inode *inode, char *path)</div><=
div>+{</div><div>+<span style=3D"white-space:pre">	</span>int ret;</div><di=
v>+<span style=3D"white-space:pre">	</span>struct utimbuf ut;</div><div>+</=
div><div>+<span style=3D"white-space:pre">	</span>ret =3D chmod(path, inode=
-&gt;i_mode);</div><div>+<span style=3D"white-space:pre">	</span>if (ret &l=
t; 0)</div><div>+<span style=3D"white-space:pre">		</span>erofs_warn(&quot;=
failed to set permissions: %s&quot;, path);</div><div>+</div><div>+<span st=
yle=3D"white-space:pre">	</span>ret =3D chown(path, inode-&gt;i_uid, inode-=
&gt;i_gid);</div><div>+<span style=3D"white-space:pre">	</span>if (ret &lt;=
 0)</div><div>+<span style=3D"white-space:pre">		</span>erofs_warn(&quot;fa=
iled to change ownership: %s&quot;, path);</div><div>+</div><div>+<span sty=
le=3D"white-space:pre">	</span>ut.actime =3D inode-&gt;i_ctime;</div><div>+=
<span style=3D"white-space:pre">	</span>ut.modtime =3D inode-&gt;i_ctime;</=
div><div>+<span style=3D"white-space:pre">	</span>if (utime(path, &amp;ut) =
&lt; 0)</div><div>+<span style=3D"white-space:pre">		</span>erofs_warn(&quo=
t;failed to set times: %s&quot;, path);</div><div>+}</div><div>+</div><div>=
=C2=A0static int erofs_check_sb_chksum(void)</div><div>=C2=A0{</div><div>=
=C2=A0<span style=3D"white-space:pre">	</span>int ret;</div><div>@@ -127,13=
7 +178,6 @@ static int erofs_check_sb_chksum(void)</div><div>=C2=A0<span st=
yle=3D"white-space:pre">	</span>return 0;</div><div>=C2=A0}</div><div>=C2=
=A0</div><div>-static int verify_uncompressed_inode(struct erofs_inode *ino=
de)</div><div>-{</div><div>-<span style=3D"white-space:pre">	</span>struct =
erofs_map_blocks map =3D {</div><div>-<span style=3D"white-space:pre">		</s=
pan>.index =3D UINT_MAX,</div><div>-<span style=3D"white-space:pre">	</span=
>};</div><div>-<span style=3D"white-space:pre">	</span>int ret;</div><div>-=
<span style=3D"white-space:pre">	</span>erofs_off_t ptr =3D 0;</div><div>-<=
span style=3D"white-space:pre">	</span>u64 i_blocks =3D DIV_ROUND_UP(inode-=
&gt;i_size, EROFS_BLKSIZ);</div><div>-</div><div>-<span style=3D"white-spac=
e:pre">	</span>while (ptr &lt; inode-&gt;i_size) {</div><div>-<span style=
=3D"white-space:pre">		</span>map.m_la =3D ptr;</div><div>-<span style=3D"w=
hite-space:pre">		</span>ret =3D erofs_map_blocks(inode, &amp;map, 0);</div=
><div>-<span style=3D"white-space:pre">		</span>if (ret)</div><div>-<span s=
tyle=3D"white-space:pre">			</span>return ret;</div><div>-</div><div>-<span=
 style=3D"white-space:pre">		</span>if (map.m_plen !=3D map.m_llen || ptr !=
=3D map.m_la) {</div><div>-<span style=3D"white-space:pre">			</span>erofs_=
err(&quot;broken data chunk layout m_la %&quot; PRIu64 &quot; ptr %&quot; P=
RIu64 &quot; m_llen %&quot; PRIu64 &quot; m_plen %&quot; PRIu64,</div><div>=
-<span style=3D"white-space:pre">				</span>=C2=A0 map.m_la, ptr, map.m_lle=
n, map.m_plen);</div><div>-<span style=3D"white-space:pre">			</span>return=
 -EFSCORRUPTED;</div><div>-<span style=3D"white-space:pre">		</span>}</div>=
<div>-</div><div>-<span style=3D"white-space:pre">		</span>if (!(map.m_flag=
s &amp; EROFS_MAP_MAPPED) &amp;&amp; !map.m_llen) {</div><div>-<span style=
=3D"white-space:pre">			</span>/* reached EOF */</div><div>-<span style=3D"=
white-space:pre">			</span>ptr =3D inode-&gt;i_size;</div><div>-<span style=
=3D"white-space:pre">			</span>continue;</div><div>-<span style=3D"white-sp=
ace:pre">		</span>}</div><div>-</div><div>-<span style=3D"white-space:pre">=
		</span>ptr +=3D map.m_llen;</div><div>-<span style=3D"white-space:pre">	<=
/span>}</div><div>-</div><div>-<span style=3D"white-space:pre">	</span>if (=
fsckcfg.print_comp_ratio) {</div><div>-<span style=3D"white-space:pre">		</=
span>fsckcfg.logical_blocks +=3D i_blocks;</div><div>-<span style=3D"white-=
space:pre">		</span>fsckcfg.physical_blocks +=3D i_blocks;</div><div>-<span=
 style=3D"white-space:pre">	</span>}</div><div>-</div><div>-<span style=3D"=
white-space:pre">	</span>return 0;</div><div>-}</div><div>-</div><div>-stat=
ic int verify_compressed_inode(struct erofs_inode *inode)</div><div>-{</div=
><div>-<span style=3D"white-space:pre">	</span>struct erofs_map_blocks map =
=3D {</div><div>-<span style=3D"white-space:pre">		</span>.index =3D UINT_M=
AX,</div><div>-<span style=3D"white-space:pre">	</span>};</div><div>-<span =
style=3D"white-space:pre">	</span>struct erofs_map_dev mdev;</div><div>-<sp=
an style=3D"white-space:pre">	</span>int ret =3D 0;</div><div>-<span style=
=3D"white-space:pre">	</span>u64 pchunk_len =3D 0;</div><div>-<span style=
=3D"white-space:pre">	</span>erofs_off_t end =3D inode-&gt;i_size;</div><di=
v>-<span style=3D"white-space:pre">	</span>unsigned int raw_size =3D 0, buf=
fer_size =3D 0;</div><div>-<span style=3D"white-space:pre">	</span>char *ra=
w =3D NULL, *buffer =3D NULL;</div><div>-</div><div>-<span style=3D"white-s=
pace:pre">	</span>while (end &gt; 0) {</div><div>-<span style=3D"white-spac=
e:pre">		</span>map.m_la =3D end - 1;</div><div>-</div><div>-<span style=3D=
"white-space:pre">		</span>ret =3D z_erofs_map_blocks_iter(inode, &amp;map,=
 0);</div><div>-<span style=3D"white-space:pre">		</span>if (ret)</div><div=
>-<span style=3D"white-space:pre">			</span>goto out;</div><div>-</div><div=
>-<span style=3D"white-space:pre">		</span>if (end &gt; map.m_la + map.m_ll=
en) {</div><div>-<span style=3D"white-space:pre">			</span>erofs_err(&quot;=
broken compressed chunk layout m_la %&quot; PRIu64 &quot; m_llen %&quot; PR=
Iu64 &quot; end %&quot; PRIu64,</div><div>-<span style=3D"white-space:pre">=
				</span>=C2=A0 map.m_la, map.m_llen, end);</div><div>-<span style=3D"whi=
te-space:pre">			</span>ret =3D -EFSCORRUPTED;</div><div>-<span style=3D"wh=
ite-space:pre">			</span>goto out;</div><div>-<span style=3D"white-space:pr=
e">		</span>}</div><div>-</div><div>-<span style=3D"white-space:pre">		</sp=
an>pchunk_len +=3D map.m_plen;</div><div>-<span style=3D"white-space:pre">	=
	</span>end =3D map.m_la;</div><div>-</div><div>-<span style=3D"white-space=
:pre">		</span>if (!fsckcfg.check_decomp || !(map.m_flags &amp; EROFS_MAP_M=
APPED))</div><div>-<span style=3D"white-space:pre">			</span>continue;</div=
><div>-</div><div>-<span style=3D"white-space:pre">		</span>if (map.m_plen =
&gt; raw_size) {</div><div>-<span style=3D"white-space:pre">			</span>raw_s=
ize =3D map.m_plen;</div><div>-<span style=3D"white-space:pre">			</span>ra=
w =3D realloc(raw, raw_size);</div><div>-<span style=3D"white-space:pre">		=
	</span>BUG_ON(!raw);</div><div>-<span style=3D"white-space:pre">		</span>}=
</div><div>-</div><div>-<span style=3D"white-space:pre">		</span>if (map.m_=
llen &gt; buffer_size) {</div><div>-<span style=3D"white-space:pre">			</sp=
an>buffer_size =3D map.m_llen;</div><div>-<span style=3D"white-space:pre">	=
		</span>buffer =3D realloc(buffer, buffer_size);</div><div>-<span style=3D=
"white-space:pre">			</span>BUG_ON(!buffer);</div><div>-<span style=3D"whit=
e-space:pre">		</span>}</div><div>-</div><div>-<span style=3D"white-space:p=
re">		</span>mdev =3D (struct erofs_map_dev) {</div><div>-<span style=3D"wh=
ite-space:pre">			</span>.m_deviceid =3D map.m_deviceid,</div><div>-<span s=
tyle=3D"white-space:pre">			</span>.m_pa =3D map.m_pa,</div><div>-<span sty=
le=3D"white-space:pre">		</span>};</div><div>-<span style=3D"white-space:pr=
e">		</span>ret =3D erofs_map_dev(&amp;sbi, &amp;mdev);</div><div>-<span st=
yle=3D"white-space:pre">		</span>if (ret) {</div><div>-<span style=3D"white=
-space:pre">			</span>erofs_err(&quot;failed to map device of m_pa %&quot; =
PRIu64 &quot;, m_deviceid %u @ nid %llu: %d&quot;,</div><div>-<span style=
=3D"white-space:pre">				</span>=C2=A0 map.m_pa, map.m_deviceid, inode-&gt;=
nid | 0ULL, ret);</div><div>-<span style=3D"white-space:pre">			</span>goto=
 out;</div><div>-<span style=3D"white-space:pre">		</span>}</div><div>-</di=
v><div>-<span style=3D"white-space:pre">		</span>ret =3D dev_read(mdev.m_de=
viceid, raw, mdev.m_pa, map.m_plen);</div><div>-<span style=3D"white-space:=
pre">		</span>if (ret &lt; 0) {</div><div>-<span style=3D"white-space:pre">=
			</span>erofs_err(&quot;failed to read compressed data of m_pa %&quot; PR=
Iu64 &quot;, m_plen %&quot; PRIu64 &quot; @ nid %llu: %d&quot;,</div><div>-=
<span style=3D"white-space:pre">				</span>=C2=A0 mdev.m_pa, map.m_plen, in=
ode-&gt;nid | 0ULL, ret);</div><div>-<span style=3D"white-space:pre">			</s=
pan>goto out;</div><div>-<span style=3D"white-space:pre">		</span>}</div><d=
iv>-</div><div>-<span style=3D"white-space:pre">		</span>ret =3D z_erofs_de=
compress(&amp;(struct z_erofs_decompress_req) {</div><div>-<span style=3D"w=
hite-space:pre">					</span>.in =3D raw,</div><div>-<span style=3D"white-sp=
ace:pre">					</span>.out =3D buffer,</div><div>-<span style=3D"white-space=
:pre">					</span>.decodedskip =3D 0,</div><div>-<span style=3D"white-space=
:pre">					</span>.inputsize =3D map.m_plen,</div><div>-<span style=3D"whit=
e-space:pre">					</span>.decodedlength =3D map.m_llen,</div><div>-<span st=
yle=3D"white-space:pre">					</span>.alg =3D map.m_algorithmformat,</div><d=
iv>-<span style=3D"white-space:pre">					</span>.partial_decoding =3D 0</di=
v><div>-<span style=3D"white-space:pre">					</span> });</div><div>-</div><=
div>-<span style=3D"white-space:pre">		</span>if (ret &lt; 0) {</div><div>-=
<span style=3D"white-space:pre">			</span>erofs_err(&quot;failed to decompr=
ess data of m_pa %&quot; PRIu64 &quot;, m_plen %&quot; PRIu64 &quot; @ nid =
%llu: %d&quot;,</div><div>-<span style=3D"white-space:pre">				</span>=C2=
=A0 mdev.m_pa, map.m_plen, inode-&gt;nid | 0ULL, ret);</div><div>-<span sty=
le=3D"white-space:pre">			</span>goto out;</div><div>-<span style=3D"white-=
space:pre">		</span>}</div><div>-<span style=3D"white-space:pre">	</span>}<=
/div><div>-</div><div>-<span style=3D"white-space:pre">	</span>if (fsckcfg.=
print_comp_ratio) {</div><div>-<span style=3D"white-space:pre">		</span>fsc=
kcfg.logical_blocks +=3D</div><div>-<span style=3D"white-space:pre">			</sp=
an>DIV_ROUND_UP(inode-&gt;i_size, EROFS_BLKSIZ);</div><div>-<span style=3D"=
white-space:pre">		</span>fsckcfg.physical_blocks +=3D</div><div>-<span sty=
le=3D"white-space:pre">			</span>DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);</d=
iv><div>-<span style=3D"white-space:pre">	</span>}</div><div>-out:</div><di=
v>-<span style=3D"white-space:pre">	</span>if (raw)</div><div>-<span style=
=3D"white-space:pre">		</span>free(raw);</div><div>-<span style=3D"white-sp=
ace:pre">	</span>if (buffer)</div><div>-<span style=3D"white-space:pre">		<=
/span>free(buffer);</div><div>-<span style=3D"white-space:pre">	</span>retu=
rn ret &lt; 0 ? ret : 0;</div><div>-}</div><div>-</div><div>=C2=A0static in=
t erofs_verify_xattr(struct erofs_inode *inode)</div><div>=C2=A0{</div><div=
>=C2=A0<span style=3D"white-space:pre">	</span>unsigned int xattr_hdr_size =
=3D sizeof(struct erofs_xattr_ibody_header);</div><div>@@ -338,7 +258,16 @@=
 out:</div><div>=C2=A0</div><div>=C2=A0static int erofs_verify_inode_data(s=
truct erofs_inode *inode)</div><div>=C2=A0{</div><div>-<span style=3D"white=
-space:pre">	</span>int ret;</div><div>+<span style=3D"white-space:pre">	</=
span>struct erofs_map_blocks map =3D {</div><div>+<span style=3D"white-spac=
e:pre">		</span>.index =3D UINT_MAX,</div><div>+<span style=3D"white-space:=
pre">	</span>};</div><div>+<span style=3D"white-space:pre">	</span>struct e=
rofs_map_dev mdev;</div><div>+<span style=3D"white-space:pre">	</span>int r=
et =3D 0;</div><div>+<span style=3D"white-space:pre">	</span>bool compresse=
d;</div><div>+<span style=3D"white-space:pre">	</span>erofs_off_t ptr =3D 0=
;</div><div>+<span style=3D"white-space:pre">	</span>u64 pchunk_len =3D 0;<=
/div><div>+<span style=3D"white-space:pre">	</span>unsigned int raw_size =
=3D 0, buffer_size =3D 0;</div><div>+<span style=3D"white-space:pre">	</spa=
n>char *raw =3D NULL, *buffer =3D NULL;</div><div>=C2=A0</div><div>=C2=A0<s=
pan style=3D"white-space:pre">	</span>erofs_dbg(&quot;verify data chunk of =
nid(%llu): type(%d)&quot;,</div><div>=C2=A0<span style=3D"white-space:pre">=
		</span>=C2=A0 inode-&gt;nid | 0ULL, inode-&gt;datalayout);</div><div>@@ -=
347,30 +276,275 @@ static int erofs_verify_inode_data(struct erofs_inode *i=
node)</div><div>=C2=A0<span style=3D"white-space:pre">	</span>case EROFS_IN=
ODE_FLAT_PLAIN:</div><div>=C2=A0<span style=3D"white-space:pre">	</span>cas=
e EROFS_INODE_FLAT_INLINE:</div><div>=C2=A0<span style=3D"white-space:pre">=
	</span>case EROFS_INODE_CHUNK_BASED:</div><div>-<span style=3D"white-space=
:pre">		</span>ret =3D verify_uncompressed_inode(inode);</div><div>+<span s=
tyle=3D"white-space:pre">		</span>compressed =3D false;</div><div>=C2=A0<sp=
an style=3D"white-space:pre">		</span>break;</div><div>=C2=A0<span style=3D=
"white-space:pre">	</span>case EROFS_INODE_FLAT_COMPRESSION_LEGACY:</div><d=
iv>=C2=A0<span style=3D"white-space:pre">	</span>case EROFS_INODE_FLAT_COMP=
RESSION:</div><div>-<span style=3D"white-space:pre">		</span>ret =3D verify=
_compressed_inode(inode);</div><div>+<span style=3D"white-space:pre">		</sp=
an>compressed =3D true;</div><div>=C2=A0<span style=3D"white-space:pre">		<=
/span>break;</div><div>=C2=A0<span style=3D"white-space:pre">	</span>defaul=
t:</div><div>-<span style=3D"white-space:pre">		</span>ret =3D -EINVAL;</di=
v><div>-<span style=3D"white-space:pre">		</span>break;</div><div>+<span st=
yle=3D"white-space:pre">		</span>erofs_err(&quot;unknown datalayout&quot;);=
</div><div>+<span style=3D"white-space:pre">		</span>return -EINVAL;</div><=
div>=C2=A0<span style=3D"white-space:pre">	</span>}</div><div>=C2=A0</div><=
div>+<span style=3D"white-space:pre">	</span>while (ptr &lt; inode-&gt;i_si=
ze) {</div><div>+<span style=3D"white-space:pre">		</span>map.m_la =3D ptr;=
</div><div>+<span style=3D"white-space:pre">		</span>if (compressed)</div><=
div>+<span style=3D"white-space:pre">			</span>ret =3D z_erofs_map_blocks_i=
ter(inode, &amp;map, EROFS_GET_BLOCKS_FIEMAP);</div><div>+<span style=3D"wh=
ite-space:pre">		</span>else</div><div>+<span style=3D"white-space:pre">			=
</span>ret =3D erofs_map_blocks(inode, &amp;map, EROFS_GET_BLOCKS_FIEMAP);<=
/div><div>+<span style=3D"white-space:pre">		</span>if (ret)</div><div>+<sp=
an style=3D"white-space:pre">			</span>goto out;</div><div>+</div><div>+<sp=
an style=3D"white-space:pre">		</span>if (compressed) {</div><div>+<span st=
yle=3D"white-space:pre">			</span>if (ptr !=3D map.m_la || map.m_la + map.m=
_llen &gt; inode-&gt;i_size) {</div><div>+<span style=3D"white-space:pre">	=
			</span>erofs_err(&quot;broken compressed chunk layout ptr %&quot; PRIu64=
 &quot; m_la %&quot; PRIu64 &quot; m_llen %&quot; PRIu64 &quot; i_size %&qu=
ot; PRIu64,</div><div>+<span style=3D"white-space:pre">					</span>=C2=A0 p=
tr, map.m_la, map.m_llen, inode-&gt;i_size);</div><div>+<span style=3D"whit=
e-space:pre">				</span>ret =3D -EFSCORRUPTED;</div><div>+<span style=3D"wh=
ite-space:pre">				</span>goto out;</div><div>+<span style=3D"white-space:p=
re">			</span>}</div><div>+<span style=3D"white-space:pre">		</span>} else =
{</div><div>+<span style=3D"white-space:pre">			</span>if (ptr !=3D map.m_l=
a || map.m_llen !=3D map.m_plen) {</div><div>+<span style=3D"white-space:pr=
e">				</span>erofs_err(&quot;broken data chunk layout ptr %&quot; PRIu64 &=
quot; m_la %&quot; PRIu64 &quot; m_llen %&quot; PRIu64 &quot; m_plen %&quot=
; PRIu64,</div><div>+<span style=3D"white-space:pre">					</span>=C2=A0 ptr=
, map.m_la, map.m_llen, map.m_plen);</div><div>+<span style=3D"white-space:=
pre">				</span>ret =3D -EFSCORRUPTED;</div><div>+<span style=3D"white-spac=
e:pre">				</span>goto out;</div><div>+<span style=3D"white-space:pre">			<=
/span>}</div><div>+</div><div>+<span style=3D"white-space:pre">			</span>if=
 (map.m_la + map.m_llen &gt; inode-&gt;i_size)</div><div>+<span style=3D"wh=
ite-space:pre">				</span>map.m_llen =3D inode-&gt;i_size - map.m_la;</div>=
<div>+<span style=3D"white-space:pre">		</span>}</div><div>+</div><div>+<sp=
an style=3D"white-space:pre">		</span>pchunk_len +=3D map.m_plen;</div><div=
>+<span style=3D"white-space:pre">		</span>ptr +=3D map.m_llen;</div><div>+=
</div><div>+<span style=3D"white-space:pre">		</span>/* reached EOF? */</di=
v><div>+<span style=3D"white-space:pre">		</span>if (!(map.m_flags &amp; ER=
OFS_MAP_MAPPED) &amp;&amp; !map.m_llen)</div><div>+<span style=3D"white-spa=
ce:pre">			</span>break;</div><div>+</div><div>+<span style=3D"white-space:=
pre">		</span>/* should skip decomp? */</div><div>+<span style=3D"white-spa=
ce:pre">		</span>if (!fsckcfg.check_decomp)</div><div>+<span style=3D"white=
-space:pre">			</span>continue;</div><div>+</div><div>+<span style=3D"white=
-space:pre">		</span>if (map.m_plen &gt; raw_size) {</div><div>+<span style=
=3D"white-space:pre">			</span>raw_size =3D map.m_plen;</div><div>+<span st=
yle=3D"white-space:pre">			</span>raw =3D realloc(raw, raw_size);</div><div=
>+<span style=3D"white-space:pre">			</span>BUG_ON(!raw);</div><div>+<span =
style=3D"white-space:pre">		</span>}</div><div>+</div><div>+<span style=3D"=
white-space:pre">		</span>if (compressed &amp;&amp; map.m_llen &gt; buffer_=
size) {</div><div>+<span style=3D"white-space:pre">			</span>buffer_size =
=3D map.m_llen;</div><div>+<span style=3D"white-space:pre">			</span>buffer=
 =3D realloc(buffer, buffer_size);</div><div>+<span style=3D"white-space:pr=
e">			</span>BUG_ON(!buffer);</div><div>+<span style=3D"white-space:pre">		=
</span>}</div><div>+</div><div>+<span style=3D"white-space:pre">		</span>md=
ev =3D (struct erofs_map_dev) {</div><div>+<span style=3D"white-space:pre">=
			</span>.m_deviceid =3D map.m_deviceid,</div><div>+<span style=3D"white-s=
pace:pre">			</span>.m_pa =3D map.m_pa,</div><div>+<span style=3D"white-spa=
ce:pre">		</span>};</div><div>+<span style=3D"white-space:pre">		</span>ret=
 =3D erofs_map_dev(&amp;sbi, &amp;mdev);</div><div>+<span style=3D"white-sp=
ace:pre">		</span>if (ret) {</div><div>+<span style=3D"white-space:pre">			=
</span>erofs_err(&quot;failed to map device of m_pa %&quot; PRIu64 &quot;, =
m_deviceid %u @ nid %llu: %d&quot;,</div><div>+<span style=3D"white-space:p=
re">				</span>=C2=A0 map.m_pa, map.m_deviceid, inode-&gt;nid | 0ULL, ret);=
</div><div>+<span style=3D"white-space:pre">			</span>goto out;</div><div>+=
<span style=3D"white-space:pre">		</span>}</div><div>+</div><div>+<span sty=
le=3D"white-space:pre">		</span>ret =3D dev_read(mdev.m_deviceid, raw, mdev=
.m_pa, map.m_plen);</div><div>+<span style=3D"white-space:pre">		</span>if =
(ret &lt; 0) {</div><div>+<span style=3D"white-space:pre">			</span>erofs_e=
rr(&quot;failed to read data of m_pa %&quot; PRIu64 &quot;, m_plen %&quot; =
PRIu64 &quot; @ nid %llu: %d&quot;,</div><div>+<span style=3D"white-space:p=
re">				</span>=C2=A0 mdev.m_pa, map.m_plen, inode-&gt;nid | 0ULL, ret);</d=
iv><div>+<span style=3D"white-space:pre">			</span>goto out;</div><div>+<sp=
an style=3D"white-space:pre">		</span>}</div><div>+</div><div>+<span style=
=3D"white-space:pre">		</span>if (compressed) {</div><div>+<span style=3D"w=
hite-space:pre">			</span>ret =3D z_erofs_decompress(&amp;(struct z_erofs_d=
ecompress_req) {</div><div>+<span style=3D"white-space:pre">						</span>.i=
n =3D raw,</div><div>+<span style=3D"white-space:pre">						</span>.out =3D=
 buffer,</div><div>+<span style=3D"white-space:pre">						</span>.decodedsk=
ip =3D 0,</div><div>+<span style=3D"white-space:pre">						</span>.inputsiz=
e =3D map.m_plen,</div><div>+<span style=3D"white-space:pre">						</span>.=
decodedlength =3D map.m_llen,</div><div>+<span style=3D"white-space:pre">		=
				</span>.alg =3D map.m_algorithmformat,</div><div>+<span style=3D"white-=
space:pre">						</span>.partial_decoding =3D 0</div><div>+<span style=3D"w=
hite-space:pre">						</span> });</div><div>+</div><div>+<span style=3D"whi=
te-space:pre">			</span>if (ret &lt; 0) {</div><div>+<span style=3D"white-s=
pace:pre">				</span>erofs_err(&quot;failed to decompress data of m_pa %&qu=
ot; PRIu64 &quot;, m_plen %&quot; PRIu64 &quot; @ nid %llu: %d&quot;,</div>=
<div>+<span style=3D"white-space:pre">					</span>=C2=A0 mdev.m_pa, map.m_p=
len, inode-&gt;nid | 0ULL, ret);</div><div>+<span style=3D"white-space:pre"=
>				</span>goto out;</div><div>+<span style=3D"white-space:pre">			</span>=
}</div><div>+<span style=3D"white-space:pre">		</span>}</div><div>+</div><d=
iv>+<span style=3D"white-space:pre">		</span>if (fsckcfg.extract_fd !=3D -1=
 &amp;&amp;</div><div>+<span style=3D"white-space:pre">			</span>=C2=A0 wri=
te(fsckcfg.extract_fd, compressed ? buffer : raw, map.m_llen) &lt; 0) {</di=
v><div>+<span style=3D"white-space:pre">			</span>ret =3D -EIO;</div><div>+=
<span style=3D"white-space:pre">			</span>goto out;</div><div>+<span style=
=3D"white-space:pre">		</span>}</div><div>+<span style=3D"white-space:pre">=
	</span>}</div><div>+</div><div>+<span style=3D"white-space:pre">	</span>if=
 (fsckcfg.print_comp_ratio) {</div><div>+<span style=3D"white-space:pre">		=
</span>fsckcfg.logical_blocks +=3D</div><div>+<span style=3D"white-space:pr=
e">			</span>DIV_ROUND_UP(inode-&gt;i_size, EROFS_BLKSIZ);</div><div>+<span=
 style=3D"white-space:pre">		</span>fsckcfg.physical_blocks +=3D</div><div>=
+<span style=3D"white-space:pre">			</span>DIV_ROUND_UP(pchunk_len, EROFS_B=
LKSIZ);</div><div>+<span style=3D"white-space:pre">	</span>}</div><div>+out=
:</div><div>+<span style=3D"white-space:pre">	</span>if (raw)</div><div>+<s=
pan style=3D"white-space:pre">		</span>free(raw);</div><div>+<span style=3D=
"white-space:pre">	</span>if (buffer)</div><div>+<span style=3D"white-space=
:pre">		</span>free(buffer);</div><div>=C2=A0<span style=3D"white-space:pre=
">	</span>if (ret =3D=3D -EIO)</div><div>=C2=A0<span style=3D"white-space:p=
re">		</span>erofs_err(&quot;I/O error occurred when verifying data chunk o=
f nid(%llu)&quot;,</div><div>=C2=A0<span style=3D"white-space:pre">			</spa=
n>=C2=A0 inode-&gt;nid | 0ULL);</div><div>+<span style=3D"white-space:pre">=
	</span>return ret &lt; 0 ? ret : 0;</div><div>+}</div><div>+</div><div>+st=
atic inline int erofs_extract_dir(struct erofs_inode *inode)</div><div>+{</=
div><div>+<span style=3D"white-space:pre">	</span>int ret;</div><div>+<span=
 style=3D"white-space:pre">	</span>struct stat sb;</div><div>+</div><div>+<=
span style=3D"white-space:pre">	</span>/* verify data chunk layout */</div>=
<div>+<span style=3D"white-space:pre">	</span>ret =3D erofs_verify_inode_da=
ta(inode);</div><div>+<span style=3D"white-space:pre">	</span>if (ret)</div=
><div>+<span style=3D"white-space:pre">		</span>return ret;</div><div>+</di=
v><div>+<span style=3D"white-space:pre">	</span>erofs_dbg(&quot;create dire=
ctory on path: %s&quot;, fsckcfg.extract_path);</div><div>+</div><div>+<spa=
n style=3D"white-space:pre">	</span>if (!lstat(fsckcfg.extract_path, &amp;s=
b)) {</div><div>+<span style=3D"white-space:pre">		</span>if (!S_ISDIR(sb.s=
t_mode)) {</div><div>+<span style=3D"white-space:pre">			</span>erofs_err(&=
quot;path is not a directory: %s&quot;, fsckcfg.extract_path);</div><div>+<=
span style=3D"white-space:pre">			</span>return -EIO;</div><div>+<span styl=
e=3D"white-space:pre">		</span>}</div><div>+<span style=3D"white-space:pre"=
>	</span>} else if (errno !=3D ENOENT || mkdir(fsckcfg.extract_path, S_IRWX=
U) &lt; 0) {</div><div>+<span style=3D"white-space:pre">		</span>erofs_err(=
&quot;failed to create directory: %s&quot;, fsckcfg.extract_path);</div><di=
v>+<span style=3D"white-space:pre">		</span>return -EIO;</div><div>+<span s=
tyle=3D"white-space:pre">	</span>}</div><div>+</div><div>+<span style=3D"wh=
ite-space:pre">	</span>if (fsckcfg.preserve)</div><div>+<span style=3D"whit=
e-space:pre">		</span>erofsfsck_restore_stat(inode, fsckcfg.extract_path);<=
/div><div>+<span style=3D"white-space:pre">	</span>return 0;</div><div>+}</=
div><div>+</div><div>+static inline int erofs_extract_file(struct erofs_ino=
de *inode)</div><div>+{</div><div>+<span style=3D"white-space:pre">	</span>=
int ret;</div><div>+<span style=3D"white-space:pre">	</span>struct stat sb;=
</div><div>+<span style=3D"white-space:pre">	</span>int fsync_fail, close_f=
ail;</div><div>+</div><div>+<span style=3D"white-space:pre">	</span>erofs_d=
bg(&quot;extract file to path: %s&quot;, fsckcfg.extract_path);</div><div>+=
</div><div>+<span style=3D"white-space:pre">	</span>if (!lstat(fsckcfg.extr=
act_path, &amp;sb)) {</div><div>+<span style=3D"white-space:pre">		</span>i=
f (S_ISDIR(sb.st_mode)) {</div><div>+<span style=3D"white-space:pre">			</s=
pan>erofs_err(&quot;path is a directory: %s&quot;, fsckcfg.extract_path);</=
div><div>+<span style=3D"white-space:pre">			</span>return -EIO;</div><div>=
+<span style=3D"white-space:pre">		</span>}</div><div>+<span style=3D"white=
-space:pre">		</span>erofs_warn(&quot;overwriting: %s&quot;, fsckcfg.extrac=
t_path);</div><div>+<span style=3D"white-space:pre">		</span>if (unlink(fsc=
kcfg.extract_path) &lt; 0) {</div><div>+<span style=3D"white-space:pre">			=
</span>erofs_err(&quot;failed to remove file: %s&quot;, fsckcfg.extract_pat=
h);</div><div>+<span style=3D"white-space:pre">			</span>return -EIO;</div>=
<div>+<span style=3D"white-space:pre">		</span>}</div><div>+<span style=3D"=
white-space:pre">	</span>}</div><div>+</div><div>+<span style=3D"white-spac=
e:pre">	</span>fsckcfg.extract_fd =3D open(fsckcfg.extract_path, O_WRONLY |=
 O_CREAT | O_TRUNC, S_IRWXU);</div><div>+<span style=3D"white-space:pre">	<=
/span>if (fsckcfg.extract_fd &lt; 0) {</div><div>+<span style=3D"white-spac=
e:pre">		</span>erofs_err(&quot;failed to open file: %s&quot;, fsckcfg.extr=
act_path);</div><div>+<span style=3D"white-space:pre">		</span>return -EIO;=
</div><div>+<span style=3D"white-space:pre">	</span>}</div><div>+</div><div=
>+<span style=3D"white-space:pre">	</span>/* verify data chunk layout */</d=
iv><div>+<span style=3D"white-space:pre">	</span>ret =3D erofs_verify_inode=
_data(inode);</div><div>+</div><div>+<span style=3D"white-space:pre">	</spa=
n>fsync_fail =3D fsync(fsckcfg.extract_fd) !=3D 0;</div><div>+<span style=
=3D"white-space:pre">	</span>close_fail =3D close(fsckcfg.extract_fd) !=3D =
0;</div><div>+<span style=3D"white-space:pre">	</span>fsckcfg.extract_fd =
=3D -1;</div><div>+</div><div>+<span style=3D"white-space:pre">	</span>if (=
ret)</div><div>+<span style=3D"white-space:pre">		</span>return ret;</div><=
div>+<span style=3D"white-space:pre">	</span>if (fsync_fail || close_fail)<=
/div><div>+<span style=3D"white-space:pre">		</span>return -EIO;</div><div>=
+<span style=3D"white-space:pre">	</span>if (fsckcfg.preserve)</div><div>+<=
span style=3D"white-space:pre">		</span>erofsfsck_restore_stat(inode, fsckc=
fg.extract_path);</div><div>+<span style=3D"white-space:pre">	</span>return=
 ret;</div><div>+}</div><div>+</div><div>+static inline int erofs_extract_s=
ymlink(struct erofs_inode *inode)</div><div>+{</div><div>+<span style=3D"wh=
ite-space:pre">	</span>int ret;</div><div>+<span style=3D"white-space:pre">=
	</span>struct stat sb;</div><div>+<span style=3D"white-space:pre">	</span>=
char *buf =3D NULL;</div><div>+</div><div>+<span style=3D"white-space:pre">=
	</span>/* verify data chunk layout */</div><div>+<span style=3D"white-spac=
e:pre">	</span>ret =3D erofs_verify_inode_data(inode);</div><div>+<span sty=
le=3D"white-space:pre">	</span>if (ret)</div><div>+<span style=3D"white-spa=
ce:pre">		</span>return ret;</div><div>=C2=A0</div><div>+<span style=3D"whi=
te-space:pre">	</span>erofs_dbg(&quot;extract symlink to path: %s&quot;, fs=
ckcfg.extract_path);</div><div>+</div><div>+<span style=3D"white-space:pre"=
>	</span>if (!lstat(fsckcfg.extract_path, &amp;sb)) {</div><div>+<span styl=
e=3D"white-space:pre">		</span>if (S_ISDIR(sb.st_mode)) {</div><div>+<span =
style=3D"white-space:pre">			</span>erofs_err(&quot;path is a directory: %s=
&quot;, fsckcfg.extract_path);</div><div>+<span style=3D"white-space:pre">	=
		</span>return -EIO;</div><div>+<span style=3D"white-space:pre">		</span>}=
</div><div>+<span style=3D"white-space:pre">		</span>erofs_warn(&quot;overw=
riting: %s&quot;, fsckcfg.extract_path);</div><div>+<span style=3D"white-sp=
ace:pre">		</span>if (unlink(fsckcfg.extract_path) &lt; 0) {</div><div>+<sp=
an style=3D"white-space:pre">			</span>erofs_err(&quot;failed to remove fil=
e: %s&quot;, fsckcfg.extract_path);</div><div>+<span style=3D"white-space:p=
re">			</span>return -EIO;</div><div>+<span style=3D"white-space:pre">		</s=
pan>}</div><div>+<span style=3D"white-space:pre">	</span>}</div><div>+</div=
><div>+<span style=3D"white-space:pre">	</span>buf =3D malloc(inode-&gt;i_s=
ize + 1);</div><div>+<span style=3D"white-space:pre">	</span>if (!buf) {</d=
iv><div>+<span style=3D"white-space:pre">		</span>ret =3D -ENOMEM;</div><di=
v>+<span style=3D"white-space:pre">		</span>goto out;</div><div>+<span styl=
e=3D"white-space:pre">	</span>}</div><div>+</div><div>+<span style=3D"white=
-space:pre">	</span>ret =3D erofs_pread(inode, buf, inode-&gt;i_size, 0);</=
div><div>+<span style=3D"white-space:pre">	</span>if (ret) {</div><div>+<sp=
an style=3D"white-space:pre">		</span>erofs_err(&quot;I/O error occurred wh=
en reading symlink @ nid %llu: %d&quot;,</div><div>+<span style=3D"white-sp=
ace:pre">			</span>=C2=A0 inode-&gt;nid | 0ULL, ret);</div><div>+<span styl=
e=3D"white-space:pre">		</span>goto out;</div><div>+<span style=3D"white-sp=
ace:pre">	</span>}</div><div>+</div><div>+<span style=3D"white-space:pre">	=
</span>buf[inode-&gt;i_size] =3D &#39;\0&#39;;</div><div>+<span style=3D"wh=
ite-space:pre">	</span>if (symlink(buf, fsckcfg.extract_path) &lt; 0) {</di=
v><div>+<span style=3D"white-space:pre">		</span>erofs_err(&quot;failed to =
create symlink: %s&quot;, fsckcfg.extract_path);</div><div>+<span style=3D"=
white-space:pre">		</span>ret =3D -EIO;</div><div>+<span style=3D"white-spa=
ce:pre">		</span>goto out;</div><div>+<span style=3D"white-space:pre">	</sp=
an>}</div><div>+</div><div>+<span style=3D"white-space:pre">	</span>if (fsc=
kcfg.preserve)</div><div>+<span style=3D"white-space:pre">		</span>erofsfsc=
k_restore_stat(inode, fsckcfg.extract_path);</div><div>+out:</div><div>+<sp=
an style=3D"white-space:pre">	</span>if (buf)</div><div>+<span style=3D"whi=
te-space:pre">		</span>free(buf);</div><div>=C2=A0<span style=3D"white-spac=
e:pre">	</span>return ret;</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=
=A0static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)</div><di=
v>=C2=A0{</div><div>+<span style=3D"white-space:pre">	</span>int ret;</div>=
<div>+<span style=3D"white-space:pre">	</span>size_t prev_pos =3D fsckcfg.e=
xtract_pos;</div><div>+</div><div>=C2=A0<span style=3D"white-space:pre">	</=
span>if (ctx-&gt;dot_dotdot)</div><div>=C2=A0<span style=3D"white-space:pre=
">		</span>return 0;</div><div>=C2=A0</div><div>-<span style=3D"white-space=
:pre">	</span>return erofsfsck_check_inode(ctx-&gt;dir-&gt;nid, ctx-&gt;de_=
nid);</div><div>+<span style=3D"white-space:pre">	</span>if (fsckcfg.extrac=
t_path) {</div><div>+<span style=3D"white-space:pre">		</span>size_t curr_p=
os =3D prev_pos;</div><div>+</div><div>+<span style=3D"white-space:pre">		<=
/span>fsckcfg.extract_path[curr_pos++] =3D &#39;/&#39;;</div><div>+<span st=
yle=3D"white-space:pre">		</span>strncpy(fsckcfg.extract_path + curr_pos, c=
tx-&gt;dname, ctx-&gt;de_namelen);</div><div>+<span style=3D"white-space:pr=
e">		</span>curr_pos +=3D ctx-&gt;de_namelen;</div><div>+<span style=3D"whi=
te-space:pre">		</span>fsckcfg.extract_path[curr_pos] =3D &#39;\0&#39;;</di=
v><div>+<span style=3D"white-space:pre">		</span>fsckcfg.extract_pos =3D cu=
rr_pos;</div><div>+<span style=3D"white-space:pre">	</span>}</div><div>+</d=
iv><div>+<span style=3D"white-space:pre">	</span>ret =3D erofsfsck_check_in=
ode(ctx-&gt;dir-&gt;nid, ctx-&gt;de_nid);</div><div>+</div><div>+<span styl=
e=3D"white-space:pre">	</span>if (fsckcfg.extract_path) {</div><div>+<span =
style=3D"white-space:pre">		</span>fsckcfg.extract_path[prev_pos] =3D &#39;=
\0&#39;;</div><div>+<span style=3D"white-space:pre">		</span>fsckcfg.extrac=
t_pos =3D prev_pos;</div><div>+<span style=3D"white-space:pre">	</span>}</d=
iv><div>+<span style=3D"white-space:pre">	</span>return ret;</div><div>=C2=
=A0}</div><div>=C2=A0</div><div>=C2=A0static int erofsfsck_check_inode(erof=
s_nid_t pnid, erofs_nid_t nid)</div><div>@@ -394,8 +568,25 @@ static int er=
ofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)</div><div>=C2=A0<spa=
n style=3D"white-space:pre">	</span>if (ret)</div><div>=C2=A0<span style=3D=
"white-space:pre">		</span>goto out;</div><div>=C2=A0</div><div>-<span styl=
e=3D"white-space:pre">	</span>/* verify data chunk layout */</div><div>-<sp=
an style=3D"white-space:pre">	</span>ret =3D erofs_verify_inode_data(&amp;i=
node);</div><div>+<span style=3D"white-space:pre">	</span>if (fsckcfg.extra=
ct_path) {</div><div>+<span style=3D"white-space:pre">		</span>switch (inod=
e.i_mode &amp; S_IFMT) {</div><div>+<span style=3D"white-space:pre">		</spa=
n>case S_IFDIR:</div><div>+<span style=3D"white-space:pre">			</span>ret =
=3D erofs_extract_dir(&amp;inode);</div><div>+<span style=3D"white-space:pr=
e">			</span>break;</div><div>+<span style=3D"white-space:pre">		</span>cas=
e S_IFREG:</div><div>+<span style=3D"white-space:pre">			</span>ret =3D ero=
fs_extract_file(&amp;inode);</div><div>+<span style=3D"white-space:pre">			=
</span>break;</div><div>+<span style=3D"white-space:pre">		</span>case S_IF=
LNK:</div><div>+<span style=3D"white-space:pre">			</span>ret =3D erofs_ext=
ract_symlink(&amp;inode);</div><div>+<span style=3D"white-space:pre">			</s=
pan>break;</div><div>+<span style=3D"white-space:pre">		</span>default:</di=
v><div>+<span style=3D"white-space:pre">			</span>goto verify;</div><div>+<=
span style=3D"white-space:pre">		</span>}</div><div>+<span style=3D"white-s=
pace:pre">	</span>} else {</div><div>+verify:</div><div>+<span style=3D"whi=
te-space:pre">		</span>/* verify data chunk layout */</div><div>+<span styl=
e=3D"white-space:pre">		</span>ret =3D erofs_verify_inode_data(&amp;inode);=
</div><div>+<span style=3D"white-space:pre">	</span>}</div><div>=C2=A0<span=
 style=3D"white-space:pre">	</span>if (ret)</div><div>=C2=A0<span style=3D"=
white-space:pre">		</span>goto out;</div><div>=C2=A0</div><div>@@ -425,6 +6=
16,9 @@ int main(int argc, char **argv)</div><div>=C2=A0<span style=3D"whit=
e-space:pre">	</span>fsckcfg.corrupted =3D false;</div><div>=C2=A0<span sty=
le=3D"white-space:pre">	</span>fsckcfg.print_comp_ratio =3D false;</div><di=
v>=C2=A0<span style=3D"white-space:pre">	</span>fsckcfg.check_decomp =3D fa=
lse;</div><div>+<span style=3D"white-space:pre">	</span>fsckcfg.extract_pat=
h =3D NULL;</div><div>+<span style=3D"white-space:pre">	</span>fsckcfg.extr=
act_pos =3D 0;</div><div>+<span style=3D"white-space:pre">	</span>fsckcfg.e=
xtract_fd =3D -1;</div><div>=C2=A0<span style=3D"white-space:pre">	</span>f=
sckcfg.logical_blocks =3D 0;</div><div>=C2=A0<span style=3D"white-space:pre=
">	</span>fsckcfg.physical_blocks =3D 0;</div><div>=C2=A0</div><div>diff --=
git a/mkfs/main.c b/mkfs/main.c</div><div>index 90cedde..1787b2c 100644</di=
v><div>--- a/mkfs/main.c</div><div>+++ b/mkfs/main.c</div><div>@@ -589,7 +5=
89,7 @@ int main(int argc, char **argv)</div><div>=C2=A0<span style=3D"whit=
e-space:pre">	</span>err =3D lstat64(cfg.c_src_path, &amp;st);</div><div>=
=C2=A0<span style=3D"white-space:pre">	</span>if (err)</div><div>=C2=A0<spa=
n style=3D"white-space:pre">		</span>return 1;</div><div>-<span style=3D"wh=
ite-space:pre">	</span>if ((st.st_mode &amp; S_IFMT) !=3D S_IFDIR) {</div><=
div>+<span style=3D"white-space:pre">	</span>if (!S_ISDIR(st.st_mode)) {</d=
iv><div>=C2=A0<span style=3D"white-space:pre">		</span>erofs_err(&quot;root=
 of the filesystem is not a directory - %s&quot;,</div><div>=C2=A0<span sty=
le=3D"white-space:pre">			</span>=C2=A0 cfg.c_src_path);</div><div>=C2=A0<s=
pan style=3D"white-space:pre">		</span>usage();</div><div>--=C2=A0</div><di=
v>2.30.2</div><div><br></div></div></div>

--000000000000be467c05d36dd85d--
