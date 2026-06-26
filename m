Return-Path: <linux-erofs+bounces-3771-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26mvOiCEPmqbHQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3771-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 15:52:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E789D6CDBA7
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 15:52:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=HrMBD8y1;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3771-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3771-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmxtz1hVBz2yYd;
	Fri, 26 Jun 2026 23:52:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782481947;
	cv=none; b=RTCbSKYM9sTz98bTmaa/72/KnbpFv/UQHQtIx1PLYpabdCrYFpBN/WNkWay0ITcqkndvrNB7xmabWdXXa6/Y6vBimu1t7fhOaMliJZuyxBdFoEJghBV0BfUcPL6QPh4xyf4MtMinlSmCmOohpviFRbOHFB1HlfQE0Eo0z5OkVi01MKP5/7FbfabLO5QJbJpyHFU0tNb99r/7+6AI4i9HqWNi7+586ttd1TtUh1hAf9D6dx6HnY5UmQwpvPjLMhYs9e2XZ8uxMfXLyGhZW2TQKOjzyf4jm5M4ThId1NBEZt7uAtmCH95nMaykZ3g506RMKCEoQ3RLiaxBtPb4vir73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782481947; c=relaxed/relaxed;
	bh=l2/q0j5sb+XsgW0Br0iyxQ0+dYd50F0fCxdgIX9ERv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE4hi4iLus4WAUce+OZKcHZDo6TMSSrDqA1IXbxBJ1rDTrS7Yza8taFnAmasF76XgEfwzlTq4R8POWB4wvlGlDdc8kF5PpBL7I/+FY/b3e2lcd2tntQ76QGTv6lMoDFBiwVKXZFnwmOGf/Tk/C8RSzPj9to0UtHPJUM3HHPfbPLxPCRg7Zukoi7Lja6Nn/ZtaG6J55qQQrUm105Ma3AqApZzZtNtLsVV3exOmZiBHKDIlzivq/JSzYQ2AVVH1KeScnXGZmRt/k+CmokKPmTsKeiUDXa8ECRBjYvdUqKg+nHOeqep831dMQg3NXSaxcV/tSLiKniQmT8kh6SI4TkJHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HrMBD8y1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmxts18W3z2xn3
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 23:52:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782481934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l2/q0j5sb+XsgW0Br0iyxQ0+dYd50F0fCxdgIX9ERv0=;
	b=HrMBD8y1mREN/S1tSf0fRnUe/t8H4TCMtckVjBo969VWkPfnfBxrXm4wiTa4Vjh2Sd+nWQE6mdzvDBBP4ZFLIZF9Ap28HQ412ui4FoZdRoThlPn2+MHv1VimYMjw+UlI46l2x7JXc3oTsHjt7yJJIcx2kACi9qiyU/s6Hlyiz5M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X5f3PcO_1782481927;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5f3PcO_1782481927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 21:52:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs-utils: fsck: add `--xattr-inode-digest` support
Date: Fri, 26 Jun 2026 21:52:06 +0800
Message-ID: <20260626135206.1594849-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260624142605.56652-1-hudson@cyzhu.com>
References: <20260624142605.56652-1-hudson@cyzhu.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3771-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tencent.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,it.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E789D6CDBA7

From: Chengyu Zhu <hudsonzhu@tencent.com>

Add a new `--xattr-inode-digest` option to verify per-inode digests
embedded by `mkfs.erofs --xattr-inode-digest`.

For each regular inode with non-zero size, the stored digest xattr is
compared against a freshly computed SHA-256 of the inode data:  Any
mismatch is reported as filesystem corruption.

