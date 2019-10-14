Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC91D6C3C
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 01:53:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sb3x5G9JzDqs1
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 10:53:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571097213;
	bh=b0PjQexgqfPGddZc5Eiuse51W/pK02+8r/riUa5vhBs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CmijMRFRSIY5CLA0acm01+vwSnvvC7k6y9y5yJTnv4QThU08UQ3PQJxapcaVbnAuY
	 GuTTrg8y4u6XOZQL/LQX+mZ2lBFTfX9pKvKaynkSzPAcsaZOkNcnrpkIV4r+ayItKj
	 EHnbKbTxYaOUYn4m75fIUz9yITLxpgP8A4o42WWTYCnJ/yGhGoCXTGP3uxn/92VWMv
	 NgFuwOpq5ugEwPN1868YIyLHLj3gsB6fO2GqkvKTRjew1gEIFH4NlPX2tuYLJN8Eg7
	 K6VfDcCOcXY++Q+Vo1rhbnAK7tD+2edUsEoXUxXRbQsP86denYN3zO5gQTjTRRD0YZ
	 3aAhQZZjR3NqQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.32; helo=sonic307-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="LVhLdiLW"; 
 dkim-atps=neutral
Received: from sonic307-8.consmr.mail.gq1.yahoo.com
 (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sb3q4Ty7zDqlZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 10:53:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571097201; bh=FjVAV3sHn2nWNDTk42OR0UhHoawprFi1+eIx/DA+0X8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=LVhLdiLWFFT1PFvJl+3Q914jw5jHZfVKECEkOUvGMlI8pTkL6odS4AjxykwMjvSLQAuZe9LBA96XtFWnRw0gYZI1dZ0cDO4+CxpB5Qp9dV494I+zWjY3Kbm0NdT7lg+YX8ZCvqiR1g1UD+jayoan+m1tBqV8Fguu040jWNRcYCB2FNs7inDGQ2dRhoskB4EnK331xDXWF+nN2FugB0JSPUwd3uJQc3TNQURWE80uxP8JNSzqTqUlB1o3r06h1VQVYzRGLtPvZuzCH4t9H7rlhgpcYt2o1Hy8pOaMN0aqC2oKNqMA558NvQvlZ+NAqF2DehSIE+82n9edu9Bg5y9HMA==
X-YMail-OSG: M8qqvioVM1kWXnvzsYxRMzTDVsYhfoB4nGRwoVllS4k0uVGWKXCveQwxSFLYCRC
 qC5DtRRCgT0aRNwz_wHmA97pp7Gao3zpLk2Bpf_lDf7GXTOQGGMhtuuGLskn..EBbSnLGJdNSa9a
 6CCv_3BuuJGyMBOT4GpGxiKcXmU_bfZUUZdQy2OL4cqKEQ0wjq6UdMTVFqkcN2S1uKzep12Dcaby
 eAqfZmYQWmQjyY3e41_4ga14_3zOHDckjQZr9P0q0S41ZTTnypcT5jTX1s9Gm.6_wEebtJao3xrW
 WH_VAvNCBjI53fmHjswmfTxzQqAfiLIGfwO0pEgXAWpXDVInjAXnrMz0g5uNu4JZ66EpcZTOwl5U
 NKl_zoUwYPRpK8am5LuRfMfwkFRvY.1aFVR7vEDiQO8fLP_fkSzqC.HVPudnbp0ZkDelGNtodioh
 ygkF_lLDqPldTwvgBG4RheK15hvUVuRqMftW6s9RObL0ka0xu606B1P8XNHqPUkTeeHbBDN7k.c3
 S3ldc5KIL6EVMLkLxTaV77ILe2fNFrShcLOcvY2O1tQXW_BO7qeqLYXuWBFHJFs36mXUSJOSf1vc
 WyJ9RO5NcmK0EB8Z4LSRv3Mj42edKpt0ZA.3w3n3DAq0xapgjlG4BWNn8UExeeX152M4Vk0wBlb3
 nfWo.ysNsHcCFg5bMap662mA8pLDcQd3QwVAFuPUNSpJz3QC7xSBRQoDqylHBO7VPhhS3m35r.vP
 8p3isl9A9GUFDHMmkTNFj_Tl7__jl7YvtFmbWImbTVQwYstW.AvHSkrjcUSqFPGiQvvosnCTetGX
 ZLEGiwpvOnaRl7ZHeXnaKpkfL4C7Vgjd1JMXOEp3ckOHmOin8f0AXonYb1RgCQBNVpgs9pqBVMpm
 w7GQr3BcmhqXyT9jLRgOQ8jZ69sy.dH53ydEhNjStS1vKfI2LIlTfBaeKIlN1G2BPv0sfRjQ.T5H
 7Rgm5uN.zqEVDK1M1iuDANFlynHomZJp7LtQHG7KsIk0imo9PivgGTKU02qBV59M0p.5VRcQv43Z
 DTqiJgH9uAboHR.j3VCfTKEB5fKRKUNSOuwqtOaNsNnHwgL4B2EU_K5f_32NhKFJrCQIOemg9Qr4
 rhWc.c0rFTlw4o9AsaRJFhnjWqS.Oy8kIBKRJ0KrHYa6odQKUJZWcSR.PKyRBxth7Um3ZCkuujzj
 YPeJgspo_mOYPHI8keUERZD6egrF16jvrIR.En3pT4S5ngUkiJCrimUAP99XnmzOGLWNL1kdWgkV
 hEa68EDrSs7qJ5.Fhbc1jMtvfGwBvU3J8mxZQW1vAnAkV6pFNLu6BtQw3zMqGfYyYjrojez8KRjI
 GjzIfxPZzrZ_qdig-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 14 Oct 2019 23:53:21 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 22e123b8743bf987373cc7daa68858c7; 
 Mon, 14 Oct 2019 23:53:18 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 2/2] erofs-utils: introduce shared xattr support
