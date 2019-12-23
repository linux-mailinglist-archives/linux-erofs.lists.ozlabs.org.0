Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E912995F
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2019 18:30:23 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hRFR6xlVzDqPF
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 04:30:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633;
 helo=mail-pl1-x633.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tPXnGUih"; 
 dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hRFD48TTzDqK5
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 04:30:05 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id x17so7443241pln.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Dec 2019 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=fZHHzC+MUyzWIPplzNe8IiF/U1z4llJhYlLYhmPdPJQ=;
 b=tPXnGUihGbAMEk56EdNcu0SqcnfrnbFX7oAFvUkKuV9aVtzclxFU0sf86flWIJSf6T
 KXQIg3Phx5+SB0b/W+GDAO6oLUZWMG7C5Bxw0pNK4DpWVDbPJkYFWrBBV2JJZQLJ5beT
 5lHpXG+MZhBGb0PsCynGeuDbsTWYmDtaU/zDy0S2d/ksCX/xGERCJP44vuOwVUVJipbN
 7cCoAJv8VSU1dUOqj9b6YJwMvZgox66MSm1GZm2+HUujAYb4zar+G0Ywh0+gJJz3RlNY
 4JPASQhosy1KsqcNoePa7Ynx3UHFek3Z6GnHzizOBB1tZWG33lECVMT5Ymt0+9JWBt8y
 2OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fZHHzC+MUyzWIPplzNe8IiF/U1z4llJhYlLYhmPdPJQ=;
 b=TuNzVAscq8S4n/JlswGCRqJAKXl+PuJcNxQ1zBgP3hehGxHN5bsna+Zl0wzjZNT+bB
 NoWYvzp1rXZL1BNdyh3AUAfIPyQz2xVxjT67u44Vj34l0/b0ztsID5JBTlWvVb4tEwDN
 GjazTw9L0tUih0MHSfql3y5eI9PzCz698kWDqvHYGKoK3e1R+hbM/la0h9xgZHCgotve
 gNgoxlUAOZd2l0TfyyJCt3etNlFvQC1K+sLiiPIRJghAD/t6S9D2VRfPGyqAPwwIwpXr
 bouJtOyM740QK4Te3Gonun512r/8rygW7g5/SK7Tfd2mSOAiKI1X5Qm41FZEXia6YP+8
 pOFg==
X-Gm-Message-State: APjAAAW/UlnRtwoF425c9MN8wbOj15lxIiub16kdfX/HIUFzHhT6Mnqn
 IDDCRYEzZVH04I2IrkmNk9uNnWPsPmw=
X-Google-Smtp-Source: APXvYqwY8R/vL8AE1mwY9yJjOBt4gFyAd8Ac4iAHJcd5TzXzjD2DxgpRYorM7XbbeeYf1S+Xqj5c4Q==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr230563pjo.2.1577122201765; 
 Mon, 23 Dec 2019 09:30:01 -0800 (PST)
Received: from localhost.localdomain ([139.5.48.156])
 by smtp.gmail.com with ESMTPSA id s1sm22788934pgv.87.2019.12.23.09.29.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Dec 2019 09:30:00 -0800 (PST)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
Date: Mon, 23 Dec 2019 22:59:38 +0530
Message-Id: <20191223172938.13189-1-pratikshinde320@gmail.com>
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

Made some changes based on comments on previous patch :
1) defined an on disk structure for representing hole.
2) Maintain a list of this structure (per file) and dump this list to
   disk at the time of writing the inode to disk.
