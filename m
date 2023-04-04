Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42906D5A2F
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxb397Dz3cj3
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP3t9zz3c9r
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfKztOv_1680595346;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfKztOv_1680595346)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:27 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 2/6] erofs-utils: extract packedfile API
Date: Tue,  4 Apr 2023 16:02:19 +0800
Message-Id: <20230404080224.77577-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
References: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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

Later packed_inode will be used in more scenarios other than fragments,
thus extract the separate packedfile API for future use.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h    |  1 +
 include/erofs/fragments.h | 19 ++++++++++++++++---
 include/erofs/inode.h     |  2 ++
 lib/fragments.c           | 20 ++++++++------------
 mkfs/main.c               | 32 ++++++++++++++++++++++++--------
 5 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 648a3e8..e4d4130 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -52,6 +52,7 @@ struct erofs_configure {
 	bool c_dedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
+	bool c_packedfile;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 21753ec..1b7c06b 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -12,15 +12,28 @@ extern "C"
 
 #include "erofs/internal.h"
 
-extern const char *frags_packedname;
-#define EROFS_PACKED_INODE	frags_packedname
+extern FILE *packedfile;
+int erofs_packedfile_init(void);
+void erofs_packedfile_exit(void);
+struct erofs_inode *erofs_mkfs_build_packedfile(void);
+
+static inline int erofs_packedfile_is_empty(void)
+{
+#ifdef HAVE_FTELLO64
+	off64_t offset = ftello64(packedfile);
+#else
+	off_t offset = ftello(packedfile);
+#endif
+	if (offset < 0)
+		return -errno;
+	return offset == 0;
+}
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
 void z_erofs_fragments_commit(struct erofs_inode *inode);
-struct erofs_inode *erofs_mkfs_build_fragments(void);
 int erofs_fragments_init(void);
 void erofs_fragments_exit(void);
 
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 058a235..cb8568a 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -21,6 +21,8 @@ void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
+
+#define EROFS_PACKED_INODE	("packed_file")
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
 
 #ifdef __cplusplus
diff --git a/lib/fragments.c b/lib/fragments.c
index 0366c82..25d72f9 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -39,8 +39,7 @@ struct erofs_fragment_dedupe_item {
 
 static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
 
-static FILE *packedfile;
-const char *frags_packedname = "packed_file";
+FILE *packedfile;
 
 #ifndef HAVE_LSEEK64
 #define erofs_lseek64 lseek
@@ -195,15 +194,16 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
 	return 0;
 }
 
-static void z_erofs_fragments_dedupe_init(void)
+int erofs_fragments_init(void)
 {
 	unsigned int i;
 
 	for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
 		init_list_head(&dupli_frags[i]);
+	return 0;
 }
 
-static void z_erofs_fragments_dedupe_exit(void)
+void erofs_fragments_exit(void)
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
+int erofs_packedfile_init(void)
 {
 #ifdef HAVE_TMPFILE64
 	packedfile = tmpfile64();
@@ -349,7 +347,5 @@ int erofs_fragments_init(void)
 #endif
 	if (!packedfile)
 		return -ENOMEM;
-
-	z_erofs_fragments_dedupe_init();
 	return 0;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 65d3df6..50fd908 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -555,6 +555,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
+	if (cfg.c_fragments)
+		cfg.c_packedfile = true;
 	return 0;
 }
 
@@ -770,10 +772,17 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (cfg.c_fragments) {
+	if (cfg.c_packedfile) {
 		if (!cfg.c_pclusterblks_packed)
 			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
 
+		err = erofs_packedfile_init();
+		if (err) {
+			erofs_err("failed to initialize packedfile");
+			return 1;
+		}
+	}
+	if (cfg.c_fragments) {
 		err = erofs_fragments_init();
 		if (err) {
 			erofs_err("failed to initialize fragments");
@@ -880,15 +889,20 @@ int main(int argc, char **argv)
 	}
 
 	packed_nid = 0;
-	if (cfg.c_fragments && erofs_sb_has_fragments()) {
-		erofs_update_progressinfo("Handling packed_file ...");
-		packed_inode = erofs_mkfs_build_fragments();
-		if (IS_ERR(packed_inode)) {
-			err = PTR_ERR(packed_inode);
+	if (cfg.c_packedfile) {
+		err = erofs_packedfile_is_empty();
+		if (err < 0)
 			goto exit;
+		if (!err) {
+			erofs_update_progressinfo("Handling packed_file ...");
+			packed_inode = erofs_mkfs_build_packedfile();
+			if (IS_ERR(packed_inode)) {
+				err = PTR_ERR(packed_inode);
+				goto exit;
+			}
+			packed_nid = erofs_lookupnid(packed_inode);
+			erofs_iput(packed_inode);
 		}
-		packed_nid = erofs_lookupnid(packed_inode);
-		erofs_iput(packed_inode);
 	}
 
 	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
@@ -917,6 +931,8 @@ exit:
 		erofs_blob_exit();
 	if (cfg.c_fragments)
 		erofs_fragments_exit();
+	if (cfg.c_packedfile)
+		erofs_packedfile_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

