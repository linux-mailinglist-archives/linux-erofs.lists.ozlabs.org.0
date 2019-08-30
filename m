Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DEBA2D7D
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 05:41:57 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KQJf34MGzDrMH
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 13:41:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KQCx1lKGzDrPZ
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 13:37:47 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 483BAEEDE2AF0D28A9B0;
 Fri, 30 Aug 2019 11:37:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:37:34 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Joe Perches <joe@perches.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v3 5/7] erofs: kill erofs_{init,exit}_inode_cache
Date: Fri, 30 Aug 2019 11:36:41 +0800
Message-ID: <20190830033643.51019-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830033643.51019-1-gaoxiang25@huawei.com>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
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

As Christoph said [1] "having this function
seems entirely pointless", I have to kill those.

filesystem                              function name
ext2,f2fs,ext4,isofs,squashfs,cifs,...  init_inodecache

In addition, add a "rcu_barrier()" when exit_fs();

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
no change.

 fs/erofs/super.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6d3a9bcb8daa..556aae5426d6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -23,21 +23,6 @@ static void init_once(void *ptr)
 	inode_init_once(&vi->vfs_inode);
 }
 
-static int __init erofs_init_inode_cache(void)
-{
-	erofs_inode_cachep = kmem_cache_create("erofs_inode",
-					       sizeof(struct erofs_vnode), 0,
-					       SLAB_RECLAIM_ACCOUNT,
-					       init_once);
-
-	return erofs_inode_cachep ? 0 : -ENOMEM;
-}
-
-static void erofs_exit_inode_cache(void)
-{
-	kmem_cache_destroy(erofs_inode_cachep);
-}
-
 static struct inode *alloc_inode(struct super_block *sb)
 {
 	struct erofs_vnode *vi =
@@ -531,9 +516,14 @@ static int __init erofs_module_init(void)
 	erofs_check_ondisk_layout_definitions();
 	infoln("initializing erofs " EROFS_VERSION);
 
-	err = erofs_init_inode_cache();
-	if (err)
+	erofs_inode_cachep = kmem_cache_create("erofs_inode",
+					       sizeof(struct erofs_vnode), 0,
+					       SLAB_RECLAIM_ACCOUNT,
+					       init_once);
+	if (!erofs_inode_cachep) {
+		err = -ENOMEM;
 		goto icache_err;
+	}
 
 	err = erofs_init_shrinker();
 	if (err)
@@ -555,7 +545,7 @@ static int __init erofs_module_init(void)
 zip_err:
 	erofs_exit_shrinker();
 shrinker_err:
-	erofs_exit_inode_cache();
+	kmem_cache_destroy(erofs_inode_cachep);
 icache_err:
 	return err;
 }
@@ -565,7 +555,10 @@ static void __exit erofs_module_exit(void)
 	unregister_filesystem(&erofs_fs_type);
 	z_erofs_exit_zip_subsystem();
 	erofs_exit_shrinker();
-	erofs_exit_inode_cache();
+
+	/* Ensure all RCU free inodes are safe before cache is destroyed. */
+	rcu_barrier();
+	kmem_cache_destroy(erofs_inode_cachep);
 	infoln("successfully finalize erofs");
 }
 
-- 
2.17.1

