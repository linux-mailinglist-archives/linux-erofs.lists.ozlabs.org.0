Return-Path: <linux-erofs+bounces-1130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6342BA6ECC
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 12:15:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZKw41dTHz3cYr;
	Sun, 28 Sep 2025 20:15:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.88
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759054548;
	cv=none; b=TY7kRxaTR7OMdYpSmprkPG3QSUs7vfgJokT3ZPikzoYbyXhXeHWEJdkc6/E/3+kwdWD3ChNa/YM1KqK6nRSRHUEA6CZzI2WNyn8Vy6/12rOJXd1x72OH1b5ANHawsR39rmUZdG9So5f2ZpSxufcrSBRVRnFjGje55gW3NkTTUT0/ewgGd+38eKolhFVzTLUCwOWjjHq2TCCp298xmvkBdalC7MFUxVjcW2GRSXHC0Pp1komHPFQarhe1FDutPVkRnUueVdHj6lFri5c3odJ0wg6+LsW7BmqzNNdSnepmPYCZ0uCXjb+gQ24INko+SyMMdht28zy4R557ul5J8tDZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759054548; c=relaxed/relaxed;
	bh=jRACRoTG1vpIrUL/Fd+WlnFPkBsGix46yOqu3FHmNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9CBHHFgwuXarJkXghYFhv/3bK+9zUkIn3fQxKZuvgVM0JSAoDus7CekgxqFS4nWW9NxQgev9BSetj8wR1/e5ESGYummESGRJg6QrYf51DWx5UCVVZqI9N/DvR/+Xg7rHy2oz/14nN9rswnQNvGdxfzqcGMrtFh4161YN7zK8wCMoakkBzNYSVisN7vorgyyLyVdYxtIbEC3KohY2hQX1i/gGUgkRmQfdSgRS4u+kNJWOQYkjdO43oz3dw5/gI0ZZVeRf4uTdUkGtEPNk1j+H2GNmF86YWwdt595daDtgHvZGBap4AizecEH9sbK1G2+hqGi5bHgPIN1Rue6CH47RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-88.mail.aliyun.com (out28-88.mail.aliyun.com [115.124.28.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZKw23Q2Zz302l
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 20:15:44 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.ep8Ba.i_1759054532 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 18:15:33 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v4] erofs-utils: mount: add support for standard OCI targz blob access
Date: Sun, 28 Sep 2025 18:15:30 +0800
Message-ID: <20250928101530.13744-1-hudson@cyzhu.com>
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
through a new source mechanism. This allows local metadata
storage while keeping OCI tgz blob data in remote registries

e.g.:
 $ mkfs.erofs --tar=i --gzinfo=ubuntu.zinfo ubuntu.erofs \
   13b7e9....tgz

 $ mount.erofs -t erofs.nbd -o oci.blob=13b7e9..., \
    oci.platform=linux/amd64,oci.tarindex=ubuntu.erofs, \
    oci.zinfo=ubuntu.zinfo ubuntu:20.04 mnt

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_oci.h |   2 +
 lib/remotes/oci.c  |  20 ---
 mount/main.c       | 378 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 371 insertions(+), 29 deletions(-)

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
index eb0dd01..3911031 100644
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
@@ -332,6 +355,256 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
 	return 0;
 }
 
