Return-Path: <linux-erofs+bounces-1453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D2C95133
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 16:16:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dK9c86dGZz2yvV;
	Mon, 01 Dec 2025 02:16:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.61
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764515800;
	cv=none; b=EWvSRSdynkn1ufTOw6mQYGq6LTiR9bQySytmkr1sLlQOzTD2qj6c4RPwRy9ZFGqb9u9h5EdNKTrtOoUx5/Trb/PQ1GQEixEg5y9bRD6avs5TCdbh5lPmM+hg2gKoMmvn7n1nngkupUMvnSOE95K3CSV995haoQ6e/GueYTYl+r0Miv0P5HBMbssYuf9BXeY8df6/uHko8F2wBLm8ISwFIf2WDJrqbWq51Uf07VvcK7sj7SOleXaA4PMv669zeZFjavbIpDOsCBAyEw2brNuloIl5woEceBUqWOwrl0E1DFBEVRMjSPT3vK3a47qa/KNTaunzauwACa8r179s4XIikw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764515800; c=relaxed/relaxed;
	bh=zwAnf5Ls1c8Nt8+uiaEbIUISmCKQLm6cTO4AkoWyXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhAVYnvWD4i5OUw0/RVeYIC1d6QoB0pF+FqJwDQTkrYklCD5X+COf6ygzYvxKPgy/jM3tGNzWsQ7siVBXfCLoJamUgTgBMjwk8KiEBD8Kg2AowrXIeIjtCOksfchbHHggX1jFh4h05N+WjAaGNyEMt5dWrGzTisjuxhv4qPBCMj3WWf8mU9AOFAf6hmzxWruW1i1cy5urL3PX7AcYRO/+MpR75xSWZhSmWGYQIvmxk/YHzQRu1752NO9L2FfkS6Z5+ttM+PKUWdJL+fScPnJCZgI08wUbnXcCx8eYAauidnR93TloOhbZEEgn/daoCuDxST98yyR/DBb/86crq6n6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.61; helo=out28-61.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.61; helo=out28-61.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dK9c65HdMz2yvL
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 02:16:37 +1100 (AEDT)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fZiFcST_1764515787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 23:16:27 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/2] erofs-utils: lib: oci: add on-demand blob cache
Date: Sun, 30 Nov 2025 23:16:25 +0800
Message-ID: <20251130151626.95009-2-hudson@cyzhu.com>
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

Add an on-disk cache for OCI blobs and hook it into the
ocierofs_iostream backend. The cache file is created under
/var/run/erofs/cache/oci/ and sized to the blob length.

Reads probe the local sparse file with SEEK_HOLE and only download
missing regions. This avoids redundant downloads and improves
random access performance for remote images.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |   1 +
 lib/remotes/oci.c  | 212 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 205 insertions(+), 8 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 5298f18..f7b26b6 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -62,6 +62,7 @@ struct ocierofs_ctx {
 struct ocierofs_iostream {
 	struct ocierofs_ctx *ctx;
 	u64 offset;
+	int cache_fd;
 };
 
 /*
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index ac8d495..8b253a3 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -5,6 +5,7 @@
  */
 #define _GNU_SOURCE
 #include "erofs/internal.h"
+#include "erofs/defs.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -12,6 +13,9 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#ifdef HAVE_SYS_SENDFILE_H
+#include <sys/sendfile.h>
+#endif
 #include <errno.h>
 #ifdef HAVE_CURL_CURL_H
 #include <curl/curl.h>
@@ -29,6 +33,10 @@
 #include "liberofs_private.h"
 #include "liberofs_gzran.h"
 
+#ifndef SEEK_HOLE
+#define SEEK_HOLE 4
+#endif
+
 #ifdef OCIEROFS_ENABLED
 
 #define DOCKER_REGISTRY "docker.io"
@@ -1425,25 +1433,208 @@ out:
 	return ret;
 }
 
