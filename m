Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05E7C7EC
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 17:59:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zJ5q5sCbzDqkk
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 01:59:43 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zJ4Q48HlzDqhF
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2019 01:58:30 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 111E15D6377D3E19FF47;
 Wed, 31 Jul 2019 23:58:26 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu
 <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 06/22] staging: erofs: clean up internal.h
Date: Wed, 31 Jul 2019 23:57:36 +0800
Message-ID: <20190731155752.210602-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731155752.210602-1-gaoxiang25@huawei.com>
References: <20190731155752.210602-1-gaoxiang25@huawei.com>
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

Tidy up relative order of variables / declarations in internal.h,
move some local static functions out into other files and
add tags at the end of #endif acrossing several lines.

No logic change.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/decompressor.c |  27 +++++
 drivers/staging/erofs/internal.h     | 157 ++++++++-------------------
 drivers/staging/erofs/super.c        |   2 +-
 drivers/staging/erofs/zdata.c        |   8 +-
 drivers/staging/erofs/zdata.h        |  13 +++
 5 files changed, 92 insertions(+), 115 deletions(-)

diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index b75524d0b322..ee5762351f80 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -223,6 +223,33 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
 	}
 }
 
+static void *erofs_vmap(struct page **pages, unsigned int count)
+{
+#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
+	int i = 0;
+
+	while (1) {
+		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
+		/* retry two more times (totally 3 times) */
+		if (addr || ++i >= 3)
+			return addr;
+		vm_unmap_aliases();
+	}
+	return NULL;
+#else
+	return vmap(pages, count, VM_MAP, PAGE_KERNEL);
+#endif
+}
+
+static void erofs_vunmap(const void *mem, unsigned int count)
+{
+#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
+	vm_unmap_ram(mem, count);
+#else
+	vunmap(mem);
+#endif
+}
+
 static int decompress_generic(struct z_erofs_decompress_req *rq,
 			      struct list_head *pagepool)
 {
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index ed487ee56f74..959bd0ae9d74 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -6,8 +6,8 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#ifndef __INTERNAL_H
-#define __INTERNAL_H
+#ifndef __EROFS_INTERNAL_H
+#define __EROFS_INTERNAL_H
 
 #include <linux/fs.h>
 #include <linux/dcache.h>
@@ -28,15 +28,11 @@
 #define infoln(x, ...)  pr_info(x "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define debugln(x, ...) pr_debug(x "\n", ##__VA_ARGS__)
-
-#define dbg_might_sleep         might_sleep
 #define DBG_BUGON               BUG_ON
 #else
 #define debugln(x, ...)         ((void)0)
-
-#define dbg_might_sleep()       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
-#endif
+#endif	/* !CONFIG_EROFS_FS_DEBUG */
 
 enum {
 	FAULT_KMALLOC,
@@ -53,7 +49,7 @@ struct erofs_fault_info {
 	unsigned int inject_rate;
 	unsigned int inject_type;
 };
-#endif
+#endif	/* CONFIG_EROFS_FAULT_INJECTION */
 
 #ifdef CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR
 #define EROFS_FS_ZIP_CACHE_LVL	(2)
@@ -71,6 +67,9 @@ struct erofs_fault_info {
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
 typedef u64 erofs_nid_t;
+typedef u64 erofs_off_t;
+/* data type for filesystem-wide blocks number */
+typedef u32 erofs_blk_t;
 
 struct erofs_sb_info {
 	/* list for all registered superblocks, mainly for shrinker */
@@ -154,7 +153,7 @@ static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
 static inline void erofs_show_injection_info(int type)
 {
 }
-#endif
+#endif	/* !CONFIG_EROFS_FAULT_INJECTION */
 
 static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 					size_t size, gfp_t flags)
@@ -179,6 +178,8 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
 #ifdef CONFIG_EROFS_FS_ZIP
+#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
+
 /* basic unit of the workstation of a super_block */
 struct erofs_workgroup {
 	/* the workgroup index in the workstation */
@@ -188,8 +189,6 @@ struct erofs_workgroup {
 	atomic_t refcount;
 };
 
-#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
-
 #if defined(CONFIG_SMP)
 static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
 						 int val)
@@ -246,50 +245,24 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
 	return v;
 }
-#endif
-
-int erofs_workgroup_put(struct erofs_workgroup *grp);
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index, bool *tag);
-int erofs_register_workgroup(struct super_block *sb,
-			     struct erofs_workgroup *grp, bool tag);
-unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-				       unsigned long nr_shrink, bool cleanup);
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
-
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
-				       struct erofs_workgroup *egrp);
-int erofs_try_to_free_cached_page(struct address_space *mapping,
-				  struct page *page);
-
-#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
-static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
-					 struct page *page)
-{
-	return page->mapping == MNGD_MAPPING(sbi);
-}
-#else
-#define MNGD_MAPPING(sbi)	(NULL)
-static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
-					 struct page *page) { return false; }
-#endif
+#endif	/* !CONFIG_SMP */
 
-#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	3
+/* hard limit of pages per compressed cluster */
+#define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
 
-static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
-						     unsigned int nr)
-{
-	return nr <= sbi->max_sync_decompress_pages;
-}
+/* page count of a compressed cluster */
+#define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
 
 int __init z_erofs_init_zip_subsystem(void);
 void z_erofs_exit_zip_subsystem(void);
 #else
+#define EROFS_PCPUBUF_NR_PAGES          0
+
 /* dummy initializer/finalizer for the decompression subsystem */
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
-#endif
+#endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
@@ -308,23 +281,6 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 
 #define ROOT_NID(sb)		((sb)->root_nid)
 
