Return-Path: <linux-erofs+bounces-262-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D4AA04F6
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 09:49:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmssv5Fv3z305P;
	Tue, 29 Apr 2025 17:49:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745912995;
	cv=none; b=IPNbJsrYTWfes4Z/iCE21CpQ0CQDLy9rlCcKbYD2+qgeWttAWjCkhsjeM9DFTFZw2dQSS3bNvnjdcDryMoEvVOzSp0xkFER1h6Vbc0tyl5qSZpL4/9XI0gZOUymbcrD6rpLZSxIleeyU7tdaoyODzvUwj3KGK/XJkYhetZPmC2tmAIm0+PoSFGsZMAPkCZlJZCIAyiKW605CbONZHQpVpDW7UfJTkIRjRIX9554WypwsZN0nOYPYwg7qhqVwbBAxc3hLRIw8UJ3NImqsFZzgM+A9wuFfgwhEf0ShNwpyxwJyliiOYP7IxXVjilqSSlCNyxPKegA7UposPT2EjDmU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745912995; c=relaxed/relaxed;
	bh=0+N57D9R/e9flzDebqcsfZhXO1JcQLBqT69LzbXNxJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClrnEHiyKoCpfKqBEg7sL7Wmd6/8jftzdsJe+CoFkePSAzOkPNC5+stRvv20o9AVTXPArR6FDuFZjkN4d4lDSmFDSFwusYgoU5RRBeCH3NlyIwqMo0ryYbawJryLoXIBSj9HBYJvIQPA44eJrRrbQmNc8AcDf6wEAUy512kegiw/G4D9OkF4lFLxYOeh63IP1ZyqkfPLQpCe5OHa6PrX4Ptr5OAtcHodZTFB1jWByuf9fSW3YGK0v3sHZ/MWC61snKLuEJeeqylVCFN33GQf0tTj0uSFyaVC3tNR5bZzuqmSfgFjwJWzDbwt3Q4Pgf9izoNhxjn08q5Zmfr42x3RdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmsst4KMmz2yYf
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 17:49:52 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZmssH5Yfpz1j4tw;
	Tue, 29 Apr 2025 15:49:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C87F180042;
	Tue, 29 Apr 2025 15:49:47 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Apr
 2025 15:49:46 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: fix file handle encoding for 64-bit NIDs
Date: Tue, 29 Apr 2025 07:41:09 +0000
Message-ID: <20250429074109.689075-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In erofs, the inode number has the location information of
files. The default encode_fh uses the ino32, this will lack
of some information when the file is too big. So we need
the internal helpers to encode filehandle.

It is easy to reproduce test:
  1. prepare an erofs image with nid bigger than UINT_MAX
  2. mount -t erofs foo.img /mnt/erofs
  3. set exportfs with configuration: /mnt/erofs *(rw,sync,
     no_root_squash)
  4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
  5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
     than UINT_MAX.
For overlayfs case, the under filesystem's file handle is
encoded in ovl_fb.fid, it is same as NFS's case.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v1: https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
  - Encode generation into file handle and minor clean code.
  - Update the commiti's title.
---
 fs/erofs/super.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..aef5d0ca1695 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -511,24 +511,62 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static struct inode *erofs_nfs_get_inode(struct super_block *sb,
-					 u64 ino, u32 generation)
+static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
 {
-	return erofs_iget(sb, ino);
+	int len = parent ? 6 : 3;
+	erofs_nid_t nid;
+	u32 generation;
+
+	if (*max_len < len) {
+		*max_len = len;
+		return FILEID_INVALID;
+	}
+
+	nid = EROFS_I(inode)->nid;
+	generation = inode->i_generation;
+	fh[0] = (u32)(nid >> 32);
+	fh[1] = (u32)(nid & 0xffffffff);
+	fh[2] = generation;
+
+	if (parent) {
+		nid = EROFS_I(parent)->nid;
+		generation = parent->i_generation;
+
+		fh[3] = (u32)(nid >> 32);
+		fh[4] = (u32)(nid & 0xffffffff);
+		fh[5] = generation;
+	}
+
+	*max_len = len;
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
 }
 
 static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	erofs_nid_t nid;
+
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
+		return NULL;
+
+	nid = (u64) fid->raw[0] << 32;
+	nid |= (u64) fid->raw[1];
+	return d_obtain_alias(erofs_iget(sb, nid));
 }
 
 static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	erofs_nid_t nid;
+
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
+		return NULL;
+
+	nid = (u64) fid->raw[2] << 32;
+	nid |= (u64) fid->raw[3];
+	return d_obtain_alias(erofs_iget(sb, nid));
 }
 
 static struct dentry *erofs_get_parent(struct dentry *child)
@@ -544,7 +582,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations erofs_export_ops = {
-	.encode_fh = generic_encode_ino32_fh,
+	.encode_fh = erofs_encode_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
-- 
2.22.0


