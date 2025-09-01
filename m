Return-Path: <linux-erofs+bounces-941-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905EB3DC57
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Sep 2025 10:28:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cFhpx5xKpz2yrB;
	Mon,  1 Sep 2025 18:28:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.68
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756715321;
	cv=none; b=ICxq6vdUpvIzl9Y1CbrYPlO9OuhHrXe2GdygTRHd7No/mcBXHeFOhnUgUje16dc9TLDz9zaePamqV/Moo4sIRJvKfHNY7aK9Pyr5qIP1Yz2YobfrXloIU2M4poKqP6mcud7/OKvsfks/R5EQ4vvacURaA5EnbAl9L/rOghnNTtF3yfvre2KpbVMmczzJtaps4u5i6iNt04O77jE4cYizmb3452FHI3s/wy2UKr4wr031z0pa+GmxQ957ci5EK5+8oXF3Zx110boDPLWpRWKQjEeoCx6UhmLAvQmOZqjJe1BVcOj8mev+dL2a/J/FhqmbV3AqfwzwATM7WfHfT+F+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756715321; c=relaxed/relaxed;
	bh=9EX/R7Y8H1+AOda9DmxHsQR1VVC35HrbG9WG/aGlsgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gw3ImQa2pMQ1NZhimtTNTmHzaeLgYlOAUAMSSF+5MFKZyuoW6cOd1a45vJv3cj11f5aVq2ozRKUBU8I15bs54w8PNDRsA9BhiK/cQQP6JBWogolTqYV5UhZKcUgBLH74sTspwaSLH5wxTwyT5KhZjlUi5FkX1gp+2yTY8a3OuwSHJwxZBzeO15U+s46uZmHzl0k55FUzac0/QPN+CaL7g1HPcKimkd8vOmK8RsKH2CJp3ea9nEPCl2sv2dUI1WA9GsT2F0955jYCjvA6dn3vSPP5E3xSj2guc9xi2bCYbSUKpLIPfAcMgcHvoP5M79Jz4QF6AfvXophcVkeS636VAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.68; helo=out28-68.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.68; helo=out28-68.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cFhpw05gkz2yhb
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Sep 2025 18:28:37 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eUkzK.z_1756715308 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 01 Sep 2025 16:28:29 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: add OCI image mounting support via NBD
Date: Mon,  1 Sep 2025 16:28:27 +0800
Message-ID: <20250901082827.19351-1-hudson@cyzhu.com>
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

- Add OCI blob range download support for efficient data access
- Implement `erofs_oci_iostream` for virtual file operations on OCI layers
- Support mounting multiple OCI layers using overlayfs
- Add --oci option for OCI image mounting with NBD backend

New mount.erofs -t erofs.nbd option: --oci=[option] source-image mountpoint

Supported options:
- platform=os/arch (default: linux/amd64)
- layer=N (extract specific layer, default: all layers)
- username/password (basic authentication)

e.g.:
./mount/mount.erofs -t erofs.nbd  --oci=platform=linux/amd64 \
quay.io/chengyuzhu6/golang:1.22.8-erofs /tmp/test/

