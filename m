Return-Path: <linux-erofs+bounces-1454-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679AC95139
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 16:16:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dK9c94HY8z2yvL;
	Mon, 01 Dec 2025 02:16:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.83
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764515801;
	cv=none; b=PEf/fhjHtD+EESvK5AYhtJmIMXe9QAWtcRL5pdrfdhv+VtJz6EHXiKT+vww5ilc9Rnhm9ck4EEtnsY1u2kolI2Smx4L10MIbG9eKBrMhfe4RU6rM5CY1wUcAISNwMlglQOYe5FvemsV7IjD5BUExnxKYe2dxIC0d7Y5RMOiUOwoFmcozK5fKjHlx0FPwRFvBGxXWpX43OVkvoGUCJ/TUSb4soGnoZmPzeSmQhX/759Rzyce8g+gDVtlXc2/2G3ayikk0zu+u7D6QSdBPn8zZYsre0HuPJJov/Gu1/6hcoePjYb6N+VRymYlA6MW67mRkUicFcawvZhK0TpmaHADBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764515801; c=relaxed/relaxed;
	bh=bldEJlke/EZcHGEzEFz7AVYVlXSQc/SQPykl8ywxJNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JglE4w7rga7ezsbLMGloADBXl0E/a9urCmL2wwu02ImlBSixBRk8amJzDD0Qe9/ZRnnZ1pGNDVitW0V1e/b5Fo8dB0Kqz1DvikcP2QupvSz4EI6INgOE4R2LuBiN3qhm9TUlGdoIBqS3fNsZUmD9d5hYStGFrDdU+G9uzA0MKOByiaawrlXoZfcnGjW+0zHCQJusUKqJ2LCGDiWMpmlwlRyI+TeuEqgjPL3zN3npffjeuQjcS8BzsPUVnVexLAoLB4bZWyYm3RLrslrMffWIODeLixVFD8QCcr+eT2PZcMGuyH/LhTr9QXJhrth5UjHPwyhNOgcxTuWZVDcU3XI6LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.83; helo=out28-83.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.83; helo=out28-83.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-83.mail.aliyun.com (out28-83.mail.aliyun.com [115.124.28.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dK9c65llPz2yvR
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 02:16:36 +1100 (AEDT)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fZiFcSr_1764515787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 23:16:27 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 2/2] erofs-utils: lib: oci: write downloaded data directly to fd
Date: Sun, 30 Nov 2025 23:16:26 +0800
Message-ID: <20251130151626.95009-3-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251130151626.95009-1-hudson@cyzhu.com>
References: <20251130151626.95009-1-hudson@cyzhu.com>
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

From: Chengyu Zhu <hudsonzhu@tencent.com>

Avoid buffering downloaded OCI blobs in memory. Instead, write the
received data directly to the target file descriptor within the curl
write callback.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/remotes/oci.c | 198 +++++++++++++---------------------------------
 1 file changed, 55 insertions(+), 143 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 8b253a3..a3efd77 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -64,10 +64,8 @@ struct ocierofs_response {
 	long http_code;
 };
 
-struct ocierofs_stream {
-	const char *digest;
-	int blobfd;
-};
+static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, const char *digest,
+					off_t offset, size_t length, int fd);
 
 static inline const char *ocierofs_get_api_registry(const char *registry)
 {
@@ -125,26 +123,42 @@ static size_t ocierofs_write_callback(void *contents, size_t size,
 	return realsize;
 }
 
-static size_t ocierofs_layer_write_callback(void *contents, size_t size,
-					    size_t nmemb, void *userp)
+struct ocierofs_write_ctx {
+	int fd;
+	off_t offset;
+	CURL *curl;
+	bool range_req;
+};
+
+static size_t ocierofs_fd_write_callback(void *contents, size_t size,
+					 size_t nmemb, void *userp)
 {
-	struct ocierofs_stream *stream = userp;
 	size_t realsize = size * nmemb;
+	struct ocierofs_write_ctx *wctx = userp;
 	const char *buf = contents;
 	size_t written = 0;
+	long http_code = 0;
 
-	if (stream->blobfd < 0)
-		return 0;
+	if (wctx->curl) {
+		curl_easy_getinfo(wctx->curl, CURLINFO_RESPONSE_CODE, &http_code);
+		if (wctx->range_req && http_code == 200) {
+			erofs_err("server returned 200 OK for Range request, aborting");
+			return 0;
+		}
+		wctx->curl = NULL;
+	}
 
 	while (written < realsize) {
-		ssize_t n = write(stream->blobfd, buf + written, realsize - written);
+		ssize_t n = pwrite(wctx->fd, buf + written, realsize - written, wctx->offset);
 
 		if (n < 0) {
-			erofs_err("failed to write layer data for layer %s",
-				  stream->digest);
+			if (errno == EINTR)
+				continue;
+			erofs_err("failed to write cache data: %s", strerror(errno));
 			return 0;
 		}
 		written += n;
+		wctx->offset += n;
 	}
 	return realsize;
 }
@@ -1157,89 +1171,33 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	return 0;
 }
 
