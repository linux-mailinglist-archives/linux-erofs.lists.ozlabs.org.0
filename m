Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F1A019F1
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jan 2025 16:12:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YR15822s9z3c5P
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 02:12:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736089944;
	cv=none; b=Wqe1w8TKro8vLHKHcTVLM38tkw3tc0Y09+y4oPYhktMcuUP2Yljg5VUev11O6hL3je4BlfsnOwNDVn/1FAoyR0I5d3lpAUu8WUrc5HL0mKRXk++bKMFI9lBMKLakt6SMORp9mGaMCSdFgqi18lENmmdf2i+t7m4rQpGcvvILEib39X7uBWS7lXQKtaCsjVUTU/0ww1RO+shyNjkPfOLxOXwhHKxXlmM+eQ3Tt0kXukhtmjA3pPOmyqncRNSoJvTsPohFQ4CX5c2s+wnFw6BTamtxyz/EQ//Qxm48ruwL8uTxXJOlT27KIDGEil+boLnM3GhIWBiZAOicFSERvfPT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736089944; c=relaxed/relaxed;
	bh=zcuKqis8GqEhVM+85u6GWnryNgXPPTu4+n1bBvKQiR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0IRxlK/IdmBNVa6EO0IRWu+eMpaSmvporFuNi+ThxDxYvOoSQzqwV+irejhd5YHZP26JJ4l6kTEuJ7cAjJ2buJ9YW+0JDbdreEAyTaQ7/FvZ3LZU9RLGK7wK0zbhZlsYNabJxkAxCdCgZlTem61Eto+lUChymYo8l6S5ms8B+iqUDSFUCNqPH2QJoboqps6gPWbWiC6OHdGtQ7YpMd5T70ktZ+cE4JTwAkTGW8uZvVchrHsCQQXgjHeZfbVW2ChwVyLPcviAsGmp0TnmM2DEwU19E1mJOLBeSLmIl+k4EfEb1BuJMOArnaS15o6hRgNV4lQeLR1BEW0B2xBamXazA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S6zihR0a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S6zihR0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YR15044DGz30Gm
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 02:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736089934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zcuKqis8GqEhVM+85u6GWnryNgXPPTu4+n1bBvKQiR8=;
	b=S6zihR0av8p+pe8JA7Uz0mcClBcFTswS+WBTsZ3DL+ZMviZoVIFIMLz+HDLXkToYOc4wrfXaBvHL3U3p6pvxvX8sKo+4X5XdlLMwlZLajC8FIgJngzgrE9/gZ/O3KugCzeQlewo2zbHXpU5BGW3xGWDrxsUPiUvzQaTdNHtK0Bk=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WMypL8l_1736089932 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 05 Jan 2025 23:12:13 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 3/4] erofs: apply the page cache share feature
Date: Sun,  5 Jan 2025 23:12:07 +0800
Message-ID: <20250105151208.3797385-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

This modifies relevant functions to apply the page cache
share feature.

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c            | 14 +++++++--
 fs/erofs/inode.c           |  5 ++-
 fs/erofs/pagecache_share.c | 63 ++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h | 11 +++++++
 fs/erofs/super.c           |  7 +++++
 fs/erofs/zdata.c           |  9 ++++--
 6 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..fb08acbeaab6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include "pagecache_share.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
