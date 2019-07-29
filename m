Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31478572
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 08:53:24 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xr4J515yzDqDm
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 16:53:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xr3P3kBMzDqKZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2019 16:52:33 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2CED5CB77BB6558A9E70;
 Mon, 29 Jul 2019 14:52:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH 09/22] staging: erofs: clean up shrinker stuffs
Date: Mon, 29 Jul 2019 14:51:46 +0800
Message-ID: <20190729065159.62378-10-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

- rename erofs_register_super / erofs_unregister_super
  to erofs_shrinker_register / erofs_shrinker_unregister;
- fold the only erofs_shrink_workstation external call
  to erofs_shrinker_unregister;
- localize erofs_shrink_workstation;
- localize erofs_shrinker_info by introducing
  erofs_init_shrinker and erofs_exit_shrinker.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 50 +++++++++++++++++---------------
 drivers/staging/erofs/super.c    | 20 ++++---------
 drivers/staging/erofs/utils.c    | 37 +++++++++++++++--------
 3 files changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 58b8bb9cbb9f..c082a462baf6 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -72,34 +72,35 @@ typedef u64 erofs_off_t;
 typedef u32 erofs_blk_t;
 
 struct erofs_sb_info {
+#ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
 	struct mutex umount_mutex;
 
-	u32 blocks;
-	u32 meta_blkaddr;
-#ifdef CONFIG_EROFS_FS_XATTR
-	u32 xattr_blkaddr;
-#endif
-
-	/* inode slot unit size in bit shift */
-	unsigned char islotbits;
-#ifdef CONFIG_EROFS_FS_ZIP
 	/* cluster size in bit shift */
 	unsigned char clusterbits;
-
 	/* the dedicated workstation for compression */
 	struct radix_tree_root workstn_tree;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
 
+	unsigned int shrinker_run_no;
+
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	struct inode *managed_cache;
 #endif
 
+#endif	/* CONFIG_EROFS_FS_ZIP */
+	u32 blocks;
+	u32 meta_blkaddr;
+#ifdef CONFIG_EROFS_FS_XATTR
+	u32 xattr_blkaddr;
 #endif
 
+	/* inode slot unit size in bit shift */
+	unsigned char islotbits;
+
 	u32 build_time_nsec;
 	u64 build_time;
 
@@ -115,7 +116,6 @@ struct erofs_sb_info {
 	char *dev_name;
 
 	unsigned int mount_opt;
-	unsigned int shrinker_run_no;
 
 #ifdef CONFIG_EROFS_FAULT_INJECTION
 	struct erofs_fault_info fault_info;	/* For fault injection */
@@ -246,13 +246,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return v;
 }
 #endif
-
-int __init z_erofs_init_zip_subsystem(void);
-void z_erofs_exit_zip_subsystem(void);
-#else
-/* dummy initializer/finalizer for the decompression subsystem */
-static inline int z_erofs_init_zip_subsystem(void) { return 0; }
-static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
@@ -526,8 +519,6 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c / zdata.c */
-extern struct shrinker erofs_shrinker_info;
-
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
 
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
@@ -545,20 +536,31 @@ static inline void *erofs_get_pcpubuf(unsigned int pagenr)
 #define erofs_put_pcpubuf(buf) do {} while (0)
 #endif
 
+#ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index, bool *tag);
 int erofs_register_workgroup(struct super_block *sb,
 			     struct erofs_workgroup *grp, bool tag);
-unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-				       unsigned long nr_shrink, bool cleanup);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+void erofs_shrinker_register(struct super_block *sb);
+void erofs_shrinker_unregister(struct super_block *sb);
+int __init erofs_init_shrinker(void);
+void erofs_exit_shrinker(void);
+int __init z_erofs_init_zip_subsystem(void);
+void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page);
-void erofs_register_super(struct super_block *sb);
-void erofs_unregister_super(struct super_block *sb);
+#else
+static inline void erofs_shrinker_register(struct super_block *sb) {}
+static inline void erofs_shrinker_unregister(struct super_block *sb) {}
+static inline int erofs_init_shrinker(void) { return 0; }
+static inline void erofs_exit_shrinker(void) {}
+static inline int z_erofs_init_zip_subsystem(void) { return 0; }
+static inline void z_erofs_exit_zip_subsystem(void) {}
+#endif
 
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index c20a94b035a7..7e6fe9cd45e7 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -458,7 +458,7 @@ static int erofs_read_super(struct super_block *sb,
 	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
 	sbi->dev_name[PATH_MAX - 1] = '\0';
 
-	erofs_register_super(sb);
+	erofs_shrinker_register(sb);
 
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", dev_name,
@@ -502,20 +502,10 @@ static void erofs_put_super(struct super_block *sb)
 	infoln("unmounted for %s", sbi->dev_name);
 	__putname(sbi->dev_name);
 
+	erofs_shrinker_unregister(sb);
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	iput(sbi->managed_cache);
 #endif
-
-	mutex_lock(&sbi->umount_mutex);
-
-#ifdef CONFIG_EROFS_FS_ZIP
-	/* clean up the compression space of this sb */
-	erofs_shrink_workstation(EROFS_SB(sb), ~0UL, true);
-#endif
-
-	erofs_unregister_super(sb);
-	mutex_unlock(&sbi->umount_mutex);
-
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -569,7 +559,7 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto icache_err;
 
-	err = register_shrinker(&erofs_shrinker_info);
+	err = erofs_init_shrinker();
 	if (err)
 		goto shrinker_err;
 
@@ -587,7 +577,7 @@ static int __init erofs_module_init(void)
 fs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
-	unregister_shrinker(&erofs_shrinker_info);
+	erofs_exit_shrinker();
 shrinker_err:
 	erofs_exit_inode_cache();
 icache_err:
@@ -598,7 +588,7 @@ static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
 	z_erofs_exit_zip_subsystem();
-	unregister_shrinker(&erofs_shrinker_info);
+	erofs_exit_shrinker();
 	erofs_exit_inode_cache();
 	infoln("successfully finalize erofs");
 }
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 024806003297..0e86e44d60d0 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -34,10 +34,10 @@ void *erofs_get_pcpubuf(unsigned int pagenr)
 }
 #endif
 
