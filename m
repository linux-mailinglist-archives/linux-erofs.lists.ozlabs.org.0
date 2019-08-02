Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A02027F7F2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 15:11:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460SGS1S33zDrBB
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 23:11:12 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 460RvF48gfzDr99
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 22:54:33 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A9AACE570F47F5F04040;
 Fri,  2 Aug 2019 20:54:22 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 20:54:14 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "Pavel Machek" <pavel@denx.de>, David Sterba <dsterba@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner
 <david@fromorbit.com>, "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara
 <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v6 06/24] erofs: support special inode
Date: Fri, 2 Aug 2019 20:53:29 +0800
Message-ID: <20190802125347.166018-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802125347.166018-1-gaoxiang25@huawei.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
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

This patch adds to support special inode, such as
block dev, char, socket, pipe inode.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index b6ea997bc4ae..637bf6e4de44 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -34,7 +34,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
@@ -58,7 +67,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
@@ -176,6 +194,11 @@ static int fill_inode(struct inode *inode, int isdir)
 			/* by default, page_get_link is used for symlink */
 			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			inode->i_op = &erofs_generic_iops;
+			init_special_inode(inode, inode->i_mode, inode->i_rdev);
+			goto out_unlock;
 		} else {
 			err = -EIO;
 			goto out_unlock;
-- 
2.17.1

