Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FCC12CF0A
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 12:11:44 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47mZWK4QJczDqB0
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 22:11:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EE3WRRxh"; 
 dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47mZW961F7zDq5k
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2019 22:11:31 +1100 (AEDT)
Received: by mail-pj1-x1041.google.com with SMTP id s94so4599971pjc.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2019 03:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ll/9u6F9AA5LtQdY9cFPDLOu7w2e+F0tbZl5M/xPd+4=;
 b=EE3WRRxhYKWdL06BOl7qAXboP9q30TVrItqUPJtTEYt77MdOjCIbKXHHsjrIYIkNAo
 Kh2efuAbsCI+KSnIPSgZpeT6+77Lj4JPCRRGTKHYCrQXJ8s15cIs9eAYVyPGmzvUpegl
 vsN4EbtZXYfO0Jv1jvcMUVdLSTGzD29EzJm6cz66l8/oooeNNYVehhm24SUsi9DJIW7P
 6k1NCTLDz5/lBFmRfBCGKjZncxzJWKvtuSeloEm3xGrKMOPKf0k0g0jsGuFHzvStcaP3
 4SlEcN64enmn8E6zpz17/+VKAOvnDUSVd29/vRaZtGAtlcAJw1aTJdxxsxxFewP7kRmz
 Qd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ll/9u6F9AA5LtQdY9cFPDLOu7w2e+F0tbZl5M/xPd+4=;
 b=l1L2U/QveAq9gn8u4cPJ0F+XxlIlSzEr+LA5QLOMQ7v21NLpSbSaWyx0kpVg7JGndS
 x7aWmFbbJUmzGOSiPp46BW1+5dfb3RRKA8yPqMQM2JGjE23mUcSw17M4es284Pn0QFSU
 USKjwflWfa3ru0OeTdz5TUVU7WC9crvNKFKpV48y5ztXjeb/nzAZ1HVNpHrlKF759X8O
 QkrQ8ziAWxQt61b+XmKoM8EGUgyxU692VgTAxYzWEH9V2orRoCTkBfXQUS6DxYue78XE
 wbmOE3GCbqLpZIDbxjkLYBwR2DwxdBhLf3f8wEIFMEFv/IuN1fXkuO9pmFlSp8678Q1U
 daqQ==
X-Gm-Message-State: APjAAAUQss44UdOgDQ+dpvEijh68jEt2hL7iJ1L+lSNxglO3kwoQF7bC
 yarpzMj04gj4u8kiG6Wk0yclLQEEjlA=
X-Google-Smtp-Source: APXvYqzTeIvUXyv6dii6+6pLTGh2HPlKUDPFq+Dyojq1fnVn7LbCFQmKmHReXwFUQhsf1f7MmXJsNQ==
X-Received: by 2002:a17:902:bd46:: with SMTP id
 b6mr67976663plx.239.1577704287272; 
 Mon, 30 Dec 2019 03:11:27 -0800 (PST)
Received: from localhost.localdomain ([42.108.228.63])
 by smtp.gmail.com with ESMTPSA id j28sm47007499pgb.36.2019.12.30.03.11.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Dec 2019 03:11:26 -0800 (PST)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [RFCv2] erofs-utils: on-disk extent format for blocks.