Date: Tue, 15 Oct 2019 07:53:08 +0800
Message-Id: <20191014235308.4277-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014114206.590-2-hsiangkao@aol.com>
References: <20191014114206.590-2-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Large xattrs or xattrs shared by a lot of files
can be stored in shared xattrs rather than
inlined right after inode.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
Changes since v4:
 - cleanxattrs when !shared_xattrs_size as well

 include/erofs/defs.h  |   2 +-
 include/erofs/xattr.h |   1 +
 lib/config.c          |   2 +-
 lib/inode.c           |   1 -
 lib/xattr.c           | 209 +++++++++++++++++++++++++++++++++++++++++-
 mkfs/main.c           |  12 ++-
 6 files changed, 221 insertions(+), 6 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index aa127d0..c67035d 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -14,7 +14,7 @@
 #include <stdint.h>
 #include <assert.h>
 #include <inttypes.h>
-
+#include <limits.h>
 #include <stdbool.h>
 
 #ifdef HAVE_CONFIG_H
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 29df025..3dff1ea 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -44,5 +44,6 @@
 
 int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
+int erofs_build_shared_xattrs_from_path(const char *path);
 
 #endif
diff --git a/lib/config.c b/lib/config.c
index cb42706..cbbecce 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -21,7 +21,7 @@ void erofs_init_configure(void)
 	cfg.c_dry_run  = false;
 	cfg.c_compr_level_master = -1;
 	cfg.c_force_inodeversion = 0;
-	cfg.c_inline_xattr_tolerance = 1;
+	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index b7121e0..86c465e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -8,7 +8,6 @@
  * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
  */
 #define _GNU_SOURCE
-#include <limits.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/lib/xattr.c b/lib/xattr.c
index d07d325..1564016 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -6,20 +6,25 @@
  * heavily changed by Li Guifu <blucerlee@gmail.com>
  *                and Gao Xiang <hsiangkao@aol.com>
  */
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <sys/xattr.h>
 #ifdef HAVE_LINUX_XATTR_H
 #include <linux/xattr.h>
 #endif
+#include <sys/stat.h>
+#include <dirent.h>
 #include "erofs/print.h"
 #include "erofs/hashtable.h"
 #include "erofs/xattr.h"
