Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF218C82DF
	for <lists+linux-erofs@lfdr.de>; Fri, 17 May 2024 11:01:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iVCgkJwX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VggtH6nskz30Vq
	for <lists+linux-erofs@lfdr.de>; Fri, 17 May 2024 19:01:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iVCgkJwX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vggt81MG2z2ytN
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 May 2024 19:01:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715936456; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CCgg8lZwYU/661MQbGQ/s8m0vOXCNnYuDQ15W1j1j/c=;
	b=iVCgkJwXQG/aax1vet6LsnzXnva5HXeoo44qD6BJGjHtS9gKBE0iAbrdtkiqc5urf4Ja4QWf85+2ifNuEfeSxavGRtbbl8z95yKyMaWx1wE6SKHlZ6hGxsqDfO9pYv3q+1PF2qiqKhP4ChGyBCIoCAnTVX13rxmoBcj2WAYnxks=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W6e9IVw_1715936449;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6e9IVw_1715936449)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:00:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add `--zfeature-bits` option
Date: Fri, 17 May 2024 17:00:48 +0800
Message-Id: <20240517090048.3039594-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thus, we could traverse all compression features with a number
easily in the testcases.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 160 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 36 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index c26cb56..12321ed 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -81,6 +81,7 @@ static struct option long_options[] = {
 #ifdef EROFS_MT_ENABLED
 	{"workers", required_argument, NULL, 520},
 #endif
+	{"zfeature-bits", required_argument, NULL, 521},
 	{0, 0, 0, 0},
 };
 
@@ -166,6 +167,7 @@ static void usage(int argc, char **argv)
 		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
 		" --ignore-mtime        use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+		" --mount-point=X       X=prefix of target fs path (default: /)\n"
 		" --preserve-mtime      keep per-file modification time strictly\n"
 		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
@@ -190,7 +192,7 @@ static void usage(int argc, char **argv)
 		" --workers=#           set the number of worker threads to # (default: %u)\n"
 #endif
 		" --xattr-prefix=X      X=extra xattr name prefix\n"
-		" --mount-point=X       X=prefix of target fs path (default: /)\n"
+		" --zfeature-bits       toggle filesystem compression features according to given bits\n"
 #ifdef WITH_ANDROID
 		"\n"
 		"Android-specific options:\n"
@@ -220,10 +222,81 @@ static bool tar_mode, rebuild_mode;
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 
+static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
+					       unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+	/* disable compacted indexes and 0padding */
+	cfg.c_legacy_compress = en;
+	return 0;
+}
+
+static int erofs_mkfs_feat_set_ztailpacking(bool en, const char *val,
+					    unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+	cfg.c_ztailpacking = en;
+	return 0;
+}
+
+static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
+					 unsigned int vallen)
+{
+	if (!en) {
+		if (vallen)
+			return -EINVAL;
+		cfg.c_fragments = false;
+		return 0;
+	}
+
+	if (vallen) {
+		char *endptr;
+		u64 i = strtoull(val, &endptr, 0);
+
+		if (endptr - val != vallen) {
+			erofs_err("invalid pcluster size %s for the packed file %s", val);
+			return -EINVAL;
+		}
+		pclustersize_packed = i;
+	}
+	cfg.c_fragments = true;
+	return 0;
+}
+
+static int erofs_mkfs_feat_set_all_fragments(bool en, const char *val,
+					     unsigned int vallen)
+{
+	cfg.c_all_fragments = en;
+	return erofs_mkfs_feat_set_fragments(en, val, vallen);
+}
+
+static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
+				      unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+	cfg.c_dedupe = en;
+	return 0;
+}
+
+static struct {
+	char *feat;
+	int (*set)(bool en, const char *val, unsigned int len);
+} z_erofs_mkfs_features[] = {
+	{"legacy-compress", erofs_mkfs_feat_set_legacy_compress},
+	{"ztailpacking", erofs_mkfs_feat_set_ztailpacking},
+	{"fragments", erofs_mkfs_feat_set_fragments},
+	{"all-fragments", erofs_mkfs_feat_set_all_fragments},
+	{"dedupe", erofs_mkfs_feat_set_dedupe},
+	{NULL, NULL},
+};
+
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
-	(keylen == sizeof(opt) - 1 && !memcmp(token, opt, sizeof(opt) - 1))
+	(keylen == strlen(opt) && !memcmp(token, opt, keylen))
 
 	const char *token, *next, *tokenend, *value __maybe_unused;
 	unsigned int keylen, vallen;
@@ -262,12 +335,7 @@ static int parse_extended_opts(const char *opts)
 			clear = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("legacy-compress", token, keylen)) {
-			if (vallen)
-				return -EINVAL;
-			/* disable compacted indexes and 0padding */
-			cfg.c_legacy_compress = true;
-		} else if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
+		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
@@ -296,41 +364,51 @@ static int parse_extended_opts(const char *opts)
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
-		} else if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
-			if (vallen)
-				return -EINVAL;
-			cfg.c_ztailpacking = !clear;
-		} else if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
-			cfg.c_all_fragments = true;
-			goto handle_fragment;
-		} else if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
-			char *endptr;
-			u64 i;
-
-handle_fragment:
-			cfg.c_fragments = true;
-			if (vallen) {
-				i = strtoull(value, &endptr, 0);
-				if (endptr - value != vallen) {
-					erofs_err("invalid pcluster size for the packed file %s",
-						  next);
-					return -EINVAL;
-				}
-				pclustersize_packed = i;
-			}
-		} else if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
-			if (vallen)
-				return -EINVAL;
-			cfg.c_dedupe = !clear;
 		} else if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_xattr_name_filter = !clear;
 		} else {
-			erofs_err("unknown extended option %.*s",
-				  p - token, token);
+			int i, err;
+
+			for (i = 0; z_erofs_mkfs_features[i].feat; ++i) {
+				if (!MATCH_EXTENTED_OPT(z_erofs_mkfs_features[i].feat,
+							token, keylen))
+					continue;
+				err = z_erofs_mkfs_features[i].set(!clear, value, vallen);
+				if (err)
+					return err;
+				break;
+			}
+
+			if (!z_erofs_mkfs_features[i].feat) {
+				erofs_err("unknown extended option %.*s",
+					  p - token, token);
+				return -EINVAL;
+			}
+		}
+	}
+	return 0;
+}
+
+static int mkfs_apply_zfeature_bits(uintmax_t bits)
+{
+	int i;
+
+	for (i = 0; bits; ++i) {
+		int err;
+
+		if (!z_erofs_mkfs_features[i].feat) {
+			erofs_err("unsupported zfeature bit %u", i);
 			return -EINVAL;
 		}
+		err = z_erofs_mkfs_features[i].set(bits & 1, NULL, 0);
+		if (err) {
+			erofs_err("failed to apply zfeature %s",
+				  z_erofs_mkfs_features[i].feat);
+			return err;
+		}
+		bits >>= 1;
 	}
 	return 0;
 }
@@ -690,6 +768,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		}
 #endif
+		case 521:
+			i = strtol(optarg, &endptr, 0);
+			if (errno || *endptr != '\0') {
+				erofs_err("invalid zfeature bits %s", optarg);
+				return -EINVAL;
+			}
+			err = mkfs_apply_zfeature_bits(i);
+			if (err)
+				return err;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.39.3