+struct erofsmount_tarindex_priv {
+	struct erofs_vfile tarindex_vf;
+	struct erofs_vfile *zinfo_vf;
+	u64 tarindex_size;
+};
+
+static ssize_t erofsmount_tarindex_pread(struct erofs_vfile *vf, void *buf,
+					 size_t count, u64 offset)
+{
+	struct erofsmount_tarindex_priv *tp;
+	ssize_t local_read = 0, remote_read = 0;
+	u64 index_part, tardata_part, remote_offset;
+
+	tp = *(struct erofsmount_tarindex_priv **)vf->payload;
+	DBG_BUGON(!tp);
+
+	/* Handle device boundary probe requests */
+	if (offset >= EROFSMOUNT_NBD_DISK_SIZE)
+		return 0;
+
+	if (offset > tp->tarindex_size) {
+		remote_offset = offset - tp->tarindex_size;
+		index_part = 0;
+	} else {
+		index_part = min(count, tp->tarindex_size - offset);
+		remote_offset = 0;
+	}
+	tardata_part = count - index_part;
+	if (index_part) {
+		local_read = erofs_io_pread(&tp->tarindex_vf, buf,
+					    index_part, offset);
+		if (local_read < 0)
+			return local_read;
+	}
+	if (tardata_part) {
+		remote_read = erofs_io_pread(tp->zinfo_vf, buf + local_read,
+					     tardata_part, remote_offset);
+		if (remote_read < 0)
+			return remote_read;
+	}
+	return local_read + remote_read;
+}
+
+static void erofsmount_tarindex_close(struct erofs_vfile *vf)
+{
+	struct erofsmount_tarindex_priv *tp;
+
+	tp = *(struct erofsmount_tarindex_priv **)vf->payload;
+	DBG_BUGON(!tp);
+
+	if (tp->tarindex_size > 0)
+		erofs_io_close(&tp->tarindex_vf);
+	if (tp->zinfo_vf)
+		erofs_io_close(tp->zinfo_vf);
+	free(tp);
+}
+
+static ssize_t erofsmount_tarindex_sendfile(struct erofs_vfile *vout,
+					    struct erofs_vfile *vin,
+					    off_t *pos, size_t count)
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
+		ret = erofsmount_tarindex_pread(vin, buf, to_read, read_offset);
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
+	.pread = erofsmount_tarindex_pread,
+	.sendfile = erofsmount_tarindex_sendfile,
+	.close = erofsmount_tarindex_close,
+};
+
+static int load_file_to_buf(const char *path, void **out, unsigned int *out_len)
+{
+	void *buf = NULL;
+	FILE *fp;
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
+	rewind(fp);
+	if (!sz) {
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
+	*out = buf;
+	*out_len = (unsigned int)sz;
+	buf = NULL;
+out:
+	if (ret < 0 && buf)
+		free(buf);
+	fclose(fp);
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
+/*
+ * Create tarindex source for gzran+oci hybrid mode with three scenarios:
+ * 1. tarindex + zinfo: Remote data is tar.gzip format
+ * 2. tarindex only: Remote data is tar format
+ */
+static int erofsmount_tarindex_open(struct erofs_vfile *out_vf,
+				    const struct ocierofs_config *oci_cfg,
+				    const char *tarindex_path,
+				    const char *zinfo_path)
+{
+	struct erofsmount_tarindex_priv *tp;
+	int err;
+	struct stat st;
+	struct erofs_vfile *vf;
+
+	tp = calloc(1, sizeof(*tp));
+	if (!tp)
+		return -ENOMEM;
+	vf = &tp->tarindex_vf;
+	vf->fd = -1;
+
+	if (tarindex_path) {
+		err = open(tarindex_path, O_RDONLY);
+		if (err < 0) {
+			err = -errno;
+			goto err_out;
+		}
+		vf->fd = err;
+		if (fstat(vf->fd, &st) < 0) {
+			err = -errno;
+			goto err_out;
+		}
+		tp->tarindex_size = st.st_size;
+	}
+
+	err = erofsmount_init_gzran(&tp->zinfo_vf, oci_cfg, zinfo_path);
+	if (err)
+		goto err_out;
+	out_vf->ops = &tarindex_vfile_ops;
+	out_vf->fd = 0;
+	out_vf->offset = 0;
+	*(struct erofsmount_tarindex_priv **)out_vf->payload = tp;
+	return 0;
+
+err_out:
+	if (vf->fd >= 0)
+		close(vf->fd);
+	free(tp);
+	return err;
+}
+
 struct erofsmount_nbd_ctx {
 	struct erofs_vfile vd;		/* virtual device */
 	struct erofs_vfile sk;		/* socket file */
@@ -388,9 +661,17 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
 	int err, err2;
 
 	if (source->type == EROFSNBD_SOURCE_OCI) {
-		err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-		if (err)
-			goto out_closefd;
+		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
+						       source->ocicfg.tarindex_path,
+						       source->ocicfg.zinfo_path);
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
@@ -400,7 +681,7 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
 		ctx.vd.fd = err;
 	}
 
-	err = erofs_nbd_connect(nbdfd, 9, INT64_MAX >> 9);
+	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
 	if (err < 0) {
 		erofs_io_close(&ctx.vd);
 		goto out_closefd;
@@ -440,6 +721,19 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
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
@@ -635,6 +929,60 @@ static int erofsmount_reattach_oci(struct erofs_vfile *vf,
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
+	if (token_count > 3 && tokens[3] && *tokens[3])
+		meta_path = tokens[3];
+	if (token_count > 4 && tokens[4] && *tokens[4])
+		zinfo_path = tokens[4];
+
+	err = erofsmount_tarindex_open(&ctx->vd, &oci_cfg,
+				       meta_path, zinfo_path);
+	free(oci_cfg.image_ref);
+	erofs_io_close(&temp_vd);
+	return err;
+}
+
 static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 {
 	char *newrecp;
@@ -679,9 +1027,17 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 			exit(EXIT_FAILURE);
 
 		if (source->type == EROFSNBD_SOURCE_OCI) {
-			err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-			if (err)
-				exit(EXIT_FAILURE);
+			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
+							       source->ocicfg.tarindex_path,
+							       source->ocicfg.zinfo_path);
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
@@ -695,7 +1051,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 		}
 
 		num = -1;
-		err = erofs_nbd_nl_connect(&num, 9, INT64_MAX >> 9, recp);
+		err = erofs_nbd_nl_connect(&num, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
 		if (err >= 0) {
 			ctx.sk.fd = err;
 			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
@@ -794,6 +1150,10 @@ static int erofsmount_reattach(const char *target)
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