This enables mounting EROFS container images directly from OCI registries
using NBD as the transport layer, supporting both single and multi-layer
images with overlay filesystem composition.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  62 ++++++++
 lib/remotes/oci.c  | 245 ++++++++++++++++++++++++++++
 mount/Makefile.am  |   2 +-
 mount/main.c       | 386 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 694 insertions(+), 1 deletion(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 698fe07..abb9e8a 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -11,6 +11,9 @@
 #define DOCKER_REGISTRY "docker.io"
 #define DOCKER_API_REGISTRY "registry-1.docker.io"
 
+/* Erofs Native Layer Media Type */
+#define EROFS_MEDIATYPE "application/vnd.erofs"
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -60,6 +63,26 @@ struct erofs_oci_params {
 	int layer_index;
 };
 
+/**
+ * struct erofs_oci_iostream
+ * @oci: OCI client (set by caller)
+ * @vf: Virtual file interface
+ * @oci_ref: OCI image reference
+ * @auth_header: Authentication header (set by caller)
+ * @layer_size: Layer size in bytes
+ * @current_offset: Current read position
+ * @initialized: Initialization flag
+ */
+struct erofs_oci_iostream {
+	struct erofs_oci *oci;
+	struct erofs_vfile vf;
+	char *oci_ref;
+	char *auth_header;
+	u64 layer_size;
+	u64 current_offset;
+	bool initialized;
+};
+
 /**
  * struct erofs_oci - Combined OCI client structure
  * @curl: CURL handle for HTTP requests
@@ -188,6 +211,45 @@ int ocierofs_prepare_auth(struct erofs_oci *oci, char **auth_header_out,
  */
 int ocierofs_curl_clear_auth(struct CURL *curl);
 
+/**
+ * ocierofs_download_blob_range - Download a range of a blob into memory
+ * @oci: OCI client structure
+ * @digest: blob digest (e.g. sha256:...)
+ * @auth_header: optional Authorization header (Bearer ...)
+ * @offset: starting byte offset (>= 0)
+ * @length: number of bytes to fetch; if 0, fetch to the end
+ * @out_buf: returns malloc'ed buffer on success (caller frees)
+ * @out_size: returns size of the buffer
+ *
+ * Download a range of bytes from an OCI blob into memory.
+ * This function supports HTTP range requests for efficient partial downloads.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_download_blob_range(struct erofs_oci *oci,
+				const char *digest,
+				const char *auth_header,
+				off_t offset, size_t length,
+				void **out_buf, size_t *out_size);
+
+/**
+ * ocierofs_iostream_init
+ * @oci_iostream_ptr: pointer to erofs_oci_iostream structure
+ * @oci_ref: OCI image reference (digest)
+ * @layer_size: known layer size in bytes
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_iostream_init(void *oci_iostream_ptr, const char *oci_ref, u64 layer_size);
+
+/**
+ * ocierofs_iostream_cleanup
+ * @oci_iostream_ptr: pointer to erofs_oci_iostream structure
+ *
+ * Clean up resources associated with an erofs_oci_iostream structure.
+ */
+void ocierofs_iostream_cleanup(void *oci_iostream_ptr);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 9774d8d..597e609 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -935,6 +935,103 @@ out:
 	return ret;
 }
 
+int ocierofs_download_blob_range(struct erofs_oci *oci,
+				     const char *digest,
+				     const char *auth_header,
+				     off_t offset, size_t length,
+				     void **out_buf, size_t *out_size)
+{
+	struct erofs_oci_request req = {};
+	struct erofs_oci_response resp = {};
+	const char *api_registry;
+	char rangehdr[64];
+	long http_code = 0;
+	int ret;
+
+	if (!out_buf || !out_size || !digest || !oci)
+		return -EINVAL;
+	*out_buf = NULL;
+	*out_size = 0;
+	if (offset < 0)
+		return -EINVAL;
+
+	api_registry = (!strcmp(oci->params.registry, DOCKER_REGISTRY)) ?
+		       DOCKER_API_REGISTRY : oci->params.registry;
+	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
+	     api_registry, oci->params.repository, digest) == -1)
+		return -ENOMEM;
+
+	if (length)
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-%lld",
+			 (long long)offset, (long long)(offset + (off_t)length - 1));
+	else
+		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-",
+			 (long long)offset);
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+	req.headers = curl_slist_append(req.headers, rangehdr);
+
+	curl_easy_reset(oci->curl);
+
+	ret = ocierofs_curl_setup_common_options(oci->curl);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_setup_rq(oci->curl, req.url, OCIEROFS_HTTP_GET,
+				     req.headers,
+				     ocierofs_write_callback,
+				     &resp, NULL, NULL);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_perform(oci->curl, &http_code);
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
 static int ocierofs_extract_layer(struct erofs_oci *oci,
 				  const char *digest, const char *auth_header)
 {
@@ -1334,3 +1431,151 @@ int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str)
 
 	return 0;
 }
