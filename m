Return-Path: <linux-erofs+bounces-811-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948BAB1FD91
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Aug 2025 03:59:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0d9T54wTz3cf7;
	Mon, 11 Aug 2025 11:59:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754877565;
	cv=none; b=LazR2QqCGK/vBWT0j3YHCDwqfAumiPr0VL43v7wg/UfWwim16BkfdJhEezuAaqtDCcBQU+V2/OcBBKk+MmgW9noebXlsf5KQzLeTe/tshgNPpXAfd06vKf83GHA6+cUM8agNb4DdP2qM0HsS1Qth23wauMGNGB0wi3p+ux1ej0sU/I2o22efSxRdcPxrd/Ns/XzQ9ZuFrv6fFB9pd4WPDwmVSgVxVcFfLZu2o/z/T0chkQlOynQ5HFDkVg8N/DZ1Vdm1wU3twhSRlUW6kw+MaKw+O1fh3JwAg7eVb7TUwGGO1lwQ2djxFvK02Nogq7f4N9pXCxS5rjn20xLU8dQtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754877565; c=relaxed/relaxed;
	bh=IONjw1X50QGYP0mFmMH0BW9D+7FZRSpe64XF3vvty8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxqhzZxAXoHepsa2lGH0xeJFUKP0lPD/1VA7rcI/FWCqAfXnlmJ+K4yEdxP0LwRDeo76zwu08hkmIdrBtZUCd6gZXZ2J8/EEw6ThNHCzdGQS4evsxgrqHTR27b6JiaNXX6apxoicqcBeVHfaXo0pksvtg/TYPNYyLUmzgXgfKLU8qH3hE1PfiyI/TOJynil2zVqciE7BeVpLieXOYxjjRCqJidDT/5Z0koj3anpNJFp/Cf+hiu2t8jGbGW2pov/VbF3AF8xKXxQTSogCCdwFKW9btuVucpLRNrTyT4TaCkhFU/IeqlwyP6JdtPnC8Ii+Tf7h1LyWLY63gRVRsC1+xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ai9Zcp0O; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ai9Zcp0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0d9R4Vbdz3cdm
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Aug 2025 11:59:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754877557; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IONjw1X50QGYP0mFmMH0BW9D+7FZRSpe64XF3vvty8k=;
	b=ai9Zcp0OU82Rc+VgqfpzVlIlu0RcqKxDpYCH9rJOlCwrkI6HQm66KRRdnp1kOXqVgdwVW98clPDnA5+e24fS1lsha0dvW+cbWqvOmvz/4UMsE+/a0x0F9hfuC3yxIb+cKBQTH/xyKFQr1ijwRYOSjBIgOn6ZKtSAfUTUuXoX9Oo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlNYAEB_1754877551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 09:59:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: mkfs: support full image generation from S3
Date: Mon, 11 Aug 2025 09:59:10 +0800
Message-ID: <20250811015910.1446727-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250809143350.3010270-1-hsiangkao@linux.alibaba.com>
References: <20250809143350.3010270-1-hsiangkao@linux.alibaba.com>
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

Preliminary implementation without multipart downloading.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix compile error due to undefined EROFS_MKFS_SOURCE_S3.

 lib/liberofs_s3.h |   2 +-
 lib/remotes/s3.c  | 119 ++++++++++++++++++++++++++++++++++++++++++----
 mkfs/main.c       |  10 ++--
 3 files changed, 115 insertions(+), 16 deletions(-)

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index 4ac03d5..27b041c 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -34,7 +34,7 @@ struct erofs_s3 {
 };
 
 int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
-			const char *path);
+			const char *path, bool fillzero);
 
 #ifdef __cplusplus
 }
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 46fba6b..1497b54 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -15,6 +15,7 @@
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/blobchunk.h"
+#include "erofs/diskbuf.h"
 #include "erofs/rebuild.h"
 #include "liberofs_s3.h"
 
@@ -41,7 +42,7 @@ struct s3erofs_curl_request {
 
 static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			       const char *endpoint,
-			       const char *path,
+			       const char *path, const char *key,
 			       struct s3erofs_query_params *params,
 			       enum s3erofs_url_style url_style)
 {
@@ -81,8 +82,14 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 				       host, split);
 		}
 	}
+	if (key) {
+		slash |= url[pos - 1] != '/';
+		pos -= !slash;
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
+	}
+
 	i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
-		     "/%s%s", path, slash ? "/" : "");
+		     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
 	req->canonical_query[i] = '\0';
 
 	for (i = 0; i < params->num; i++)
@@ -91,6 +98,7 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 				params->key[i], params->value[i]);
 	if (schema != https)
 		free((void *)schema);
+	erofs_dbg("Request URL %s", url);
 	return 0;
 }
 
@@ -460,11 +468,15 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 	}
 
 	req.method = "GET";
-	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket,
+	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket, NULL,
 				  &params, s3->url_style);
 	if (ret < 0)
 		return ret;
 
+	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
+			     s3erofs_request_write_memory_cb) != CURLE_OK)
+		return -EIO;
+
 	ret = s3erofs_request_perform(s3, &req, &resp);
 	if (ret < 0)
 		return ret;
