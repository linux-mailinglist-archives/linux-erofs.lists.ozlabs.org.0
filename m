Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA022398F97
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Jun 2021 18:06:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FwDRs1RzGz2yxL
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jun 2021 02:06:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k5U45MSD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=k5U45MSD; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FwDRm00NVz2yYK
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jun 2021 02:06:43 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8B46161E;
 Wed,  2 Jun 2021 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622650000;
 bh=EHFr9F6g1VxVXVXM8lxkOJtRT+aYKQvDtKCMXAdXLTI=;
 h=From:To:Cc:Subject:Date:From;
 b=k5U45MSDgqZSf5TEI+EAS18aXE+2SF3KOdoKaUL8MPSQh+vTd++U7wYPqufBywd3H
 2kCr52LiNuBwIPQdYhT6Oa0EtJfyWoDzGGHv/pCVpfgjWSEPZqAyg7nZEIfvzp/qeM
 pP7pHkz1jUoT2tPz7EUW5UY/speA15+/Ea0jQOfwqnThubHE1wgWwMxGg4BcheEf8I
 U91sE2GCAcDZ3+z2eGRNqnyTl3qse4myOmrdOgdJj1epo3/yjtA5RcyYNUPETAHA/s
 xEdVQKH90+b08xy54knnw7lhj/VMTgNrCP57W2sIZeQ3LfZrPvWSu3eSCox/S+AUL8
 g9yMJdm5h5R7Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up file headers & footers
Date: Thu,  3 Jun 2021 00:06:34 +0800
Message-Id: <20210602160634.10757-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

 - Remove my outdated misleading email address;

 - Get rid of all unnecessary trailing newline by accident.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig        | 1 -
 fs/erofs/compress.h     | 2 --
 fs/erofs/data.c         | 2 --
 fs/erofs/decompressor.c | 2 --
 fs/erofs/dir.c          | 2 --
 fs/erofs/erofs_fs.h     | 2 --
 fs/erofs/inode.c        | 2 --
 fs/erofs/internal.h     | 2 --
 fs/erofs/namei.c        | 2 --
 fs/erofs/super.c        | 2 --
 fs/erofs/tagptr.h       | 3 ---
 fs/erofs/utils.c        | 2 --
 fs/erofs/xattr.c        | 2 --
 fs/erofs/xattr.h        | 1 -
 fs/erofs/zdata.c        | 2 --
 fs/erofs/zdata.h        | 1 -
 fs/erofs/zmap.c         | 2 --
 fs/erofs/zpvec.h        | 2 --
 18 files changed, 34 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 858b3339f381..906af0c1998c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -75,4 +75,3 @@ config EROFS_FS_ZIP
 	  Enable fixed-sized output compression for EROFS.
 
 	  If you don't want to enable compression feature, say N.
-
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index aea129ddda74..3701c72bacb2 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_COMPRESS_H
 #define __EROFS_FS_COMPRESS_H
@@ -85,4 +84,3 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool);
 
 #endif
-
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ebac756cb2a3..3787a5fb0a42 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
 #include <linux/prefetch.h>
@@ -315,4 +314,3 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.readahead = erofs_raw_access_readahead,
 	.bmap = erofs_bmap,
 };
-
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 88e33addf229..a5bc4b1b7813 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "compress.h"
 #include <linux/module.h>
@@ -407,4 +406,3 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		return z_erofs_shifted_transform(rq, pagepool);
 	return z_erofs_decompress_generic(rq, pagepool);
 }
-
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 2776bb832127..eee9b0b31b63 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
 
@@ -139,4 +138,3 @@ const struct file_operations erofs_dir_fops = {
 	.read		= generic_read_dir,
 	.iterate_shared	= erofs_readdir,
 };
-
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 8739d3adf51f..0f8da74570b4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
@@ -348,4 +347,3 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 }
 
 #endif
-
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7ed2d7391692..aa8a0d770ba3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "xattr.h"
 
@@ -374,4 +373,3 @@ const struct inode_operations erofs_fast_symlink_iops = {
 	.listxattr = erofs_listxattr,
 	.get_acl = erofs_get_acl,
 };
-
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f92e3e32b9f4..543c2ff97d30 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_INTERNAL_H
 #define __EROFS_INTERNAL_H
@@ -469,4 +468,3 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 3a81e1f7fc06..a8271ce5e13f 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "xattr.h"
 
@@ -247,4 +246,3 @@ const struct inode_operations erofs_dir_iops = {
 	.listxattr = erofs_listxattr,
 	.get_acl = erofs_get_acl,
 };
-
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 22991d22af5a..8fc6c04b54f4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include <linux/module.h>
 #include <linux/buffer_head.h>
@@ -752,4 +751,3 @@ module_exit(erofs_module_exit);
 MODULE_DESCRIPTION("Enhanced ROM File System");
 MODULE_AUTHOR("Gao Xiang, Chao Yu, Miao Xie, CONSUMER BG, HUAWEI Inc.");
 MODULE_LICENSE("GPL");
-
diff --git a/fs/erofs/tagptr.h b/fs/erofs/tagptr.h
index a72897c86744..64ceb7270b5c 100644
--- a/fs/erofs/tagptr.h
+++ b/fs/erofs/tagptr.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * A tagged pointer implementation
- *
- * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_TAGPTR_H
 #define __EROFS_FS_TAGPTR_H
@@ -107,4 +105,3 @@ tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
 *ptptr; })
 
 #endif	/* __EROFS_FS_TAGPTR_H */
-
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 6758c5b19f7c..bd86067a63f7 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
 #include <linux/pagevec.h>
@@ -278,4 +277,3 @@ void erofs_exit_shrinker(void)
 	unregister_shrinker(&erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 47314a26767a..8dd54b420a1d 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include <linux/security.h>
 #include "xattr.h"
@@ -709,4 +708,3 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type)
 	return acl;
 }
 #endif
-
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 815304bd335f..366dcb400525 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_XATTR_H
 #define __EROFS_XATTR_H
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 275fef484f24..cb4d0889eca9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "zdata.h"
 #include "compress.h"
@@ -1469,4 +1468,3 @@ const struct address_space_operations z_erofs_aops = {
 	.readpage = z_erofs_readpage,
 	.readahead = z_erofs_readahead,
 };
-
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 942ee69dff6a..3a008f1b9f78 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_ZDATA_H
 #define __EROFS_FS_ZDATA_H
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index efaf32596b97..f68aea4baed7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
 #include <asm/unaligned.h>
@@ -597,4 +596,3 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
-
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
index 95a620739e6a..dfd7fe0503bb 100644
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_ZPVEC_H
 #define __EROFS_FS_ZPVEC_H
@@ -151,4 +150,3 @@ z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
 	return tagptr_unfold_ptr(t);
 }
 #endif
-
-- 
2.20.1

