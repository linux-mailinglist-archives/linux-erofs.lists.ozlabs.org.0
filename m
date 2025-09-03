Return-Path: <linux-erofs+bounces-957-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03221B4187C
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 10:29:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGwkn57Qyz2yr4;
	Wed,  3 Sep 2025 18:29:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.63
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756888161;
	cv=none; b=aaJ3YCYRuR0s1vmZhx1SkCZm3icIHMOuIlqC2g1ZhKux7qUVTWTGdjWJYEMn+OVrc3Y2OrRpa8pDl85SQv7TsG6gj9uU5meZeVoC51rnSUhx610So+IrrwbqoHSGIYobaXaMYI9p2Hls1w+xxbR54sNy6TZDwr1VuK0NpqJpdijYJKbMhNcRBzMkWpQ8zl3zYGI8UxGBsi5D2RBUE3e1UrOkaatyeUYDiuD8V7f+FT6iI9sQKve8pFjLGrwNr0mtSudYPpZQXqrlBaVbi6d9qvV+F+mUAcduovHlss6uOnmqXYc/YmYq0NAWfc0ozZ/SgjV+DTgnyoC1HzKGKTSeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756888161; c=relaxed/relaxed;
	bh=zca2SCIePuLxcPiNMksCujKpnVy2b/v2JFU+zT+B9dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyNb+1FLfI1JTtg4F/K3ebjunoao42yXddLSYouy57aWmAU3o3cZxJ6b7lAuma5+LmHJpmIDIjkfxL4NFPrswkTSCq6HtHqU6niad9bKvD5CNFcWRAsT+19EGyMDSP1CBe6sPakw09mRT5m11p2mJyPAZucZ1mQ8BMBbnNES4cI2SfriZLft+sakmlt2cDrGOrqzVMIEGEUb269OlsaXilQpUx3UVIc51dbiJMlIVqjPIH6k7eKhfhTQDkOMsFza67ra/Iwh06Okyk8gw/8oXDyVLow5IZY50o5akXmMa93xSvzJuBT1E4m0pYCPdI0dGcnge3DgjGRPvYk9zlE3/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGwkl5bQGz2xQ1
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 18:29:19 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eWS3HTG_1756888154 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:29:15 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3 2/2] erofs-utils: add NBD-backed OCI image mounting
Date: Wed,  3 Sep 2025 16:29:06 +0800
Message-ID: <20250903082906.83826-3-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903082906.83826-1-hudson@cyzhu.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250903082906.83826-1-hudson@cyzhu.com>
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
- Add --oci option for OCI image mounting with NBD backend

New mount.erofs -t erofs.nbd option: --oci=[option] source-image mountpoint

Supported options:
- platform=os/arch (default: linux/amd64)
- layer=N (extract specific layer, default: all layers)
- username/password (basic authentication)

e.g.:
./mount/mount.erofs -t erofs.nbd  --oci=platform=linux/amd64 \
quay.io/chengyuzhu6/golang:1.22.8-erofs /tmp/test/

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  19 +++-
 lib/remotes/oci.c  | 242 ++++++++++++++++++++++++++++++++++++++++++++-
 mount/Makefile.am  |   3 +-
 mount/main.c       | 236 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 493 insertions(+), 7 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index d119a2b..f35228c 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -7,7 +7,6 @@
 #define __EROFS_OCI_H
 
 #include <stdbool.h>
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -56,7 +55,11 @@ struct ocierofs_ctx {
 	} img;
 };
 
-int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
+struct ocierofs_iostream {
+	struct ocierofs_ctx *ctx;
+	struct erofs_vfile vf;
+	u64 offset;
+};
 
 /*
  * ocierofs_build_trees - Build file trees from an OCI container image
@@ -65,8 +68,16 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config
  *
  * Return: 0 on success, negative errno on failure
  */
-int ocierofs_build_trees(struct erofs_importer *importer,
-			 const struct ocierofs_config *cfg);
+int ocierofs_build_trees(struct erofs_importer *importer, const struct ocierofs_config *cfg);
+
+int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx);
+
+int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
+
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx);
+
+int ocierofs_iostream_open(struct ocierofs_iostream *oci_iostream, struct ocierofs_ctx *oci_ctx);
+void ocierofs_iostream_close(struct ocierofs_iostream *oci_iostream);
 
 #ifdef __cplusplus
 }
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 01f1e24..8750772 100644
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
@@ -1133,7 +1136,7 @@ out:
 	return ret;
 }
 