Note that enabling this option also forces extraction.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c           | 129 +++++++++++++++++++++++++++++++++++++-----
 include/erofs/xattr.h |   3 +
 lib/xattr.c           |  56 ++++++++++++++++--
 man/fsck.erofs.1      |   4 ++
 4 files changed, 174 insertions(+), 18 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 759ca7df6722..b63fd135d7ad 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -15,9 +15,12 @@
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
+#include "../lib/sha256.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
+static char erofsfsck_nullstr[] = "";
+
 struct erofsfsck_dirstack {
 	erofs_nid_t dirs[PATH_MAX];
 	int top;
@@ -29,6 +32,7 @@ struct erofsfsck_cfg {
 	u64 logical_blocks;
 	char *extract_path;
 	size_t extract_pos;
+	char *digest_xattr_name;
 	mode_t umask;
 	bool superuser;
 	bool corrupted;
@@ -64,6 +68,7 @@ static struct option long_options[] = {
 	{"nid", required_argument, 0, 15},
 	{"path", required_argument, 0, 16},
 	{"no-sbcrc", no_argument, 0, 512},
+	{"xattr-inode-digest", no_argument, 0, 17},
 	{0, 0, 0, 0},
 };
 
@@ -117,6 +122,7 @@ static void usage(int argc, char **argv)
 		" --nid=#                check or extract from the target inode of nid #\n"
 		" --path=X               check or extract from the target inode of path X\n"
 		" --no-sbcrc             bypass the superblock checksum verification\n"
+		" --xattr-inode-digest   verify per-inode digests recorded as extended attributes\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
@@ -257,6 +263,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 16:
 			fsckcfg.inode_path = optarg;
 			break;
+		case 17:
+			fsckcfg.digest_xattr_name = erofsfsck_nullstr;
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
 
@@ -739,6 +769,56 @@ static void erofsfsck_hardlink_exit(void)
 	}
 }
 
+static int erofsfsck_verify_file_digest(struct erofs_inode *inode,
+					const u8 *digest)
+{
+	u8 stored[32 + sizeof("sha256:") - 1];
+	int ret;
+
+	ret = __erofs_getxattr(inode, fsckcfg.digest_xattr_name,
+			       (char *)stored, sizeof(stored), true);
+	if (ret == -ENODATA) {
+		erofs_warn("no digest xattr for nid %llu, skipped",
+			   inode->nid | 0ULL);
+		return 0;
+	} else if (ret < 0)
+		return ret;
+
+	if (ret != sizeof(stored) ||
+	    memcmp(stored, "sha256:", sizeof("sha256:") - 1)) {
+		erofs_err("unidentified digest xattr @ nid %llu (size=%d)",
+			  inode->nid | 0ULL, ret);
+		return -EFSCORRUPTED;
+	}
+
+	if (memcmp(digest, stored + sizeof("sha256:") - 1, 32)) {
+		erofs_err("digest MISMATCH @ nid %llu",
+			  inode->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+static int erofsfsck_calc_inode_data(struct erofs_inode *inode, int outfd)
+{
+	int ret;
+
+	if (fsckcfg.digest_xattr_name &&
+	    S_ISREG(inode->i_mode) && inode->i_size > 0) {
+		struct sha256_state md;
+		u8 out[32];
+
+		erofs_sha256_init(&md);
+		ret = erofs_verify_inode_data(inode, outfd, &md);
+		erofs_sha256_done(&md, out);
+
+		if (ret)
+			return ret;
+		return erofsfsck_verify_file_digest(inode, out);
+	}
+	return erofs_verify_inode_data(inode, outfd, NULL);
+}
+
 static inline int erofs_extract_file(struct erofs_inode *inode)
 {
 	bool tryagain = true;
@@ -774,8 +854,7 @@ again:
 		return -errno;
 	}
 
-	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, fd);
+	ret = erofsfsck_calc_inode_data(inode, fd);
 	close(fd);
 	return ret;
 }
@@ -791,7 +870,7 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, -1);
+	ret = erofs_verify_inode_data(inode, -1, NULL);
 	if (ret)
 		return ret;
 
@@ -845,7 +924,7 @@ static int erofs_extract_special(struct erofs_inode *inode)
 	erofs_dbg("extract special to path: %s", fsckcfg.extract_path);
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(inode, -1);
+	ret = erofs_verify_inode_data(inode, -1, NULL);
 	if (ret)
 		return ret;
 
@@ -928,13 +1007,13 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 
 static int erofsfsck_extract_inode(struct erofs_inode *inode)
 {
-	int ret;
 	char *oldpath;
+	int ret;
 
 	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
 verify:
 		/* verify data chunk layout */
-		return erofs_verify_inode_data(inode, -1);
+		return erofsfsck_calc_inode_data(inode, -1);
 	}
 
 	oldpath = erofsfsck_hardlink_find(inode->nid);
@@ -968,7 +1047,8 @@ verify:
 			inode->i_mode, inode->nid | 0ULL);
 		goto verify;
 	}
-	if (ret && ret != -ECANCELED)
+
+	if (ret && (ret != -ECANCELED || fsckcfg.digest_xattr_name))
 		return ret;
 
 	/* record nid and old path for hardlink */
@@ -1097,6 +1177,25 @@ int main(int argc, char *argv[])
 		goto exit_put_super;
 	}
 
