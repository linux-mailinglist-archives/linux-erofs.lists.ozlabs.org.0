Return-Path: <linux-erofs+bounces-3227-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3YAsAO12n+KggAu9opvQ
	(envelope-from <linux-erofs+bounces-3227-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 04:28:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1F43C5894
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 04:28:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frkPR1q6zz2ySj;
	Thu, 09 Apr 2026 12:28:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775701691;
	cv=none; b=JHQVXbtoqGek4zf3609J6fzie3MJCKX483o3FcDfzY/gQ/GaJJd2DOOzrVV08u0OqjNmB6L1+I8l3L2s+k7/o5nfcUuz6xK5zJG4tv04sVo3kNM6MGbCJVQeAAsdtLDFxQrChVXZpD7G+OjR+KYsXYR0moNcxG2cR+tq8+D4QAYahgRCFpKBH8mTRYqVqJ9SdAkZNm30SJeI1keJVV0dvlkcgbxhIn5UoxjxP+ONcRLQ3mhz40C+Uqs0+gxRSz1PP1r2qm95sCU7onJu7Y+NgteYD8/MKhmmmfJQeINt3RUfEGgzrQgttw5KEfjvMKzMbmw30OKR4jbG51j2JvHtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775701691; c=relaxed/relaxed;
	bh=yXQZuY/HgJwFeR2DDNJx1Q/TE50bRDatO6eHBOwygG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5T2ZoSwERTghPWdDP/ogsdfGXYyBSE6cf0q1FyaBO07ggEaRYe/rHuJqALHWgwezfNK5vFCrOXQ5sdDLczJ8CD1MyYoGmXl4v5RUh36thBMRLjCY6oLf/EVpE+43ltojyWNMgp5bT5qJjXSiVxWeBQkr9wbzr/8PsJABH5CW2CdjTr9efa7Yy1c0tAImruu+nB/85Lx1XKRKNLGXr/G+ocZHKW2/Weq4+2yJ35s0OQnc6dWBZkXr8MIJcsm/SSOWfBHnEBb5S4wilUPJwWgLVTq3DcPXqxvYLsAxGlN6eUR2W1kjXpjaH3PhdLxywSeVxeYh0bURc2ZTIhVx/rpiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.81; helo=out28-81.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.81; helo=out28-81.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-81.mail.aliyun.com (out28-81.mail.aliyun.com [115.124.28.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frkPN5Gwvz2xTh
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 12:28:05 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0161991-0.00305207-0.980749;FP=9963476626713691898|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.h7xcwnA_1775701676;
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.h7xcwnA_1775701676 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 10:27:57 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/1] fsck.erofs: add --verify-digest for per-file SHA-256 verification
Date: Thu,  9 Apr 2026 10:27:53 +0800
Message-ID: <20260409022753.42266-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3227-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-0.787];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyzhu.com:mid]
X-Rspamd-Queue-Id: BD1F43C5894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Add a new --verify-digest option to fsck.erofs that verifies per-file
SHA-256 digests embedded by mkfs.erofs --xattr-inode-digest. For each
regular file, the stored digest xattr is compared against a freshly
computed SHA-256 of the decompressed file data. Any mismatch is
reported as filesystem corruption.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 fsck/main.c           | 160 ++++++++++++++++++++++++++++++++++++++----
 include/erofs/xattr.h |   1 +
 lib/sha256.h          |   4 +-
 lib/xattr.c           |  33 +++++++++
 man/fsck.erofs.1      |   7 ++
 5 files changed, 190 insertions(+), 15 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 21ada19..efc92c5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -15,6 +15,7 @@
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
+#include "../lib/sha256.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -42,6 +43,8 @@ struct erofsfsck_cfg {
 	erofs_nid_t nid;
 	const char *inode_path;
 	bool nosbcrc;
+	bool verify_digest;
+	char *digest_xattr_name;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -64,6 +67,7 @@ static struct option long_options[] = {
 	{"nid", required_argument, 0, 15},
 	{"path", required_argument, 0, 16},
 	{"no-sbcrc", no_argument, 0, 512},
+	{"verify-digest", no_argument, 0, 17},
 	{0, 0, 0, 0},
 };
 