+#include "erofs/cache.h"
 
 #define EA_HASHTABLE_BITS 16
 
 struct xattr_item {
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
+	int shared_xattr_id;
 	u8 prefix;
 	struct hlist_node node;
 };
@@ -31,6 +36,9 @@ struct inode_xattr_node {
 
 static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
 
+static LIST_HEAD(shared_xattrs_list);
+static unsigned int shared_xattrs_count, shared_xattrs_size;
+
 static struct xattr_prefix {
 	const char *prefix;
 	u16 prefix_len;
@@ -113,6 +121,7 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->len[1] = len[1];
 	item->hash[0] = hash[0];
 	item->hash[1] = hash[1];
+	item->shared_xattr_id = -1;
 	item->prefix = prefix;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
@@ -160,7 +169,6 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	kvbuf = malloc(len[0] + len[1]);
 	if (!kvbuf)
 		return ERR_PTR(-ENOMEM);
-
 	memcpy(kvbuf, key + prefixlen, len[0]);
 	if (len[1]) {
 		/* copy value to buffer */
@@ -190,6 +198,23 @@ static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 	return 0;
 }
 
+static int shared_xattr_add(struct xattr_item *item)
+{
+	struct inode_xattr_node *node = malloc(sizeof(*node));
+
+	if (!node)
+		return -ENOMEM;
+
+	init_list_head(&node->list);
+	node->item = item;
+	list_add(&node->list, &shared_xattrs_list);
+
+	shared_xattrs_size += sizeof(struct erofs_xattr_entry);
+	shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
+					       item->len[0] + item->len[1]);
+	return ++shared_xattrs_count;
+}
+
 static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
 {
 	int ret = 0;
@@ -235,6 +260,11 @@ static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
 			ret = inode_xattr_add(ixattrs, item);
 			if (ret < 0)
 				goto err;
+		} else if (item->count == cfg.c_inline_xattr_tolerance + 1) {
+			ret = shared_xattr_add(item);
+			if (ret < 0)
+				goto err;
+			ret = 0;
 		}
 		kllen -= keylen + 1;
 		key += keylen + 1;
@@ -266,16 +296,175 @@ int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
 	list_for_each_entry(node, ixattrs, list) {
 		const struct xattr_item *item = node->item;
 
+		if (item->shared_xattr_id >= 0) {
+			ret += sizeof(__le32);
+			continue;
+		}
 		ret += sizeof(struct erofs_xattr_entry);
 		ret = EROFS_XATTR_ALIGN(ret + item->len[0] + item->len[1]);
 	}
 	return ret;
 }
 
