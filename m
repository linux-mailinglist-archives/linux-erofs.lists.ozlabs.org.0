Return-Path: <linux-erofs+bounces-350-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162AABF0B3
	for <lists+linux-erofs@lfdr.de>; Wed, 21 May 2025 12:03:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b2Rp81dPvz3bxL;
	Wed, 21 May 2025 20:03:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747821824;
	cv=none; b=GKvB0TPDB2yuTwlsB4ouxPjv9Q9/n5nKFoH0GzuBQXBp2X5sH/muktIBaYsS1eXNBo36QpF8my7bW7YT1XYsKnt7B67tqMH+igWSkPc5CS7axPjir8aRQnRpjdvdPjplba1lNUDGJkNAMBBHXF0CKwPlumGqUx9ZMsNkzNdS6FpSg2vmWRRxD2ZkGwFme+8j+LfYwV6/++qWr1kP1XHPcO6ohjxgbhmdHUCsDBeQoTS+VcNrsm40TsZW2/GJbjrS1pa+S4oenmJGPEva5sisqY3eqLqpHsLe2tNkIWBn9uoe0nrIF8aR2B5AUxif82ZGWLwTbYUFv7HUprfFiwt8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747821824; c=relaxed/relaxed;
	bh=kuAQeZ6nxWNWh2iDG6R4yw8ZJ6kS+bopttR0Cx3ixyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy8Umf236H5zgk/wA+iI2m+bAF7HdSqjH4EBnvTXPlTXgfdgEKbSxuIMaU6r1/lH4kl5ItCPadPoOEJzVz/nZcO+4CG7HY7FrRtYmCpJp/DhP5Zf+sZRA7WwCH/fAmLo1xmcF8DxoOiiXvi0LanV/TtTFhaR2iQQll3y+dSObYIBUGzcUVZsCrDUc6Ukth+0bbuBDazY4VunDNHe3DYvAb+KrCfx5zFExrm2g17UxIQx+zyqfpg4F9zeMKiqd33+hqvnL8uEAsyXl6418hx4NWdWPB8KLaaPztkx8/rELh1GxmeXSTf4uyCI95INrWFYvrssRrnbcK1lwtPbvu/x6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gowcfBLn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gowcfBLn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b2Rp56rNCz3bx5
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 May 2025 20:03:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747821815; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kuAQeZ6nxWNWh2iDG6R4yw8ZJ6kS+bopttR0Cx3ixyA=;
	b=gowcfBLnSuFGGI3FYO1SmaXlkdiwDoQMz1Rvb/bxjiZpBFqhkCL5wE6XAjnAHq+tA/I0RY13T1o+ek1FNB+RQwehQHQgVN+/VPBMG4tNtLw6lYh5Gczypm8ADhaf2VPJwku0OWYiweRe0vJ0DqbMbeDTwca8xhK2CMXfyO0B3VE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbRHrq9_1747821807 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 18:03:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH UNTESTED v4] erofs: support DEFLATE decompression by using Intel QAT
Date: Wed, 21 May 2025 18:03:26 +0800
Message-ID: <20250521100326.2867828-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250516082634.3801-1-liubo03@inspur.com>
References: <20250516082634.3801-1-liubo03@inspur.com>
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

From: Bo Liu <liubo03@inspur.com>

This patch introduces the use of the Intel QAT to offload data compression
in the EROFS filesystem, aiming to improve the decompression performance.

A 285MiB dataset is used with the following command to create EROFS images
with different cluster sizes:
     $ mkfs.erofs -zdeflate,level=9 -C16384

Fio is used to test the following read patterns:
     # fio -filename=testfile  -bs=4k -rw=read -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1

Here are some performance numbers for reference:

Processors: Intel(R) Xeon(R) 6766E(144 core)
Memory:     521 GiB

|-----------------------------------------------------------------------------|
|           | Cluster size | sequential read | randread  | small randread(5%) |
|-----------|--------------|-----------------|-----------|--------------------|
| Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
| Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
| Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
| Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
| Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
| deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
| deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
| deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
| deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
| deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |

Signed-off-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
Hi Bo,
Please test/refine this version and complete sysfs documentation.

Thanks,
Gao Xiang


 fs/erofs/Kconfig                |  14 +++
 fs/erofs/Makefile               |   1 +
 fs/erofs/compress.h             |  10 ++
 fs/erofs/decompressor_crypto.c  | 184 ++++++++++++++++++++++++++++++++
 fs/erofs/decompressor_deflate.c |  20 +++-
 fs/erofs/sysfs.c                |  35 +++++-
 fs/erofs/zdata.c                |   1 +
 7 files changed, 260 insertions(+), 5 deletions(-)
 create mode 100644 fs/erofs/decompressor_crypto.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 8f68ec49ad89..6beeb7063871 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -144,6 +144,20 @@ config EROFS_FS_ZIP_ZSTD
 
 	  If unsure, say N.
 
