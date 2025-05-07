Return-Path: <linux-erofs+bounces-293-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDCAADBD4
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 11:49:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zsr7Z0cqLz2xl6;
	Wed,  7 May 2025 19:48:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746611338;
	cv=none; b=JlvsHLa3oCf7oYvkUzgZVba3ABVB7k4TzpBYw6CFIP3Lv/qjrJ/22zph6AAyYw9s+ivrk6A31qAc4dn4UnPxq5IiNrR18HMFk+fBFu3R+nYvErcagYLScW0/pU8/rc1TPUhq0dmt7Nwu1jnxRoCID2M59rNFtzgxbdDKrfewGZ88SG5NjSKdTMsYqS/6nNzOnw27PwaNFbkc9TDKx+mWjlpRUUguwL+ebD6LKqOnlxdQ7HlCInP2YvplpN2pPSgJeFIxvZ4kBrBxDYsWk05bfivwqHl+uKImosI4KbDoxPOQ1ZnCirQIsYtBI/ZkAWHJD/cO3Fq/l0ETkywX3mt2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746611338; c=relaxed/relaxed;
	bh=n5Nv4/k2x38bs9PGzXV7gGoWeWmMcchF2icmPLAViGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIPgrao/Ht7aR6fCSBGr2Bf1VSfdUQCj5fFcvyEUezjxGVH6NO3VHDf6IP3JIm2ojYxAnDOTX82JF/e2yK4usZ3hNWJSlAVqqfgyjOxTgMX8WAwE+xT3SqAYNxOOvjUukykKrcncUuXx346wFX3Sety+XfGtLSfKyNwwy99DXraPZxXH4+2is6k7HUw6u9PdXQ5mlrZU/piz2QYQuBNLcmcj4Ke4ImLSsBXVZVL3F8zM2liTdwdUqgHagH04HAs+xB4OzHKdMz4bz9glfaAwEzZFjLzYGL50K8UvTU2Zojwq1fTXu3rJhVKhncvzcVBWQ2ana8gieFw4nHNyoEhG3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zsr7X506nz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 19:48:54 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zsr6l1ZVGz2TSDk;
	Wed,  7 May 2025 17:48:15 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A5FF91A016C;
	Wed,  7 May 2025 17:48:49 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 May
 2025 17:48:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH v4] erofs: fix file handle encoding for 64-bit NIDs
Date: Wed, 7 May 2025 09:40:15 +0000
Message-ID: <20250507094015.14007-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

EROFS uses NID to indicate the on-disk inode offset, which can
exceed 32 bits. However, the default encode_fh uses the ino32,
thus it doesn't work if the image is larger than 128GiB.

Let's introduce our own helpers to encode file handles.

It's easy to reproduce:
  1. prepare an erofs image with nid bigger than U32_MAX
  2. mount -t erofs foo.img /mnt/erofs
  3. set exportfs with configuration: /mnt/erofs *(rw,sync,
     no_root_squash)
  4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
  5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
     than U32_MAX.  # you will get ESTALE error.

In the case of overlayfs, the underlying filesystem's file
handle is encoded in ovl_fb.fid, which is similar to NFS's
case. If the NID of file is larger than U32_MAX, the overlay
will get -ESTALE error when calls exportfs_decode_fh.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v3: https://lore.kernel.org/all/20250429134257.690176-1-lihongbo22@huawei.com/
  - Improve commit message readability as suggested by Xiang.
  - Remove extra variable to make the code simpler as suggested
    by Xiang.

v2: https://lore.kernel.org/all/20250429074109.689075-1-lihongbo22@huawei.com/
  - Assign parent nid with correct value.

v1: https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
   - Encode generation into file handle and minor clean code.
   - Update the commiti's title.
---
 fs/erofs/super.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..727e2fbaa168 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -511,24 +511,52 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static struct inode *erofs_nfs_get_inode(struct super_block *sb,
-					 u64 ino, u32 generation)
+static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
 {
-	return erofs_iget(sb, ino);
+	erofs_nid_t nid = EROFS_I(inode)->nid;
+	int len = parent ? 6 : 3;
+
+	if (*max_len < len) {
+		*max_len = len;
+		return FILEID_INVALID;
+	}
+
+	fh[0] = (u32)(nid >> 32);
+	fh[1] = (u32)(nid & 0xffffffff);
+	fh[2] = inode->i_generation;
+
+	if (parent) {
+		nid = EROFS_I(parent)->nid;
+
+		fh[3] = (u32)(nid >> 32);
+		fh[4] = (u32)(nid & 0xffffffff);
+		fh[5] = parent->i_generation;
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
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
+		return NULL;
+
+	return d_obtain_alias(erofs_iget(sb,
+		((u64)fid->raw[0] << 32) | fid->raw[1]));
 }
 
 static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
+		return NULL;
+
+	return d_obtain_alias(erofs_iget(sb,
+		((u64)fid->raw[3] << 32) | fid->raw[4]));
 }
 
 static struct dentry *erofs_get_parent(struct dentry *child)
@@ -544,7 +572,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations erofs_export_ops = {
-	.encode_fh = generic_encode_ino32_fh,
+	.encode_fh = erofs_encode_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
-- 
2.22.0


