Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9E731512
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686824287;
	bh=oD75h7VgAtn5IYSfVygxzGeG+ZkWjn4eeWIc3MigzT0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=N3lSMLDqczMVnzD2AMUjBo8/wvsShB76+BzCnudMh9Au+FLz6SsjQUc8j8w8rQB9R
	 5Lh8Awr86tSUrYPIWA3RH1WxWHKuA4MUMMJ7kQH4a/Ch0yMc7AxabeeH4El+n+UHZ/
	 PLT9NOotjm8A72v2bhhTz+Rcr5iJiIC5k83zLNPqjShMJffi3A3cNqTJ91zjg29Ldf
	 5ZP5x16a28MVG5crq9jsHjH/+xFF/uNWvH+N71SWUFgIovdoAgt+aB5RfoRHIZFhxj
	 Uq1/NWAYQrs0oUfftOiybzOzEWHjjVnXSDZWcQnRLay/hDI3hKPEps+MZj4TGztbyn
	 qzxY1Gk/F9dJw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhdXb0ssbz3bZ3
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:18:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.154; helo=frasgout12.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhdXG6wRhz30dm
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:17:50 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QhdGC41dBz9xFb9
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 18:05:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwDXvYc55YpkT63TCA--.7908S4;
	Thu, 15 Jun 2023 10:17:38 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/4] erofs-utils: lib: unify all identical compressor print function
Date: Thu, 15 Jun 2023 18:17:25 +0800
Message-Id: <20230615101727.946446-3-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230615101727.946446-1-guoxuenan@huawei.com>
References: <20230615101727.946446-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwDXvYc55YpkT63TCA--.7908S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45AF48uFyfArW8uFWktFb_yoW7Jw1UpF
	45GryrGrW0gr15Aw4fJrsYgFyfGrs7KF1DJw17G3s3J3W5XrZ7XF48trnYqFWUGr93Za1v
	vwsFvw47Gws5tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij2
	8IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URuWLUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

{dump,fsck}.erofs use the same compressor print function,
available compressors means which algothrims are currently
supported by binary tools.
supported compressors including all algothrims that are ready
for your erofs binary tools.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 fsck/main.c              | 15 +-----------
 include/erofs/compress.h |  3 ++-
 lib/compressor.c         | 51 ++++++++++++++++++++++++++--------------
 mkfs/main.c              | 15 +-----------
 4 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index f816bec..e559050 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -49,19 +49,6 @@ static struct option long_options[] = {
 	{0, 0, 0, 0},
 };
 
-static void print_available_decompressors(FILE *f, const char *delim)
-{
-	unsigned int i = 0;
-	const char *s;
-
-	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
-		if (i++)
-			fputs(delim, f);
-		fputs(s, f);
-	}
-	fputc('\n', f);
-}
-
 static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
@@ -84,7 +71,7 @@ static void usage(void)
 	      " --no-preserve-owner    extract as yourself\n"
 	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
 	      "\nSupported algorithms are: ", stderr);
-	print_available_decompressors(stderr, ", ");
+	erofs_print_available_compressors(stderr);
 }
 
 static void erofsfsck_print_version(void)
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 08af9e3..f1b9bbd 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -22,7 +22,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
-const char *z_erofs_list_available_compressors(unsigned int i);
+void erofs_print_available_compressors(FILE *f);
+void erofs_print_supported_compressors(FILE *f, unsigned int mask);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compressor.c b/lib/compressor.c
index 88a2fb0..da8d1b9 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -10,18 +10,6 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
-static const struct erofs_compressor *compressors[] = {
-#if LZ4_ENABLED
-#if LZ4HC_ENABLED
-		&erofs_compressor_lz4hc,
-#endif
-		&erofs_compressor_lz4,
-#endif
-#if HAVE_LIBLZMA
-		&erofs_compressor_lzma,
-#endif
-};
-
 /* for compressors type configuration */
 static struct erofs_supported_algothrim {
 	int algtype;
@@ -119,9 +107,38 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	return ret;
 }
 
-const char *z_erofs_list_available_compressors(unsigned int i)
+void erofs_print_supported_compressors(FILE *f, unsigned int mask)
 {
-	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
+	unsigned int i = 0;
+	int comma = false;
+	const char *s;
+
+	while (i < erofs_ccfg.erofs_ccfg_num) {
+		s = erofs_ccfg.compressors[i].name;
+		if (s && (mask & (1 << erofs_ccfg.compressors[i++].algorithmtype))) {
+			if (comma)
+				fputs(", ", f);
+			else
+				comma = true;
+			fputs(s, f);
+		}
+	}
+	fputc('\n', f);
+}
+
+void erofs_print_available_compressors(FILE *f)
+{
+	unsigned int i = 0;
+	const char *s;
+
+	while (i < erofs_ccfg.erofs_ccfg_num &&
+			erofs_ccfg.compressors[i].handle.alg &&
+			(s = erofs_ccfg.compressors[i].name)) {
+		if (i++)
+			fputs(", ", f);
+		fputs(s, f);
+	}
+	fputc('\n', f);
 }
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
@@ -154,11 +171,11 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 	}
 
 	ret = -EINVAL;
-	for (i = 0; i < ARRAY_SIZE(compressors); ++i) {
-		if (alg_name && strcmp(alg_name, compressors[i]->name))
+	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; ++i) {
+		if (alg_name && strcmp(alg_name, erofs_ccfg.compressors[i].name))
 			continue;
 
-		ret = compressors[i]->init(c);
+		ret = erofs_ccfg.compressors[i].handle.alg->init(c);
 		if (!ret) {
 			DBG_BUGON(!c->alg);
 			return 0;
diff --git a/mkfs/main.c b/mkfs/main.c
index ac208e5..9433a75 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -66,19 +66,6 @@ static struct option long_options[] = {
 	{0, 0, 0, 0},
 };
 
-static void print_available_compressors(FILE *f, const char *delim)
-{
-	unsigned int i = 0;
-	const char *s;
-
-	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
-		if (i++)
-			fputs(delim, f);
-		fputs(s, f);
-	}
-	fputc('\n', f);
-}
-
 static void usage(void)
 {
 	fputs("usage: [options] FILE DIRECTORY\n\n"
@@ -126,7 +113,7 @@ static void usage(void)
 	      " --block-list-file=X   X=block_list file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
-	print_available_compressors(stderr, ", ");
+	erofs_print_available_compressors(stderr);
 }
 
 static unsigned int pclustersize_packed, pclustersize_max;
-- 
2.31.1

