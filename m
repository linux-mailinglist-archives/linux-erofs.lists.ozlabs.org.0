Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C70806A71
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 10:11:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlWqc6Zp3z3d9g
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 20:11:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlWqG0VZ1z3cZ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 20:11:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRQh_1701853876;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRQh_1701853876)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs: enable sub-page compressed block support
Date: Wed,  6 Dec 2023 17:10:57 +0800
Message-Id: <20231206091057.87027-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's just disable cached decompression and inplace I/Os for partial
pages as a first step in order to enable sub-page block initial
support.  In other words, currently it works primarily based on
temporary short-lived pages.  Don't expect too much in terms of
performance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 6 ++++--
 fs/erofs/zdata.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 14a79d3226ab..3d616dea55dc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -259,8 +259,10 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		if (!erofs_is_fscache_mode(inode->i_sb) &&
-		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
+		if (!erofs_is_fscache_mode(inode->i_sb)) {
+			DO_ONCE_LITE_IF(inode->i_sb->s_blocksize != PAGE_SIZE,
+				  erofs_info, inode->i_sb,
+				  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 			inode->i_mapping->a_ops = &z_erofs_aops;
 			err = 0;
 			goto out_unlock;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d02989466711..a2c3e87d2f81 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -563,6 +563,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 	unsigned int i;
 
+	if (i_blocksize(fe->inode) != PAGE_SIZE)
+		return;
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
 		return;
 
@@ -967,12 +969,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
+	const unsigned int bs = i_blocksize(inode);
 	bool tight = true, exclusive;
 	unsigned int cur, end, len, split;
 	int err = 0;
 
 	z_erofs_onlinepage_init(page);
-
 	split = 0;
 	end = PAGE_SIZE;
 repeat:
@@ -1021,7 +1023,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
-	exclusive = (!cur && ((split <= 1) || tight));
+	exclusive = (!cur && ((split <= 1) || (tight && bs == PAGE_SIZE)));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
-- 
2.39.3

