Return-Path: <linux-erofs+bounces-1129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBDBA6D42
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 11:25:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZJp158Y1z3cYr;
	Sun, 28 Sep 2025 19:25:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759051529;
	cv=none; b=TkCujb1pWnx1YRxsTR/SW8Ugrkl1ibvMkAmY3sASzOUCPmcIr5kgdD0yjkqhRFxAVenRN14zvrqklu/rFZ4EaJDV7iZg1p7wLVO15KNV03qX3ljZov3ks4YaxeeFyg2NJRMXqqBmOqzF4cgF4BEFOmwF8vAlzYcM0Lsv2eBGFhLFANIO1xmEWnRH972YtVVwBK89FHIftYUh53SWL91aw70aaCCOwx9r9UF/isEBtm4gyGNs1JjzWtLFwevdGC9qe6EResAxt8TkVCChP+4iqOo8wBWdGYhSSMUT011dUyWvvewJ6qN/uScvPbWzK6om7ThJ2v77YY6SB3qF8zub0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759051529; c=relaxed/relaxed;
	bh=WKePfj5SrfPdkXadbFEEoSc9zVou0vyorErsgp3W44o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW/yiI15Up5Wu7H3dukNPuqsr2nMC0bzaDU6tX5FlxNeHsvYiN6/Njo7dUA1ClFhKwYb8AWuQzCvTxNLO+ul5ELESx/sW7921fUBTjmA9wWO7trx3ueYv1ICoMbCW16B48Xlzoq4BgwCDHMQ388+28W3xnsm+o++PjVgn9Y0GKupVY+gFWzs/H/rMuGoZ+x30ctLB1DuXXawg1NuGd39ShHXNykYd5qwp7LBiX+LnwcbtzRvkUffh+mru82eZCokXF2h4+qtG9+DTBAsV66J8gJYeQJc9C17eJ5i7OgQTJxhTndFXuUC7F8mJR+e7qbyAvtNnWNO+mPIWsXh/AagwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.42; helo=out28-42.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.42; helo=out28-42.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZJp00V2Pz3cYR
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 19:25:25 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.ep8GRB1_1759051519 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 17:25:20 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3-changed] erofs-utils: add source support for tarindex and gzran
Date: Sun, 28 Sep 2025 17:25:18 +0800
Message-ID: <20250928092518.83524-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928033957.23867-1-hudson@cyzhu.com>
References: <20250928033957.23867-1-hudson@cyzhu.com>
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

Add support for combining tarindex files with remote OCI blobs
through a new source mechanism. This enables local metadata
storage while keeping blob data in remote registries.

e.g.:
$ mkfs.erofs --tar=i --gzinfo=tmp/ubuntu.zinfo tmp/ubuntu.erofs \
13b7e9....tar.gzip

$ mount.erofs -t erofs.nbd -o \
'oci.blob=13b7e9...,oci.platform=linux/amd64,\
oci.tarindex=ubuntu.erofs,oci.zinfo=ubuntu.zinfo' \
ubuntu:20.04 /mnt

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |   2 +
 lib/remotes/oci.c  |  20 ---
 mount/main.c       | 407 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 400 insertions(+), 29 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 71c8879..5298f18 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -35,6 +35,8 @@ struct ocierofs_config {
 	char *password;
 	char *blob_digest;
 	int layer_index;
+	char *tarindex_path;
+	char *zinfo_path;
 };
 
 struct ocierofs_layer_info {
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index b2f1f59..b25e0b2 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1461,19 +1461,6 @@ static void ocierofs_io_close(struct erofs_vfile *vfile)
 	*(struct ocierofs_iostream **)vfile->payload = NULL;
 }
 