-static int ocierofs_download_blob_to_fd(struct ocierofs_ctx *ctx,
-					const char *digest,
-					const char *auth_header,
-					int outfd)
-{
-	struct ocierofs_request req = {};
-	struct ocierofs_stream stream = {};
-	const char *api_registry;
-	long http_code;
-	int ret;
-
-	stream = (struct ocierofs_stream) {
-		.digest = digest,
-		.blobfd = outfd,
-	};
-
-	api_registry = ocierofs_get_api_registry(ctx->registry);
-	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, ctx->repository, digest) == -1)
-		return -ENOMEM;
-
-	if (auth_header && strstr(auth_header, "Bearer"))
-		req.headers = curl_slist_append(req.headers, auth_header);
-
-	curl_easy_reset(ctx->curl);
-
-	ret = ocierofs_curl_setup_common_options(ctx->curl);
-	if (ret)
-		goto out;
-
-	ret = ocierofs_curl_setup_rq(ctx->curl, req.url, OCIEROFS_HTTP_GET,
-				     req.headers,
-				     ocierofs_layer_write_callback,
-				     &stream, NULL, NULL);
-	if (ret)
-		goto out;
-
-	ret = ocierofs_curl_perform(ctx->curl, &http_code);
-	if (ret)
-		goto out;
-
-	if (http_code < 200 || http_code >= 300) {
-		erofs_err("HTTP request failed with code %ld", http_code);
-		ret = -EIO;
-		goto out;
-	}
-	ret = 0;
-out:
-	ocierofs_request_cleanup(&req);
-	return ret;
-}
-
 static int ocierofs_extract_layer(struct ocierofs_ctx *ctx,
 				  const char *digest, const char *auth_header)
 {
-	struct ocierofs_stream stream = {};
-	int ret;
+	int fd, ret;
 
-	stream = (struct ocierofs_stream) {
-		.digest = digest,
-		.blobfd = erofs_tmpfile(),
-	};
-	if (stream.blobfd < 0) {
+	fd = erofs_tmpfile();
+	if (fd < 0) {
 		erofs_err("failed to create temporary file for %s", digest);
 		return -errno;
 	}
 
-	ret = ocierofs_download_blob_to_fd(ctx, digest, auth_header, stream.blobfd);
+	ret = ocierofs_download_blob_range(ctx, digest, 0, 0, fd);
 	if (ret)
 		goto out;
 
-	if (lseek(stream.blobfd, 0, SEEK_SET) < 0) {
+	if (lseek(fd, 0, SEEK_SET) < 0) {
 		erofs_err("failed to seek to beginning of temp file: %s",
 			  strerror(errno));
 		ret = -errno;
 		goto out;
 	}
 
-	return stream.blobfd;
+	return fd;
 
 out:
-	if (stream.blobfd >= 0)
-		close(stream.blobfd);
+	if (fd >= 0)
+		close(fd);
 	return ret;
 }
 
@@ -1334,33 +1292,32 @@ out:
 	return ret;
 }
 
-static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset, size_t length,
-					void **out_buf, size_t *out_size)
+static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, const char *digest,
+					off_t offset, size_t length, int fd)
 {
 	struct ocierofs_request req = {};
-	struct ocierofs_response resp = {};
+	struct ocierofs_write_ctx wctx = {
+		.fd = fd,
+		.offset = offset,
+		.curl = ctx->curl,
+		.range_req = (length != 0),
+	};
 	const char *api_registry;
 	char rangehdr[64];
 	long http_code = 0;
 	int ret, index;
-	const char *digest;
 	u64 blob_size;
-	size_t available;
-	size_t copy_size;
 
-	index = ocierofs_find_layer_by_digest(ctx, ctx->blob_digest);
+	index = ocierofs_find_layer_by_digest(ctx, digest);
 	if (index < 0)
 		return -ENOENT;
-	digest = ctx->blob_digest;
 	blob_size = ctx->layers[index]->size;
 
 	if (offset < 0)
 		return -EINVAL;
 
-	if (offset >= blob_size) {
-		*out_size = 0;
+	if (offset >= blob_size)
 		return 0;
-	}
 
 	if (length && offset + length > blob_size)
 		length = (size_t)(blob_size - offset);
@@ -1373,13 +1330,15 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 	if (length)
 		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-%lld",
 			 (long long)offset, (long long)(offset + (off_t)length - 1));
