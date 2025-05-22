Return-Path: <linux-erofs+bounces-354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C6AC06C7
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 10:14:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b31L13s0pz3c3D;
	Thu, 22 May 2025 18:14:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747901689;
	cv=none; b=JmNnUoIHWb9tJ7lO+oKtyzvLm1C9X9/RkwI0nW3qU4W9FW/BLhhNw/t6RYACMBpnr0dQ16WpmJPtDmjBCmqLzkZpTLY+vEQkNjQQdKuyUcHr1Sux02nMIFQpRFIRZcfh0CvL1ln6fAvTrW6HmgExSvu0VvP5Gj/F9I/B0zHhkB9tVBzNp0VxxNGxU1+5SNnxFFAgsbSWz107itU2tFgm4MmzvOEPgjVZyA9xCZMOtvR0msfPhCyT2S87ODi/MwFhuC/R2eVskRSj7mopdUQF+BTl6nOj1iG1uolP6nf8zc8q3QIGh6jpVA0DGdNaiZhHeuimdIJ7vqweDZpfYxyJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747901689; c=relaxed/relaxed;
	bh=HndKehFzHVuEJG8a/yiuBiURJ+rbAp/B4oQ9KaIRFb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YN99zxVO75oPECcnYwDyrsrxS+TzHV6yqgxYMDEztGSFpUItP105jFvuGnnszO5iOJl1ajw0100S8R7iWH+kxvrXcHtQo11kkRjeY6kHRnlpQyf4oGSl/Cd590AW8PhQbemsvYVr6/g86DSPOgttxybtvtqHfn+VuFAeIhz97EKJfhEGlXB/2ctt9VBTLXLxB40zYIu+NYjWnq3fn+zsDVnL40+szTHmjfG3JbQALB1+gQrB3mNRl/f91kT5CrBXBIibGBbCHYNP4Plj8ewrSDuzY1p3hRV9GQExg3LzHVSyA1EVWpBfBL5/QxD/mXR76eRUxw23X+0/km45+n4s4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b31L01Td4z2yfK
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 18:14:45 +1000 (AEST)
Received: from jtjnmail201608.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202505221614391774;
        Thu, 22 May 2025 16:14:39 +0800
Received: from localhost.localdomain (10.94.19.116) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 22 May 2025 16:14:40 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v6] erofs: support deflate decompress by using Intel QAT
Date: Thu, 22 May 2025 04:14:33 -0400
Message-ID: <20250522081433.16812-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
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
Content-Type: text/plain
X-Originating-IP: [10.94.19.116]
tUid: 2025522161439b79179d51f7b395ee93eae4a04668331
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch introdueces the use of the Intel QAT to decompress compressed
data in the EROFS filesystem, aiming to improve the decompression speed
of compressed datea.

We created a 285MiB compressed file and then used the following command to
create EROFS images with different cluster size.
     # mkfs.erofs -zdeflate,level=9 -C16384

fio command was used to test random read and small random read(~5%) and
sequential read performance.
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
---
v1: https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@inspur.com/
v2: https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@inspur.com/T/#t
v3: https://lore.kernel.org/linux-erofs/20250516082634.3801-1-liubo03@inspur.com/
v4: https://lore.kernel.org/linux-erofs/20250521100326.2867828-1-hsiangkao@linux.alibaba.com/
v5: https://lore.kernel.org/linux-erofs/f245b9edfc1b4205804c415cc0608558@inspur.com/T/#t

change since v5:
 - update sysfs documentation.

 Documentation/ABI/testing/sysfs-fs-erofs |   9 ++
 fs/erofs/Kconfig                         |  14 ++
 fs/erofs/Makefile                        |   1 +
 fs/erofs/compress.h                      |  10 ++
 fs/erofs/decompressor_crypto.c           | 186 +++++++++++++++++++++++
 fs/erofs/decompressor_deflate.c          |  17 ++-
 fs/erofs/sysfs.c                         |  34 ++++-
 fs/erofs/zdata.c                         |   1 +
 8 files changed, 269 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/decompressor_crypto.c

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index b134146d735b..4d024f043ea1 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -27,3 +27,12 @@ Description:	Writing to this will drop compression-related caches,
 		- 1 : invalidate cached compressed folios
 		- 2 : drop in-memory pclusters
 		- 3 : drop in-memory pclusters and cached compressed folios
+
+What:		/sys/fs/erofs/accel
+Date:		May 2025
+Contact:	"Bo Liu" <liubo03@inspur.com>
+Description:	Used to set or show hardware accelerators in effect
+		and multiple accelerators are separated by '\n'.
+		Supported accelerator(s): qat_deflate.
+		Disable all accelerators with an empty string (echo > accel).
+
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 331e49cd1b8d..74e878a9784a 100644
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
index 2704d7a592a5..6a3dc3ba406a 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -76,4 +76,14 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
 int __init z_erofs_init_decompressor(void);
 void z_erofs_exit_decompressor(void);
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+				struct page **pgpl);
+int z_erofs_crypto_enable_engine(const char *name, int len);
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+void z_erofs_crypto_disable_all_engines(void);
+int z_erofs_crypto_show_engines(char *buf, int size, char sep);
+#else
+static inline void z_erofs_crypto_disable_all_engines(void) {}
+static inline int z_erofs_crypto_show_engines(char *buf, int size, char sep) { return 0; }
+#endif
 #endif
diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
new file mode 100644
index 000000000000..95a3778cb3bd
--- /dev/null
+++ b/fs/erofs/decompressor_crypto.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
+
+#include "compress.h"
+
+static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+				struct crypto_acomp *tfm)
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
+	if (!req)
+		return -ENOMEM;
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
+		st_dst.sgl, rq->inputsize, rq->outputsize);
+
+	crypto_init_wait(&wait);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				crypto_req_done, &wait);
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
+
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+				 struct page **pgpl)
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
+
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
+
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index c6908a487054..e4c9df9d7978 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -97,7 +97,7 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				      struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
@@ -178,6 +178,21 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	return err;
 }
 
+static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+				struct page **pgpl)
+{
+#ifdef CONFIG_EROFS_FS_ZIP_ACCEL
+	int err;
+
+	if (!rq->partial_decoding) {
+		err = z_erofs_crypto_decompress(rq, pgpl);
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+#endif
+	return __z_erofs_deflate_decompress(rq, pgpl);
+}
+
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
 	.config = z_erofs_load_deflate_config,
 	.decompress = z_erofs_deflate_decompress,
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dad4e6c6c155..1239d452f45f 100644
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
@@ -60,14 +62,26 @@ static struct erofs_attr erofs_attr_##_name = {			\
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
+
 ATTRIBUTE_GROUPS(erofs);
 
 /* Features this copy of erofs supports */
@@ -128,6 +142,8 @@ static ssize_t erofs_attr_show(struct kobject *kobj,
 		if (!ptr)
 			return 0;
 		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
+	case attr_accel:
+		return z_erofs_crypto_show_engines(buf, PAGE_SIZE, '\n');
 	}
 	return 0;
 }
@@ -181,6 +197,19 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
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
+			buf += buf[t] != '\0' ? t + 1 : t;
+		}
+		return len;
 #endif
 	}
 	return 0;
@@ -199,12 +228,13 @@ static const struct sysfs_ops erofs_attr_ops = {
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
index 0671184d9cf1..f02bf95aeb3f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -409,6 +409,7 @@ void z_erofs_exit_subsystem(void)
 	erofs_destroy_percpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
+	z_erofs_crypto_disable_all_engines();
 	z_erofs_exit_decompressor();
 }
 
-- 
2.31.1


