Return-Path: <linux-erofs+bounces-810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0AB1F4FA
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Aug 2025 16:34:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bzk1D1CRFz2yD5;
	Sun, 10 Aug 2025 00:34:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754750048;
	cv=none; b=Z0R7djzioektPbcpKUich3BziMk1WB/QCf8W5oARjjYX3++BNydmTmTFuiajKHCOQyvr0QQFu4LV9l0AL/MO3YufH6z0bxsRX1oq15ZQoM70z5ttgEsA7K3Rvbcb2OWxNRDKsNdHZDBfIfI0rz0z06u42AQdSFK2RDrRYTx4gAu0bjCs+dxBdBWTxZRQo0gXmjE+igcIWh3DrjcXGSx8shoBELlpNG5N/2izIi/wNZwsXWEJwZhAquXbxn0MF/MKi7D8LShLo3Uii/QbOVUiWKD7xLfMR+6pcWf5CGWJAo3Xt8UqLuYZJ2xSRX19XTcV15g4LhIxMF1STbeekEO3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754750048; c=relaxed/relaxed;
	bh=TKD/J9Xxw6EKqdctvBcQxkU6JwGkyYp5H+SRIuZQWKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxRHvpbYLP8kFmaR2nLohkJCb38jbIjE3T2cAqfB0RKoeN9u0ur2opA+Eygk3iarL4AJDofJJBDV3OenKRYaqizviDTBGpxwPdc0i9I2UN9QlFQDJEQ5Y1W7WZxEIo/nUgUcbISHEMJgYksIlYsFvNybrXl0rx4DD69j1X7dIj1f2K48YpjUirXdljQIHFkZT20+3jGId5FDb6ZP5CV8xhF+WvlLi08gAFNESvR8X8hAr88apwjdn4RbzgYrB/ydZmDd4FzKN7UwbTDlvLekdTzqflQbJayi9IFfNPIjRAMNNgJIpigb0XO9+I/s/kqvT4RzjagG3SpBXeouMPyMnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rrGmQgKk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rrGmQgKk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bzk1B1lNwz2xPv
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Aug 2025 00:34:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754750038; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TKD/J9Xxw6EKqdctvBcQxkU6JwGkyYp5H+SRIuZQWKc=;
	b=rrGmQgKkzfVahqgxUAV+tdxrMjM+hzWva05J4aTVF1rCdN/Q7qY8nJzkjqEPlAh47ToAXT2aOWjKKxBQDeIAJBP9Ae+AWHcfA2B38fNfgPsgeAUhLjJJ37voTk91XoMNlemitczPmeGpRF9AbxwgD7HRsNNlmjbBy94pQMtDTPE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlK9023_1754750031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 Aug 2025 22:33:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: support full image generation from S3
Date: Sat,  9 Aug 2025 22:33:50 +0800
Message-ID: <20250809143350.3010270-1-hsiangkao@linux.alibaba.com>
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

Preliminary implementation without multipart downloading.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_s3.h |   2 +-
 lib/remotes/s3.c  | 119 ++++++++++++++++++++++++++++++++++++++++++----
 mkfs/main.c       |   8 ++--
 3 files changed, 115 insertions(+), 14 deletions(-)

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
index d3bd1cd..5e4a35c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1639,7 +1639,8 @@ int main(int argc, char **argv)
 	else if (!incremental_mode)
 		erofs_uuid_generate(g_sbi.uuid);
 
-	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
+	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
+	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1749,11 +1750,12 @@ int main(int argc, char **argv)
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