-static int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx)
-{
-	if (ctx->layer_count > 0 && ctx->layers[0] &&
-	    ctx->layers[0]->media_type) {
-		const char *media_type = ctx->layers[0]->media_type;
-		size_t len = strlen(media_type);
-
-		if (len >= 6 && strcmp(media_type + len - 6, ".erofs") == 0)
-			return 0;
-	}
-	return -ENOENT;
-}
-
 static struct erofs_vfops ocierofs_io_vfops = {
 	.pread = ocierofs_io_pread,
 	.read = ocierofs_io_read,
@@ -1497,13 +1484,6 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 		return err;
 	}
 
-	err = ocierofs_is_erofs_native_image(ctx);
-	if (err) {
-		ocierofs_ctx_cleanup(ctx);
-		free(ctx);
-		return err;
-	}
-
 	oci_iostream = calloc(1, sizeof(*oci_iostream));
 	if (!oci_iostream) {
 		ocierofs_ctx_cleanup(ctx);
diff --git a/mount/main.c b/mount/main.c
index eb0dd01..47e0db3 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -16,6 +16,8 @@
 #include "erofs/io.h"
 #include "../lib/liberofs_nbd.h"
 #include "../lib/liberofs_oci.h"
+#include "../lib/liberofs_gzran.h"
+
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
 #else
@@ -35,6 +37,9 @@ struct loop_info {
 #include <sys/sysmacros.h>
 #endif
 
+/* Device boundary probe */
+#define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)
+
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
@@ -141,7 +146,25 @@ static int erofsmount_parse_oci_option(const char *option)
 						if (!oci_cfg->password)
 							return -ENOMEM;
 					} else {
-						return -EINVAL;
+						p = strstr(option, "oci.tarindex=");
+						if (p != NULL) {
+							p += strlen("oci.tarindex=");
+							free(oci_cfg->tarindex_path);
+							oci_cfg->tarindex_path = strdup(p);
+							if (!oci_cfg->tarindex_path)
+								return -ENOMEM;
+						} else {
+							p = strstr(option, "oci.zinfo=");
+							if (p != NULL) {
+								p += strlen("oci.zinfo=");
+								free(oci_cfg->zinfo_path);
+								oci_cfg->zinfo_path = strdup(p);
+								if (!oci_cfg->zinfo_path)
+									return -ENOMEM;
+							} else {
+								return -EINVAL;
+							}
+						}
 					}
 				}
 			}
@@ -332,11 +355,289 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
 	return 0;
 }
 
+struct erofsmount_tarindex_source {
+	struct erofs_vfile *tarindex_vf;
+	struct erofs_vfile *zinfo_vf;
+	u64 tarindex_size;
+};
+
 struct erofsmount_nbd_ctx {
 	struct erofs_vfile vd;		/* virtual device */
 	struct erofs_vfile sk;		/* socket file */
 };
 