@@ -117,6 +121,8 @@ static void usage(int argc, char **argv)
 		" --nid=#                check or extract from the target inode of nid #\n"
 		" --path=X               check or extract from the target inode of path X\n"
 		" --no-sbcrc             bypass the superblock checksum verification\n"
+		" --verify-digest        verify per-file SHA-256 digests embedded by\n"
+		"                        mkfs.erofs --xattr-inode-digest\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
@@ -257,6 +263,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 16:
 			fsckcfg.inode_path = optarg;
 			break;
+		case 17:
+			fsckcfg.verify_digest = true;
+			fsckcfg.check_decomp = true;
+			break;
 		case 512:
 			fsckcfg.nosbcrc = true;
 			break;
@@ -503,7 +513,8 @@ out:
 	return ret;
 }
 
-static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
+static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
+				   struct sha256_state *digest)
 {
 	struct erofs_map_blocks map = {
 		.buf = __EROFS_BUF_INITIALIZER,
@@ -546,11 +557,24 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		if (map.m_la >= inode->i_size || !needdecode)
 			continue;
 
-		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
-			ret = lseek(outfd, map.m_llen, SEEK_CUR);
-			if (ret < 0) {
-				ret = -errno;
-				goto out;
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			if (digest) {
+				static const char zeros[4096];
+				u64 remain = map.m_llen;
+
+				while (remain > 0) {
+					u64 chunk = remain > sizeof(zeros) ?
+						    sizeof(zeros) : remain;
+					erofs_sha256_process(digest,
+						(const u8 *)zeros, chunk);
+					remain -= chunk;
+				}
+			} else if (outfd >= 0) {
+				ret = lseek(outfd, map.m_llen, SEEK_CUR);
+				if (ret < 0) {
+					ret = -errno;
+					goto out;
+				}
 			}
 			continue;
 		}
@@ -596,6 +620,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			if (ret)
 				goto out;
 
+			if (digest)
+				erofs_sha256_process(digest,
+					(const u8 *)buffer, map.m_llen);
 			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
 				goto fail_eio;
 		} else {
@@ -609,6 +636,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 				if (ret)
 					goto out;
 
+				if (digest)
+					erofs_sha256_process(digest,
+						(const u8 *)raw, count);
 				if (outfd >= 0 && write(outfd, raw, count) < 0)
 					goto fail_eio;
 				map.m_llen -= count;
@@ -643,7 +673,7 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 	erofs_dbg("create directory %s", fsckcfg.extract_path);
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, -1);
+	ret = erofs_verify_inode_data(inode, -1, NULL);
 	if (ret)
 		return ret;
 
@@ -739,7 +769,8 @@ static void erofsfsck_hardlink_exit(void)
 	}
 }
 
-static inline int erofs_extract_file(struct erofs_inode *inode)
+static inline int erofs_extract_file(struct erofs_inode *inode,
+				     struct sha256_state *digest)
 {
 	bool tryagain = true;
 	int ret, fd;
@@ -775,7 +806,7 @@ again:
 	}
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, fd);
+	ret = erofs_verify_inode_data(inode, fd, digest);
 	close(fd);
 	return ret;
 }
@@ -790,7 +821,7 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, -1);
+	ret = erofs_verify_inode_data(inode, -1, NULL);
 	if (ret)
 		return ret;
 
@@ -844,7 +875,7 @@ static int erofs_extract_special(struct erofs_inode *inode)
 	erofs_dbg("extract special to path: %s", fsckcfg.extract_path);
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, -1);
+	ret = erofs_verify_inode_data(inode, -1, NULL);
 	if (ret)
 		return ret;
 
@@ -925,15 +956,81 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	return ret;
 }
 