+
+static ssize_t erofs_oci_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
+{
+	struct erofs_oci_iostream *oci_iostream = *(struct erofs_oci_iostream **)vf->payload;
+	void *download_buf = NULL;
+	size_t download_size = 0;
+	ssize_t ret;
+
+	ret = ocierofs_download_blob_range(oci_iostream->oci, oci_iostream->oci_ref,
+					   oci_iostream->auth_header, offset, len,
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
+static ssize_t erofs_oci_io_read(struct erofs_vfile *vf, void *buf, size_t len)
+{
+	struct erofs_oci_iostream *oci_iostream = *(struct erofs_oci_iostream **)vf->payload;
+	ssize_t ret;
+
+	ret = erofs_oci_io_pread(vf, buf, len, oci_iostream->current_offset);
+	if (ret > 0)
+		oci_iostream->current_offset += ret;
+
+	return ret;
+}
+
+static off_t erofs_oci_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
+{
+	struct erofs_oci_iostream *oci_iostream = *(struct erofs_oci_iostream **)vf->payload;
+	off_t new_offset;
+
+	switch (whence) {
+	case SEEK_SET:
+		new_offset = offset;
+		break;
+	case SEEK_CUR:
+		new_offset = oci_iostream->current_offset + offset;
+		break;
+	case SEEK_END:
+		new_offset = oci_iostream->layer_size + offset;
+		break;
+	default:
+		return -1;
+	}
+
+	if (new_offset < 0 || new_offset > oci_iostream->layer_size)
+		return -1;
+
+	oci_iostream->current_offset = new_offset;
+	return new_offset;
+}
+
+static ssize_t erofs_oci_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			       off_t *pos, size_t count)
+{
+	struct erofs_oci_iostream *oci_iostream = *(struct erofs_oci_iostream **)vin->payload;
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
+		u64 read_offset = pos ? *pos : oci_iostream->current_offset;
+
+		ret = erofs_oci_io_pread(vin, buf, to_read, read_offset);
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
+			oci_iostream->current_offset += ret;
+	}
+
+	free(buf);
+	return count;
+}
+
+static struct erofs_vfops erofs_oci_io_vfops = {
+	.pread = erofs_oci_io_pread,
+	.read = erofs_oci_io_read,
+	.lseek = erofs_oci_io_lseek,
+	.sendfile = erofs_oci_io_sendfile,
+};
+
+int ocierofs_iostream_init(void *oci_iostream_ptr, const char *oci_ref, u64 layer_size)
+{
+	struct erofs_oci_iostream *oci_iostream = (struct erofs_oci_iostream *)oci_iostream_ptr;
+
+	memset(oci_iostream, 0, sizeof(*oci_iostream));
+	oci_iostream->oci_ref = strdup(oci_ref);
+	if (!oci_iostream->oci_ref)
+		return -ENOMEM;
+
+	oci_iostream->layer_size = layer_size;
+	oci_iostream->vf.ops = &erofs_oci_io_vfops;
+	oci_iostream->vf.fd = -1;
+	*(struct erofs_oci_iostream **)oci_iostream->vf.payload = oci_iostream;
+	oci_iostream->initialized = true;
+
+	return 0;
+}
+
+void ocierofs_iostream_cleanup(void *oci_iostream_ptr)
+{
+	struct erofs_oci_iostream *oci_iostream = (struct erofs_oci_iostream *)oci_iostream_ptr;
+
+	free(oci_iostream->auth_header);
+	oci_iostream->auth_header = NULL;
+	free(oci_iostream->oci_ref);
+	oci_iostream->oci_ref = NULL;
+	oci_iostream->initialized = false;
+}
diff --git a/mount/Makefile.am b/mount/Makefile.am
index b76e336..b64059d 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -9,5 +9,5 @@ mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
 endif
