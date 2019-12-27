Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AECE12B5B0
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2019 16:44:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47krjH0gjHzDqDm
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Dec 2019 02:44:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gob7+cSq"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47krj32xbYzDqDX
 for <linux-erofs@lists.ozlabs.org>; Sat, 28 Dec 2019 02:44:06 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g6so8911497plp.6
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Dec 2019 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=h8aN4bWjpslj7Cyhj6sBJOxjWLwm63ZEF3hqud7ZPaI=;
 b=Gob7+cSq72fmqsGC9DPeL70SJkyQJ9WjP9azU+uPN6AlomvJhjsClG+x3cN8ohmVx6
 nCe5Z7WlToi2L+22vSzkUIaMv9YVje82r0ERLcUE9f1FCxxM8KS/1VbDaxcbgPlQcMma
 mWLDSGgYYxJghSGLduLTYKvIXU6RlYxX15KszPHlkyjxOan8fDbsvdETFdLOJLwS9Q/U
 qP8T/tJ8Db8z6lAlDd7FfAyNJnICBBRtg3NTli0HdPaBY2FZLjdxh02ZMPRLThP1+e46
 Z9vSo1piasLZOnvOzNtz2MuGgPKC/qG34LpBXvsz5uN+nwbf4J03EhCGjBLRyOPjlDC8
 /aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=h8aN4bWjpslj7Cyhj6sBJOxjWLwm63ZEF3hqud7ZPaI=;
 b=i/E0aptV+uiy/2bw9gYG8EMIFqhFEgfn1GBZ6/wWWrWbdOu7z9JNLNzGBpailm8vAS
 VDBabACmWFQn4BBRRRNsbcMFOkCUWJE+8UeesIlcO+Vcnpsk7d6RTfaOi9CqXSVwHQa9
 jmyYZ1qJTgIaAmEXqTABksxQPg8uXKLDIziep7jrEJQN6t+rCxbazZ2WR9H+QVHaiiV8
 /hrRIgkpR6dZhOpexCXnE1XYjKrrNGGPL4OwQKUtCj1jXjV5tfywjG1/JcfDNB5xb61G
 Rg6HY8sIrItWeOuwH/wI2nP+2GUAs/Lndf8Y0czf0pdcoaXCu6oE4QcS/4xQ2vSTZIdE
 p6UQ==
X-Gm-Message-State: APjAAAWkp5wU8QvRs+h/UHbEKJ37BGW+7hi6fAmvwcFOO1uK5ipixpNq
 fEvF21uGCbVb5f6UJOs1oEYboCfDuBwn5A==
X-Google-Smtp-Source: APXvYqz95yYizlEDRsMYkL8D7/L9BRmonpj8Qx6iLnReWkMQ/OUKzOfDV7CNG0l1ZxGY3oEOGDLGtg==
X-Received: by 2002:a17:902:59d8:: with SMTP id
 d24mr50161047plj.318.1577461442828; 
 Fri, 27 Dec 2019 07:44:02 -0800 (PST)
Received: from localhost.localdomain ([103.97.240.51])
 by smtp.gmail.com with ESMTPSA id ep12sm15340149pjb.7.2019.12.27.07.43.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Dec 2019 07:44:01 -0800 (PST)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [RFC] erofs-utils: on-disk extent format for blocks.
Date: Fri, 27 Dec 2019 21:13:48 +0530
Message-Id: <20191227154348.21432-1-pratikshinde320@gmail.com>
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

since this patch is quite different from previous patches I am treating
this as new patch.