+static int erofs_count_all_xattrs_from_path(const char *path)
+{
+	int ret;
+	DIR *_dir;
+	struct stat64 st;
+
+	_dir = opendir(path);
+	if (!_dir) {
+		erofs_err("%s, failed to opendir at %s: %s",
+			  __func__, path, erofs_strerror(errno));
+		return -errno;
+	}
+
+	ret = 0;
+	while (1) {
+		struct dirent *dp;
+		char buf[PATH_MAX];
+
+		/*
+		 * set errno to 0 before calling readdir() in order to
+		 * distinguish end of stream and from an error.
+		 */
+		errno = 0;
+		dp = readdir(_dir);
+		if (!dp)
+			break;
+
+		if (is_dot_dotdot(dp->d_name) ||
+		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
+			continue;
+
+		ret = snprintf(buf, PATH_MAX, "%s/%s", path, dp->d_name);
+
+		if (ret < 0 || ret >= PATH_MAX) {
+			/* ignore the too long path */
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		ret = read_xattrs_from_file(buf, NULL);
+		if (ret)
+			goto fail;
+
+		ret = lstat64(buf, &st);
+		if (ret) {
+			ret = -errno;
+			goto fail;
+		}
+
+		if (!S_ISDIR(st.st_mode))
+			continue;
+
+		ret = erofs_count_all_xattrs_from_path(buf);
+		if (ret)
+			goto fail;
+	}
+
+	if (errno)
+		ret = -errno;
+
+fail:
+	closedir(_dir);
+	return ret;
+}
+
+static void erofs_cleanxattrs(bool sharedxattrs)
+{
+	unsigned int i;
+	struct xattr_item *item;
+
+	hash_for_each(ea_hashtable, i, item, node) {
+		if (sharedxattrs && item->shared_xattr_id >= 0)
+			continue;
+
+		hash_del(&item->node);
+		free(item);
+	}
+
+	if (sharedxattrs)
+		return;
+
+	shared_xattrs_size = shared_xattrs_count = 0;
+}
+
+int erofs_build_shared_xattrs_from_path(const char *path)
+{
+	int ret;
+	struct erofs_buffer_head *bh;
+	struct inode_xattr_node *node, *n;
+	char *buf;
+	unsigned int p;
+	erofs_off_t off;
+
+	/* check if xattr or shared xattr is disabled */
+	if (cfg.c_inline_xattr_tolerance < 0 ||
+	    cfg.c_inline_xattr_tolerance == INT_MAX)
+		return 0;
+
+	if (shared_xattrs_size || shared_xattrs_count) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
+	ret = erofs_count_all_xattrs_from_path(path);
+	if (ret)
+		return ret;
+
+	if (!shared_xattrs_size)
+		goto out;
+
+	buf = malloc(shared_xattrs_size);
+	if (!buf)
+		return -ENOMEM;
+
+	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
+	if (IS_ERR(bh)) {
+		free(buf);
+		return PTR_ERR(bh);
+	}
+	bh->op = &erofs_skip_write_bhops;
+
+	erofs_mapbh(bh->block, true);
+	off = erofs_btell(bh, false);
+
+	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
+	off %= EROFS_BLKSIZ;
+	p = 0;
+
+	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
+		struct xattr_item *const item = node->item;
+		const struct erofs_xattr_entry entry = {
+			.e_name_index = item->prefix,
+			.e_name_len = item->len[0],
+			.e_value_size = cpu_to_le16(item->len[1])
+		};
+
+		list_del(&node->list);
+
+		item->shared_xattr_id = (off + p) /
+			sizeof(struct erofs_xattr_entry);
+
+		memcpy(buf + p, &entry, sizeof(entry));
+		p += sizeof(struct erofs_xattr_entry);
+		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
+		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
+		free(node);
+	}
+	bh->fsprivate = buf;
+	bh->op = &erofs_buf_write_bhops;
+out:
+	erofs_cleanxattrs(true);
+	return 0;
+}
+
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 {
 	struct inode_xattr_node *node, *n;
 	struct erofs_xattr_ibody_header *header;
+	LIST_HEAD(ilst);
 	unsigned int p;
 	char *buf = calloc(1, size);
 
@@ -288,6 +477,24 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
+
+		list_del(&node->list);
+
+		/* move inline xattrs to the onstack list */
+		if (item->shared_xattr_id < 0) {
+			list_add(&node->list, &ilst);
+			continue;
+		}
+
+		*(__le32 *)(buf + p) = cpu_to_le32(item->shared_xattr_id);
+		p += sizeof(__le32);
+		++header->h_shared_count;
+		free(node);
+		put_xattritem(item);
+	}
+
+	list_for_each_entry_safe(node, n, &ilst, list) {
+		struct xattr_item *const item = node->item;
 		const struct erofs_xattr_entry entry = {
 			.e_name_index = item->prefix,
 			.e_name_len = item->len[0],
diff --git a/mkfs/main.c b/mkfs/main.c
index 0df2a96..71c81f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -19,6 +19,7 @@
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/xattr.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -28,7 +29,7 @@ static void usage(void)
 	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
-	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 1)\n");
+	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
 }
@@ -188,7 +189,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
-		.xattr_blkaddr = 0,
+		.xattr_blkaddr = sbi.xattr_blkaddr,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 	};
 	const unsigned int sb_blksize =
@@ -284,6 +285,13 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
+	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+	if (err) {
+		erofs_err("Failed to build shared xattrs: %s",
+			  erofs_strerror(err));
+		goto exit;
+	}
+
 	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
-- 
2.17.1

