Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5BA789D
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:12:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS525PH4zDqml
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:12:22 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS3624C7zDqlr
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:42 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 060AAA4F430BAAEEEBB4;
 Wed,  4 Sep 2019 10:10:39 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:28 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 21/25] erofs: save one level of indentation
Date: Wed, 4 Sep 2019 10:09:08 +0800
Message-ID: <20190904020912.63925-22-gaoxiang25@huawei.com>
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

As Christoph said [1], ".. and save one
level of indentation."

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8e53765a532c..5a6d3282fefb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -193,41 +193,42 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	data = page_address(page);
 
 	err = erofs_read_inode(inode, data + ofs);
-	if (!err) {
-		/* setup the new inode */
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFREG:
-			inode->i_op = &erofs_generic_iops;
-			inode->i_fop = &generic_ro_fops;
-			break;
-		case S_IFDIR:
-			inode->i_op = &erofs_dir_iops;
-			inode->i_fop = &erofs_dir_fops;
-			break;
-		case S_IFLNK:
-			err = erofs_fill_symlink(inode, data, ofs);
-			if (err)
-				goto out_unlock;
-			inode_nohighmem(inode);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			inode->i_op = &erofs_generic_iops;
-			init_special_inode(inode, inode->i_mode, inode->i_rdev);
-			goto out_unlock;
-		default:
-			err = -EFSCORRUPTED;
+	if (err)
+		goto out_unlock;
+
+	/* setup the new inode */
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &erofs_generic_iops;
+		inode->i_fop = &generic_ro_fops;
+		break;
+	case S_IFDIR:
+		inode->i_op = &erofs_dir_iops;
+		inode->i_fop = &erofs_dir_fops;
+		break;
+	case S_IFLNK:
+		err = erofs_fill_symlink(inode, data, ofs);
+		if (err)
 			goto out_unlock;
-		}
+		inode_nohighmem(inode);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_op = &erofs_generic_iops;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		goto out_unlock;
+	default:
+		err = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 
-		if (erofs_inode_is_data_compressed(vi->datalayout)) {
-			err = z_erofs_fill_inode(inode);
-			goto out_unlock;
-		}
-		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		err = z_erofs_fill_inode(inode);
+		goto out_unlock;
 	}
+	inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 out_unlock:
 	unlock_page(page);
-- 
2.17.1

