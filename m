Return-Path: <linux-erofs+bounces-993-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0141B4A853
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 11:40:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLf240wXGz3cYy;
	Tue,  9 Sep 2025 19:40:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757410828;
	cv=none; b=eVN0s9s5SGzi0J7QC/s+s/vpMJARQaynEBwYecao+3gM0P/brvXURopRCXojOQ7tH4bc0TTsMK6gVWBDVufipQaTGdaZjtgS6k48KQIKfy3z+0LsZzNNMglPgoSqGqVFZlXoByQxD/q4qiPOfAtMHIzgdtUXkENzggRRZBsUJEWXcuA++uJYilxNRgWMdPdflOd9MfcGPIOL6FerIb/w2RXgaaMH6QszSxySvRDzipwTduXgonDKMtDKF5xexD4UUa7H+C9hgvQoPDuChBagmAH5qY/0pm8exHJwv1+SQjplwekIz2Y+QVBJVveozXz0+R3jvukjPl5KzToBsHjfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757410828; c=relaxed/relaxed;
	bh=+HAsTzkIBUgKQ0u5DtIUsCfJQmwb4FMfXBudTj4Ijy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNyrnyWJdOzGoKb0YWWlxhUtdcjI6N1VRe0Xs6Bm/r4bYN84i6ZgPKXxE50o+eXvTYkHAN8xBYzX8IImLbCwgUR1GED8Zul/1C8w8rgIyGuBWcXOwASzjmlHRPQ32EljxKj7L7ESbDXeV6vN1s+NeHQKisdwajMmapeaRstOBfEkJv2Yj7CcXxER9OvRTTRxUYMmj6nyVOZzKVNRVnYi7vMF05whXaAzaQ1hx/ocr1hUOYALmPIQLmziXc4lHWhyRJ8gn4QniMtaCD5mbfTSgFTjgFn1vMFz6hkq7WzmIdUuFkopWTRWIdfA7Lc5FAxNb64OHcGcgSWR2zRf5QbK7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fk7671g/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fk7671g/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLf215HDKz2xnM
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 19:40:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757410820; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+HAsTzkIBUgKQ0u5DtIUsCfJQmwb4FMfXBudTj4Ijy4=;
	b=fk7671g/yBq42Yf7y5DLTEQ7N+asgx5TFZJWzJPgCDebAIzFT4KT+YN4JcWoRqlidGs9Y0oY5UhCqNxX3IuCm7/rIj+YNAhTtHoX1ZTMJMJgfsPH8UwiBwjlYLV98DU/HPFtmsdt59CkDUCij6Xg7u7ubOySMS8MKv7xw+E335Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WndX0gm_1757410814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 17:40:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: migrate `c_force_inodeversion`
Date: Tue,  9 Sep 2025 17:40:12 +0800
Message-ID: <20250909094014.875652-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  7 -------
 include/erofs/importer.h |  6 ++++++
 lib/config.c             |  1 -
 lib/inode.c              | 20 +++++++++++---------
 mkfs/main.c              |  9 +++++----
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 0312909..6554ad2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -15,12 +15,6 @@ extern "C"
 #include "defs.h"
 #include "err.h"
 
-
-enum {
-	FORCE_INODE_COMPACT = 1,
-	FORCE_INODE_EXTENDED,
-};
-
 enum {
 	FORCE_INODE_BLOCK_MAP = 1,
 	FORCE_INODE_CHUNK_INDEXES,
@@ -73,7 +67,6 @@ struct erofs_configure {
 	char *c_blobdev_path;
 	char *c_compress_hints_file;
 	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
-	char c_force_inodeversion;
 	char c_force_chunkformat;
 	u8 c_mkfs_metabox_algid;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 28d29bd..85e3a50 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -12,6 +12,11 @@ extern "C"
 
 #include "internal.h"
 
+enum {
+	EROFS_FORCE_INODE_COMPACT = 1,
+	EROFS_FORCE_INODE_EXTENDED,
+};
+
 struct erofs_importer_params {
 	char *source;
 	u32 mt_async_queue_limit;
@@ -20,6 +25,7 @@ struct erofs_importer_params {
 	u32 uid_offset;
 	u32 gid_offset;
 	u32 fsalignblks;
+	char force_inodeversion;
 	bool no_datainline;
 	bool hard_dereference;
 	bool ovlfs_strip;
diff --git a/lib/config.c b/lib/config.c
index c5e6757..28bfc2f 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -30,7 +30,6 @@ void erofs_init_configure(void)
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
 	cfg.c_ignore_mtime = false;
-	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
diff --git a/lib/inode.c b/lib/inode.c
index 7ee6b3d..0bb82f8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1073,10 +1073,10 @@ out:
 	return 0;
 }
 
-static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
-					    const char *path)
+static bool erofs_should_use_inode_extended(struct erofs_importer *im,
+				struct erofs_inode *inode, const char *path)
 {
-	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
+	if (im->params->force_inodeversion == EROFS_FORCE_INODE_EXTENDED)
 		return true;
 	if (inode->i_size > UINT_MAX)
 		return true;
@@ -1206,8 +1206,10 @@ int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 			    struct stat *st, const char *path)
 {
-	int err = __erofs_fill_inode(im, inode, st, path);
+	const struct erofs_importer_params *params = im->params;
+	int err;
 
+	err =  __erofs_fill_inode(im, inode, st, path);
 	if (err)
 		return err;
 
@@ -1239,8 +1241,8 @@ static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode
 			return -ENOMEM;
 	}
 
-	if (erofs_should_use_inode_extended(inode, path)) {
-		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+	if (erofs_should_use_inode_extended(im, inode, path)) {
+		if (params->force_inodeversion == EROFS_FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
@@ -1813,7 +1815,7 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 				    struct erofs_inode *inode, bool incremental)
 {
-	struct erofs_importer_params *params = im->params;
+	const struct erofs_importer_params *params = im->params;
 	char *trimmed;
 	int ret;
 
@@ -1822,8 +1824,8 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 	erofs_update_progressinfo("Processing %s ...", trimmed);
 	free(trimmed);
 
-	if (erofs_should_use_inode_extended(inode, inode->i_srcpath)) {
-		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+	if (erofs_should_use_inode_extended(im, inode, inode->i_srcpath)) {
+		if (params->force_inodeversion == EROFS_FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
diff --git a/mkfs/main.c b/mkfs/main.c
index 28588db..4f52656 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -416,7 +416,8 @@ static struct {
 
 static bool mkfs_no_datainline;
 
-static int parse_extended_opts(const char *opts)
+static int parse_extended_opts(struct erofs_importer_params *params,
+			       const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
 	(keylen == strlen(opt) && !memcmp(token, opt, keylen))
@@ -461,12 +462,12 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
+			params->force_inodeversion = EROFS_FORCE_INODE_COMPACT;
 			cfg.c_ignore_mtime = true;
 		} else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+			params->force_inodeversion = EROFS_FORCE_INODE_EXTENDED;
 		} else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -1011,7 +1012,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 
 		case 'E':
-			opt = parse_extended_opts(optarg);
+			opt = parse_extended_opts(params, optarg);
 			if (opt)
 				return opt;
 			break;
-- 
2.43.5


