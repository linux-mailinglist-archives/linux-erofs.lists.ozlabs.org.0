Return-Path: <linux-erofs+bounces-252-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B24C0A9FEF0
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 03:20:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmjDf6HNXz2yGM;
	Tue, 29 Apr 2025 11:20:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745889634;
	cv=none; b=nRchBwNv/XZOehh4u88nuJIsJjZa+SRP1Nr2SRRBo7NinemgDrDreYr8dumkTs0FHHqUPJeakTwJ8avmTtluRfDJnDXnxbuZPmQNeAzZ7cikEKGESVnVOCppVkVM7OsUec4WudtjABLWgk9NECwW9cfmcdOfI+0/ee/9b5DbFGsXARRmSuFoI9J44gg2mTo8dcQ2WhwtIQMM4BC7ZhRmIKF0Y30KH9KiBNPldaXeV6qB4hwNl66D4HNI7k78Zt6u5+fvB1gyS0ah8PI9w1sMQc+A/Dhbw/PYh0KTJgaMFtSr8fLeyzbTiF/0NajPzL0T+wC7teDr28aJeneKms3O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745889634; c=relaxed/relaxed;
	bh=xdxgL/MB0Gr9efSQGNxTVTVZ31csnH5lE62RSikUaqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oa8Tk1qozqVvUnMVqadV1Oo1uh+zeAFr3ejAfPa2nAs55jR1KMm7rxsD7wREvjzKZssN0OYwLT5cbVhRUF/A57oYtGU3VS1nw+xoC/I6CNBcbx7CFQP94jZzK9lP7zQ5zD+rrPt/QkgjIJ3U5rUNz+CHdcEv/CUizOqsX97tkstmzIRFz0J3r4sraHCdDf5SCbrC1Kn+lTQEI/gN68zov49zExZ9EHEQ5/VIAPGMFhT09lduRiRLqizUSt4hI3B+9Q++2MQM9m98k4JQEIYODVorc2siibXf0sJwXxZI1NrQ2349/AWA7D/YBRx7U7CZWb6C0HRP5wv1JD89FAlh3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmjDd32Vhz2xd4
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:20:31 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zmj8P5Dm5zLpdR;
	Tue, 29 Apr 2025 09:16:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D9A901401E0;
	Tue, 29 Apr 2025 09:20:25 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Apr
 2025 09:20:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] erofs: encode file handle with the internal helpers
Date: Tue, 29 Apr 2025 01:11:39 +0000
Message-ID: <20250429011139.686847-1-lihongbo22@huawei.com>
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

In erofs, the inode number has the location information of
files. The default encode_fh uses the ino32, this will lack
of some information when the file is too big. So we need
the internal helpers to encode filehandle.

Since i_generation in EROFS is not used, here we only encode
the nid into file handle when it is exported. So it is easy
to parse the dentry from file handle.

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
 fs/erofs/super.c | 51 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..8f787c47e04d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -511,24 +511,59 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static struct inode *erofs_nfs_get_inode(struct super_block *sb,
-					 u64 ino, u32 generation)
+static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
 {
-	return erofs_iget(sb, ino);
+	int len = parent ? 4 : 2;
+	erofs_nid_t nid;
+
+	if (*max_len < len) {
+		*max_len = len;
+		return FILEID_INVALID;
+	}
+
+	nid = EROFS_I(inode)->nid;
+	fh[0] = (u32)(nid >> 32);
+	fh[1] = (u32)(nid & 0xffffffff);
+
+	if (parent) {
+		nid = EROFS_I(parent)->nid;
+
+		fh[2] = (u32)(nid >> 32);
+		fh[3] = (u32)(nid & 0xffffffff);
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
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 2)
+		return NULL;
+
+	nid = (u64) fid->raw[0] << 32;
+	nid |= (u64) fid->raw[1];
+
+	return d_obtain_alias(erofs_iget(sb, nid));
 }
 
 static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	erofs_nid_t nid;
+
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 4)
+		return NULL;
+
+	nid = (u64) fid->raw[2] << 32;
+	nid |= (u64) fid->raw[3];
+
+	return d_obtain_alias(erofs_iget(sb, nid));
 }
 
 static struct dentry *erofs_get_parent(struct dentry *child)
@@ -544,7 +579,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations erofs_export_ops = {
-	.encode_fh = generic_encode_ino32_fh,
+	.encode_fh = erofs_encode_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
-- 
2.22.0