-static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 {
 	if (!ctx)
 		return;
@@ -1193,3 +1196,240 @@ int ocierofs_build_trees(struct erofs_importer *importer,
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
+	int index = ctx->img.layer_index;
+
+	if (offset < 0)
+		return -EINVAL;
+
+	api_registry = ocierofs_get_api_registry(ctx->img.registry);
+	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
+	     api_registry, ctx->img.repository, ctx->img.layers[index]->digest) == -1)
+		return -ENOMEM;
+
+	if (length)
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-%lld",
+			 (long long)offset, (long long)(offset + (off_t)length - 1));
+	else
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-",
+			 (long long)offset);
+
+	if (ctx->net.auth_header && strstr(ctx->net.auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, ctx->net.auth_header);
+	req.headers = curl_slist_append(req.headers, rangehdr);
+
+	curl_easy_reset(ctx->net.curl);
+
+	ret = ocierofs_curl_setup_common_options(ctx->net.curl);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_setup_rq(ctx->net.curl, req.url, OCIEROFS_HTTP_GET,
+				     req.headers,
+				     ocierofs_write_callback,
+				     &resp, NULL, NULL);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_perform(ctx->net.curl, &http_code);
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
+				size_t available = resp.size - offset;
+				size_t copy_size = length ? min_t(size_t, length, available) : available;
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
+				*out_buf = NULL;
+				*out_size = 0;
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
+	int layer_index = oci_iostream->ctx->img.layer_index;
+
+	switch (whence) {
+	case SEEK_SET:
+		new_offset = offset;
+		break;
+	case SEEK_CUR:
+		new_offset = oci_iostream->offset + offset;
+		break;
+	case SEEK_END:
+		new_offset = oci_iostream->ctx->img.layers[layer_index]->size + offset;
+		break;
+	default:
+		return -1;
+	}
+
+	if (new_offset < 0 || new_offset > oci_iostream->ctx->img.layers[layer_index]->size)
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
+			erofs_err("OCI I/O sendfile: failed to read from OCI: %s",
+				  erofs_strerror(ret));
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
+
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
+	if (ctx->img.layer_count > 0 && ctx->img.layers[0] &&
+	    ctx->img.layers[0]->media_type) {
+		if (strcmp(ctx->img.layers[0]->media_type, EROFS_MEDIATYPE) != 0)
+			return -ENOENT;
+		return 0;
+	}
+	return -ENOENT;
+}
diff --git a/mount/Makefile.am b/mount/Makefile.am
index d93f3f4..7b971f5 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -9,5 +9,4 @@ mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS}
-endif
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS} ${openssl_LIBS}
diff --git a/mount/main.c b/mount/main.c
index 139b532..77c16f5 100644
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
@@ -56,6 +61,11 @@ static struct erofsmount_cfg {
 	long flags;
 	enum erofs_backend_drv backend;
 	enum erofsmount_mode mountmode;
+	bool umount;
+#ifdef OCIEROFS_ENABLED
+	char *oci_options;
+	bool use_oci;
+#endif
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
@@ -128,6 +138,9 @@ static int erofsmount_parse_options(int argc, char **argv)
 	static const struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
 		{"reattach", no_argument, 0, 512},
+#ifdef OCIEROFS_ENABLED
+		{"oci", optional_argument, 0, 513},
+#endif
 		{0, 0, 0, 0},
 	};
 	char *dot;
@@ -165,6 +178,12 @@ static int erofsmount_parse_options(int argc, char **argv)
 		case 512:
 			mountcfg.mountmode = EROFSMOUNT_MODE_REATTACH;
 			break;
+#ifdef OCIEROFS_ENABLED
+		case 513:
+			mountcfg.oci_options = optarg;
+			mountcfg.use_oci = true;
+			break;
+#endif
 		default:
 			return -EINVAL;
 		}
@@ -198,6 +217,74 @@ static int erofsmount_parse_options(int argc, char **argv)
 	return 0;
 }
 