+static ssize_t erofs_tarindex_pread(struct erofs_vfile *vf, void *buf,
+				  size_t count, u64 offset)
+{
+	struct erofsmount_tarindex_source *hs;
+	ssize_t local_read, remote_read;
+	u64 index_part, tardata_part, remote_offset;
+
+	hs = *(struct erofsmount_tarindex_source **)vf->payload;
+	if (!hs)
+		return -EINVAL;
+
+	/* Handle device boundary probe requests */
+	if (offset >= EROFSMOUNT_NBD_DISK_SIZE)
+		return 0;
+
+	if (offset >= hs->tarindex_size) {
+		remote_offset = offset - hs->tarindex_size;
+
+		return hs->zinfo_vf->ops->pread(hs->zinfo_vf, buf, count, remote_offset);
+	}
+
+	if (offset + count <= hs->tarindex_size)
+		return erofs_io_pread(hs->tarindex_vf, buf, count, offset);
+
+	index_part = hs->tarindex_size - offset;
+	tardata_part = count - index_part;
+
+	local_read = erofs_io_pread(hs->tarindex_vf, buf, index_part, offset);
+	if (local_read < 0)
+		return local_read;
+
+	remote_read = hs->zinfo_vf->ops->pread(hs->zinfo_vf,
+					      (char *)buf + local_read,
+					      tardata_part, 0);
+	if (remote_read < 0)
+		return remote_read;
+	return local_read + remote_read;
+}
+
+static void erofs_tarindex_close(struct erofs_vfile *vf)
+{
+	struct erofsmount_tarindex_source *hs;
+
+	if (!vf)
+		return;
+
+	hs = *(struct erofsmount_tarindex_source **)vf->payload;
+	if (!hs)
+		return;
+
+	if (hs->tarindex_size > 0) {
+		erofs_io_close(hs->tarindex_vf);
+		free(hs->tarindex_vf);
+	}
+
+	if (hs->zinfo_vf)
+		erofs_io_close(hs->zinfo_vf);
+
+	free(hs);
+}
+
+static int load_file_to_buf(const char *path, void **out, unsigned int *out_len)
+{
+	FILE *fp = NULL;
+	void *buf = NULL;
+	int ret = 0;
+	long sz;
+	size_t num;
+
+	fp = fopen(path, "rb");
+	if (!fp)
+		return -errno;
+
+	if (fseek(fp, 0, SEEK_END) != 0) {
+		ret = -errno;
+		goto out;
+	}
+	sz = ftell(fp);
+	if (sz < 0) {
+		ret = -errno;
+		goto out;
+	}
+	if (fseek(fp, 0, SEEK_SET) != 0) {
+		ret = -errno;
+		goto out;
+	}
+	if (sz == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf = malloc((size_t)sz);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	num = fread(buf, 1, (size_t)sz, fp);
+	if (num != (size_t)sz) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*out = buf;
+	*out_len = (unsigned int)sz;
+	buf = NULL;
+
+out:
+	if (fp)
+		fclose(fp);
+	if (ret < 0 && buf)
+		free(buf);
+	return ret;
+}
+
+static int erofsmount_init_gzran(struct erofs_vfile **zinfo_vf,
+				  const struct ocierofs_config *oci_cfg,
+				  const char *zinfo_path)
+{
+	int err = 0;
+	void *zinfo_data = NULL;
+	unsigned int zinfo_len = 0;
+	struct erofs_vfile *oci_vf = NULL;
+
+	oci_vf = malloc(sizeof(*oci_vf));
+	if (!oci_vf) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	err = ocierofs_io_open(oci_vf, oci_cfg);
+	if (err) {
+		free(oci_vf);
+		goto cleanup;
+	}
+
+	/* If no zinfo_path, return oci_vf directly for tar format */
+	if (!zinfo_path) {
+		*zinfo_vf = oci_vf;
+		return 0;
+	}
+
+	err = load_file_to_buf(zinfo_path, &zinfo_data, &zinfo_len);
+	if (err) {
+		erofs_io_close(oci_vf);
+		free(oci_vf);
+		return err;
+	}
+
+	*zinfo_vf = erofs_gzran_zinfo_open(oci_vf, zinfo_data, zinfo_len);
+	if (IS_ERR(*zinfo_vf)) {
+		err = PTR_ERR(*zinfo_vf);
+		*zinfo_vf = NULL;
+		erofs_io_close(oci_vf);
+		free(oci_vf);
+		goto cleanup;
+	}
+
+	free(zinfo_data);
+	return 0;
+
+cleanup:
+	if (zinfo_data)
+		free(zinfo_data);
+	return err;
+}
+
+static ssize_t erofs_tarindex_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+				      off_t *pos, size_t count)
+{
+	static char buf[32768];
+	ssize_t total_written = 0, ret = 0, written;
+	size_t to_read;
+	u64 read_offset;
+
+	while (count > 0) {
+		to_read = min_t(size_t, count, sizeof(buf));
+		read_offset = pos ? *pos : 0;
+
+		ret = erofs_tarindex_pread(vin, buf, to_read, read_offset);
+		if (ret <= 0) {
+			if (ret < 0 && total_written == 0)
+				return ret;
+			break;
+		}
+
+		written = __erofs_io_write(vout->fd, buf, ret);
+		if (written < 0) {
+			ret = -errno;
+			break;
+		}
+		if (written != ret)
+			ret = written;
+
+		total_written += ret;
+		count -= ret;
+		if (pos)
+			*pos += ret;
+	}
+	return count;
+}
+
+static struct erofs_vfops tarindex_vfile_ops = {
+	.pread = erofs_tarindex_pread,
+	.sendfile = erofs_tarindex_sendfile,
+	.close = erofs_tarindex_close,
+};
+
+/*
+ * Create tarindex source for gzran+oci hybrid mode with three scenarios:
+ * 1. tarindex + zinfo: Remote data is tar.gzip format
+ * 2. tarindex only: Remote data is tar format
+ */
+static int erofs_create_tarindex_source(struct erofs_vfile *out_vf,
+				      const struct ocierofs_config *oci_cfg,
+				      const char *tarindex_path,
+				      const char *zinfo_path)
+{
+	struct erofsmount_tarindex_source *hs;
+	int err;
+	struct stat st;
+	struct erofs_vfile *vf;
+
+	hs = calloc(1, sizeof(*hs));
+	if (!hs)
+		return -ENOMEM;
+
+	if (tarindex_path) {
+		hs->tarindex_vf = malloc(sizeof(*hs->tarindex_vf));
+		if (!hs->tarindex_vf) {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+
+		vf = hs->tarindex_vf;
+		vf->fd = open(tarindex_path, O_RDONLY);
+		if (vf->fd < 0) {
+			err = -errno;
+			goto cleanup;
+		}
+
+		vf->ops = NULL;
+		vf->offset = 0;
+
+		if (fstat(vf->fd, &st) < 0) {
+			err = -errno;
+			goto cleanup;
+		}
+		hs->tarindex_size = st.st_size;
+	}
+
+	err = erofsmount_init_gzran(&hs->zinfo_vf, oci_cfg, zinfo_path);
+	if (err)
+		goto cleanup;
+
+	out_vf->ops = &tarindex_vfile_ops;
+	out_vf->fd = 0;
+	out_vf->offset = 0;
+	*(struct erofsmount_tarindex_source **)out_vf->payload = hs;
+
+	return 0;
+cleanup:
+	if (tarindex_path && hs->tarindex_vf) {
+		vf = hs->tarindex_vf;
+		if (vf->fd >= 0)
+			close(vf->fd);
+	}
+	free(hs->tarindex_vf);
+	free(hs);
+	return err;
+}
+
 static void *erofsmount_nbd_loopfn(void *arg)
 {
 	struct erofsmount_nbd_ctx *ctx = arg;
@@ -388,9 +689,17 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
 	int err, err2;
 
 	if (source->type == EROFSNBD_SOURCE_OCI) {
-		err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-		if (err)
-			goto out_closefd;
+		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+			err = erofs_create_tarindex_source(&ctx.vd, &source->ocicfg,
+							source->ocicfg.tarindex_path,
+							source->ocicfg.zinfo_path);
+			if (err)
+				goto out_closefd;
+		} else {
+			err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
+			if (err)
+				goto out_closefd;
+		}
 	} else {
 		err = open(source->device_path, O_RDONLY);
 		if (err < 0) {
@@ -400,7 +709,7 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
 		ctx.vd.fd = err;
 	}
 
-	err = erofs_nbd_connect(nbdfd, 9, INT64_MAX >> 9);
+	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
 	if (err < 0) {
 		erofs_io_close(&ctx.vd);
 		goto out_closefd;
@@ -440,6 +749,19 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 			return PTR_ERR(b64cred);
 	}
 
+	if ((source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) &&
+	    source->ocicfg.blob_digest && *source->ocicfg.blob_digest) {
+		ret = fprintf(f, "TARINDEX_OCI_BLOB %s %s %s %s %s %s\n",
+			      source->ocicfg.image_ref ?: "",
+			      source->ocicfg.platform ?: "",
+			      source->ocicfg.blob_digest,
+			      b64cred ?: "",
+			      source->ocicfg.tarindex_path ?: "",
+			      source->ocicfg.zinfo_path ?: "");
+		free(b64cred);
+		return ret < 0 ? -ENOMEM : 0;
+	}
+
 	if (source->ocicfg.blob_digest && *source->ocicfg.blob_digest) {
 		ret = fprintf(f, "OCI_NATIVE_BLOB %s %s %s %s\n",
 			      source->ocicfg.image_ref ?: "",
@@ -635,6 +957,61 @@ static int erofsmount_reattach_oci(struct erofs_vfile *vf,
 }
 #endif
 
+static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
+					 char *source)
+{
+	char *tokens[6] = {0}, *p = source, *space, *oci_source;
+	char *meta_path = NULL, *zinfo_path = NULL;
+	int token_count = 0, err;
+	const char *b64cred;
+	struct erofs_vfile temp_vd;
+	struct ocierofs_config oci_cfg = {};
+
+	while (token_count < 5) {
+		space = strchr(p, ' ');
+		if (!space)
+			break;
+
+		*space = '\0';
+		p = space + 1;
+		tokens[token_count++] = p;
+	}
+
+	if (token_count < 4)
+		return -EINVAL;
+
+	b64cred = (token_count > 2 && tokens[2]) ? tokens[2] : "";
+
+	err = asprintf(&oci_source, "%s %s %s %s",
+		       source, tokens[0], tokens[1], b64cred);
+	if (err < 0)
+		return -ENOMEM;
+
+	err = erofsmount_reattach_oci(&ctx->vd, "OCI_NATIVE_BLOB", oci_source);
+	free(oci_source);
+	if (err)
+		return err;
+
+	temp_vd = ctx->vd;
+	oci_cfg.image_ref = strdup(source);
+	if (!oci_cfg.image_ref) {
+		erofs_io_close(&temp_vd);
+		return -ENOMEM;
+	}
+
+	if (token_count > 3 && tokens[3] && strlen(tokens[3]) > 0)
+		meta_path = tokens[3];
+	if (token_count > 4 && tokens[4] && strlen(tokens[4]) > 0)
+		zinfo_path = tokens[4];
+
+	err = erofs_create_tarindex_source(&ctx->vd, &oci_cfg,
+					meta_path, zinfo_path);
+	free(oci_cfg.image_ref);
+	erofs_io_close(&temp_vd);
+
+	return err;
+}
+
 static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 {
 	char *newrecp;
@@ -679,9 +1056,17 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 			exit(EXIT_FAILURE);
 
 		if (source->type == EROFSNBD_SOURCE_OCI) {
-			err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-			if (err)
-				exit(EXIT_FAILURE);
+			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+				err = erofs_create_tarindex_source(&ctx.vd, &source->ocicfg,
+								source->ocicfg.tarindex_path,
+								source->ocicfg.zinfo_path);
+				if (err)
+					exit(EXIT_FAILURE);
+			} else {
+				err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
+				if (err)
+					exit(EXIT_FAILURE);
+			}
 		} else {
 			err = open(source->device_path, O_RDONLY);
 			if (err < 0)
@@ -695,7 +1080,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 		}
 
 		num = -1;
-		err = erofs_nbd_nl_connect(&num, 9, INT64_MAX >> 9, recp);
+		err = erofs_nbd_nl_connect(&num, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
 		if (err >= 0) {
 			ctx.sk.fd = err;
 			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
@@ -794,6 +1179,10 @@ static int erofsmount_reattach(const char *target)
 			goto err_line;
 		}
 		ctx.vd.fd = err;
+	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
+		err = erofsmount_reattach_gzran_oci(&ctx, source);
+		if (err)
+			goto err_line;
 	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
 		err = erofsmount_reattach_oci(&ctx.vd, line, source);
 		if (err)
-- 
2.51.0


