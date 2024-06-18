Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548990C4E7
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:25:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k5tTz7F3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KZB1RQFz3cDt
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:25:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k5tTz7F3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYK1SSmz3bNs
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699072; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=X0X4X6yP5YyN0vwS0d/KtaSppu8DX7YB4Jw5PvA2yic=;
	b=k5tTz7F3Jq3xo4CLpJAR67UvwoW6XJB2fbd+jlFkVNyhIuo02CZhtBTVbTVTSbKcFqzrmTQd+7683/nnBvYUEBL61sHgvZvo1P0f4/0ziweTK+Hd7GG11pTGhH+CMOo5m3v0mMhouzB97BOs/rmM6nXlgZr9nU7bZzvjyZSZ7Qw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcNAY_1718699070;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcNAY_1718699070)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 05/10] erofs-utils: fix up unchanged directory pNIDs for incremental builds
Date: Tue, 18 Jun 2024 16:24:10 +0800
Message-Id: <20240618082414.47876-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
References: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For incremental builds, it's unnecessary to dump all unchanged
directories, yet the pNIDs of those directories need to be fixed to
the new parent on-disk inodes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 321b2f5..6c4fa2a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -338,6 +338,84 @@ static void erofs_d_invalidate(struct erofs_dentry *d)
 	erofs_iput(inode);
 }
 
+static int erofs_rebuild_inode_fix_pnid(struct erofs_inode *parent,
+					erofs_nid_t nid)
+{
+	struct erofs_inode dir = {
+		.sbi = parent->sbi,
+		.nid = nid
+	};
+	unsigned int bsz = erofs_blksiz(dir.sbi);
+	unsigned int err, isz;
+	erofs_off_t boff, off;
+	erofs_nid_t pnid;
+	bool fixed = false;
+
+	err = erofs_read_inode_from_disk(&dir);
+	if (err)
+		return err;
+
+	if (!S_ISDIR(dir.i_mode))
+		return -ENOTDIR;
+
+	if (dir.datalayout != EROFS_INODE_FLAT_INLINE &&
+	    dir.datalayout != EROFS_INODE_FLAT_PLAIN)
+		return -EOPNOTSUPP;
+
+	pnid = erofs_lookupnid(parent);
+	isz = dir.inode_isize + dir.xattr_isize;
+	boff = erofs_pos(dir.sbi, dir.u.i_blkaddr);
+	for (off = 0; off < dir.i_size; off += bsz) {
+		char buf[EROFS_MAX_BLOCK_SIZE];
+		struct erofs_dirent *de = (struct erofs_dirent *)buf;
+		unsigned int nameoff, count, de_nameoff;
+
+		count = min_t(erofs_off_t, bsz, dir.i_size - off);
+		err = erofs_pread(&dir, buf, count, off);
+		if (err)
+			return err;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= count) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, offset %llu",
+				  nameoff, dir.nid | 0ULL, off | 0ULL);
+			return -EFSCORRUPTED;
+		}
+
+		while ((char *)de < buf + nameoff) {
+			de_nameoff = le16_to_cpu(de->nameoff);
+			if (((char *)(de + 1) >= buf + nameoff ?
+				strnlen(buf + de_nameoff, count - de_nameoff) == 2 :
+				le16_to_cpu(de[1].nameoff) == de_nameoff + 2) &&
+			   !memcmp(buf + de_nameoff, "..", 2)) {
+				if (de->nid == cpu_to_le64(pnid))
+					return 0;
+				de->nid = cpu_to_le64(pnid);
+				fixed = true;
+				break;
+			}
+			++de;
+		}
+
+		if (!fixed)
+			continue;
+		err = erofs_dev_write(dir.sbi, buf,
+			(off + bsz > dir.i_size &&
+				dir.datalayout == EROFS_INODE_FLAT_INLINE ?
+				erofs_iloc(&dir) + isz : boff + off), count);
+		erofs_dbg("directory %llu pNID is updated to %llu",
+			  nid | 0ULL, pnid | 0ULL);
+		break;
+	}
+	if (err || fixed)
+		return err;
+
+	erofs_err("directory data %llu is corrupted (\"..\" not found)",
+		  nid | 0ULL);
+	return -EFSCORRUPTED;
+}
+
 static int erofs_write_dir_file(struct erofs_inode *dir)
 {
 	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
@@ -359,6 +437,13 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		const unsigned int len = strlen(d->name) +
 			sizeof(struct erofs_dirent);
 
+		/* XXX: a bit hacky, but to avoid another traversal */
+		if (d->validnid && d->type == EROFS_FT_DIR) {
+			ret = erofs_rebuild_inode_fix_pnid(dir, d->nid);
+			if (ret)
+				return ret;
+		}
+
 		erofs_d_invalidate(d);
 		if (used + len > erofs_blksiz(sbi)) {
 			ret = write_dirblock(sbi, q, head, d,
@@ -1193,7 +1278,9 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 	}
 
 	if (item->type == EROFS_MKFS_JOB_DIR_BH) {
-		erofs_write_dir_file(inode);
+		ret = erofs_write_dir_file(inode);
+		if (ret)
+			return ret;
 		erofs_write_tail_end(inode);
 		inode->bh->op = &erofs_write_inode_bhops;
 		erofs_iput(inode);
-- 
2.39.3