---
 include/erofs/internal.h |   8 +++-
 lib/inode.c              | 108 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e13adda..863ef8a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,7 +63,7 @@ struct erofs_sb_info {
 extern struct erofs_sb_info sbi;
 
 struct erofs_inode {
-	struct list_head i_hash, i_subdirs, i_xattrs;
+	struct list_head i_hash, i_subdirs, i_xattrs, i_holes;
 
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
@@ -93,6 +93,7 @@ struct erofs_inode {
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
+	unsigned int holes_isize;
 
 	erofs_nid_t nid;
 	struct erofs_buffer_head *bh;
@@ -139,5 +140,10 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+struct erofs_hole {
+	erofs_blk_t st;
+	u32 len;
+	struct list_head next;
+};
 #endif
 
diff --git a/lib/inode.c b/lib/inode.c
index 0e19b11..20bbf06 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -38,6 +38,85 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
 
 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
 
+
+#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
+		             roundup(end, EROFS_BLKSIZ) == end &&	\
+			    (end - start) % EROFS_BLKSIZ == 0)
+#define HOLE_BLK		-1
+unsigned int erofs_detect_holes(struct erofs_inode *inode,
+				struct list_head *holes, unsigned int *htimes)
+{
+	int fd, st, en;
+	unsigned int nholes = 0;
+	erofs_off_t data, hole, len;
+	struct erofs_hole *eh;
+
+	fd = open(inode->i_srcpath, O_RDONLY);
+	if (fd < 0) {
+		return -errno;
+	}
+	len = lseek(fd, 0, SEEK_END);
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		return -errno;
+	data = 0;
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
+			eh = malloc(sizeof(struct erofs_hole));
+			if (eh == NULL)
+				return -ENOMEM;
+			eh->st = st;
+			eh->len = (en - st);
+			list_add_tail(&eh->next, holes);
+			nholes += eh->len;
+			*htimes += 1;
+		}
+	}
+	return nholes;
+}
+
+bool erofs_ishole(erofs_blk_t blk, struct list_head holes)
+{
+	if (list_empty(&holes))
+		return false;
+	struct erofs_hole *eh;
+	list_for_each_entry(eh, &holes, next) {
+		if (eh->st > blk)
+			return false;
+		if (eh->st <= blk && (eh->st + eh->len - 1) >= blk)
+			return true;
+	}
+	return false;
+}
+
+char *erofs_create_holes_buffer(struct list_head *holes, unsigned int size)
+{
+	struct erofs_hole *eh;
+	char *buf;
+	unsigned int p = 0;
+
+	buf = malloc(size);
+	if (buf == NULL)
+		return ERR_PTR(-ENOMEM);
+	list_for_each_entry(eh, holes, next) {
+		*(__le32 *)(buf + p) = cpu_to_le32(eh->st);
+		p += sizeof(__le32);
+		*(__le32 *)(buf + p) = cpu_to_le32(eh->len);
+		p += sizeof(__le32);
+		list_del(&eh->next);
+		free(eh);
+	}
+	return buf;
+}
+
 void erofs_inode_manager_init(void)
 {
 	unsigned int i;
@@ -304,7 +383,7 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 
 int erofs_write_file(struct erofs_inode *inode)
 {
-	unsigned int nblocks, i;
+	unsigned int nblocks, i, nholes, hitems = 0;
 	int ret, fd;
 
 	if (!inode->i_size) {
@@ -322,16 +401,24 @@ int erofs_write_file(struct erofs_inode *inode)
 	/* fallback to all data uncompressed */
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
-
-	ret = __allocate_inode_bh_data(inode, nblocks);
+	nholes = erofs_detect_holes(inode, &inode->i_holes, &hitems);
+	if (nholes < 0)
+		return nholes;
+	inode->holes_isize = (sizeof(struct erofs_hole) -
+			      sizeof(struct list_head)) * hitems;
+	if (nblocks < 0)
+		return nblocks;
+	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
 	if (ret)
 		return ret;
-
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0)
 		return -errno;
 
 	for (i = 0; i < nblocks; ++i) {
+		if (erofs_ishole(i, inode->i_holes)) {
+			continue;
+		}
 		char buf[EROFS_BLKSIZ];
 
 		ret = read(fd, buf, EROFS_BLKSIZ);
@@ -479,8 +566,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (ret)
 			return false;
 		free(inode->compressmeta);
+		off += inode->extent_isize;
 	}
 
+	if (inode->holes_isize) {
+		char *holes = erofs_create_holes_buffer(&inode->i_holes,
+							inode->holes_isize);
+		if (IS_ERR(holes))
+			return false;
+		ret = dev_write(holes, off, inode->holes_isize);
+		free(holes);
+		if (ret)
+			return false;
+	}
 	inode->bh = NULL;
 	erofs_iput(inode);
 	return erofs_bh_flush_generic_end(bh);
@@ -737,6 +835,7 @@ struct erofs_inode *erofs_new_inode(void)
 
 	init_list_head(&inode->i_subdirs);
 	init_list_head(&inode->i_xattrs);
+	init_list_head(&inode->i_holes);
 
 	inode->idata_size = 0;
 	inode->xattr_isize = 0;
@@ -961,4 +1060,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
-
-- 
2.9.3

