Return-Path: <linux-erofs+bounces-972-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F3B434EF
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 10:06:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHXB41WW6z2xnM;
	Thu,  4 Sep 2025 18:06:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756973196;
	cv=none; b=gz4M84r31YYQYodvC/P47sumPvsqUee29x5Ox+xkQDrESbAZzDKGI07/O3STNnyGZ6Jq5bCo4j5pyjBsBIIeAgFI+lAQVZ2XJFV4ZjbZO3t0AbAqR1IppTHGfMOGLd0lTc0pwznJrV0k7v6UAUqQYmwfnG/MwEBe/pw7/4N5PdptnMCsDKwkHYgX0wgwuHvx1T4xTpwQzAaApsZ8b0BUgEyntMaWa/MwPhnSS7bk4QsdX+vKpe2BKtC01InO6JPqVOL/BxGZnLzz8MjuarRLRJlBZSztgmo7vUKPL2vbVWEiUC5P7F12udh+t0pEFIuSCcSd66T1P/Z4FACnW47e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756973196; c=relaxed/relaxed;
	bh=9h4ouDuurC+VfZPmi4vCIjggoIiN7jH5pmUXp+B/pvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2RudY83zT7d41HDw3LI2nJcGDqRqaUA9qLElW9ASgzMKWMrN7Dbb5IovaIFE05enwO+JL/hWf9eieKvsMf64Q9uTs/jxxVHUtZtMV/vuWCFhrY5YVjSGf2d1ipCRXTrcXSDhHumpG4AKn3sip4sl1Bv3ZLMWsOIOP5YOzWuYqU3d7LaiRhcNVC/N6GmFufzhRyTp9ddaAJmnTbv1r7R+TvB1N+kpToVaCktg4lFvegctpJ4+3tuWHfW4Klft6Y/dIOkwqAYbKRyc0Ejt5zO8RWWYR9eHk7xO234XXx6B6DzePwoKRv/6ggLVkeOt8whDugEIEwKNfheUlvaHCN//A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.80; helo=out28-80.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.80; helo=out28-80.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-80.mail.aliyun.com (out28-80.mail.aliyun.com [115.124.28.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHXB23Fr3z2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 18:06:31 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eXFmmfP_1756973185 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 16:06:26 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: add NBD-backed OCI image mounting
Date: Thu,  4 Sep 2025 16:06:24 +0800
Message-ID: <20250904080624.57376-1-hudson@cyzhu.com>
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
quay.io/chengyuzhu6/golang:1.22.8-erofs /tmp/test/

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  14 +++
 lib/remotes/oci.c  | 249 ++++++++++++++++++++++++++++++++++++++++++++-
 mount/Makefile.am  |   2 +-
 mount/main.c       | 233 ++++++++++++++++++++++++++++++++++--------
 4 files changed, 452 insertions(+), 46 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 2896308..077b7f9 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -55,6 +55,12 @@ struct ocierofs_ctx {
 	int layer_count;
 };
 