Date: Mon, 30 Dec 2019 16:18:05 +0530
Message-Id: <20191230104805.27139-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Tracking only the data-extents + some minor naming changes.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/internal.h |  20 ++++++-
 lib/inode.c              | 151 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 150 insertions(+), 21 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e13adda..5a29a67 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,7 +63,7 @@ struct erofs_sb_info {
 extern struct erofs_sb_info sbi;
 
 struct erofs_inode {
-	struct list_head i_hash, i_subdirs, i_xattrs;
+	struct list_head i_hash, i_subdirs, i_xattrs, i_sparse_extents;
 
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
@@ -93,6 +93,7 @@ struct erofs_inode {
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
+	unsigned int sparse_extent_isize;
 
 	erofs_nid_t nid;
 	struct erofs_buffer_head *bh;
@@ -139,5 +140,22 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+/* on disk extent format */
+struct erofs_extent {
+	__le32 ee_lblk;
+	__le32 ee_pblk;
+	__le32 ee_len;
+};
+
+struct erofs_extent_node {
+	struct list_head next;
+	erofs_blk_t lblk;
+	erofs_blk_t pblk;
+	u32 len;
+};
+
+struct erofs_inline_extent_header {
+	u32 count;
+};
 #endif
 
diff --git a/lib/inode.c b/lib/inode.c
index 0e19b11..01ac54f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -38,6 +38,98 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
 
 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
 
+
+#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
+		             roundup(end, EROFS_BLKSIZ) == end &&	\
+			    (end - start) % EROFS_BLKSIZ == 0)
+
+/* returns the number of holes present in the file */
+unsigned int erofs_read_extents(struct erofs_inode *inode,
+				struct list_head *extents)
+{
+	int fd, st, dt, en;
+	unsigned int nholes = 0;
+	erofs_off_t data, hole, len = 0, last_data;
+	struct erofs_extent_node *e_data;
+
+	fd = open(inode->i_srcpath, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	len = lseek(fd, 0, SEEK_END);
+	if (len < 0)
+		goto fail;
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		goto fail;
+	data = 0;
+	last_data = 0;
+	while (data < len) {
+		hole = lseek(fd, data, SEEK_HOLE);
+		if (hole == len)
+			break;
+		data = lseek(fd, hole, SEEK_DATA);
+		if (data < 0 || hole > data) {
+			close(fd);
+			return -EINVAL;
+		}
+		if (IS_HOLE(hole, data)) {
+			st = erofs_blknr(hole);
+			dt = erofs_blknr(last_data);
+			en = erofs_blknr(data);
+			last_data = data;
+			e_data = malloc(sizeof(struct erofs_extent_node));
+			if (e_data == NULL)
+				goto fail;
+			e_data->lblk = dt;
+			e_data->len = (st - dt);
+			list_add_tail(&e_data->next, extents);
+			nholes += (en - st);
+		}
+	}
+	/* rounddown to exclude tail-end data */
+	if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
+		e_data = malloc(sizeof(struct erofs_extent_node));
+		if (e_data == NULL)
+			goto fail;
+		st = erofs_blknr(last_data);
+		e_data->lblk = st;
+		e_data->len = erofs_blknr(rounddown((len - last_data),
+					  EROFS_BLKSIZ));
+		list_add_tail(&e_data->next, extents);
+	}
+	return nholes;
+
+fail:	close(fd);
+	return -errno;
+}
+
+char *erofs_create_extent_buffer(struct list_head *extents, unsigned int size)
+{
+	struct erofs_extent_node *e_node;
+	struct erofs_inline_extent_header *header;
+	char *buf;
+	unsigned int p = 0;
+
+	buf = malloc(size);
+	if (buf == NULL)
+		return ERR_PTR(-ENOMEM);
+	header = (struct erofs_inline_extent_header *) buf;
+	header->count = 0;
+	p += sizeof(struct erofs_inline_extent_header);
+	list_for_each_entry(e_node, extents, next) {
+		const struct erofs_extent ee = {
+			.ee_lblk = cpu_to_le32(e_node->lblk),
+			.ee_pblk = cpu_to_le32(e_node->pblk),
+			.ee_len  = cpu_to_le32(e_node->len)
+		};
+		memcpy(buf + p, &ee, sizeof(struct erofs_extent));
+		p += sizeof(struct erofs_extent);
+		header->count++;
+		list_del(&e_node->next);
+		free(e_node);
+	}
+	return buf;
+}
+
 void erofs_inode_manager_init(void)
 {
 	unsigned int i;
@@ -304,8 +396,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 
 int erofs_write_file(struct erofs_inode *inode)
 {
-	unsigned int nblocks, i;
+	unsigned int nblocks, i, j, nholes;
 	int ret, fd;
+	struct erofs_extent_node *e_node;
 
 	if (!inode->i_size) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
@@ -322,31 +415,38 @@ int erofs_write_file(struct erofs_inode *inode)
 	/* fallback to all data uncompressed */
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
-
-	ret = __allocate_inode_bh_data(inode, nblocks);
+	nholes = erofs_read_extents(inode, &inode->i_sparse_extents);
+	if (nholes < 0)
+		return nholes;
+	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
 	if (ret)
 		return ret;
-
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0)
 		return -errno;
-
-	for (i = 0; i < nblocks; ++i) {
-		char buf[EROFS_BLKSIZ];
-
-		ret = read(fd, buf, EROFS_BLKSIZ);
-		if (ret != EROFS_BLKSIZ) {
-			if (ret < 0)
+	i = inode->u.i_blkaddr;
+	inode->sparse_extent_isize = sizeof(struct erofs_inline_extent_header);
+	list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
+		inode->sparse_extent_isize += sizeof(struct erofs_extent);
+		e_node->pblk = i;
+		ret = lseek(fd, blknr_to_addr(e_node->lblk), SEEK_SET);
+		if (ret < 0)
+			goto fail;
+		for (j = 0; j < e_node->len; j++) {
+			char buf[EROFS_BLKSIZ];
+			ret = read(fd, buf, EROFS_BLKSIZ);
+			if (ret != EROFS_BLKSIZ) {
+				if (ret < 0)
+					goto fail;
+				close(fd);
+				return -EAGAIN;
+			}
+			ret = blk_write(buf, e_node->pblk + j, 1);
+			if (ret)
 				goto fail;
-			close(fd);
-			return -EAGAIN;
 		}
-
-		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
-		if (ret)
-			goto fail;
+		i += e_node->len;
 	}
-
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
@@ -479,8 +579,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (ret)
 			return false;
 		free(inode->compressmeta);
+		off += inode->extent_isize;
 	}
 
+	if (inode->sparse_extent_isize) {
+		char *extents = erofs_create_extent_buffer(&inode->i_sparse_extents,
+						   inode->sparse_extent_isize);
+		if (IS_ERR(extents))
+			return false;
+		ret = dev_write(extents, off, inode->sparse_extent_isize);
+		if (ret)
+			return false;
+		free(extents);
+	}
 	inode->bh = NULL;
 	erofs_iput(inode);
 	return erofs_bh_flush_generic_end(bh);
@@ -737,10 +848,11 @@ struct erofs_inode *erofs_new_inode(void)
 
 	init_list_head(&inode->i_subdirs);
 	init_list_head(&inode->i_xattrs);
+	init_list_head(&inode->i_sparse_extents);
 
 	inode->idata_size = 0;
 	inode->xattr_isize = 0;
-	inode->extent_isize = 0;
+	inode->sparse_extent_isize = 0;
 
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
@@ -961,4 +1073,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
-
-- 
2.9.3