@@ -370,12 +371,21 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	int ret, pcshr;
+
+	pcshr = erofs_pcshr_read_begin(file, folio);
+	ret = iomap_read_folio(folio, &erofs_iomap_ops);
+	erofs_pcshr_read_end(file, folio, pcshr);
+	return ret;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	int pcshr;
+
+	pcshr = erofs_pcshr_readahead_begin(rac);
+	iomap_readahead(rac, &erofs_iomap_ops);
+	erofs_pcshr_readahead_end(rac, pcshr);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d4b89407822a..0b070f4b46b8 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "pagecache_share.h"
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
@@ -212,7 +213,9 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
-		if (erofs_inode_is_data_compressed(vi->datalayout))
+		if (erofs_pcshr_fill_inode(inode) == 0)
+			inode->i_fop = &erofs_pcshr_fops;
+		else if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
index 703fd17c002c..22172b5e21c7 100644
--- a/fs/erofs/pagecache_share.c
+++ b/fs/erofs/pagecache_share.c
@@ -22,6 +22,7 @@ struct erofs_pcshr_counter {
 
 struct erofs_pcshr_private {
 	char fprt[PCSHR_FPRT_MAXLEN];
+	struct mutex mutex;
 };
 
 static struct erofs_pcshr_counter mnt_counter = {
@@ -84,6 +85,7 @@ static int erofs_fprt_set(struct inode *inode, void *data)
 	if (!ano_private)
 		return -ENOMEM;
 	memcpy(ano_private, data, sizeof(size_t) + *(size_t *)data);
+	mutex_init(&ano_private->mutex);
 	inode->i_private = ano_private;
 	return 0;
 }
@@ -226,3 +228,64 @@ const struct file_operations erofs_pcshr_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
+
+int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
+{
+	struct erofs_inode *vi;
+	struct erofs_pcshr_private *ano_private;
+
+	if (!(file && file->private_data))
+		return 0;
+
+	vi = file->private_data;
+	if (vi->ano_inode != file_inode(file))
+		return 0;
+
+	ano_private = vi->ano_inode->i_private;
+	mutex_lock(&ano_private->mutex);
+	folio->mapping->host = &vi->vfs_inode;
+	return 1;
+}
+
+void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr)
+{
+	struct erofs_pcshr_private *ano_private;
+
+	if (pcshr == 0)
+		return;
+
+	ano_private = file_inode(file)->i_private;
+	folio->mapping->host = file_inode(file);
+	mutex_unlock(&ano_private->mutex);
+}
+
+int erofs_pcshr_readahead_begin(struct readahead_control *rac)
+{
+	struct erofs_inode *vi;
+	struct file *file = rac->file;
+	struct erofs_pcshr_private *ano_private;
+
+	if (!(file && file->private_data))
+		return 0;
+
+	vi = file->private_data;
+	if (vi->ano_inode != file_inode(file))
+		return 0;
+
+	ano_private = file_inode(file)->i_private;
+	mutex_lock(&ano_private->mutex);
+	rac->mapping->host = &vi->vfs_inode;
+	return 1;
+}
+
+void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr)
+{
+	struct erofs_pcshr_private *ano_private;
+
+	if (pcshr == 0)
+		return;
+
+	ano_private = file_inode(rac->file)->i_private;
+	rac->mapping->host = file_inode(rac->file);
+	mutex_unlock(&ano_private->mutex);
+}
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
index f3889d6889e5..abda2a60278b 100644
--- a/fs/erofs/pagecache_share.h
+++ b/fs/erofs/pagecache_share.h
@@ -14,6 +14,12 @@ void erofs_pcshr_free_mnt(void);
 int erofs_pcshr_fill_inode(struct inode *inode);
 void erofs_pcshr_free_inode(struct inode *inode);
 
+/* switch between the anonymous inode and the real inode */
+int erofs_pcshr_read_begin(struct file *file, struct folio *folio);
+void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr);
+int erofs_pcshr_readahead_begin(struct readahead_control *rac);
+void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr);
+
 #else
 
 static inline int erofs_pcshr_init_mnt(void) { return 0; }
@@ -21,6 +27,11 @@ static inline void erofs_pcshr_free_mnt(void) {}
 static inline int erofs_pcshr_fill_inode(struct inode *inode) { return -1; }
 static inline void erofs_pcshr_free_inode(struct inode *inode) {}
 
+static inline int erofs_pcshr_read_begin(struct file *file, struct folio *folio) { return 0; }
+static inline void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr) {}
+static inline int erofs_pcshr_readahead_begin(struct readahead_control *rac) { return 0; }
+static inline void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr) {}
+
 #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b4ce07dc931c..1b690eb6c1f1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -81,6 +82,7 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+	erofs_pcshr_free_inode(inode);
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -683,6 +685,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_pcshr_init_mnt();
+	if (err)
+		return err;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
@@ -818,6 +824,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+	erofs_pcshr_free_mnt();
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 19ef4ff2a134..fc2ed01eaabe 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
+#include "pagecache_share.h"
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
@@ -1891,9 +1892,10 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	int err;
+	int err, pcshr;
 
 	trace_erofs_read_folio(folio, false);
+	pcshr = erofs_pcshr_read_begin(file, folio);
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
@@ -1909,6 +1911,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+	erofs_pcshr_read_end(file, folio, pcshr);
 	return err;
 }
 
@@ -1918,8 +1921,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct folio *head = NULL, *folio;
 	unsigned int nr_folios;
-	int err;
+	int err, pcshr;
 
+	pcshr = erofs_pcshr_readahead_begin(rac);
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, true);
@@ -1947,6 +1951,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nr_folios);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+	erofs_pcshr_readahead_end(rac, pcshr);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.43.5