+static int erofsfsck_compute_digest(struct erofs_inode *inode,
+				    int fd, u8 *out)
+{
+	struct sha256_state md;
+	int ret;
+
+	erofs_sha256_init(&md);
+	ret = erofs_verify_inode_data(inode, fd, &md);
+	if (!ret)
+		erofs_sha256_done(&md, out);
+	return ret;
+}
+
+static int erofsfsck_verify_file_digest(struct erofs_inode *inode,
+					const u8 *computed_digest)
+{
+	u8 stored[32 + EROFS_SHA256_PREFIX_LEN];
+	u8 computed[32];
+	const u8 *digest = computed_digest;
+	int ret;
+
+	ret = erofs_getxattr(inode, fsckcfg.digest_xattr_name,
+			     (char *)stored, sizeof(stored));
+	if (ret == -ENODATA) {
+		erofs_warn("no digest xattr for nid %llu, skipped",
+			   inode->nid | 0ULL);
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(stored) ||
+	    strncmp((const char *)stored, EROFS_SHA256_PREFIX, EROFS_SHA256_PREFIX_LEN)) {
+		erofs_err("malformed digest xattr @ nid %llu (size=%d)",
+			  inode->nid | 0ULL, ret);
+		return -EFSCORRUPTED;
+	}
+
+	if (!digest) {
+		ret = erofsfsck_compute_digest(inode, -1, computed);
+		if (ret)
+			return ret;
+		digest = computed;
+	}
+
+	if (memcmp(digest, stored + EROFS_SHA256_PREFIX_LEN, 32)) {
+		erofs_err("digest MISMATCH @ nid %llu",
+			  inode->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
 static int erofsfsck_extract_inode(struct erofs_inode *inode)
 {
+	u8 computed_digest[32];
+	bool has_digest = false;
 	int ret;
 	char *oldpath;
 
 	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
 verify:
 		/* verify data chunk layout */
-		return erofs_verify_inode_data(inode, -1);
+		if (fsckcfg.verify_digest &&
+		    S_ISREG(inode->i_mode) && inode->i_size > 0) {
+			ret = erofsfsck_compute_digest(inode, -1,
+						       computed_digest);
+			if (ret)
+				return ret;
+			has_digest = true;
+		} else {
+			ret = erofs_verify_inode_data(inode, -1, NULL);
+			if (ret)
+				return ret;
+		}
+		goto check_digest;
 	}
 
 	oldpath = erofsfsck_hardlink_find(inode->nid);
@@ -950,9 +1047,21 @@ verify:
 	case S_IFDIR:
 		ret = erofs_extract_dir(inode);
 		break;
-	case S_IFREG:
-		ret = erofs_extract_file(inode);
+	case S_IFREG: {
+		struct sha256_state md;
+
+		if (fsckcfg.verify_digest && inode->i_size > 0) {
+			erofs_sha256_init(&md);
+			ret = erofs_extract_file(inode, &md);
+			if (!ret) {
+				erofs_sha256_done(&md, computed_digest);
+				has_digest = true;
+			}
+		} else {
+			ret = erofs_extract_file(inode, NULL);
+		}
 		break;
+	}
 	case S_IFLNK:
 		ret = erofs_extract_symlink(inode);
 		break;
@@ -969,11 +1078,21 @@ verify:
 	}
 	if (ret && ret != -ECANCELED)
 		return ret;
+	if (ret == -ECANCELED && fsckcfg.verify_digest)
+		return ret;
 
 	/* record nid and old path for hardlink */
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		ret = erofsfsck_hardlink_insert(inode->nid,
 						fsckcfg.extract_path);
+	if (ret)
+		return ret;
+
+check_digest:
+	if (fsckcfg.verify_digest &&
+	    S_ISREG(inode->i_mode) && inode->i_size > 0)
+		ret = erofsfsck_verify_file_digest(inode,
+						   has_digest ? computed_digest : NULL);
 	return ret;
 }
 
@@ -1096,6 +1215,18 @@ int main(int argc, char *argv[])
 		goto exit_put_super;
 	}
 