1) On disk extent format for erofs data blocks.
2) Detect holes inside files & skip allocation for hole blocks.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/internal.h |  21 ++++++-
 lib/inode.c              | 155 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 156 insertions(+), 20 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e13adda..128aa63 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,7 +63,7 @@ struct erofs_sb_info {
 extern struct erofs_sb_info sbi;
 
 struct erofs_inode {
-	struct list_head i_hash, i_subdirs, i_xattrs;
+	struct list_head i_hash, i_subdirs, i_xattrs, i_extents;
 
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
@@ -93,6 +93,7 @@ struct erofs_inode {
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
+	unsigned int extent_meta_isize;
 
 	erofs_nid_t nid;
 	struct erofs_buffer_head *bh;
@@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+#define HOLE_BLK	-1
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
index 0e19b11..a6af509 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
 
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
+	int fd, st, en, dt;
+	unsigned int nholes = 0;
+	erofs_off_t data, hole, len, last_data;
+	struct erofs_extent_node *e_hole, *e_data;
+
+	fd = open(inode->i_srcpath, O_RDONLY);
+	if (fd < 0) {
+		return -errno;
+	}
+	len = lseek(fd, 0, SEEK_END);
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		return -errno;
+	data = 0;
+	last_data = 0;
+	while (data < len) {
+		hole = lseek(fd, data, SEEK_HOLE);
+		if (hole == len)
+			break;
+		data = lseek(fd, hole, SEEK_DATA);
+		if (data < 0 || hole > data) {
+			return -EINVAL;
+		}
+		if (IS_HOLE(hole, data)) {
+			st = hole >> S_SHIFT;
+			en = data >> S_SHIFT;
+			dt = last_data >> S_SHIFT;
+			last_data = data;
+			e_data = malloc(sizeof(struct erofs_extent_node));
+			if (e_data == NULL)
+				return -ENOMEM;
+			e_data->lblk = dt;
+			e_data->len = (st - dt);
+			list_add_tail(&e_data->next, extents);
+			e_hole = malloc(sizeof(struct erofs_extent_node));
+			if (e_hole == NULL)
+				return -ENOMEM;
+			e_hole->lblk = st;
+			e_hole->pblk = HOLE_BLK;
+			e_hole->len = (en - st);
+			list_add_tail(&e_hole->next, extents);
+			nholes += e_hole->len;
+		}
+	}
+	/* rounddown to exclude tail-end data */
+	if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
+		e_data = malloc(sizeof(struct erofs_extent_node));
+		if (e_data == NULL)
+			return -ENOMEM;
+		st = last_data >> S_SHIFT;
+		e_data->lblk = st;
+		e_data->len = rounddown((len - last_data), EROFS_BLKSIZ) >> S_SHIFT;
+		list_add_tail(&e_data->next, extents);
+	}
+	return nholes;
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
@@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 
 int erofs_write_file(struct erofs_inode *inode)
 {
-	unsigned int nblocks, i;
+	unsigned int nblocks, i, j, nholes;
 	int ret, fd;
+	struct erofs_extent_node *e_node;
 
 	if (!inode->i_size) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
@@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode *inode)
 	/* fallback to all data uncompressed */
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
-
-	ret = __allocate_inode_bh_data(inode, nblocks);
+	nholes = erofs_read_extents(inode, &inode->i_extents);
+	if (nholes < 0)
+		return nholes;
+	if (nblocks < 0)
+		return nblocks;
+	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
 	if (ret)
 		return ret;
 
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
-				goto fail;
-			close(fd);
-			return -EAGAIN;
+	i = inode->u.i_blkaddr;
+	inode->extent_meta_isize = sizeof(struct erofs_inline_extent_header);
+	list_for_each_entry(e_node, &inode->i_extents, next) {
+		inode->extent_meta_isize += sizeof(struct erofs_extent);
+		if (e_node->pblk == HOLE_BLK) {
+			lseek(fd, e_node->len * EROFS_BLKSIZ, SEEK_CUR);
+			continue;
 		}
+		e_node->pblk = i;
+		i += e_node->len;
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
+				goto fail;
 
-		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
-		if (ret)
-			goto fail;
+		}
 	}
-
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
@@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (ret)
 			return false;
 		free(inode->compressmeta);
+		off += inode->extent_isize;
 	}
 
+	if (inode->extent_meta_isize) {
+		char *extents = erofs_create_extent_buffer(&inode->i_extents,
+						   inode->extent_meta_isize);
+		if (IS_ERR(extents))
+			return false;
+		ret = dev_write(extents, off, inode->extent_meta_isize);
+		free(extents);
+		if (ret)
+			return false;
+	}
 	inode->bh = NULL;
 	erofs_iput(inode);
 	return erofs_bh_flush_generic_end(bh);
@@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)
 
 	init_list_head(&inode->i_subdirs);
 	init_list_head(&inode->i_xattrs);
+	init_list_head(&inode->i_extents);
 
 	inode->idata_size = 0;
 	inode->xattr_isize = 0;
-	inode->extent_isize = 0;
+	inode->extent_meta_isize = 0;
 
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
@@ -961,4 +1079,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
-
-- 
2.9.3