-	else
+	else if (offset > 0)
 		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-",
 			 (long long)offset);
 
 	if (ctx->auth_header && strstr(ctx->auth_header, "Bearer"))
 		req.headers = curl_slist_append(req.headers, ctx->auth_header);
-	req.headers = curl_slist_append(req.headers, rangehdr);
+
+	if (wctx.range_req || offset > 0)
+		req.headers = curl_slist_append(req.headers, rangehdr);
 
 	curl_easy_reset(ctx->curl);
 
@@ -1389,8 +1348,8 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 
 	ret = ocierofs_curl_setup_rq(ctx->curl, req.url, OCIEROFS_HTTP_GET,
 				     req.headers,
-				     ocierofs_write_callback,
-				     &resp, NULL, NULL);
+				     ocierofs_fd_write_callback,
+				     &wctx, NULL, NULL);
 	if (ret)
 		goto out;
 
@@ -1398,30 +1357,10 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 	if (ret)
 		goto out;
 
-	ret = 0;
-	if (http_code == 206) {
-		*out_buf = resp.data;
-		*out_size = resp.size;
-		resp.data = NULL;
-	} else if (http_code == 200) {
-		if (!offset) {
-			*out_buf = resp.data;
-			*out_size = resp.size;
-			resp.data = NULL;
-		} else if (offset < resp.size) {
-			available = resp.size - offset;
-			copy_size = length ? min_t(size_t, length, available) : available;
-
-			*out_buf = malloc(copy_size);
-			if (!*out_buf) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			memcpy(*out_buf, resp.data + offset, copy_size);
-			*out_size = copy_size;
-		}
+	if (http_code == 206 || (http_code == 200 && !wctx.range_req && offset == 0)) {
+		ret = 0;
 	} else {
-		erofs_err("HTTP range request failed with code %ld", http_code);
+		erofs_err("HTTP request failed with code %ld", http_code);
 		ret = -EIO;
 	}
 
@@ -1429,15 +1368,12 @@ out:
 	if (req.headers)
 		curl_slist_free_all(req.headers);
 	free(req.url);
-	free(resp.data);
 	return ret;
 }
 
 static int ocierofs_cache(struct ocierofs_iostream *oci_iostream, off_t offset, size_t needed)
 {
 	struct ocierofs_ctx *ctx = oci_iostream->ctx;
-	void *download_buf = NULL;
-	size_t download_size = 0;
 	int ret = 0;
 	off_t hole, align_offset;
 	size_t download_len;
@@ -1479,32 +1415,8 @@ static int ocierofs_cache(struct ocierofs_iostream *oci_iostream, off_t offset,
 	align_offset = round_down(hole, OCIEROFS_IO_CHUNK_SIZE);
 	download_len = max_t(size_t, offset + needed - align_offset, OCIEROFS_IO_CHUNK_SIZE);
 
-	ret = ocierofs_download_blob_range(ctx, align_offset, download_len,
-					   &download_buf, &download_size);
-	if (ret < 0)
-		return ret;
-
-	if (download_buf && download_size > 0) {
-		char *p = download_buf;
-		size_t to_write = download_size;
-		ssize_t written = 0;
-
-		while (to_write > 0) {
-			ssize_t w = pwrite(oci_iostream->cache_fd, p, to_write, align_offset + written);
-			if (w < 0) {
-				if (errno == EINTR)
-					continue;
-				ret = -errno;
-				goto out_free;
-			}
-			written += w;
-			p += w;
-			to_write -= w;
-		}
-	}
-
-out_free:
-	free(download_buf);
+	ret = ocierofs_download_blob_range(ctx, ctx->blob_digest, align_offset, download_len,
+					   oci_iostream->cache_fd);
 	return ret;
 }
 
-- 
2.47.1


