Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FD6DAE99
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:09:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtKx95LLcz3fVb
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:09:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtKx05gJdz3fSp
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:09:07 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfX4eoS_1680876542;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX4eoS_1680876542)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:09:02 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/3] erofs-utils: lib: export packedfile APIs
Date: Fri,  7 Apr 2023 22:09:00 +0800
Message-Id: <20230407140902.97275-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Later packed_inode will be used in other scenarios other than
compressed fragments. Let's separate packedfile APIs for future use.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/fragments.h | 13 ++++++++-----
 lib/fragments.c           | 24 ++++++++++--------------
 mkfs/main.c               | 14 +++++++++++---
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 21753ec..4c6f755 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -12,17 +12,20 @@ extern "C"
 
 #include "erofs/internal.h"
 
-extern const char *frags_packedname;
-#define EROFS_PACKED_INODE	frags_packedname
+extern const char *erofs_frags_packedname;
+#define EROFS_PACKED_INODE	erofs_frags_packedname
+
+FILE *erofs_packedfile_init(void);
+void erofs_packedfile_exit(void);
+struct erofs_inode *erofs_mkfs_build_packedfile(void);
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
 void z_erofs_fragments_commit(struct erofs_inode *inode);
-struct erofs_inode *erofs_mkfs_build_fragments(void);
-int erofs_fragments_init(void);
-void erofs_fragments_exit(void);
+int z_erofs_fragments_init(void);
+void z_erofs_fragments_exit(void);
 
 #ifdef __cplusplus
 }
diff --git a/lib/fragments.c b/lib/fragments.c
index 0366c82..bf4dc19 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -38,9 +38,8 @@ struct erofs_fragment_dedupe_item {
 #define FRAGMENT_HASH(c)		((c) & (FRAGMENT_HASHSIZE - 1))
 
 static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
-
 static FILE *packedfile;
-const char *frags_packedname = "packed_file";
+const char *erofs_frags_packedname = "packed_file";
 
 #ifndef HAVE_LSEEK64
 #define erofs_lseek64 lseek
@@ -195,15 +194,16 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
 	return 0;
 }
 
-static void z_erofs_fragments_dedupe_init(void)
+int z_erofs_fragments_init(void)
 {
 	unsigned int i;
 
 	for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
 		init_list_head(&dupli_frags[i]);
+	return 0;
 }
 
-static void z_erofs_fragments_dedupe_exit(void)
+void z_erofs_fragments_exit(void)
 {
 	struct erofs_fragment_dedupe_item *di, *n;
 	struct list_head *head;
@@ -324,23 +324,21 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-struct erofs_inode *erofs_mkfs_build_fragments(void)
+struct erofs_inode *erofs_mkfs_build_packedfile(void)
 {
 	fflush(packedfile);
 
 	return erofs_mkfs_build_special_from_fd(fileno(packedfile),
-						frags_packedname);
+						EROFS_PACKED_INODE);
 }
 
-void erofs_fragments_exit(void)
+void erofs_packedfile_exit(void)
 {
 	if (packedfile)
 		fclose(packedfile);
-
-	z_erofs_fragments_dedupe_exit();
 }
 
-int erofs_fragments_init(void)
+FILE *erofs_packedfile_init(void)
 {
 #ifdef HAVE_TMPFILE64
 	packedfile = tmpfile64();
@@ -348,8 +346,6 @@ int erofs_fragments_init(void)
 	packedfile = tmpfile();
 #endif
 	if (!packedfile)
-		return -ENOMEM;
-
-	z_erofs_fragments_dedupe_init();
-	return 0;
+		return ERR_PTR(-ENOMEM);
+	return packedfile;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 65d3df6..cb52058 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -715,6 +715,7 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37] = "not available";
+	FILE *packedfile = NULL;
 
 	erofs_init_configure();
 	erofs_mkfs_default_options();
@@ -774,7 +775,13 @@ int main(int argc, char **argv)
 		if (!cfg.c_pclusterblks_packed)
 			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
 
-		err = erofs_fragments_init();
+		packedfile = erofs_packedfile_init();
+		if (IS_ERR(packedfile)) {
+			erofs_err("failed to initialize packedfile");
+			return 1;
+		}
+
+		err = z_erofs_fragments_init();
 		if (err) {
 			erofs_err("failed to initialize fragments");
 			return 1;
@@ -882,7 +889,7 @@ int main(int argc, char **argv)
 	packed_nid = 0;
 	if (cfg.c_fragments && erofs_sb_has_fragments()) {
 		erofs_update_progressinfo("Handling packed_file ...");
-		packed_inode = erofs_mkfs_build_fragments();
+		packed_inode = erofs_mkfs_build_packedfile();
 		if (IS_ERR(packed_inode)) {
 			err = PTR_ERR(packed_inode);
 			goto exit;
@@ -916,7 +923,8 @@ exit:
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
 	if (cfg.c_fragments)
-		erofs_fragments_exit();
+		z_erofs_fragments_exit();
+	erofs_packedfile_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

