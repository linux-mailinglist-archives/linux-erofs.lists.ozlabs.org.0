Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 687FD8B3F0
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 11:17:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4676YN5dVDzDqQ8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 19:17:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4676Vc6f9vzDqY1
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 19:14:48 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 33690D9B7AB2CCFF7DE3;
 Tue, 13 Aug 2019 17:14:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 17:14:35 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v7 23/24] erofs: introduce cached decompression
Date: Tue, 13 Aug 2019 17:13:25 +0800
Message-ID: <20190813091326.84652-24-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813091326.84652-1-gaoxiang25@huawei.com>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, Pavel Machek <pavel@denx.de>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Dave
 Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds strategies which can be selected
by users in order to cache both incomplete ends of
compressed physical clusters as a complement of
in-place I/O in order to boost random read, but
it costs more memory than the in-place I/O only.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  16 +++++
 fs/erofs/super.c    | 126 ++++++++++++++++++++++++++++++++-
 fs/erofs/utils.c    |  40 ++++++++---
 fs/erofs/zdata.c    | 165 ++++++++++++++++++++++++++++++++++++++++++--
 fs/erofs/zdata.h    |   7 +-
 5 files changed, 336 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5e2500f8d629..23eb4f50926e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -72,6 +72,12 @@ struct erofs_sb_info {
 	unsigned int max_sync_decompress_pages;
 
 	unsigned int shrinker_run_no;
+
+	/* current strategy of how to use managed cache */
+	unsigned char cache_strategy;
+
+	/* pseudo inode to manage cached pages */
+	struct inode *managed_cache;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
@@ -157,6 +163,12 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
 #ifdef CONFIG_EROFS_FS_ZIP
+enum {
+	EROFS_ZIP_CACHE_DISABLED,
+	EROFS_ZIP_CACHE_READAHEAD,
+	EROFS_ZIP_CACHE_READAROUND
+};
+
 #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
 
 /* basic unit of the workstation of a super_block */
@@ -524,6 +536,10 @@ int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_zip_subsystem(void);
 void z_erofs_exit_zip_subsystem(void);
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *egrp);
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bdac8abf3aa7..95187619b3e3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -197,10 +197,45 @@ static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
 }
 #endif
 
+#ifdef CONFIG_EROFS_FS_ZIP
+static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
+				      substring_t *args)
+{
+	const char *cs = match_strdup(args);
+	int err = 0;
+
+	if (!cs) {
+		errln("Not enough memory to store cache strategy");
+		return -ENOMEM;
+	}
+
+	if (!strcmp(cs, "disabled")) {
+		sbi->cache_strategy = EROFS_ZIP_CACHE_DISABLED;
+	} else if (!strcmp(cs, "readahead")) {
+		sbi->cache_strategy = EROFS_ZIP_CACHE_READAHEAD;
+	} else if (!strcmp(cs, "readaround")) {
+		sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	} else {
+		errln("Unrecognized cache strategy \"%s\"", cs);
+		err = -EINVAL;
+	}
+	kfree(cs);
+	return err;
+}
+#else
+static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
+				      substring_t *args)
+{
+	infoln("EROFS compression is disabled, so cache strategy is ignored");
+	return 0;
+}
+#endif
+
 /* set up default EROFS parameters */
 static void default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
+	sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	sbi->max_sync_decompress_pages = 3;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -217,6 +252,7 @@ enum {
 	Opt_acl,
 	Opt_noacl,
 	Opt_fault_injection,
+	Opt_cache_strategy,
 	Opt_err
 };
 
@@ -226,6 +262,7 @@ static match_table_t erofs_tokens = {
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
 	{Opt_fault_injection, "fault_injection=%u"},
+	{Opt_cache_strategy, "cache_strategy=%s"},
 	{Opt_err, NULL}
 };
 
@@ -283,6 +320,11 @@ static int parse_options(struct super_block *sb, char *options)
 			if (err)
 				return err;
 			break;
+		case Opt_cache_strategy:
+			err = erofs_build_cache_strategy(EROFS_SB(sb), args);
+			if (err)
+				return err;
+			break;
 		default:
 			errln("Unrecognized mount option \"%s\" or missing value", p);
 			return -EINVAL;
@@ -291,6 +333,65 @@ static int parse_options(struct super_block *sb, char *options)
 	return 0;
 }
 