+config EROFS_FS_ZIP_ACCEL
+	bool "EROFS hardware decompression support"
+	depends on EROFS_FS_ZIP
+	help
+	  Saying Y here includes hardware accelerator support for reading
+	  EROFS file systems containing compressed data.  It gives better
+	  decompression speed than the software-implemented decompression, and
+	  it costs lower CPU overhead.
+
+	  Hardware accelerator support is an experimental feature for now and
+	  file systems are still readable without selecting this option.
+
+	  If unsure, say N.
+
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109..549abc424763 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,5 +7,6 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
+erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 2704d7a592a5..2bea4097e0b4 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -76,4 +76,14 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
 int __init z_erofs_init_decompressor(void);
 void z_erofs_exit_decompressor(void);
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+			      struct page **pgpl);
+int z_erofs_crypto_enable_engine(const char *name, int len);
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+void z_erofs_crypto_disable_all_engines(void);
+int z_erofs_crypto_show_engines(char *buf, int size, char sep);
+#else
+static inline void z_erofs_crypto_disable_all_engines(void) {}
+static inline int z_erofs_crypto_show_engines(char *buf, int size, char sep) {}
+#endif
 #endif
diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
new file mode 100644
index 000000000000..ba0f46f6ef12
--- /dev/null
+++ b/fs/erofs/decompressor_crypto.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
+#include "compress.h"
+
+static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+				       struct crypto_acomp *tfm)
+{
+	struct sg_table st_src, st_dst;
+	struct acomp_req *req;
+	struct crypto_wait wait;
+	u8 *headpage;
+	int ret;
+
+	headpage = kmap_local_page(*rq->in);
+	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+				min_t(unsigned int, rq->inputsize,
+							rq->sb->s_blocksize - rq->pageofs_in));
+	kunmap_local(headpage);
+	if (ret)
+		return ret;
+
+	req = acomp_request_alloc(tfm);
+	if (!req) {
+		erofs_err(rq->sb, "failed to alloc decompress request");
+		return -ENOMEM;
+	}
+
+	ret = sg_alloc_table_from_pages_segment(&st_src, rq->in, rq->inpages,
+			rq->pageofs_in, rq->inputsize, UINT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto failed_src_alloc;
+
+	ret = sg_alloc_table_from_pages_segment(&st_dst, rq->out, rq->outpages,
+			rq->pageofs_out, rq->outputsize, UINT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto failed_dst_alloc;
+
+	acomp_request_set_params(req, st_src.sgl,
+				 st_dst.sgl, rq->inputsize, rq->outputsize);
+
+	crypto_init_wait(&wait);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+	if (ret) {
+		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+			  ret, rq->inputsize, rq->pageofs_in, rq->outputsize);
+		ret = -EIO;
+	}
+
+	sg_free_table(&st_dst);
+failed_dst_alloc:
+	sg_free_table(&st_src);
+failed_src_alloc:
+	acomp_request_free(req);
+	return ret;
+}
+
+struct z_erofs_crypto_engine {
+	char *crypto_name;
+	struct crypto_acomp *tfm;
+};
+
+struct z_erofs_crypto_engine *z_erofs_crypto[Z_EROFS_COMPRESSION_MAX] = {
+	[Z_EROFS_COMPRESSION_LZ4] = (struct z_erofs_crypto_engine[]) {
+		{},
+	},
+	[Z_EROFS_COMPRESSION_LZMA] = (struct z_erofs_crypto_engine[]) {
+		{},
+	},
+	[Z_EROFS_COMPRESSION_DEFLATE] = (struct z_erofs_crypto_engine[]) {
+		{ .crypto_name = "qat_deflate", },
+		{},
+	},
+	[Z_EROFS_COMPRESSION_ZSTD] = (struct z_erofs_crypto_engine[]) {
+		{},
+	},
+};
+
+static DECLARE_RWSEM(z_erofs_crypto_rwsem);
+
+static struct crypto_acomp *z_erofs_crypto_get_engine(int alg)
+{
+	struct z_erofs_crypto_engine *e;
+
+	for (e = z_erofs_crypto[alg]; e->crypto_name; ++e)
+		if (e->tfm)
+			return e->tfm;
+	return NULL;
+}
+
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+			      struct page **pgpl)
+{
+	struct crypto_acomp *tfm;
+	int i, err;
+
+	down_read(&z_erofs_crypto_rwsem);
+	tfm = z_erofs_crypto_get_engine(rq->alg);
+	if (!tfm) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	for (i = 0; i < rq->outpages; i++) {
+		struct page *const page = rq->out[i];
+		struct page *victim;
+
+		if (!page) {
+			victim = __erofs_allocpage(pgpl, rq->gfp, true);
+			if (!victim) {
+				err = -ENOMEM;
+				goto out;
+			}
+			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
+			rq->out[i] = victim;
+		}
+	}
+	err = __z_erofs_crypto_decompress(rq, tfm);
+out:
+	up_read(&z_erofs_crypto_rwsem);
+	return err;
+}
+
+int z_erofs_crypto_enable_engine(const char *name, int len)
+{
+	struct z_erofs_crypto_engine *e;
+	struct crypto_acomp *tfm;
+	int alg;
+
+	down_write(&z_erofs_crypto_rwsem);
+	for (alg = 0; alg < Z_EROFS_COMPRESSION_MAX; ++alg) {
+		for (e = z_erofs_crypto[alg]; e->crypto_name; ++e) {
+			if (!strncmp(name, e->crypto_name, len)) {
+				if (e->tfm)
+					break;
+				tfm = crypto_alloc_acomp(e->crypto_name, 0, 0);
+				if (IS_ERR(tfm)) {
+					up_write(&z_erofs_crypto_rwsem);
+					return -EOPNOTSUPP;
+				}
+				e->tfm = tfm;
+				break;
+			}
+		}
+	}
+	up_write(&z_erofs_crypto_rwsem);
+	return 0;
+}
+
+void z_erofs_crypto_disable_all_engines(void)
+{
+	struct z_erofs_crypto_engine *e;
+	int alg;
+
+	down_write(&z_erofs_crypto_rwsem);
+	for (alg = 0; alg < Z_EROFS_COMPRESSION_MAX; ++alg) {
+		for (e = z_erofs_crypto[alg]; e->crypto_name; ++e) {
+			if (!e->tfm)
+				continue;
+			crypto_free_acomp(e->tfm);
+			e->tfm = NULL;
+		}
+	}
+	up_write(&z_erofs_crypto_rwsem);
+}
+
+int z_erofs_crypto_show_engines(char *buf, int size, char sep)
+{
+	struct z_erofs_crypto_engine *e;
+	int alg, len = 0;
+
+	for (alg = 0; alg < Z_EROFS_COMPRESSION_MAX; ++alg) {
+		for (e = z_erofs_crypto[alg]; e->crypto_name; ++e) {
+			if (!e->tfm)
+				continue;
+			len += scnprintf(buf + len, size - len, "%s%c",
+					 e->crypto_name, sep);
+		}
+	}
+	return len;
+}
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index c6908a487054..6909b2d529c7 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -97,8 +97,8 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-				      struct page **pgpl)
+static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+					struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
@@ -178,6 +178,22 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	return err;
 }
 
