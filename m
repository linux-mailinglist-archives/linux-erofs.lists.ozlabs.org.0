Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65663847C
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 08:31:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJRPh2Y7Rz3ccw
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 18:31:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
X-Greylist: delayed 957 seconds by postgrey-1.36 at boromir; Fri, 25 Nov 2022 18:31:31 AEDT
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJRPb5Jspz3cFn
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Nov 2022 18:31:30 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NJR2r5yqhz4f3tTd
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Nov 2022 15:15:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHONaGa4BjmM56BA--.40764S4;
	Fri, 25 Nov 2022 15:15:19 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: check the uniqueness of fsid in shared domain in advance
Date: Fri, 25 Nov 2022 15:40:57 +0800
Message-Id: <20221125074057.2229083-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONaGa4BjmM56BA--.40764S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1Dury8ur4xXFy5Gr1rJFb_yoW3Wr1xpa
	yfCw1SqrWkXry5ua1fXF4DXFyfK3s7ta1DCw48J3sYyw48Jr18GryvyFyYkF47GryDArWI
	vF42va1Uuw48Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
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
Cc: Yue Hu <huyue2@coolpad.com>, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hou Tao <houtao1@huawei.com>

When shared domain is enabled, doing mount twice with the same fsid and
domain_id will trigger sysfs warning as shown below:

 sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
 CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x38/0x49
  dump_stack+0x10/0x12
  sysfs_warn_dup.cold+0x17/0x27
  sysfs_create_dir_ns+0xb8/0xd0
  kobject_add_internal+0xb1/0x240
  kobject_init_and_add+0x71/0xa0
  erofs_register_sysfs+0x89/0x110
  erofs_fc_fill_super+0x98c/0xaf0
  vfs_get_super+0x7d/0x100
  get_tree_nodev+0x16/0x20
  erofs_fc_get_tree+0x20/0x30
  vfs_get_tree+0x24/0xb0
  path_mount+0x2fa/0xa90
  do_mount+0x7c/0xa0
  __x64_sys_mount+0x8b/0xe0
  do_syscall_64+0x30/0x60
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
data blob (aka fsid) is unique in the shared domain and
erofs_register_sysfs() invoked by the second mount will fail due to the
duplicated fsid in the shared domain and report warning.

It would be better to check the uniqueness of fsid before doing
erofs_register_sysfs(), so adding a new flags parameter for
erofs_fscache_register_cookie() and doing the uniqueness check if
EROFS_REG_COOKIE_NEED_NOEXIST is enabled.

After the patch, the error in dmesg for the duplicated mount would be:

 erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/erofs/fscache.c  | 47 +++++++++++++++++++++++++++++++++------------
 fs/erofs/internal.h | 10 ++++++++--
 fs/erofs/super.c    |  2 +-
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index af5ed6b9c54d..6a792a513d6b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -494,7 +494,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 
 static
 struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
-						    char *name, bool need_inode)
+						   char *name,
+						   unsigned int flags)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -516,7 +517,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	fscache_use_cookie(cookie, false);
 	ctx->cookie = cookie;
 
-	if (need_inode) {
+	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
 		struct inode *const inode = new_inode(sb);
 
 		if (!inode) {
@@ -554,14 +555,15 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 
 static
 struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
-		char *name, bool need_inode)
+						       char *name,
+						       unsigned int flags)
 {
 	int err;
 	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
-	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
+	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
 	if (IS_ERR(ctx))
 		return ctx;
 
@@ -589,7 +591,8 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 static
 struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
-						   char *name, bool need_inode)
+						   char *name,
+						   unsigned int flags)
 {
 	struct inode *inode;
 	struct erofs_fscache *ctx;
@@ -602,23 +605,30 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 		ctx = inode->i_private;
 		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
 			continue;
-		igrab(inode);
+		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
+			igrab(inode);
+		} else {
+			erofs_err(sb, "%s already exists in domain %s", name,
+				  domain->domain_id);
+			ctx = ERR_PTR(-EEXIST);
+		}
 		spin_unlock(&psb->s_inode_list_lock);
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
 	spin_unlock(&psb->s_inode_list_lock);
-	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
+	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
 }
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						    char *name, bool need_inode)
+						    char *name,
+						    unsigned int flags)
 {
 	if (EROFS_SB(sb)->domain_id)
-		return erofs_domain_register_cookie(sb, name, need_inode);
-	return erofs_fscache_acquire_cookie(sb, name, need_inode);
+		return erofs_domain_register_cookie(sb, name, flags);
+	return erofs_fscache_acquire_cookie(sb, name, flags);
 }
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
@@ -647,6 +657,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
+	unsigned int flags;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -655,8 +666,20 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	if (ret)
 		return ret;
 
-	/* acquired domain/volume will be relinquished in kill_sb() on error */
-	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, true);
+	/*
+	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
+	 * the primary data blob (aka fsid) is unique in the shared domain.
+	 *
+	 * For non-shared-domain case, fscache_acquire_volume() invoked by
+	 * erofs_fscache_register_volume() has already guaranteed
+	 * the uniqueness of primary data blob.
+	 *
+	 * Acquired domain/volume will be relinquished in kill_sb() on error.
+	 */
+	flags = EROFS_REG_COOKIE_NEED_INODE;
+	if (sbi->domain_id)
+		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
+	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 05dc68627722..a5f8c8fcdd17 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -604,13 +604,18 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+/* flags for erofs_fscache_register_cookie() */
+#define EROFS_REG_COOKIE_NEED_INODE 1
+#define EROFS_REG_COOKIE_NEED_NOEXIST 2
+
 /* fscache.c */
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode);
+						    char *name,
+						    unsigned int flags);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
@@ -623,7 +628,8 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
 static inline
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode)
+						     char *name,
+						     unsigned int flags)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1c7dcca702b3..481788c24a68 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -245,7 +245,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
+		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-- 
2.29.2