+#ifdef CONFIG_EROFS_FS_ZIP
+static const struct address_space_operations managed_cache_aops;
+
+static int managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
+{
+	int ret = 1;	/* 0 - busy */
+	struct address_space *const mapping = page->mapping;
+
+	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
+
+	if (PagePrivate(page))
+		ret = erofs_try_to_free_cached_page(mapping, page);
+
+	return ret;
+}
+
+static void managed_cache_invalidatepage(struct page *page,
+					 unsigned int offset,
+					 unsigned int length)
+{
+	const unsigned int stop = length + offset;
+
+	DBG_BUGON(!PageLocked(page));
+
+	/* Check for potential overflow in debug mode */
+	DBG_BUGON(stop > PAGE_SIZE || stop < length);
+
+	if (offset == 0 && stop == PAGE_SIZE)
+		while (!managed_cache_releasepage(page, GFP_NOFS))
+			cond_resched();
+}
+
+static const struct address_space_operations managed_cache_aops = {
+	.releasepage = managed_cache_releasepage,
+	.invalidatepage = managed_cache_invalidatepage,
+};
+
+static int erofs_init_managed_cache(struct super_block *sb)
+{
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	struct inode *const inode = new_inode(sb);
+
+	if (unlikely(!inode))
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+
+	inode->i_mapping->a_ops = &managed_cache_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			     GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	sbi->managed_cache = inode;
+	return 0;
+}
+#else
+static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
+#endif
+
 static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
@@ -325,7 +426,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EROFS_FS_XATTR
 	sb->s_xattr = erofs_xattr_handlers;
 #endif
-
 	/* set erofs default mount options */
 	default_options(sbi);
 
@@ -362,6 +462,10 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
+	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
+	err = erofs_init_managed_cache(sb);
+	if (unlikely(err))
+		return err;
 
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
@@ -397,7 +501,15 @@ static void erofs_kill_sb(struct super_block *sb)
 /* called when ->s_root is non-NULL */
 static void erofs_put_super(struct super_block *sb)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+
+	DBG_BUGON(!sbi);
+
 	erofs_shrinker_unregister(sb);
+#ifdef CONFIG_EROFS_FS_ZIP
+	iput(sbi->managed_cache);
+	sbi->managed_cache = NULL;
+#endif
 }
 
 static struct file_system_type erofs_fs_type = {
@@ -495,6 +607,18 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, FAULT_INJECTION))
 		seq_printf(seq, ",fault_injection=%u",
 			   erofs_get_fault_rate(sbi));
+#ifdef CONFIG_EROFS_FS_ZIP
+	if (sbi->cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
+		seq_puts(seq, ",cache_strategy=disabled");
+	} else if (sbi->cache_strategy == EROFS_ZIP_CACHE_READAHEAD) {
+		seq_puts(seq, ",cache_strategy=readahead");
+	} else if (sbi->cache_strategy == EROFS_ZIP_CACHE_READAROUND) {
+		seq_puts(seq, ",cache_strategy=readaround");
+	} else {
+		seq_puts(seq, ",cache_strategy=(unknown)");
+		DBG_BUGON(1);
+	}
+#endif
 	return 0;
 }
 
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index ae6362abed67..c48e417d3926 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -144,24 +144,48 @@ int erofs_workgroup_put(struct erofs_workgroup *grp)
 	return count;
 }
 
-/* for nocache case, no customized reclaim path at all */
+static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
+{
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
+}
+
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp,
 					   bool cleanup)
 {
-	int cnt = atomic_read(&grp->refcount);
-
-	DBG_BUGON(cnt <= 0);
-	DBG_BUGON(cleanup && cnt != 1);
+	/*
+	 * If managed cache is on, refcount of workgroups
+	 * themselves could be < 0 (freezed). In other words,
+	 * there is no guarantee that all refcounts > 0.
+	 */
+	if (!erofs_workgroup_try_to_freeze(grp, 1))
+		return false;
 
-	if (cnt > 1)
+	/*
+	 * Note that all cached pages should be unattached
+	 * before deleted from the radix tree. Otherwise some
+	 * cached pages could be still attached to the orphan
+	 * old workgroup when the new one is available in the tree.
+	 */
+	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
+		erofs_workgroup_unfreeze(grp, 1);
 		return false;
+	}
 
+	/*
+	 * It's impossible to fail after the workgroup is freezed,
+	 * however in order to avoid some race conditions, add a
+	 * DBG_BUGON to observe this in advance.
+	 */
 	DBG_BUGON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
 						     grp->index)) != grp);
 
