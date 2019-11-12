Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC13F8E8B
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2019 12:25:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47C54x0NmQzF4J4
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2019 22:25:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C54S3k5pzF4FS
 for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2019 22:24:38 +1100 (AEDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0BA47A979C19132017ED
 for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2019 19:24:28 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 12 Nov
 2019 19:24:20 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] erofs-utils: complete missing memory handling
Date: Tue, 12 Nov 2019 19:26:49 +0800
Message-ID: <20191112112650.143498-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

memory allocation failure should be handled
properly in principle.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
[ Gao Xiang: due to Huawei outgoing email limitation,
  I have to help Guifu send out his patches at work. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/inode.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 86c465ee2f78..620db60f4a5b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -264,6 +264,8 @@ int erofs_write_dir_file(struct erofs_inode *dir)
 	if (used) {
 		/* fill tail-end dir block */
 		dir->idata = malloc(used);
+		if (!dir->idata)
+			return -ENOMEM;
 		DBG_BUGON(used != dir->idata_size);
 		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
 	}
@@ -286,6 +288,8 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
+		if (!inode->idata)
+			return -ENOMEM;
 		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
 		       inode->idata_size);
 	}
@@ -347,9 +351,12 @@ int erofs_write_file(struct erofs_inode *inode)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
+		if (!inode->idata)
+			return -ENOMEM;
 
 		ret = read(fd, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
+			free(inode->idata);
 			close(fd);
 			return -EIO;
 		}
@@ -825,12 +832,18 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
 
+			if (!symlink)
+				return ERR_PTR(-ENOMEM);
 			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
-			if (ret < 0)
+			if (ret < 0) {
+				free(symlink);
 				return ERR_PTR(-errno);
+			}
 
-			erofs_write_file_from_buffer(dir, symlink);
+			ret = erofs_write_file_from_buffer(dir, symlink);
 			free(symlink);
+			if (ret)
+				return ERR_PTR(ret);
 		} else {
 			erofs_write_file(dir);
 		}
-- 
2.17.1