+	if (fsckcfg.digest_xattr_name == erofsfsck_nullstr) {
+		fsckcfg.digest_xattr_name =
+			erofs_xattr_get_ishare_prefix(&g_sbi);
+		if (IS_ERR(fsckcfg.digest_xattr_name)) {
+			err = PTR_ERR(fsckcfg.digest_xattr_name);
+			erofs_err("failed to get ishare prefix: %s",
+				  erofs_strerror(err));
+			goto exit_put_super;
+		}
+
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
 
@@ -1177,6 +1276,8 @@ exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
 exit_put_super:
+	if (fsckcfg.digest_xattr_name != erofsfsck_nullstr)
+		free(fsckcfg.digest_xattr_name);
 	erofs_put_super(&g_sbi);
 exit_dev_close:
 	erofs_dev_close(&g_sbi);
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 235688649592..5fe3e91a4054 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -35,9 +35,12 @@ int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *pa
 int erofs_xattr_insert_name_prefix(const char *prefix);
 int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
 				  const char *prefix);
+char *erofs_xattr_get_ishare_prefix(struct erofs_sb_info *sbi);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
+int __erofs_getxattr(struct erofs_inode *vi, const char *name,
+		     char *buffer, size_t buffer_size, bool hidden);
 int erofs_setxattr(struct erofs_inode *inode, int index, const char *name,
 		   const void *value, size_t size);
 int erofs_vfs_setxattr(struct erofs_inode *inode, const char *name,
diff --git a/lib/xattr.c b/lib/xattr.c
index 1891ac3f23ef..52e8d0f1a6ad 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1410,8 +1410,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	return ret;
 }
 
-int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
-		   size_t buffer_size)
+int __erofs_getxattr(struct erofs_inode *vi, const char *name,
+		     char *buffer, size_t buffer_size, bool hidden)
 {
 	int ret;
 	unsigned int prefix, prefixlen;
@@ -1424,8 +1424,12 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
-		return -ENODATA;
+	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen)) {
+		if (!hidden)
+			return -ENODATA;
+		prefixlen = 0;
+		prefix = 0;
+	}
 	it.index = prefix;
 	it.name = name + prefixlen;
 	it.len = strlen(it.name);
@@ -1445,6 +1449,12 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	return ret ? ret : it.buffer_ofs;
 }
 
+int erofs_getxattr(struct erofs_inode *vi, const char *name,
+		   char *buffer, size_t buffer_size)
+{
+	return __erofs_getxattr(vi, name, buffer, buffer_size, false);
+}
+
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 {
 	int ret;
@@ -1515,6 +1525,44 @@ int erofs_xattr_set_ishare_prefix(struct erofs_sb_info *sbi,
 	return 0;
 }
 
+char *erofs_xattr_get_ishare_prefix(struct erofs_sb_info *sbi)
+{
+	struct erofs_xattr_prefix_item *pf;
+	unsigned int idx, base_index;
+	size_t base_len, infix_len;
+	char *name;
+
+	if (!erofs_sb_has_ishare_xattrs(sbi))
+		return NULL;
+
+	if (sbi->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX) {
+		idx = sbi->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
+		if (idx >= sbi->xattr_prefix_count)
+			return NULL;
+
+		pf = &sbi->xattr_prefixes[idx];
+		base_index = pf->prefix->base_index;
+		infix_len = pf->infix_len;
+	} else {
+		base_index = sbi->ishare_xattr_prefix_id &
+			EROFS_XATTR_LONG_PREFIX_MASK;
+		infix_len = 0;
+	}
+	if (base_index >= ARRAY_SIZE(xattr_types))
+		return ERR_PTR(-EFSCORRUPTED);
+
+	base_len = xattr_types[base_index].prefix_len;
+	name = malloc(base_len + infix_len + 1);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(name, xattr_types[base_index].prefix, base_len);
+	if (infix_len)
+		memcpy(name + base_len, pf->prefix->infix, infix_len);
+	name[base_len + infix_len] = '\0';
+	return name;
+}
+
 void erofs_xattr_cleanup_name_prefixes(void)
 {
 	struct ea_type_node *tnode, *n;
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 0f698da3b9b7..b2d35a7ded70 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -48,6 +48,10 @@ Specify the target inode by its path for checking or extraction. If both
 .BI "--[no-]xattrs"
 Whether to dump extended attributes during extraction (default off).
 .TP
+.B "\-\-xattr-inode-digest"
+Verify per-inode digests recorded as extended attributes during image
+creation with \fBmkfs.erofs \-\-xattr-inode-digest\fR.
+.TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
 .TP
-- 
2.43.5


