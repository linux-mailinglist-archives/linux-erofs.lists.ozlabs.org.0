Return-Path: <linux-erofs+bounces-980-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB08B45A86
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Sep 2025 16:30:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJJfq1mgGz3dHL;
	Sat,  6 Sep 2025 00:30:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.88
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757082643;
	cv=none; b=klz2N0XqqRCeQRkyRrpaI+lEJuwNwcXZAhqnaakRgKmUImFYqJ4/bGLvQk23EKKkDTPnVXHe3iQOy6iYSEWxjKeYRjhUi6RKUoBtoBCHeaf5xooX/3RKSSOsXkPFJEZVi4tF0gttsnlUmTup8i0t1XmH+0pgWYneGaV2Tjvr7QnkDGe8yhQHF+QW7UeVOSOLObuAdYVQMhhsVhgWX7YawMRe0vqgfvFAMXoRXlkWNErPVuhC8yT/nauRDWZiChqQcdFZ/YExexJtlv7vAMxYDPX5x/Hz0AbMxB9Fp42aS4W41gJF+H63KyRiXMmJUSn5CK83fskb6xyOairbLb+KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757082643; c=relaxed/relaxed;
	bh=7HvajFY6h1Bk7lB7M0iLJy7zcUHiKOzrrl9+7E4LjMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rewec7yP+caN5itNIkhUIkasV804HDVBEFF0KDqNPPxBwRLg1FyO7YrxpIfJkkM0aON6vhNrp+hlsqqqI7pzyQHO2MPZYbt/je3KlNm8HP1+TGFOYx9eyKOfpBAjStzPL2dsgx4gMQ+HnbH1v/v8mhjwmpikWKCrBlUboovjR38VnfPqR93dMGetFisDlbfu44uQ6f/gxgUmR2fNbbQtyh+R0Z4Zn+NerX6BBmjgWSWZlu9gWi0ymikBMFVPitHqOHMziUt8tDRTfXM0w26IJDZHFd0Rmo1hwTcYMikSpb4XRNWAF6Id9Kj7INo7OBsBr32bD97SYLGWk4iNcoKvzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-88.mail.aliyun.com (out28-88.mail.aliyun.com [115.124.28.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJJfn3Y2Vz3dHK
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Sep 2025 00:30:38 +1000 (AEST)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eYUpG-U_1757082622 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 22:30:31 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] erofs-utils: add NBD-backed OCI image mounting
Date: Fri,  5 Sep 2025 22:30:21 +0800
Message-ID: <20250905143021.91960-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250904100719.31892-1-hudson@cyzhu.com>
References: <20250904100719.31892-1-hudson@cyzhu.com>
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

- Add HTTP range downloads for OCI blobs
- Introduce ocierofs_iostream for virtual file I/O
- Add oci option for OCI image mounting with NBD backend

New mount.erofs -t erofs.nbd option: -o=[options] source-image mountpoint

Supported oci options:
- oci.platform=os/arch (default: linux/amd64)
- oci=N (extract specific layer, default: all layers)
- oci.username/oci.password (basic authentication)

e.g.:
sudo mount.erofs -t erofs.nbd  -o 'oci=0,oci.platform=linux/amd64' \
quay.io/chengyuzhu6/golang:1.22.8-erofs /mnt

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |   8 +-
 lib/remotes/oci.c  | 247 ++++++++++++++++++++++++++++++++++++++++++++-
 mount/Makefile.am  |   2 +-
 mount/main.c       | 196 +++++++++++++++++++++++++++--------
 4 files changed, 406 insertions(+), 47 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 2896308..873a560 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -55,7 +55,11 @@ struct ocierofs_ctx {
 	int layer_count;
 };
 
-int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
+struct ocierofs_iostream {
+	struct ocierofs_ctx *ctx;
+	struct erofs_vfile vf;
+	u64 offset;
+};
 
 /*
  * ocierofs_build_trees - Build file trees from OCI container image layers
@@ -67,6 +71,8 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config
 int ocierofs_build_trees(struct erofs_importer *importer,
 			 const struct ocierofs_config *cfg);
 
+int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index f2b08b2..ba01a0e 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -16,6 +16,7 @@
 #include <json-c/json.h>
 #include "erofs/importer.h"
 #include "erofs/internal.h"
+#include "erofs/io.h"
 #include "erofs/print.h"
 #include "erofs/tar.h"
 #include "liberofs_oci.h"
@@ -33,6 +34,8 @@
 #define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
 #define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
 
+#define OCIEROFS_IO_CHUNK_SIZE 32768
+
 struct ocierofs_request {
 	char *url;
 	struct curl_slist *headers;
@@ -1032,7 +1035,7 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
  *
  * Return: 0 on success, negative errno on failure
  */
-int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
+static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
 {
 	int ret;
 
@@ -1226,3 +1229,245 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 	ocierofs_ctx_cleanup(&ctx);
 	return ret;
 }
+
+static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset, size_t length,
+					void **out_buf, size_t *out_size)
+{
+	struct ocierofs_request req = {};
+	struct ocierofs_response resp = {};
+	const char *api_registry;
+	char rangehdr[64];
+	long http_code = 0;
+	int ret;
+	int index = ctx->layer_index;
+	u64 blob_size = ctx->layers[index]->size;
+	size_t available;
+	size_t copy_size;
+
+	if (offset < 0)
+		return -EINVAL;
+
+	if (offset >= blob_size)
+		return 0;
+
+	if (length && offset + (off_t)length > blob_size)
+		length = (size_t)(blob_size - offset);
+
+	api_registry = ocierofs_get_api_registry(ctx->registry);
+	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
+	     api_registry, ctx->repository, ctx->layers[index]->digest) == -1)
+		return -ENOMEM;
+
+	if (length)
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-%lld",
+			 (long long)offset, (long long)(offset + (off_t)length - 1));
+	else
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-",
+			 (long long)offset);
+
+	if (ctx->auth_header && strstr(ctx->auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, ctx->auth_header);
+	req.headers = curl_slist_append(req.headers, rangehdr);
+
+	curl_easy_reset(ctx->curl);
+
+	ret = ocierofs_curl_setup_common_options(ctx->curl);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_setup_rq(ctx->curl, req.url, OCIEROFS_HTTP_GET,
+				     req.headers,
+				     ocierofs_write_callback,
+				     &resp, NULL, NULL);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_perform(ctx->curl, &http_code);
+	if (ret)
+		goto out;
+
+	if (http_code == 206) {
+		*out_buf = resp.data;
+		*out_size = resp.size;
+		resp.data = NULL;
+		ret = 0;
+	} else if (http_code == 200) {
+		if (!offset) {
+			*out_buf = resp.data;
+			*out_size = resp.size;
+			resp.data = NULL;
+			ret = 0;
+		} else {
+			if (offset < resp.size) {
+				available = resp.size - offset;
+				copy_size = length ? min_t(size_t, length, available) : available;
+
+				*out_buf = malloc(copy_size);
+				if (!*out_buf) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				memcpy(*out_buf, resp.data + offset, copy_size);
+				*out_size = copy_size;
+				ret = 0;
+			} else {
+				ret = 0;
+			}
+		}
+	} else {
+		erofs_err("HTTP range request failed with code %ld", http_code);
+		ret = -EIO;
+	}
+
+out:
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	free(req.url);
+	free(resp.data);
+	return ret;
+}
+
+static ssize_t ocierofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
+	void *download_buf = NULL;
+	size_t download_size = 0;
+	ssize_t ret;
+
+	ret = ocierofs_download_blob_range(oci_iostream->ctx, offset, len,
+					   &download_buf, &download_size);
+	if (ret < 0)
+		return ret;
+
+	if (download_buf && download_size > 0) {
+		memcpy(buf, download_buf, download_size);
+		free(download_buf);
+		return download_size;
+	}
+
+	return 0;
+}
+
+static ssize_t ocierofs_io_read(struct erofs_vfile *vf, void *buf, size_t len)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
+	ssize_t ret;
+
+	ret = ocierofs_io_pread(vf, buf, len, oci_iostream->offset);
+	if (ret > 0)
+		oci_iostream->offset += ret;
+
+	return ret;
+}
+
+static ssize_t ocierofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			       off_t *pos, size_t count)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vin->payload;
+	static char buf[OCIEROFS_IO_CHUNK_SIZE];
+	ssize_t total_written = 0;
+	ssize_t ret = 0;
+
+	while (count > 0) {
+		size_t to_read = min_t(size_t, count, OCIEROFS_IO_CHUNK_SIZE);
+		u64 read_offset = pos ? *pos : oci_iostream->offset;
+
+		ret = ocierofs_io_pread(vin, buf, to_read, read_offset);
+		if (ret <= 0) {
+			if (ret < 0 && total_written == 0)
+				return ret;
+			break;
+		}
+		ssize_t written = __erofs_io_write(vout->fd, buf, ret);
+
+		if (written < 0) {
+			erofs_err("OCI I/O sendfile: failed to write to output: %s",
+				  strerror(errno));
+			ret = -errno;
+			break;
+		}
+
+		if (written != ret) {
+			erofs_err("OCI I/O sendfile: partial write: %zd != %zd", written, ret);
+			ret = written;
+		}
+
+		total_written += ret;
+		count -= ret;
+		if (pos)
+			*pos += ret;
+		else
+			oci_iostream->offset += ret;
+	}
+
+	return count;
+}
+
+static void ocierofs_io_close(struct erofs_vfile *vfile)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vfile->payload;
+
+	ocierofs_ctx_cleanup(oci_iostream->ctx);
+	free(oci_iostream->ctx);
+	free(oci_iostream);
+	*(struct ocierofs_iostream **)vfile->payload = NULL;
+}
+
+static int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx)
+{
+	if (ctx->layer_count > 0 && ctx->layers[0] &&
+	    ctx->layers[0]->media_type) {
+		const char *media_type = ctx->layers[0]->media_type;
+		size_t len = strlen(media_type);
+		
+		if (len >= 6 && strcmp(media_type + len - 6, ".erofs") == 0)
+			return 0;
+	}
+	return -ENOENT;
+}
+
+static struct erofs_vfops ocierofs_io_vfops = {
+	.pread = ocierofs_io_pread,
+	.read = ocierofs_io_read,
+	.sendfile = ocierofs_io_sendfile,
+	.close = ocierofs_io_close,
+};
+
+int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
+{
+	struct ocierofs_ctx *ctx;
+	struct ocierofs_iostream *oci_iostream = NULL;
+	int err;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+
+	err = ocierofs_init(ctx, cfg);
+	if (err) {
+		free(ctx);
+		return err;
+	}
+
+	err = ocierofs_is_erofs_native_image(ctx);
+	if (err) {
+		ocierofs_ctx_cleanup(ctx);
+		free(ctx);
+		return err;
+	}
+
+	oci_iostream = calloc(1, sizeof(*oci_iostream));
+	if (!oci_iostream) {
+		ocierofs_ctx_cleanup(ctx);
+		free(ctx);
+		return -ENOMEM;
+	}
+
+	oci_iostream->ctx = ctx;
+	oci_iostream->offset = 0;
+	oci_iostream->vf.ops = &ocierofs_io_vfops;
+	vfile->ops = &ocierofs_io_vfops;
+	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
+
+	return 0;
+}
diff --git a/mount/Makefile.am b/mount/Makefile.am
index d93f3f4..0b4447f 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -9,5 +9,5 @@ mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS} ${openssl_LIBS}
 endif