-static ssize_t ocierofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
+static int ocierofs_cache(struct ocierofs_iostream *oci_iostream, off_t offset, size_t needed)
 {
-	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
+	struct ocierofs_ctx *ctx = oci_iostream->ctx;
 	void *download_buf = NULL;
 	size_t download_size = 0;
-	ssize_t ret;
+	int ret = 0;
+	off_t hole, align_offset;
+	size_t download_len;
+	int layer_idx;
+
+	if (oci_iostream->cache_fd < 0) {
+		char *path;
+
+		mkdir("/var/run/erofs", 0777);
+		mkdir("/var/run/erofs/cache", 0777);
+		mkdir("/var/run/erofs/cache/oci", 0777);
+
+		if (asprintf(&path, "/var/run/erofs/cache/oci/%s",
+			     ctx->blob_digest ?: "erofs_oci_unknown") < 0)
+			return -ENOMEM;
+
+		oci_iostream->cache_fd = open(path, O_RDWR | O_CREAT, 0666);
+		free(path);
+
+		if (oci_iostream->cache_fd < 0)
+			return -errno;
+
+		layer_idx = ocierofs_find_layer_by_digest(ctx, ctx->blob_digest);
+		if (layer_idx >= 0) {
+			if (ftruncate(oci_iostream->cache_fd, ctx->layers[layer_idx]->size) < 0)
+				return -errno;
+		}
+	}
+
+	hole = lseek(oci_iostream->cache_fd, offset, SEEK_HOLE);
+	if (hole < 0) {
+		if (errno == ENXIO)
+			return 0;
+		return -errno;
+	}
+	if (hole >= offset + needed)
+		return 0;
 
-	ret = ocierofs_download_blob_range(oci_iostream->ctx, offset, len,
+	align_offset = round_down(hole, OCIEROFS_IO_CHUNK_SIZE);
+	download_len = max_t(size_t, offset + needed - align_offset, OCIEROFS_IO_CHUNK_SIZE);
+
+	ret = ocierofs_download_blob_range(ctx, align_offset, download_len,
 					   &download_buf, &download_size);
 	if (ret < 0)
 		return ret;
 
 	if (download_buf && download_size > 0) {
-		memcpy(buf, download_buf, download_size);
-		free(download_buf);
-		return download_size;
+		char *p = download_buf;
+		size_t to_write = download_size;
+		ssize_t written = 0;
+
+		while (to_write > 0) {
+			ssize_t w = pwrite(oci_iostream->cache_fd, p, to_write, align_offset + written);
+			if (w < 0) {
+				if (errno == EINTR)
+					continue;
+				ret = -errno;
+				goto out_free;
+			}
+			written += w;
+			p += w;
+			to_write -= w;
+		}
 	}
 
-	return 0;
+out_free:
+	free(download_buf);
+	return ret;
+}
+
+static ssize_t ocierofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+				    off_t *pos, size_t count)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vin->payload;
+	off_t offset;
+	size_t remaining = count;
+	ssize_t total_written = 0;
+	int ret;
+
+	if (!pos)
+		offset = oci_iostream->offset;
+	else
+		offset = *pos;
+
+	ret = ocierofs_cache(oci_iostream, offset, count);
+	if (ret < 0)
+		return ret;
+
+	while (remaining > 0) {
+		struct stat st;
+
+		if (fstat(oci_iostream->cache_fd, &st) < 0)
+			return -errno;
+
+		if (offset >= st.st_size)
+			break;
+
+		size_t available = st.st_size - offset;
+		size_t chunk = min_t(size_t, remaining, available);
+
+		if (chunk == 0) {
+			chunk = min_t(size_t, remaining, OCIEROFS_IO_CHUNK_SIZE);
+		}
+
+#if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
+		off_t in_offset = offset;
+		ssize_t sent;
+
+		sent = sendfile(vout->fd, oci_iostream->cache_fd, &in_offset, chunk);
+		if (sent < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			if (total_written > 0)
+				goto out;
+			return -errno;
+		}
+		if (sent == 0)
+			break;
+
+		total_written += sent;
+		remaining -= sent;
+		offset += sent;
+#else
+		chunk = min_t(size_t, remaining, available);
+		if (chunk == 0)
+			break;
+
+		char buf[32768];
+		size_t to_read = min_t(size_t, chunk, sizeof(buf));
+		ssize_t read_len, write_len;
+
+		read_len = pread(oci_iostream->cache_fd, buf, to_read, offset);
+		if (read_len < 0)
+			return -errno;
+		if (read_len == 0)
+			break;
+
+		char *p = buf;
+		size_t to_write = read_len;
+		while (to_write > 0) {
+			write_len = write(vout->fd, p, to_write);
+			if (write_len < 0) {
+				if (errno == EINTR)
+					continue;
+				return -errno;
+			}
+			p += write_len;
+			to_write -= write_len;
+		}
+
+		total_written += read_len;
+		offset += read_len;
+		remaining -= read_len;
+#endif
+	}
+
+out:
+	if (pos)
+		*pos = offset;
+	else
+		oci_iostream->offset = offset;
+
+	return total_written;
+}
+
+static ssize_t ocierofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
+	size_t remaining = len;
+	char *p = buf;
+	ssize_t total_read = 0;
+	int ret;
+
+	ret = ocierofs_cache(oci_iostream, offset, len);
+	if (ret < 0)
+		return ret;
+
+	while (remaining > 0) {
+		size_t chunk = min_t(size_t, remaining, OCIEROFS_IO_CHUNK_SIZE);
+		ssize_t n;
+
+		n = pread(oci_iostream->cache_fd, p, chunk, offset);
+		if (n < 0)
+			return -errno;
+		if (n == 0)
+			break;
+
+		p += n;
+		offset += n;
+		remaining -= n;
+		total_read += n;
+
+		if (n < chunk)
+			break;
+	}
+
+	return total_read;
 }
 
 static ssize_t ocierofs_io_read(struct erofs_vfile *vf, void *buf, size_t len)
@@ -1462,6 +1653,9 @@ static void ocierofs_io_close(struct erofs_vfile *vfile)
 {
 	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vfile->payload;
 
+	if (oci_iostream->cache_fd >= 0)
+		close(oci_iostream->cache_fd);
+
 	ocierofs_ctx_cleanup(oci_iostream->ctx);
 	free(oci_iostream->ctx);
 	free(oci_iostream);
@@ -1472,6 +1666,7 @@ static struct erofs_vfops ocierofs_io_vfops = {
 	.pread = ocierofs_io_pread,
 	.read = ocierofs_io_read,
 	.close = ocierofs_io_close,
+	.sendfile = ocierofs_io_sendfile,
 };
 
 int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
@@ -1499,6 +1694,7 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 
 	oci_iostream->ctx = ctx;
 	oci_iostream->offset = 0;
+	oci_iostream->cache_fd = -1;
 	*vfile = (struct erofs_vfile){.ops = &ocierofs_io_vfops};
 	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
 	return 0;
-- 
2.47.1


