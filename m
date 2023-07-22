Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20D75DD2D
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690039310;
	bh=Dq5oyOWpaFdi/ekkN0QcYybX04D+s+f0ZEOvWiw8YCk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S6aOPwtwnpssxHGeMdINWWuJ9ovKshu4bzgYw9KECl0qFhrVGjJgRrB1EONkedcoG
	 z0GzzsWI0roA6f4q2NFuA8YhzEms4D6p6iMAcbZbCBmy4KkP0g3LYV2sYCg1GXkTiz
	 GqWBJGfMtcBbvHEE/MYSHx9spzhF1HiBkOfB0EbRluV7xQG/A1U66QOF8jsakTBbeB
	 btYHDq31Odq0vMEZCOLcyqcEtBNE2anE81XVMGpz9CrhqkahFub9MJBVVC6kPNSHOd
	 UQYiBv0zduX/LOpDjskk1dhsYL/tuf0VRlG9aPbxMxekwuZaUg7gybRbP9c923nVTI
	 gtOUwcfhqYziw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7VWy5GGRz2ytm
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Jul 2023 01:21:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7VWs4b5bz2yW5
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Jul 2023 01:21:45 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R7TvN0bw8zB0hnx
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 22:53:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwCXnVcE8LtkMMq2Cg--.24810S4;
	Sat, 22 Jul 2023 15:04:45 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/4] erofs-utils: lib: unify all identical compressor print function
Date: Sat, 22 Jul 2023 23:04:32 +0800
Message-Id: <20230722150434.2921381-3-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230722150434.2921381-1-guoxuenan@huawei.com>
References: <20230722150434.2921381-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwCXnVcE8LtkMMq2Cg--.24810S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45AF4UtryrAw15uw4xCrg_yoWrKF4DpF
	4YkryrGrWxJr15Zws3Jrs5KF43GFW8G3WDKw17G3s3X3Z8XrZ7XFn7tFn3ZFWUGr93Xa1q
	vwsFvw17Cr4fKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 fsck/main.c              | 15 +--------------
 include/erofs/compress.h |  3 ++-
 lib/compressor.c         | 41 ++++++++++++++++++++++++++++++++++++----
 mkfs/main.c              | 15 +--------------
 4 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 39a5534..6e0dcb5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -59,19 +59,6 @@ struct erofsfsck_hardlink_entry {
 
 static struct list_head erofsfsck_link_hashtable[NR_HARDLINK_HASHTABLE];
 
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
@@ -94,7 +81,7 @@ static void usage(void)
 	      " --no-preserve-owner    extract as yourself\n"
 	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
 	      "\nSupported algorithms are: ", stderr);
-	print_available_decompressors(stderr, ", ");
+	erofs_print_available_compressors(stderr);
 }
 
 static void erofsfsck_print_version(void)
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index f1ad84a..67bedf2 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -23,7 +23,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
-const char *z_erofs_list_available_compressors(unsigned int i);
+void erofs_print_available_compressors(FILE *f);
+void erofs_print_supported_compressors(FILE *f, unsigned int mask);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compressor.c b/lib/compressor.c
index 6288297..2cc2464 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -60,11 +60,13 @@ static void erofs_init_compressor(struct erofs_sb_info *sbi,
 static void erofs_compressor_register(struct erofs_sb_info *sbi,
 		const char *name, const struct erofs_compressor *alg)
 {
+	struct erofs_supported_algorithm *cur;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(erofs_supported_algorithms); i++) {
-		if (!strcmp(erofs_supported_algorithms[i].name, name)) {
-			erofs_init_compressor(sbi, &erofs_supported_algorithms[i].handle, alg);
+		cur = &erofs_supported_algorithms[i];
+		if (!strcmp(cur->name, name)) {
+			erofs_init_compressor(sbi, &cur->handle, alg);
 			return;
 		}
 	}
@@ -116,9 +118,40 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	return ret;
 }
 
-const char *z_erofs_list_available_compressors(unsigned int i)
+void erofs_print_supported_compressors(FILE *f, unsigned int mask)
 {
-	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algorithms);
+	unsigned int i = 0;
+	int comma = false;
+	const char *s;
+
+	while (i < algnum) {
+		s = erofs_supported_algorithms[i].name;
+		if (s && (mask & (1 << erofs_supported_algorithms[i++].algtype))) {
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
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algorithms);
+	unsigned int i = 0;
+	const char *s;
+
+	while (i < algnum &&
+			erofs_supported_algorithms[i].handle.alg &&
+			(s = erofs_supported_algorithms[i].name)) {
+		if (i++)
+			fputs(", ", f);
+		fputs(s, f);
+	}
+	fputc('\n', f);
 }
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
diff --git a/mkfs/main.c b/mkfs/main.c
index 92a07fd..54e7d99 100644
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
2.34.3