diff --git a/mount/main.c b/mount/main.c
index 2826dac..359dbbf 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -15,6 +15,7 @@
 #include "erofs/err.h"
 #include "erofs/io.h"
 #include "../lib/liberofs_nbd.h"
+#include "../lib/liberofs_oci.h"
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
 #else
@@ -34,6 +35,8 @@ struct loop_info {
 #include <sys/sysmacros.h>
 #endif
 
+static struct ocierofs_config ocicfg;
+
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
@@ -56,12 +59,84 @@ static struct erofsmount_cfg {
 	long flags;
 	enum erofs_backend_drv backend;
 	enum erofsmount_mode mountmode;
+	bool use_oci;
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
 	.fstype = "erofs",
 };
 
+enum erofs_nbd_source_type {
+	EROFSNBD_SOURCE_LOCAL,
+	EROFSNBD_SOURCE_OCI,
+};
+
+union erofs_nbd_source {
+	const char *device_path;
+	struct erofs_vfile *vf;
+};
+
+union erofs_nbd_source src;
+
+#ifdef OCIEROFS_ENABLED
+static int erofsmount_parse_oci_option(struct ocierofs_config *oci_cfg, const char *option)
+{
+	char *p;
+
+	p = strstr(option, "oci=");
+	if (p != NULL) {
+		p += strlen("oci=");
+		{
+			char *endptr;
+			unsigned long v = strtoul(p, &endptr, 10);
+
+			if (endptr == p || *endptr != '\0')
+				return -EINVAL;
+			oci_cfg->layer_index = (int)v;
+		}
+	} else {
+		p = strstr(option, "oci.platform=");
+		if (p != NULL) {
+			p += strlen("oci.platform=");
+			free(oci_cfg->platform);
+			oci_cfg->platform = strdup(p);
+			if (!oci_cfg->platform)
+				return -ENOMEM;
+		} else {
+			p = strstr(option, "oci.username=");
+			if (p != NULL) {
+				p += strlen("oci.username=");
+				free(oci_cfg->username);
+				oci_cfg->username = strdup(p);
+				if (!oci_cfg->username)
+					return -ENOMEM;
+			} else {
+				p = strstr(option, "oci.password=");
+				if (p != NULL) {
+					p += strlen("oci.password=");
+					free(oci_cfg->password);
+					oci_cfg->password = strdup(p);
+					if (!oci_cfg->password)
+						return -ENOMEM;
+				} else {
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
+	if (ocicfg.platform || ocicfg.username || ocicfg.password || ocicfg.layer_index != 0)
+		mountcfg.use_oci = true;
+
+	return 0;
+}
+#else
+static int erofsmount_parse_oci_option(struct ocierofs_config *oci_cfg, const char *option)
+{
+	return -EINVAL;
+}
+#endif
+
 static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 {
 	static const struct {
@@ -86,33 +161,42 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 	for (;;) {
 		char *comma;
 		int i;
+		int err;
 
 		comma = strchr(s, ',');
 		if (comma)
 			*comma = '\0';
-		for (i = 0; i < ARRAY_SIZE(opts); ++i) {
-			if (!strcasecmp(s, opts[i].name)) {
-				if (opts[i].flags < 0)
-					flags &= opts[i].flags;
-				else
-					flags |= opts[i].flags;
-				break;
-			}
-		}
 
-		if (more && i >= ARRAY_SIZE(opts)) {
-			int sl = strlen(s);
-			char *new = *more;
+		if (strncmp(s, "oci", 3) == 0) {
+			err = erofsmount_parse_oci_option(&ocicfg, s);
+
+			if (err < 0)
+				return err;
+		} else {
+			for (i = 0; i < ARRAY_SIZE(opts); ++i) {
+				if (!strcasecmp(s, opts[i].name)) {
+					if (opts[i].flags < 0)
+						flags &= opts[i].flags;
+					else
+						flags |= opts[i].flags;
+					break;
+				}
+			}
 
-			i = new ? strlen(new) : 0;
-			new = realloc(new, i + strlen(s) + 2);
-			if (!new)
-				return -ENOMEM;
-			if (i)
-				new[i++] = ',';
-			memcpy(new + i, s, sl);
-			new[i + sl] = '\0';
-			*more = new;
+			if (more && i >= ARRAY_SIZE(opts)) {
+				int sl = strlen(s);
+				char *new = *more;
+
+				i = new ? strlen(new) : 0;
+				new = realloc(new, i + strlen(s) + 2);
+				if (!new)
+					return -ENOMEM;
+				if (i)
+					new[i++] = ',';
+				memcpy(new + i, s, sl);
+				new[i + sl] = '\0';
+				*more = new;
+			}
 		}
 
 		if (!comma)
@@ -272,21 +356,31 @@ static void *erofsmount_nbd_loopfn(void *arg)
 	return (void *)(uintptr_t)err;
 }
 
-static int erofsmount_startnbd(int nbdfd, const char *source)
+static int erofsmount_startnbd(int nbdfd, union erofs_nbd_source source,
+			       enum erofs_nbd_source_type source_type)
 {
 	struct erofsmount_nbd_ctx ctx = {};
 	uintptr_t retcode;
 	pthread_t th;
 	int err, err2;
+	int blkbits = 9;
+	u64 blocks = INT64_MAX >> blkbits;
 
-	err = open(source, O_RDONLY);
-	if (err < 0) {
-		err = -errno;
-		goto out_closefd;
+	if (source_type == EROFSNBD_SOURCE_OCI) {
+		err = ocierofs_io_open(source.vf, &ocicfg);
+		if (err)
+			goto out_closefd;
+		ctx.vd = *source.vf;
+	} else {
+		err = open(source.device_path, O_RDONLY);
+		if (err < 0) {
+			err = -errno;
+			goto out_closefd;
+		}
+		ctx.vd.fd = err;
 	}
-	ctx.vd.fd = err;
 
-	err = erofs_nbd_connect(nbdfd, 9, INT64_MAX >> 9);
+	err = erofs_nbd_connect(nbdfd, blkbits, blocks);
 	if (err < 0) {
 		erofs_io_close(&ctx.vd);
 		goto out_closefd;
@@ -532,9 +626,9 @@ err_identifier:
 	return err;
 }
 
-static int erofsmount_nbd(const char *source, const char *mountpoint,
-			  const char *fstype, int flags,
-			  const char *options)
+static int erofsmount_nbd(union erofs_nbd_source source, enum erofs_nbd_source_type source_type,
+			  const char *mountpoint, const char *fstype,
+			  int flags, const char *options)
 {
 	bool is_netlink = false;
 	char nbdpath[32], *id;
@@ -549,9 +643,16 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 	}
 	flags |= MS_RDONLY;
 
-	err = erofsmount_startnbd_nl(&pid, source);
-	if (err < 0) {
-		erofs_info("Fall back to ioctl-based NBD; failover is unsupported");
+	if (source_type == EROFSNBD_SOURCE_LOCAL) {
+		err = erofsmount_startnbd_nl(&pid, source.device_path);
+		if (err >= 0) {
+			num = err;
+			(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+			is_netlink = true;
+		}
+	}
+
+	if (!is_netlink) {
 		num = erofs_nbd_devscan();
 		if (num < 0)
 			return num;
@@ -561,14 +662,11 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 		if (nbdfd < 0)
 			return -errno;
 
-		if ((pid = fork()) == 0)
-			return erofsmount_startnbd(nbdfd, source) ?
+		if ((pid = fork()) == 0) {
+			return erofsmount_startnbd(nbdfd, source, source_type) ?
 				EXIT_FAILURE : EXIT_SUCCESS;
+		}
 		close(nbdfd);
-	} else {
-		num = err;
-		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
-		is_netlink = true;
 	}
 
 	while (1) {
@@ -586,7 +684,7 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 		if (err < 0)
 			err = -errno;
 
-		if (!err && is_netlink) {
+		if (!err && is_netlink && source_type == EROFSNBD_SOURCE_LOCAL) {
 			id = erofs_nbd_get_identifier(num);
 
 			err = IS_ERR(id) ? PTR_ERR(id) :
@@ -789,9 +887,19 @@ int main(int argc, char *argv[])
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
-		err = erofsmount_nbd(mountcfg.device, mountcfg.target,
-				     mountcfg.fstype, mountcfg.flags,
-				     mountcfg.options);
+		if (mountcfg.use_oci) {
+			struct erofs_vfile vfile = {};
+
+			ocicfg.image_ref = mountcfg.device;
+			src.vf = &vfile;
+			err = erofsmount_nbd(src, EROFSNBD_SOURCE_OCI, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags, mountcfg.options);
+		} else {
+			src.device_path = mountcfg.device;
+			err = erofsmount_nbd(src, EROFSNBD_SOURCE_LOCAL, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags,
+					     mountcfg.options);
+		}
 		goto exit;
 	}
 
-- 
2.47.1