+static int mount_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
+{
+	char *opt, *q, *p;
+
+	if (!options_str)
+		return 0;
+
+	opt = options_str;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		p = strstr(opt, "platform=");
+		if (p) {
+			p += strlen("platform=");
+			free(oci_cfg->platform);
+			oci_cfg->platform = strdup(p);
+			if (!oci_cfg->platform)
+				return -ENOMEM;
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		p = strstr(opt, "layer=");
+		if (p) {
+			p += strlen("layer=");
+			oci_cfg->layer_index = atoi(p);
+			if (oci_cfg->layer_index < 0) {
+				erofs_err("invalid layer index %d",
+				  oci_cfg->layer_index);
+				return -EINVAL;
+			}
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		p = strstr(opt, "username=");
+		if (p) {
+			p += strlen("username=");
+			free(oci_cfg->username);
+			oci_cfg->username = strdup(p);
+			if (!oci_cfg->username)
+				return -ENOMEM;
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		p = strstr(opt, "password=");
+		if (p) {
+			p += strlen("password=");
+			free(oci_cfg->password);
+			oci_cfg->password = strdup(p);
+			if (!oci_cfg->password)
+				return -ENOMEM;
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		erofs_err("mkfs: invalid --oci value %s", opt);
+		return -EINVAL;
+
+		opt = q ? q + 1 : NULL;
+	}
+
+	return 0;
+}
+
 static int erofsmount_fuse(const char *source, const char *mountpoint,
 			   const char *fstype, const char *options)
 {
@@ -750,6 +837,122 @@ err_out:
 	return err < 0 ? err : 0;
 }
 
+/**
+ * erofsmount_startnbd_oci - Start NBD server for OCI image
+ * @nbdfd: NBD device file descriptor
+ * @oci_ctx: OCI client structure (pre-authenticated)
+ * @auth_header: pre-authenticated auth header
+ *
+ * Start an NBD server that serves data from an OCI image layer.
+ * This function reuses the existing erofsmount_nbd_loopfn logic
+ * but uses erofsoci_iostream as the virtual device instead of a local file.
+ * The OCI client should be pre-authenticated to avoid concurrent auth issues.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int erofsmount_startnbd_oci(int nbdfd, struct ocierofs_ctx *oci_ctx)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	struct ocierofs_iostream *oci_iostream = NULL;
+	uintptr_t retcode;
+	pthread_t th;
+	int err, err2;
+	int blkbits = 12;
+	int index = oci_ctx->img.layer_index;
+	u64 blocks;
+
+	blocks = (oci_ctx->img.layers[index]->size + (1ULL << blkbits) - 1) >> blkbits;
+
+	oci_iostream = malloc(sizeof(struct ocierofs_iostream));
+	if (!oci_iostream)
+		return -ENOMEM;
+
+	err = ocierofs_iostream_open(oci_iostream, oci_ctx);
+	if (err) {
+		free(oci_iostream);
+		return err;
+	}
+
+	ctx.vd = oci_iostream->vf;
+
+	err = erofs_nbd_connect(nbdfd, blkbits, blocks);
+	if (err < 0) {
+		ocierofs_iostream_close(oci_iostream);
+		free(oci_iostream);
+		return err;
+	}
+	ctx.sk.fd = err;
+
+	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
+	if (err) {
+		ocierofs_iostream_close(oci_iostream);
+		free(oci_iostream);
+		close(ctx.sk.fd);
+		return err;
+	}
+
+	err = erofs_nbd_do_it(nbdfd);
+	err2 = -pthread_join(th, (void **)&retcode);
+	if (!err2 && retcode) {
+		erofs_err("NBD worker failed with %s",
+			  erofs_strerror(retcode));
+		err2 = retcode;
+	}
+
+	ocierofs_iostream_close(oci_iostream);
+	free(oci_iostream);
+
+	return err ?: err2;
+}
+
+static int erofsmount_nbd_oci(struct ocierofs_ctx *ctx, const char *mountpoint,
+			      const char *fstype, int flags, const char *options)
+{
+	char nbdpath[32];
+	int num, nbdfd;
+	pid_t pid;
+	long err;
+
+	if (strcmp(fstype, "erofs")) {
+		fprintf(stderr, "unsupported filesystem type `%s`\n", fstype);
+		return -ENODEV;
+	}
+
+	flags |= O_RDONLY;
+
+	num = erofs_nbd_devscan();
+	if (num < 0)
+		return num;
+
+	(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+	nbdfd = open(nbdpath, O_RDWR);
+	if (nbdfd < 0)
+		return -errno;
+
+	if ((pid = fork()) == 0) {
+		return erofsmount_startnbd_oci(nbdfd, ctx) ?
+			EXIT_FAILURE : EXIT_SUCCESS;
+	}
+	close(nbdfd);
+
+	while (1) {
+		err = erofs_nbd_in_service(num);
+		if (err == -ENOENT || err == -ENOTCONN) {
+			usleep(50000);
+			continue;
+		}
+		if (err >= 0)
+			err = (err != pid ? -EBUSY : 0);
+		break;
+	}
+	if (!err) {
+		err = mount(nbdpath, mountpoint, fstype, flags, options);
+		if (err < 0)
+			err = -errno;
+	}
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
@@ -785,9 +988,42 @@ int main(int argc, char *argv[])
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
+#ifdef OCIEROFS_ENABLED
+		if (mountcfg.use_oci) {
+			struct ocierofs_ctx ctx = {};
+
+			ocicfg.image_ref = mountcfg.device;
+			err = mount_parse_oci_options(&ocicfg, mountcfg.oci_options);
+			if (err)
+				goto exit;
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
+			err = erofsmount_nbd_oci(&ctx, mountcfg.target,
+						 mountcfg.fstype, mountcfg.flags, mountcfg.options);
+			if (err) {
+				ocierofs_ctx_cleanup(&ctx);
+				goto exit;
+			}
+		} else {
+			err = erofsmount_nbd(mountcfg.device, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags,
+					     mountcfg.options);
+		}
+#else
 		err = erofsmount_nbd(mountcfg.device, mountcfg.target,
 				     mountcfg.fstype, mountcfg.flags,
 				     mountcfg.options);
+#endif
 		goto exit;
 	}
 
-- 
2.51.0