-#ifdef CONFIG_EROFS_FS_ZIP
-/* hard limit of pages per compressed cluster */
-#define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
-
-/* page count of a compressed cluster */
-#define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
-
-#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PCPUBUF_NR_PAGES          0
-#endif
-
-typedef u64 erofs_off_t;
-
-/* data type for filesystem-wide blocks number */
-typedef u32 erofs_blk_t;
-
 #define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
 #define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
@@ -364,7 +320,7 @@ struct erofs_vnode {
 			unsigned char  z_logical_clusterbits;
 			unsigned char  z_physical_clusterbits[2];
 		};
-#endif
+#endif	/* CONFIG_EROFS_FS_ZIP */
 	};
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
@@ -472,13 +428,14 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 {
 	return -ENOTSUPP;
 }
-#endif
+#endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* data.c */
-static inline struct bio *
-erofs_grab_bio(struct super_block *sb,
-	       erofs_blk_t blkaddr, unsigned int nr_pages, void *bi_private,
-	       bio_end_io_t endio, bool nofail)
+static inline struct bio *erofs_grab_bio(struct super_block *sb,
+					 erofs_blk_t blkaddr,
+					 unsigned int nr_pages,
+					 void *bi_private, bio_end_io_t endio,
+					 bool nofail)
 {
 	const gfp_t gfp = GFP_NOIO;
 	struct bio *bio;
@@ -525,20 +482,13 @@ static inline struct page *erofs_get_meta_page(struct super_block *sb,
 	return __erofs_get_meta_page(sb, blkaddr, prio, false);
 }
 
-static inline struct page *erofs_get_meta_page_nofail(struct super_block *sb,
-	erofs_blk_t blkaddr, bool prio)
-{
-	return __erofs_get_meta_page(sb, blkaddr, prio, true);
-}
-
 int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
 
-static inline struct page *
-erofs_get_inline_page(struct inode *inode,
-		      erofs_blk_t blkaddr)
+static inline struct page *erofs_get_inline_page(struct inode *inode,
+						 erofs_blk_t blkaddr)
 {
-	return erofs_get_meta_page(inode->i_sb,
-		blkaddr, S_ISDIR(inode->i_mode));
+	return erofs_get_meta_page(inode->i_sb, blkaddr,
+				   S_ISDIR(inode->i_mode));
 }
 
 /* inode.c */
@@ -578,34 +528,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
-static inline void *erofs_vmap(struct page **pages, unsigned int count)
-{
-#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
-	int i = 0;
-
-	while (1) {
-		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
-		/* retry two more times (totally 3 times) */
-		if (addr || ++i >= 3)
-			return addr;
-		vm_unmap_aliases();
-	}
-	return NULL;
-#else
-	return vmap(pages, count, VM_MAP, PAGE_KERNEL);
-#endif
-}
-
-static inline void erofs_vunmap(const void *mem, unsigned int count)
-{
-#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
-	vm_unmap_ram(mem, count);
-#else
-	vunmap(mem);
-#endif
-}
-
-/* utils.c */
+/* utils.c / zdata.c */
 extern struct shrinker erofs_shrinker_info;
 
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
@@ -625,12 +548,20 @@ static inline void *erofs_get_pcpubuf(unsigned int pagenr)
 #define erofs_put_pcpubuf(buf) do {} while (0)
 #endif
 
+int erofs_workgroup_put(struct erofs_workgroup *grp);
+struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
+					     pgoff_t index, bool *tag);
+int erofs_register_workgroup(struct super_block *sb,
+			     struct erofs_workgroup *grp, bool tag);
+unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+				       unsigned long nr_shrink, bool cleanup);
+void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *egrp);
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page);
 void erofs_register_super(struct super_block *sb);
 void erofs_unregister_super(struct super_block *sb);
 
-#ifndef lru_to_page
-#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
-#endif
-
-#endif
+#endif	/* __EROFS_INTERNAL_H */
 
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 38cd7a59750a..55f51d2b3930 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -211,7 +211,7 @@ static void default_options(struct erofs_sb_info *sbi)
 {
 	/* set up some FS parameters */
 #ifdef CONFIG_EROFS_FS_ZIP
-	sbi->max_sync_decompress_pages = DEFAULT_MAX_SYNC_DECOMPRESS_PAGES;
+	sbi->max_sync_decompress_pages = 3;
 #endif
 
 #ifdef CONFIG_EROFS_FS_XATTR
diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index f7667628bbf1..bc478eebf509 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -1509,6 +1509,12 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	return 0;
 }
 
+static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
+					    unsigned int nr)
+{
+	return nr <= sbi->max_sync_decompress_pages;
+}
+
 static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 					      struct address_space *mapping,
 					      struct list_head *pages,
@@ -1517,7 +1523,7 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 	struct inode *const inode = mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
-	bool sync = __should_decompress_synchronously(sbi, nr_pages);
+	bool sync = should_decompress_synchronously(sbi, nr_pages);
 	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
 	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
 	struct page *head = NULL;
diff --git a/drivers/staging/erofs/zdata.h b/drivers/staging/erofs/zdata.h
index 8d0119d697da..6574d43ba877 100644
--- a/drivers/staging/erofs/zdata.h
+++ b/drivers/staging/erofs/zdata.h
@@ -104,6 +104,19 @@ struct z_erofs_vle_unzip_io_sb {
 	struct super_block *sb;
 };
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
+					 struct page *page)
+{
+	return page->mapping == MNGD_MAPPING(sbi);
+}
+#else
+#define MNGD_MAPPING(sbi)	(NULL)
+static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
+					 struct page *page) { return false; }
+#endif	/* !EROFS_FS_HAS_MANAGED_CACHE */
+
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS 2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
 #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
-- 
2.17.1