@@ -544,14 +556,10 @@ static int s3erofs_global_init(void)
 	if (!easy_curl)
 		goto out_err;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
-			     s3erofs_request_write_memory_cb) != CURLE_OK)
-		goto out_err;
-
 	if (curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
 		goto out_err;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L) != CURLE_OK)
+	if (curl_easy_setopt(easy_curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
 		goto out_err;
 
 	if (curl_easy_setopt(easy_curl, CURLOPT_USERAGENT,
@@ -578,8 +586,95 @@ static void s3erofs_global_exit(void)
 	curl_global_cleanup();
 }
 
+struct s3erofs_curl_getobject_resp {
+	struct erofs_vfile *vf;
+	erofs_off_t pos, end;
+};
+
+static size_t s3erofs_remote_getobject_cb(void *contents, size_t size,
+					  size_t nmemb, void *userp)
+{
+	struct s3erofs_curl_getobject_resp *resp = userp;
+	size_t realsize = size * nmemb;
+
+	if (resp->pos + realsize > resp->end ||
+	    erofs_io_pwrite(resp->vf, contents, resp->pos, realsize) != realsize)
+		return 0;
+
+	resp->pos += realsize;
+	return realsize;
+}
+
+static int s3erofs_remote_getobject(struct erofs_s3 *s3,
+				    struct erofs_inode *inode,
+				    const char *bucket, const char *key)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct s3erofs_curl_request req = {};
+	struct s3erofs_curl_getobject_resp resp;
+	struct s3erofs_query_params params;
+	struct erofs_vfile vf;
+	int ret;
+
+	params.num = 0;
+	req.method = "GET";
+	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key,
+				  &params, s3->url_style);
+	if (ret < 0)
+		return ret;
+
+	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
+			     s3erofs_remote_getobject_cb) != CURLE_OK)
+		return -EIO;
+
+	resp.pos = 0;
+	if (!cfg.c_compr_opts[0].alg && !cfg.c_inline_data) {
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		inode->idata_size = 0;
+		ret = erofs_allocate_inode_bh_data(inode,
+				DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits));
+		if (ret)
+			return ret;
+		resp.vf = &sbi->bdev;
+		resp.pos = erofs_pos(inode->sbi, inode->u.i_blkaddr);
+		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+	} else {
+		u64 off;
+
+		if (!inode->i_diskbuf) {
+			inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
+			if (!inode->i_diskbuf)
+				return -ENOSPC;
+		} else {
+			erofs_diskbuf_close(inode->i_diskbuf);
+		}
+
+		vf = (struct erofs_vfile) {.fd =
+			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off)};
+		if (vf.fd < 0)
+			return -EBADF;
+		resp.pos = off;
+		resp.vf = &vf;
+		inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+	}
+	resp.end = resp.pos + inode->i_size;
+
+	ret = s3erofs_request_perform(s3, &req, &resp);
+	if (resp.vf == &vf) {
+		erofs_diskbuf_commit(inode->i_diskbuf, resp.end - resp.pos);
+		if (ret) {
+			erofs_diskbuf_close(inode->i_diskbuf);
+			inode->i_diskbuf = NULL;
+			inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+		}
+	}
+	if (ret)
+		return ret;
+	return resp.pos != resp.end ? -EIO : 0;
+}
+
 int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
-			const char *path)
+			const char *path, bool fillzero)
 {
 	struct erofs_sb_info *sbi = root->sbi;
 	struct s3erofs_object_iterator *iter;
@@ -656,7 +751,11 @@ int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
 		ret = __erofs_fill_inode(inode, &st, obj->key);
 		if (!ret && S_ISREG(inode->i_mode)) {
 			inode->i_size = obj->size;
-			ret = erofs_write_zero_inode(inode);
+			if (fillzero)
+				ret = erofs_write_zero_inode(inode);
+			else
+				ret = s3erofs_remote_getobject(s3, inode,
+						iter->bucket, obj->key);
 		}
 		if (ret)
 			goto err_iter;
diff --git a/mkfs/main.c b/mkfs/main.c
index d3bd1cd..804d483 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -271,9 +271,7 @@ enum {
 static enum {
 	EROFS_MKFS_SOURCE_LOCALDIR,
 	EROFS_MKFS_SOURCE_TAR,
-#ifdef S3EROFS_ENABLED
 	EROFS_MKFS_SOURCE_S3,
-#endif
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
@@ -1639,7 +1637,8 @@ int main(int argc, char **argv)
 	else if (!incremental_mode)
 		erofs_uuid_generate(g_sbi.uuid);
 
-	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
+	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
+	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1749,11 +1748,12 @@ int main(int argc, char **argv)
 			}
 
 			if (incremental_mode ||
-			    dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL)
+			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
 				err = -EOPNOTSUPP;
 			else
 				err = s3erofs_build_trees(root, &s3cfg,
-							  cfg.c_src_path);
+							  cfg.c_src_path,
+					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
 			if (err)
 				goto exit;
 #endif
-- 
2.43.5


