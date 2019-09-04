Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7AA7892
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:11:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS4G1LJ2zDqlw
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:11:42 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS2s0ZrKzDql2
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:28 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6F718D93F59080B35CF4;
 Wed,  4 Sep 2019 10:10:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 11/25] erofs: update comments in inode.c
Date: Wed, 4 Sep 2019 10:08:58 +0800
Message-ID: <20190904020912.63925-12-gaoxiang25@huawei.com>
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

As Christoph suggested [1], update them all.

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index f6dfd0271261..a42f5fc14df9 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -147,7 +147,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE)
 		return 0;
 
-	/* fast symlink (following ext4) */
+	/* fast symlink */
 	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
 		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
 
@@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 
 		m_pofs += vi->inode_isize + vi->xattr_isize;
 
-		/* inline symlink data shouldn't across page boundary as well */
+		/* inline symlink data shouldn't cross page boundary as well */
 		if (m_pofs + inode->i_size > PAGE_SIZE) {
 			kfree(lnk);
 			errln("inline data cross block boundary @ nid %llu",
@@ -165,7 +165,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 			return -EFSCORRUPTED;
 		}
 
-		/* get in-page inline data */
 		memcpy(lnk, data + m_pofs, inode->i_size);
 		lnk[inode->i_size] = '\0';
 
-- 
2.17.1

