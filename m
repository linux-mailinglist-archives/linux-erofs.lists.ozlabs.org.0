Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A7A788C
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:11:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS3c3p9TzDqm6
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:11:08 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS2j1bRDzDqhC
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:20 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7F63A171F2FC74A1B58E;
 Wed,  4 Sep 2019 10:10:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:07 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 03/25] erofs: some macros are much more readable as a
 function
Date: Wed, 4 Sep 2019 10:08:50 +0800
Message-ID: <20190904020912.63925-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Christoph suggested [1], these macros are much
more readable as a function.

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 22 ++++++++++++++--------
 fs/erofs/inode.c    |  4 ++--
 fs/erofs/xattr.c    |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index d1f152a3670a..c1220b0f26e0 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -171,16 +171,22 @@ struct erofs_xattr_entry {
 	char   e_name[0];       /* attribute name */
 } __packed;
 
-#define ondisk_xattr_ibody_size(count)	({\
-	u32 __count = le16_to_cpu(count); \
-	((__count) == 0) ? 0 : \
-	sizeof(struct erofs_xattr_ibody_header) + \
-		sizeof(__u32) * ((__count) - 1); })
+static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
+{
+	if (!i_xattr_icount)
+		return 0;
+
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(__u32) * (le16_to_cpu(i_xattr_icount) - 1);
+}
 
 #define EROFS_XATTR_ALIGN(size) round_up(size, sizeof(struct erofs_xattr_entry))
-#define EROFS_XATTR_ENTRY_SIZE(entry) EROFS_XATTR_ALIGN( \
-	sizeof(struct erofs_xattr_entry) + \
-	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
+
+static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
+{
+	return EROFS_XATTR_ALIGN(sizeof(struct erofs_xattr_entry) +
+				 e->e_name_len + le16_to_cpu(e->e_value_size));
+}
 
 /* available compression algorithm types */
 enum {
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8a0574530a0a..3fc4f764b387 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -29,7 +29,7 @@ static int read_inode(struct inode *inode, void *data)
 		struct erofs_inode_v2 *v2 = data;
 
 		vi->inode_isize = sizeof(struct erofs_inode_v2);
-		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
+		vi->xattr_isize = erofs_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
 		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
@@ -62,7 +62,7 @@ static int read_inode(struct inode *inode, void *data)
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 		vi->inode_isize = sizeof(struct erofs_inode_v1);
-		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
+		vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
 		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d80f61dde72f..620cbc15f4d0 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -231,7 +231,7 @@ static int xattr_foreach(struct xattr_iter *it,
 	 */
 	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
 	if (tlimit) {
-		unsigned int entry_sz = EROFS_XATTR_ENTRY_SIZE(&entry);
+		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
 
 		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
 		if (*tlimit < entry_sz) {
-- 
2.17.1

