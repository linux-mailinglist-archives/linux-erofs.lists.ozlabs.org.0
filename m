Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869DA786F
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:10:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS2z4j3NzDqlR
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:10:35 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS2d72pZzDqhC
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:17 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 525D9A02AB4F0FA6D09C;
 Wed,  4 Sep 2019 10:10:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:06 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 02/25] erofs: on-disk format should have explicitly
 assigned numbers
Date: Wed, 4 Sep 2019 10:08:49 +0800
Message-ID: <20190904020912.63925-3-gaoxiang25@huawei.com>
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

As Christoph suggested [1], on-disk format should have
explicitly assigned numbers.

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 49335fff9d65..d1f152a3670a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -53,10 +53,10 @@ struct erofs_super_block {
  * 4~7 - reserved
  */
 enum {
-	EROFS_INODE_FLAT_PLAIN,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
-	EROFS_INODE_FLAT_INLINE,
-	EROFS_INODE_FLAT_COMPRESSION,
+	EROFS_INODE_FLAT_PLAIN			= 0,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_FLAT_INLINE			= 2,
+	EROFS_INODE_FLAT_COMPRESSION		= 3,
 	EROFS_INODE_LAYOUT_MAX
 };
 
@@ -184,7 +184,7 @@ struct erofs_xattr_entry {
 
 /* available compression algorithm types */
 enum {
-	Z_EROFS_COMPRESSION_LZ4,
+	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
 
@@ -242,10 +242,10 @@ struct z_erofs_map_header {
  *                (di_advise could be 0, 1 or 2)
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
 	Z_EROFS_VLE_CLUSTER_TYPE_MAX
 };
 
-- 
2.17.1

