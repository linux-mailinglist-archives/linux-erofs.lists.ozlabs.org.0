Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EDF74AF5
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 11:59:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45vSPN1LCZzDqPl
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 19:59:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45vSMB46L5zDqPn
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jul 2019 19:57:58 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 09A098223A32FE688F92;
 Thu, 25 Jul 2019 17:57:52 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 17:57:42 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "David Sterba" <dsterba@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 15/24] erofs: introduce erofs shrinker
Date: Thu, 25 Jul 2019 17:56:49 +0800
Message-ID: <20190725095658.155779-16-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725095658.155779-1-gaoxiang25@huawei.com>
References: <20190725095658.155779-1-gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds a dedicated shrinker targeting to free
unneeded memory consumed by a number of erofs in-memory
data structures.

Like F2FS and UBIFS, it also adds:
  - sbi->umount_mutex to avoid races on shrinker and put_super;
  - sbi->shrinker_run_no to not revisit recently scanned objects.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  7 ++++
 fs/erofs/super.c    |  6 +++
 fs/erofs/utils.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2d437bcf140d..3b43f960b7bd 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -64,6 +64,9 @@ struct erofs_sb_info {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
+	struct mutex umount_mutex;
+
+	unsigned int shrinker_run_no;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
@@ -408,9 +411,13 @@ extern const struct file_operations erofs_dir_fops;
 #ifdef CONFIG_EROFS_FS_ZIP
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
+int __init erofs_init_shrinker(void);
+void erofs_exit_shrinker(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
+static inline int erofs_init_shrinker(void) { return 0; }
+static inline void erofs_exit_shrinker(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c9fe585a38a6..b8c48508a0dd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -413,6 +413,9 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto icache_err;
 
+	err = erofs_init_shrinker();
+	if (err)
+		goto shrinker_err;
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -421,6 +424,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_shrinker();
+shrinker_err:
 	erofs_exit_inode_cache();
 icache_err:
 	return err;
@@ -429,6 +434,7 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
+	erofs_exit_shrinker();
 	erofs_exit_inode_cache();
 	infoln("successfully finalize erofs");
 }
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 791b2df1f761..cab7d77c4e59 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -9,6 +9,12 @@
 #include "internal.h"
 
 #ifdef CONFIG_EROFS_FS_ZIP
+/* global shrink count (for all mounted EROFS instances) */
+static atomic_long_t erofs_global_shrink_cnt;
+
+/* protected by 'erofs_sb_list_lock' */
+static unsigned int shrinker_run_no;
+
 /* protects the mounted 'erofs_sb_list' */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
@@ -17,6 +23,8 @@ void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
+	mutex_init(&sbi->umount_mutex);
+
 	spin_lock(&erofs_sb_list_lock);
 	list_add(&sbi->list, &erofs_sb_list);
 	spin_unlock(&erofs_sb_list_lock);
@@ -24,9 +32,92 @@ void erofs_shrinker_register(struct super_block *sb)
 
 void erofs_shrinker_unregister(struct super_block *sb)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+
+	mutex_lock(&sbi->umount_mutex);
+	/* will add shrink final handler here */
+
+	spin_lock(&erofs_sb_list_lock);
+	list_del(&sbi->list);
+	spin_unlock(&erofs_sb_list_lock);
+	mutex_unlock(&sbi->umount_mutex);
+}
+
+static unsigned long erofs_shrink_count(struct shrinker *shrink,
+					struct shrink_control *sc)
+{
+	return atomic_long_read(&erofs_global_shrink_cnt);
+}
+
+static unsigned long erofs_shrink_scan(struct shrinker *shrink,
+				       struct shrink_control *sc)
+{
+	struct erofs_sb_info *sbi;
+	struct list_head *p;
+
+	unsigned long nr = sc->nr_to_scan;
+	unsigned int run_no;
+	unsigned long freed = 0;
+
 	spin_lock(&erofs_sb_list_lock);
-	list_del(&EROFS_SB(sb)->list);
+	do {
+		run_no = ++shrinker_run_no;
+	} while (run_no == 0);
+
+	/* Iterate over all mounted superblocks and try to shrink them */
+	p = erofs_sb_list.next;
+	while (p != &erofs_sb_list) {
+		sbi = list_entry(p, struct erofs_sb_info, list);
+
+		/*
+		 * We move the ones we do to the end of the list, so we stop
+		 * when we see one we have already done.
+		 */
+		if (sbi->shrinker_run_no == run_no)
+			break;
+
+		if (!mutex_trylock(&sbi->umount_mutex)) {
+			p = p->next;
+			continue;
+		}
+
+		spin_unlock(&erofs_sb_list_lock);
+		sbi->shrinker_run_no = run_no;
+
+		/* will add shrink handler here */
+
+		spin_lock(&erofs_sb_list_lock);
+		/* Get the next list element before we move this one */
+		p = p->next;
+
+		/*
+		 * Move this one to the end of the list to provide some
+		 * fairness.
+		 */
+		list_move_tail(&sbi->list, &erofs_sb_list);
+		mutex_unlock(&sbi->umount_mutex);
+
+		if (freed >= nr)
+			break;
+	}
 	spin_unlock(&erofs_sb_list_lock);
+	return freed;
+}
+
+static struct shrinker erofs_shrinker_info = {
+	.scan_objects = erofs_shrink_scan,
+	.count_objects = erofs_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
+int __init erofs_init_shrinker(void)
+{
+	return register_shrinker(&erofs_shrinker_info);
+}
+
+void erofs_exit_shrinker(void)
+{
+	unregister_shrinker(&erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-- 
2.17.1