-	/* (rarely) could be grabbed again when freeing */
-	erofs_workgroup_put(grp);
+	/*
+	 * If managed cache is on, last refcount should indicate
+	 * the related workstation.
+	 */
+	erofs_workgroup_unfreeze_final(grp);
 	return true;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ffa64b1d8908..24be7d98bce3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -167,7 +167,110 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     enum z_erofs_cache_alloctype type,
 				     struct list_head *pagepool)
 {
-	/* nowhere to load compressed pages from */
+	const struct z_erofs_pcluster *pcl = clt->pcl;
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	struct page **pages = clt->compressedpages;
+	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
+	bool standalone = true;
+
+	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
+		return;
+
+	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
+		struct page *page;
+		compressed_page_t t;
+
+		/* the compressed page was loaded before */
+		if (READ_ONCE(*pages))
+			continue;
+
+		page = find_get_page(mc, index);
+
+		if (page) {
+			t = tag_compressed_page_justfound(page);
+		} else if (type == DELAYEDALLOC) {
+			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
+		} else {	/* DONTALLOC */
+			if (standalone)
+				clt->compressedpages = pages;
+			standalone = false;
+			continue;
+		}
+
+		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
+			continue;
+
+		if (page)
+			put_page(page);
+	}
+
+	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+}
+
+/* called by erofs_shrinker to get rid of all compressed_pages */
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *grp)
+{
+	struct z_erofs_pcluster *const pcl =
+		container_of(grp, struct z_erofs_pcluster, obj);
+	struct address_space *const mapping = MNGD_MAPPING(sbi);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	int i;
+
+	/*
+	 * refcount of workgroup is now freezed as 1,
+	 * therefore no need to worry about available decompression users.
+	 */
+	for (i = 0; i < clusterpages; ++i) {
+		struct page *page = pcl->compressed_pages[i];
+
+		if (!page)
+			continue;
+
+		/* block other users from reclaiming or migrating the page */
+		if (!trylock_page(page))
+			return -EBUSY;
+
+		if (unlikely(page->mapping != mapping))
+			continue;
+
+		/* barrier is implied in the following 'unlock_page' */
+		WRITE_ONCE(pcl->compressed_pages[i], NULL);
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+
+		unlock_page(page);
+		put_page(page);
+	}
+	return 0;
+}
+
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page)
+{
+	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	int ret = 0;	/* 0 - busy */
+
+	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
+		unsigned int i;
+
+		for (i = 0; i < clusterpages; ++i) {
+			if (pcl->compressed_pages[i] == page) {
+				WRITE_ONCE(pcl->compressed_pages[i], NULL);
+				ret = 1;
+				break;
+			}
+		}
+		erofs_workgroup_unfreeze(&pcl->obj, 1);
+
+		if (ret) {
+			ClearPagePrivate(page);
+			put_page(page);
+		}
+	}
+	return ret;
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
@@ -434,6 +537,20 @@ static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 	return page;
 }
 
+static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
+				       unsigned int cachestrategy,
+				       erofs_off_t la)
+{
+	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
+		return false;
+
+	if (fe->backmost)
+		return true;
+
+	return cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
+		la < fe->headoffset;
+}
+
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page,
 				struct list_head *pagepool)
@@ -488,7 +605,13 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
-	preload_compressed_pages(clt, MNGD_MAPPING(sbi), DONTALLOC, pagepool);
+	if (should_alloc_managed_pages(fe, sbi->cache_strategy, map->m_la))
+		cache_strategy = DELAYEDALLOC;
+	else
+		cache_strategy = DONTALLOC;
+
+	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+				 cache_strategy, pagepool);
 
 	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
 hitted:
@@ -987,6 +1110,7 @@ static struct z_erofs_unzip_io *jobqueue_init(struct super_block *sb,
 
 /* define decompression jobqueue types */
 enum {
+	JQ_BYPASS,
 	JQ_SUBMIT,
 	NR_JOBQUEUES,
 };
@@ -997,6 +1121,13 @@ static void *jobqueueset_init(struct super_block *sb,
 			      struct z_erofs_unzip_io *fgq,
 			      bool forcefg)
 {
+	/*
+	 * if managed cache is enabled, bypass jobqueue is needed,
+	 * no need to read from device for all pclusters in this queue.
+	 */
+	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, true);
+	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
+
 	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, forcefg);
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
@@ -1007,17 +1138,34 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 				    z_erofs_next_pcluster_t qtail[],
 				    z_erofs_next_pcluster_t owned_head)
 {
-	/* impossible to bypass submission for managed cache disabled */
-	DBG_BUGON(1);
+	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
+	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
+
+	DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
+		owned_head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
+
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL_CLOSED);
+
+	WRITE_ONCE(*submit_qtail, owned_head);
+	WRITE_ONCE(*bypass_qtail, &pcl->next);
+
+	qtail[JQ_BYPASS] = &pcl->next;
 }
 
 static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
 				       unsigned int nr_bios,
 				       bool force_fg)
 {
-	/* bios should be >0 if managed cache is disabled */
-	DBG_BUGON(!nr_bios);
-	return false;
+	/*
+	 * although background is preferred, no one is pending for submission.
+	 * don't issue workqueue for decompression but drop it directly instead.
+	 */
+	if (force_fg || nr_bios)
+		return false;
+
+	kvfree(container_of(q[JQ_SUBMIT], struct z_erofs_unzip_io_sb, io));
+	return true;
 }
 
 static bool z_erofs_vle_submit_all(struct super_block *sb,
@@ -1130,6 +1278,9 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 				    pagepool, io, force_fg))
 		return;
 
+	/* decompress no I/O pclusters immediately */
+	z_erofs_vle_unzip_all(sb, &io[JQ_BYPASS], pagepool);
+
 	if (!force_fg)
 		return;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 3a82ae933015..506ca46727db 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -101,9 +101,12 @@ struct z_erofs_unzip_io_sb {
 	struct super_block *sb;
 };
 
-#define MNGD_MAPPING(sbi)	(NULL)
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
 static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
-					 struct page *page) { return false; }
+					 struct page *page)
+{
+	return page->mapping == MNGD_MAPPING(sbi);
+}
 
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
-- 
2.17.1