+#ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
-#ifdef CONFIG_EROFS_FS_ZIP
 #define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
 #define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
 
@@ -215,9 +215,9 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 
 #endif
 
-unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-				       unsigned long nr_shrink,
-				       bool cleanup)
+static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+					      unsigned long nr_shrink,
+					      bool cleanup)
 {
 	pgoff_t first_index = 0;
 	void *batch[PAGEVEC_SIZE];
@@ -250,8 +250,6 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-#endif
-
 /* protected by 'erofs_sb_list_lock' */
 static unsigned int shrinker_run_no;
 
@@ -259,7 +257,7 @@ static unsigned int shrinker_run_no;
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
 
-void erofs_register_super(struct super_block *sb)
+void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
@@ -270,11 +268,17 @@ void erofs_register_super(struct super_block *sb)
 	spin_unlock(&erofs_sb_list_lock);
 }
 
-void erofs_unregister_super(struct super_block *sb)
+void erofs_shrinker_unregister(struct super_block *sb)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+
+	mutex_lock(&sbi->umount_mutex);
+	erofs_shrink_workstation(sbi, ~0UL, true);
+
 	spin_lock(&erofs_sb_list_lock);
-	list_del(&EROFS_SB(sb)->list);
+	list_del(&sbi->list);
 	spin_unlock(&erofs_sb_list_lock);
+	mutex_unlock(&sbi->umount_mutex);
 }
 
 static unsigned long erofs_shrink_count(struct shrinker *shrink,
@@ -318,9 +322,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
 
-#ifdef CONFIG_EROFS_FS_ZIP
 		freed += erofs_shrink_workstation(sbi, nr, false);
-#endif
 
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
@@ -340,9 +342,20 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-struct shrinker erofs_shrinker_info = {
+static struct shrinker erofs_shrinker_info = {
 	.scan_objects = erofs_shrink_scan,
 	.count_objects = erofs_shrink_count,
 	.seeks = DEFAULT_SEEKS,
 };
 
+int __init erofs_init_shrinker(void)
+{
+	return register_shrinker(&erofs_shrinker_info);
+}
+
+void erofs_exit_shrinker(void)
+{
+	unregister_shrinker(&erofs_shrinker_info);
+}
+#endif	/* !CONFIG_EROFS_FS_ZIP */
+
-- 
2.17.1

