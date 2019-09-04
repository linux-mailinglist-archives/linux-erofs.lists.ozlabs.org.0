Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B1AA78A0
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:12:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS5G1Bm0zDqm9
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:12:34 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS373Jt0zDqlV
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:43 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AAD3C2CB4D783838F6DE;
 Wed,  4 Sep 2019 10:10:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:32 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 24/25] erofs: always use iget5_locked
Date: Wed, 4 Sep 2019 10:09:11 +0800
Message-ID: <20190904020912.63925-25-gaoxiang25@huawei.com>
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

As Christoph said [1] [2], "Just use the slightly
more complicated 32-bit version everywhere so that
you have a single actually tested code path.
And then remove this helper. "

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
[2] https://lore.kernel.org/r/20190902125320.GA16726@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a0cec3c754cd..3350ab65d892 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -243,7 +243,6 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
  * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
  * we should do more for 32-bit platform to find the right inode.
  */
-#if BITS_PER_LONG == 32
 static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
@@ -258,20 +257,14 @@ static int erofs_iget_set_actor(struct inode *inode, void *opaque)
 	inode->i_ino = erofs_inode_hash(nid);
 	return 0;
 }
-#endif
 
 static inline struct inode *erofs_iget_locked(struct super_block *sb,
 					      erofs_nid_t nid)
 {
 	const unsigned long hashval = erofs_inode_hash(nid);
 
-#if BITS_PER_LONG >= 64
-	/* it is safe to use iget_locked for >= 64-bit platform */
-	return iget_locked(sb, hashval);
-#else
 	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
 		erofs_iget_set_actor, &nid);
-#endif
 }
 
 struct inode *erofs_iget(struct super_block *sb,
-- 
2.17.1