+	if (fsckcfg.verify_digest) {
+		fsckcfg.digest_xattr_name =
+			erofs_xattr_build_ishare_name(&g_sbi);
+		if (!fsckcfg.digest_xattr_name) {
+			erofs_err("image has no inode digest xattrs (was --xattr-inode-digest used during mkfs?)");
+			err = -ENODATA;
+			goto exit_put_super;
+		}
+		erofs_info("verifying digests using xattr \"%s\"",
+			   fsckcfg.digest_xattr_name);
+	}
+
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_init();
 
@@ -1176,6 +1307,7 @@ exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
 exit_put_super:
+	free(fsckcfg.digest_xattr_name);
 	erofs_put_super(&g_sbi);
 exit_dev_close:
 	erofs_dev_close(&g_sbi);
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 2356886..4fbf871 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -35,6 +35,7 @@ int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *pa
 int erofs_xattr_insert_name_prefix(const char *prefix);
 int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
 				  const char *prefix);
+char *erofs_xattr_build_ishare_name(struct erofs_sb_info *sbi);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
diff --git a/lib/sha256.h b/lib/sha256.h
index 6bcf03c..a9fca0e 100644
--- a/lib/sha256.h
+++ b/lib/sha256.h
@@ -4,6 +4,9 @@
 
 #include "erofs/defs.h"
 
+#define EROFS_SHA256_PREFIX	"sha256:"
+#define EROFS_SHA256_PREFIX_LEN	(sizeof(EROFS_SHA256_PREFIX) - 1)
+
 #if defined(HAVE_OPENSSL) && defined(HAVE_OPENSSL_EVP_H)
 #include <openssl/evp.h>
 struct sha256_state {
@@ -22,7 +25,6 @@ void erofs_sha256_init(struct sha256_state *md);
 int erofs_sha256_process(struct sha256_state *md,
 		const unsigned char *in, unsigned long inlen);
 int erofs_sha256_done(struct sha256_state *md, unsigned char *out);
-
 void erofs_sha256(const unsigned char *in, unsigned long in_size,
 		  unsigned char out[32]);
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 3cf86e8..f78072e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1515,6 +1515,39 @@ int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
 	return 0;
 }
 
+char *erofs_xattr_build_ishare_name(struct erofs_sb_info *sbi)
+{
+	struct erofs_xattr_prefix_item *pf;
+	unsigned int idx, base_index;
+	const char *base;
+	size_t base_len, total;
+	char *name;
+
+	if (!erofs_sb_has_ishare_xattrs(sbi))
+		return NULL;
+
+	idx = sbi->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
+	if (idx >= sbi->xattr_prefix_count)
+		return NULL;
+
+	pf = &sbi->xattr_prefixes[idx];
+	base_index = pf->prefix->base_index;
+	if (!base_index || base_index >= ARRAY_SIZE(xattr_types))
+		return NULL;
+
+	base = xattr_types[base_index].prefix;
+	base_len = xattr_types[base_index].prefix_len;
+	total = base_len + pf->infix_len + 1;
+	name = malloc(total);
+	if (!name)
+		return NULL;
+
+	memcpy(name, base, base_len);
+	memcpy(name + base_len, pf->prefix->infix, pf->infix_len);
+	name[total - 1] = '\0';
+	return name;
+}
+
 void erofs_xattr_cleanup_name_prefixes(void)
 {
 	struct ea_type_node *tnode, *n;
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 0f698da..c704aae 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -37,6 +37,13 @@ Optionally extract contents of the \fIIMAGE\fR to \fIdirectory\fR.
 .B "--no-sbcrc"
 Bypass the on-disk superblock checksum verification.
 .TP
+.B "--verify-digest"
+Verify the per-file SHA-256 digests that were embedded during image creation
+with \fBmkfs.erofs --xattr-inode-digest\fR. For each regular file, the stored
+digest is compared against a freshly computed SHA-256 of the (decompressed)
+file data. Any digest mismatch or digest-related verification error causes
+the filesystem to be reported as corrupted.
+.TP
 .BI "\-\-nid=" #
 Specify the target inode by its NID for checking or extraction.
 The default is the root inode.
-- 
2.51.0