diff --git a/mount/main.c b/mount/main.c
index c9deae2..82fa4f3 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -14,6 +14,7 @@
 #include "erofs/err.h"
 #include "erofs/io.h"
 #include "../lib/liberofs_nbd.h"
+#include "../lib/liberofs_oci.h"
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
 #else
@@ -49,6 +50,10 @@ static struct erofsmount_cfg {
 	long flags;
 	enum erofs_backend_drv backend;
 	bool umount;
+#ifdef OCIEROFS_ENABLED
+	char *oci_options;
+	bool use_oci;
+#endif
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
@@ -120,6 +125,9 @@ static int erofsmount_parse_options(int argc, char **argv)
 {
 	static const struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
+#ifdef OCIEROFS_ENABLED
+		{"oci", optional_argument, 0, 200},
+#endif
 		{0, 0, 0, 0},
 	};
 	char *dot;
@@ -154,6 +162,12 @@ static int erofsmount_parse_options(int argc, char **argv)
 		case 'u':
 			mountcfg.umount = true;
 			break;
+#ifdef OCIEROFS_ENABLED
+		case 200:
+			mountcfg.oci_options = optarg;
+			mountcfg.use_oci = true;
+			break;
+#endif
 		default:
 			return -EINVAL;
 		}
@@ -502,6 +516,366 @@ err_out:
 	return err < 0 ? err : 0;
 }
 
