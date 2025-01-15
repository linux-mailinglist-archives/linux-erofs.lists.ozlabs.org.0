Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D2A1173F
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 03:27:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXqf1424xz3bSN
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 13:27:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736908055;
	cv=none; b=SpHOYlqU7xVMDdzi0DegntFVcWy/OdbXF5szG0GD2hhdBVtiXzeEUZxOwsouEhXjOMLJX4VmHr3NBIJv0UQ+hKd4ZbA0Hqj56WCgsUCuojQNIzNZcZY+Ph1d5JFhhoolSTCowQqqiEOpUnBjud9EikFSvbIqExDBsjStIEo38GlN1yLm9AnZDjKlhps1FEoPoM6njaegSJ/3T+fJk2F9rWyPQYtfu4VVp6HUPTNv52pfcgtRDOZ0kawh9DUZ2yetrXlkuD6wPXG77LktSvHONdfb3UjRpingEdctffR7AhZz7jK5VAhpuzwgtTh75gRTqcxu+47Kka7CS9c4fgccxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736908055; c=relaxed/relaxed;
	bh=zlRBeGxU2+xtabwzkd8VwuKTRbdKkI377B64UDXBTus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGB1ihcNHcRCfbBQKlEOZ4/DIwCDeZXMbUqCiYfLVCzkfty9+JC7q2Kn1LflslpF2nB7LKEVOs5VdRJQX1C830OCgEi/2cZKfwRSKyocxUKowP8aWYb7+Veck2J3GRVzRPGmWj/yFtHFg4+EjaH/FoRrOkwbe/GueGqaCGo/ZpAmvyMMJewFMRDDydaZJzvlKAMBN5h0OoSCVz8BQdDGMwvdibdm0V6h2464METcyfU2F0Jk82wETiZoyGaQPc37px7ky1kuPmAKGdk/iZsZuk+yh9ViiUDlui2A6M1YANxnvzQPb3RKLjgtTpOdr04jSU5e8mBR15huCxISh4P0Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rZFPL1wo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rZFPL1wo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXqdx3qNZz30NF
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 13:27:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736908048; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zlRBeGxU2+xtabwzkd8VwuKTRbdKkI377B64UDXBTus=;
	b=rZFPL1woblZ+yXDmNsyvSqvI2kVh4Yr6QUL6M1L1bRG0lecvozMy4dcXeDa9rBAYjlV5kae/0BwOGaGX+cTg1XFkh/tYIawd9AptWSLPjAS+K2QDm6/ppjdrJuvbQNLfqvwdvAQH+Yv3uvd7myO5gejfrgAQb0eUZJIqhgxLoR4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNguUym_1736908041 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 10:27:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: dynamically sized `struct erofs_dentry`
Date: Wed, 15 Jan 2025 10:27:20 +0800
Message-ID: <20250115022720.2204033-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 - Reduced memory footprints;
 - Optimize dname sorting and strlen(dname).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  4 +++-
 lib/inode.c              | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2edc1b4..596e363 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -314,15 +314,17 @@ static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
 
 #define IS_ROOT(x)	((x) == erofs_parent_inode(x))
 
+#define EROFS_DENTRY_NAME_ALIGNMENT	4
 struct erofs_dentry {
 	struct list_head d_child;	/* child of parent list */
 	union {
 		struct erofs_inode *inode;
 		erofs_nid_t nid;
 	};
-	char name[EROFS_NAME_LEN];
+	unsigned char namelen;
 	u8 type;
 	bool validnid;
+	char name[];
 };
 
 static inline bool is_dot_dotdot_len(const char *name, unsigned int len)
diff --git a/lib/inode.c b/lib/inode.c
index 7ee5d78..e51c0fc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -160,14 +160,22 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name)
 {
-	struct erofs_dentry *d = malloc(sizeof(*d));
+	unsigned int namelen = strlen(name);
+	unsigned int fsz = round_up(namelen + 1, EROFS_DENTRY_NAME_ALIGNMENT);
+	struct erofs_dentry *d;
 
+	if (namelen > EROFS_NAME_LEN) {
+		DBG_BUGON(1);
+		return ERR_PTR(-ENAMETOOLONG);
+	}
+	d = malloc(sizeof(*d) + fsz);
 	if (!d)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(d->name, name, EROFS_NAME_LEN - 1);
-	d->name[EROFS_NAME_LEN - 1] = '\0';
+	memcpy(d->name, name, namelen);
+	memset(d->name + namelen, 0, fsz - namelen);
 	d->inode = NULL;
+	d->namelen = namelen;
 	d->type = EROFS_FT_UNKNOWN;
 	d->validnid = false;
 	list_add_tail(&d->d_child, &parent->i_subdirs);
@@ -208,10 +216,16 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 static int comp_subdir(const void *a, const void *b)
 {
 	const struct erofs_dentry *da, *db;
+	int commonlen, sign;
 
 	da = *((const struct erofs_dentry **)a);
 	db = *((const struct erofs_dentry **)b);
-	return strcmp(da->name, db->name);
+	commonlen = min(round_up(da->namelen, EROFS_DENTRY_NAME_ALIGNMENT),
+			round_up(db->namelen, EROFS_DENTRY_NAME_ALIGNMENT));
+	sign = memcmp(da->name, db->name, commonlen);
+	if (sign)
+		return sign;
+	return cmpsgn(da->namelen, db->namelen);
 }
 
 int erofs_init_empty_dir(struct erofs_inode *dir)
@@ -260,7 +274,7 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 
 	/* let's calculate dir size */
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		int len = strlen(d->name) + sizeof(struct erofs_dirent);
+		int len = d->namelen + sizeof(struct erofs_dirent);
 
 		if (erofs_blkoff(sbi, d_size) + len > erofs_blksiz(sbi))
 			d_size = round_up(d_size, erofs_blksiz(sbi));
@@ -283,7 +297,7 @@ static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 
 	/* write out all erofs_dirents + filenames */
 	while (head != end) {
-		const unsigned int namelen = strlen(head->name);
+		const unsigned int namelen = head->namelen;
 		struct erofs_dirent d = {
 			.nid = cpu_to_le64(head->nid),
 			.nameoff = cpu_to_le16(q),
@@ -438,8 +452,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		return ret;
 
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		const unsigned int len = strlen(d->name) +
-			sizeof(struct erofs_dirent);
+		unsigned int len = d->namelen + sizeof(struct erofs_dirent);
 
 		/* XXX: a bit hacky, but to avoid another traversal */
 		if (d->validnid && d->type == EROFS_FT_DIR) {
-- 
2.43.5