+struct ocierofs_iostream {
+	struct ocierofs_ctx *ctx;
+	struct erofs_vfile vf;
+	u64 offset;
+};
+
 int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
 
 /*
@@ -67,6 +73,14 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config
 int ocierofs_build_trees(struct erofs_importer *importer,
 			 const struct ocierofs_config *cfg);
 
+int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx);
+
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx);
+
+int ocierofs_iostream_open(struct ocierofs_iostream *oci_iostream, struct ocierofs_ctx *oci_ctx);
+
+void ocierofs_iostream_close(struct ocierofs_iostream *oci_iostream);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index f2b08b2..5c393e1 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -33,6 +33,9 @@
 #define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
 #define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
 
+/* Erofs Native Layer Media Type */
+#define EROFS_MEDIATYPE "application/vnd.erofs"
+
 struct ocierofs_request {
 	char *url;
 	struct curl_slist *headers;
@@ -1161,7 +1164,7 @@ out:
  * Clean up CURL handle, free all allocated string parameters, and
  * reset the OCI context structure to a clean state.
  */
-static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 {
 	if (!ctx)
 		return;
@@ -1226,3 +1229,247 @@ int ocierofs_build_trees(struct erofs_importer *importer,
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
+		if (offset == 0) {
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
+	if (ret < 0) {
+		memset(buf, 0, len);
+		return len;
+	}
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
+static off_t ocierofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
+	off_t new_offset;
+	int layer_index = oci_iostream->ctx->layer_index;
+
+	switch (whence) {
+	case SEEK_SET:
+		new_offset = offset;
+		break;
+	case SEEK_CUR:
+		new_offset = oci_iostream->offset + offset;
+		break;
+	case SEEK_END:
+		new_offset = oci_iostream->ctx->layers[layer_index]->size + offset;
+		break;
+	default:
+		return -1;
+	}
+
+	if (new_offset < 0 || new_offset > oci_iostream->ctx->layers[layer_index]->size)
+		return -1;
+
+	oci_iostream->offset = new_offset;
+	return new_offset;
+}
+
+static ssize_t ocierofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			       off_t *pos, size_t count)
+{
+	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vin->payload;
+	char *buf = NULL;
+	ssize_t total_written = 0;
+	ssize_t ret = 0;
+
+	buf = malloc(min_t(size_t, count, 32768));
+	if (!buf)
+		return -ENOMEM;
+
+	while (count > 0) {
+		size_t to_read = min_t(size_t, count, 32768);
+		u64 read_offset = pos ? *pos : oci_iostream->offset;
+
+		ret = ocierofs_io_pread(vin, buf, to_read, read_offset);
+		if (ret <= 0) {
+			if (ret < 0)
+				erofs_err("OCI I/O sendfile: failed to read from OCI: %s",
+					  erofs_strerror(ret));
+			memset(buf, 0, to_read);
+			ret = to_read;
+		}
+
+		ssize_t written = write(vout->fd, buf, ret);
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
+	free(buf);
+	return count;
+}
+
+static struct erofs_vfops ocierofs_io_vfops = {
+	.pread = ocierofs_io_pread,
+	.read = ocierofs_io_read,
+	.lseek = ocierofs_io_lseek,
+	.sendfile = ocierofs_io_sendfile,
+};
+
+int ocierofs_iostream_open(struct ocierofs_iostream *oci_iostream, struct ocierofs_ctx *oci_ctx)
+{
+	memset(oci_iostream, 0, sizeof(*oci_iostream));
+	oci_iostream->ctx = oci_ctx;
+	oci_iostream->vf.ops = &ocierofs_io_vfops;
+	oci_iostream->vf.fd = -1;
+	*(struct ocierofs_iostream **)oci_iostream->vf.payload = oci_iostream;
+
+	return 0;
+}
+
+void ocierofs_iostream_close(struct ocierofs_iostream *oci_iostream)
+{
+	close(oci_iostream->vf.fd);
+}
+
+int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx)
+{
+	if (ctx->layer_count > 0 && ctx->layers[0] &&
+	    ctx->layers[0]->media_type) {
+		if (strcmp(ctx->layers[0]->media_type, EROFS_MEDIATYPE) != 0)
+			return -ENOENT;
+		return 0;
+	}
+	return -ENOENT;
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
index a270f0a..3af4d63 100644
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
@@ -34,6 +35,10 @@ struct loop_info {
 #include <sys/sysmacros.h>
 #endif
 
+#ifdef OCIEROFS_ENABLED
+static struct ocierofs_config ocicfg;
+#endif
+
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
@@ -56,12 +61,76 @@ static struct erofsmount_cfg {
 	long flags;
 	enum erofs_backend_drv backend;
 	enum erofsmount_mode mountmode;
+#ifdef OCIEROFS_ENABLED
+	bool use_oci;
+#endif
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
+	struct ocierofs_ctx *oci_ctx;
+};
+
+union erofs_nbd_source src;
+
+static int parse_oci_option(struct ocierofs_config *oci_cfg, const char *option)
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
+	return 0;
+}
+
 static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 {
 	static const struct {
@@ -90,29 +159,41 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
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
+#ifdef OCIEROFS_ENABLED
+			int err = parse_oci_option(&ocicfg, s);
 
-			i = new ? strlen(new) : 0;
-			new = realloc(new, i + strlen(s) + 2);
-			if (!new)
-				return -ENOMEM;
-			if (i)
-				new[i++] = ',';
-			memcpy(new + i, s, sl);
-			new[i + sl] = '\0';
-			*more = new;
+			if (err < 0)
+				return err;
+#else
+			return -EINVAL;
+#endif
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
+
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
@@ -120,6 +201,11 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 		*comma = ',';
 		s = comma + 1;
 	}
+
+#ifdef OCIEROFS_ENABLED
+	if (ocicfg.platform || ocicfg.username || ocicfg.password || ocicfg.layer_index != 0)
+		mountcfg.use_oci = true;
+#endif
 	return flags;
 }
 
@@ -272,30 +358,47 @@ static void *erofsmount_nbd_loopfn(void *arg)
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
+	struct ocierofs_iostream oci_iostream = {};
 
-	err = open(source, O_RDONLY);
-	if (err < 0) {
-		err = -errno;
-		goto out_closefd;
+	if (source_type == EROFSNBD_SOURCE_OCI) {
+		err = ocierofs_iostream_open(&oci_iostream, source.oci_ctx);
+		if (err)
+			goto out_closefd;
+		ctx.vd = oci_iostream.vf;
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
-		close(ctx.vd.fd);
+		if (source_type == EROFSNBD_SOURCE_OCI)
+			ocierofs_iostream_close(&oci_iostream);
+		else
+			close(ctx.vd.fd);
 		goto out_closefd;
 	}
 	ctx.sk.fd = err;
 
 	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
 	if (err) {
-		close(ctx.vd.fd);
+		if (source_type == EROFSNBD_SOURCE_OCI)
+			ocierofs_iostream_close(&oci_iostream);
+		else
+			close(ctx.vd.fd);
 		close(ctx.sk.fd);
 		goto out_closefd;
 	}
@@ -307,6 +410,10 @@ static int erofsmount_startnbd(int nbdfd, const char *source)
 		          erofs_strerror(retcode));
 		err2 = retcode;
 	}
+
+	if (source_type == EROFSNBD_SOURCE_OCI)
+		ocierofs_iostream_close(&oci_iostream);
+
 	return err ?: err2;
 out_closefd:
 	close(nbdfd);
@@ -540,9 +647,9 @@ err_identifier:
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
@@ -557,9 +664,16 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
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
@@ -569,14 +683,11 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
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
@@ -594,7 +705,7 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 		if (err < 0)
 			err = -errno;
 
-		if (!err && is_netlink) {
+		if (!err && is_netlink && source_type == EROFSNBD_SOURCE_LOCAL) {
 			id = erofs_nbd_get_identifier(num);
 			if (id == ERR_PTR(-ENOENT))
 				id = NULL;
@@ -799,9 +910,43 @@ int main(int argc, char *argv[])
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
-		err = erofsmount_nbd(mountcfg.device, mountcfg.target,
+#ifdef OCIEROFS_ENABLED
+		if (mountcfg.use_oci) {
+			struct ocierofs_ctx ctx = {};
+
+			ocicfg.image_ref = mountcfg.device;
+			err = ocierofs_init(&ctx, &ocicfg);
+			if (err) {
+				ocierofs_ctx_cleanup(&ctx);
+				goto exit;
+			}
+
+			err = ocierofs_is_erofs_native_image(&ctx);
+			if (err) {
+				ocierofs_ctx_cleanup(&ctx);
+				goto exit;
+			}
+
+			src.oci_ctx = &ctx;
+
+			err = erofsmount_nbd(src, EROFSNBD_SOURCE_OCI, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags, mountcfg.options);
+			if (err) {
+				ocierofs_ctx_cleanup(&ctx);
+				goto exit;
+			}
+		} else {
+			src.device_path = mountcfg.device;
+			err = erofsmount_nbd(src, EROFSNBD_SOURCE_LOCAL, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags,
+					     mountcfg.options);
+		}
+#else
+		src.device_path = mountcfg.device;
+		err = erofsmount_nbd(src, EROFSNBD_SOURCE_LOCAL, mountcfg.target,
 				     mountcfg.fstype, mountcfg.flags,
 				     mountcfg.options);
+#endif
 		goto exit;
 	}
 
-- 
2.51.0


