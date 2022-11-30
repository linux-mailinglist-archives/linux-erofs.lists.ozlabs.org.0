Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6D63CF16
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 07:05:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMTFh67xJz3bNt
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 17:05:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.8; helo=out30-8.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMTFX6QJ8z2xfS
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 17:05:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW1iHGt_1669788295;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW1iHGt_1669788295)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 14:04:56 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: enable large folios for iomap mode
Date: Wed, 30 Nov 2022 14:04:55 +0800
Message-Id: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Enable large folios for iomap mode.  Then the readahead routine will
pass down large folios containing multiple pages.

Let's enable this for non-compressed format for now, until the
compression part supports large folios later.

When large folios supported, the iomap routine will allocate iomap_page
for each large folio and thus we need iomap_release_folio() and
iomap_invalidate_folio() to free iomap_page when these folios get
recalimed or invalidated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2:
- add calling for iomap_release_folio() and iomap_invalidate_folio() to
  support large folios

v1: https://lore.kernel.org/all/20221110074023.8059-1-jefflexu@linux.alibaba.com/
---
 fs/erofs/data.c  | 2 ++
 fs/erofs/inode.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fe8ac0e163f7..c9526c627dda 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -403,6 +403,8 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
+	.release_folio = iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 };
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ad2a82f2eb4c..e457b8a59ee7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,6 +295,8 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (!erofs_is_fscache_mode(inode->i_sb))
+		mapping_set_large_folios(inode->i_mapping);
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (erofs_is_fscache_mode(inode->i_sb))
 		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-- 
2.19.1.6.gb485710b