+/**
+ * erofsmount_startnbd_oci - Start NBD server for OCI image
+ * @nbdfd: NBD device file descriptor
+ * @oci_ref: OCI image reference
+ * @oci: OCI client structure (pre-authenticated)
+ * @auth_header: pre-authenticated auth header
+ *
+ * Start an NBD server that serves data from an OCI image layer.
+ * This function reuses the existing erofsmount_nbd_loopfn logic
+ * but uses erofs_oci_iostream as the virtual device instead of a local file.
+ * The OCI client should be pre-authenticated to avoid concurrent auth issues.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int erofsmount_startnbd_oci(int nbdfd, const char *oci_ref, struct erofs_oci *oci,
+				   const char *auth_header, u64 layer_size)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	struct erofs_oci_iostream *oci_iostream = NULL;
+	uintptr_t retcode;
+	pthread_t th;
+	int err, err2;
+	int blkbits = 12;
+	u64 blocks;
+
+	blocks = (layer_size + (1ULL << blkbits) - 1) >> blkbits;
+
+	oci_iostream = malloc(sizeof(struct erofs_oci_iostream));
+	if (!oci_iostream)
+		return -ENOMEM;
+
+	err = ocierofs_iostream_init(oci_iostream, oci_ref, layer_size);
+	if (err) {
+		free(oci_iostream);
+		return err;
+	}
+
+	oci_iostream->oci = oci;
+	if (auth_header)
+		oci_iostream->auth_header = strdup(auth_header);
+
+	ctx.vd = oci_iostream->vf;
+
+	err = erofs_nbd_connect(nbdfd, blkbits, blocks);
+	if (err < 0) {
+		ocierofs_iostream_cleanup(oci_iostream);
+		free(oci_iostream);
+		return err;
+	}
+	ctx.sk.fd = err;
+
+	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
+	if (err) {
+		ocierofs_iostream_cleanup(oci_iostream);
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
+	ocierofs_iostream_cleanup(oci_iostream);
+	free(oci_iostream);
+
+	return err ?: err2;
+}
+
+/**
+ * erofsmount_overlay_from_mountpoints - Mount overlayfs from pre-mounted lowerdirs
+ * @layer_mountpoints: array of mountpoint paths for each layer
+ * @layer_count: number of layers
+ * @mountpoint: final mountpoint for the overlay
+ * @flags: mount flags
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int erofsmount_overlay_from_mountpoints(const char **layer_mountpoints, int layer_count,
+				   const char *mountpoint, int flags)
+{
+	char *workdir = NULL;
+	char *upperdir = NULL;
+	char *lowerdirs = NULL;
+	int i, ret = 0;
+
+	if (!layer_mountpoints || !layer_count || !mountpoint)
+		return -EINVAL;
+
+	for (i = 0; i < layer_count; i++) {
+		char *next = NULL;
+
+		if (!lowerdirs) {
+			if (asprintf(&next, "%s", layer_mountpoints[i]) < 0) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
+		} else {
+			if (asprintf(&next, "%s:%s", lowerdirs, layer_mountpoints[i]) < 0) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
+			free(lowerdirs);
+		}
+		lowerdirs = next;
+	}
+
+	if (asprintf(&workdir, "%s.work", mountpoint) < 0) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (asprintf(&upperdir, "%s.upper", mountpoint) < 0) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	if (mkdir(workdir, 0755) < 0 && errno != EEXIST) {
+		ret = -errno;
+		goto out_free;
+	}
+	if (mkdir(upperdir, 0755) < 0 && errno != EEXIST) {
+		ret = -errno;
+		goto out_free;
+	}
+
+	{
+		char *overlay_options = NULL;
+
+		if (asprintf(&overlay_options,
+			     "lowerdir=%s,upperdir=%s,workdir=%s",
+			     lowerdirs, upperdir, workdir) < 0) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+
+		ret = mount("overlay", mountpoint, "overlay", flags, overlay_options);
+		if (ret < 0)
+			ret = -errno;
+
+		free(overlay_options);
+	}
+
+out_free:
+	free(workdir);
+	free(upperdir);
+	free(lowerdirs);
+	return ret;
+}
+
+/**
+ * erofsmount_nbd_oci_one_layer - Mount single OCI layer using NBD
+ * @oci_ref: OCI image reference (digest)
+ * @oci: OCI client structure (pre-authenticated)
+ * @auth_header: pre-authenticated auth header
+ * @mountpoint: mount point path
+ * @fstype: filesystem type
+ * @flags: mount flags
+ * @options: mount options
+ * @layer_size: layer size in bytes
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int erofsmount_nbd_oci_one_layer(const char *oci_ref, struct erofs_oci *oci,
+					const char *auth_header, const char *mountpoint,
+					const char *fstype, int flags, const char *options,
+					u64 layer_size)
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
+	flags |= MS_RDONLY;
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
+		return erofsmount_startnbd_oci(nbdfd, oci_ref, oci, auth_header, layer_size) ?
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
+int erofsmount_nbd_oci(const char *source, const char *mountpoint,
+			  const char *fstype, int flags,
+			  const char *options)
+{
+	struct erofs_oci oci = {};
+	struct ocierofs_layer_info **layers = NULL;
+	int layer_count = 0;
+	char **layer_mountpoints = NULL;
+	int i, err;
+	char *auth_header = NULL;
+	char *manifest_digest = NULL;
+	bool using_basic = false;
+	int start_index = 0;
+	int mounted_count = 0;
+
+	err = ocierofs_init(&oci);
+	if (err)
+		goto exit;
+
+	err = ocierofs_parse_options(&oci, mountcfg.oci_options);
+	if (err)
+		goto out_oci_cleanup;
+
+	err = ocierofs_parse_ref(&oci, source);
+	if (err)
+		goto out_oci_cleanup;
+
+	err = ocierofs_prepare_layers(&oci, &auth_header, &using_basic,
+				     &manifest_digest, &layers, &layer_count, &start_index);
+	if (err < 0) {
+		erofs_err("Failed to get EROFS layers information: %s", erofs_strerror(err));
+		goto out_oci_cleanup;
+	}
+
+	if (layer_count > 0 && layers[0] && layers[0]->media_type) {
+		if (strcmp(layers[0]->media_type, EROFS_MEDIATYPE) != 0) {
+			err = -ENOENT;
+			goto out_oci_cleanup;
+		}
+	} else {
+		err = -ENOENT;
+		goto out_oci_cleanup;
+	}
+
+	layer_mountpoints = calloc(layer_count, sizeof(char *));
+	if (!layer_mountpoints) {
+		err = -ENOMEM;
+		goto out_auth_cleanup;
+	}
+
+	for (i = 0; i < layer_count; i++) {
+		if (layer_count == 1) {
+			layer_mountpoints[i] = strdup(mountpoint);
+		} else {
+			const char *dg = layers[i]->digest ? layers[i]->digest : "";
+			const char *hex = strchr(dg, ':') ? strchr(dg, ':') + 1 : dg;
+			char dg8[9];
+			int n = strlen(hex) < 8 ? (int)strlen(hex) : 8;
+
+			memcpy(dg8, hex, n);
+			dg8[n] = '\0';
+
+			if (asprintf(&layer_mountpoints[i], "%s.%s", mountpoint, dg8) == -1) {
+				err = -ENOMEM;
+				goto out_cleanup_mounts;
+			}
+		}
+
+		if (!layer_mountpoints[i]) {
+			err = -ENOMEM;
+			goto out_cleanup_mounts;
+		}
+
+		if (mkdir(layer_mountpoints[i], 0755) < 0 && errno != EEXIST) {
+			err = -errno;
+			goto out_cleanup_mounts;
+		}
+
+		err = erofsmount_nbd_oci_one_layer(layers[i]->digest, &oci, auth_header,
+						   layer_mountpoints[i], fstype, flags,
+						   options, layers[i]->size);
+		if (err)
+			goto out_cleanup_mounts;
+		mounted_count++;
+	}
+
+	if (layer_count > 1) {
+		err = erofsmount_overlay_from_mountpoints((const char **)layer_mountpoints,
+							layer_count, mountpoint, flags);
+		if (err)
+			goto out_cleanup_mounts;
+	}
+
+	for (i = 0; i < layer_count; i++) {
+		if (layer_mountpoints[i])
+			free(layer_mountpoints[i]);
+	}
+	free(layer_mountpoints);
+
+	ocierofs_free_layers_info(layers, layer_count);
+	free(manifest_digest);
+	free(auth_header);
+	if (using_basic)
+		ocierofs_curl_clear_auth(oci.curl);
+
+	ocierofs_cleanup(&oci);
+	return 0;
+
+out_auth_cleanup:
+	free(manifest_digest);
+	free(auth_header);
+	if (using_basic)
+		ocierofs_curl_clear_auth(oci.curl);
+
+out_cleanup_mounts:
+	if (layer_mountpoints) {
+		for (i = mounted_count - 1; i >= 0; i--) {
+			if (layer_mountpoints[i])
+				umount(layer_mountpoints[i]);
+		}
+		for (i = 0; i < layer_count; i++) {
+			if (layer_mountpoints[i]) {
+				rmdir(layer_mountpoints[i]);
+				free(layer_mountpoints[i]);
+			}
+		}
+		free(layer_mountpoints);
+	}
+
+	if (layers)
+		ocierofs_free_layers_info(layers, layer_count);
+
+	free(manifest_digest);
+	free(auth_header);
+	if (using_basic)
+		ocierofs_curl_clear_auth(oci.curl);
+
+out_oci_cleanup:
+	ocierofs_cleanup(&oci);
+exit:
+	erofs_err("OCI NBD mount failed with error: %s", erofs_strerror(err));
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
@@ -529,9 +903,21 @@ int main(int argc, char *argv[])
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
+#ifdef OCIEROFS_ENABLED
+		if (mountcfg.use_oci) {
+			err = erofsmount_nbd_oci(mountcfg.device, mountcfg.mountpoint,
+						 mountcfg.fstype, mountcfg.flags,
+						 mountcfg.options);
+		} else {
+			err = erofsmount_nbd(mountcfg.device, mountcfg.mountpoint,
+					     mountcfg.fstype, mountcfg.flags,
+					     mountcfg.options);
+		}
+#else
 		err = erofsmount_nbd(mountcfg.device, mountcfg.mountpoint,
 				     mountcfg.fstype, mountcfg.flags,
 				     mountcfg.options);
+#endif
 		goto exit;
 	}
 
-- 
2.51.0