+static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+				      struct page **pgpl)
+{
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+	int err;
+
+	if (!rq->partial_decoding) {
+		err = z_erofs_crypto_decompress(rq, pgpl);
+		if (err != -EOPNOTSUPP)
+			return err;
+
+	}
+#endif
+	return __z_erofs_deflate_decompress(rq, pgpl);
+}
+
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
 	.config = z_erofs_load_deflate_config,
 	.decompress = z_erofs_deflate_decompress,
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dad4e6c6c155..4c0ad4b93161 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -7,12 +7,14 @@
 #include <linux/kobject.h>
 
 #include "internal.h"
+#include "compress.h"
 
 enum {
 	attr_feature,
 	attr_drop_caches,
 	attr_pointer_ui,
 	attr_pointer_bool,
+	attr_accel,
 };
 
 enum {
@@ -60,14 +62,25 @@ static struct erofs_attr erofs_attr_##_name = {			\
 EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
 EROFS_ATTR_FUNC(drop_caches, 0200);
 #endif
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+EROFS_ATTR_FUNC(accel, 0644);
+#endif
 
-static struct attribute *erofs_attrs[] = {
+static struct attribute *erofs_sb_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
 	ATTR_LIST(drop_caches),
 #endif
 	NULL,
 };
+ATTRIBUTE_GROUPS(erofs_sb);
+
+static struct attribute *erofs_attrs[] = {
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+	ATTR_LIST(accel),
+#endif
+	NULL,
+};
 ATTRIBUTE_GROUPS(erofs);
 
 /* Features this copy of erofs supports */
@@ -128,12 +141,14 @@ static ssize_t erofs_attr_show(struct kobject *kobj,
 		if (!ptr)
 			return 0;
 		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
+	case attr_accel:
+		return z_erofs_crypto_show_engines(buf, PAGE_SIZE, '\n');
 	}
 	return 0;
 }
 
 static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
-						const char *buf, size_t len)
+				const char *buf, size_t len)
 {
 	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
 						s_kobj);
@@ -181,6 +196,19 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 		if (t & 1)
 			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
 		return len;
+#endif
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+	case attr_accel:
+		buf = skip_spaces(buf);
+		z_erofs_crypto_disable_all_engines();
+		while (*buf) {
+			t = strcspn(buf, "\n");
+			ret = z_erofs_crypto_enable_engine(buf, t);
+			if (ret < 0)
+				return ret;
+			buf += buf[t] == '\n' ? t + 1 : t;
+		}
+		return len;
 #endif
 	}
 	return 0;
@@ -199,12 +227,13 @@ static const struct sysfs_ops erofs_attr_ops = {
 };
 
 static const struct kobj_type erofs_sb_ktype = {
-	.default_groups = erofs_groups,
+	.default_groups = erofs_sb_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 	.release	= erofs_sb_release,
 };
 
 static const struct kobj_type erofs_ktype = {
+	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 };
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ab61c84d47cd..fe8071844724 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -441,6 +441,7 @@ void z_erofs_exit_subsystem(void)
 	z_erofs_destroy_pcpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
+	z_erofs_crypto_disable_all_engines();
 	z_erofs_exit_decompressor();
 }
 
-- 
2.43.5


