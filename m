Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAAA90C3F9
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 08:49:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JPnZW0qc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3HRX55l8z3cRR
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 16:49:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JPnZW0qc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3HRF21c6z30Vc
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 16:49:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693348; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qhu+1eWQDgZf6EUkfPFZ9Ao8bfQPGSGORmQvvsPNgm0=;
	b=JPnZW0qclIhZjEPNTh+jrIVr/Yhn0wVdIK0v17z0APlhJYErarzY5WqjRkop+uJso0633b67dz0y0wBBqptqEuA1TjFTJ9MSO04iexGCmzRNZb/gDnCCj9qclPQIEbpERw/S7jseK5orLzYyzkKKKRJwWt2tURp0fRFh8GP2XlE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jEqyg_1718693345;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jEqyg_1718693345)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:49:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/9] erofs-utils: mkfs: minor cleanup & rearrangement
Date: Tue, 18 Jun 2024 14:48:52 +0800
Message-Id: <20240618064859.4117858-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
References: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
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

Introduce erofs_flush_packed_inode() and more for exporting liberofs
APIs later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/fragments.h |  2 +-
 lib/fragments.c           | 15 ++++++++++++---
 lib/inode.c               | 11 ++++++-----
 mkfs/main.c               | 27 ++++++++++-----------------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 4c6f755..65910f5 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -17,7 +17,7 @@ extern const char *erofs_frags_packedname;
 
 FILE *erofs_packedfile_init(void);
 void erofs_packedfile_exit(void);
-struct erofs_inode *erofs_mkfs_build_packedfile(void);
+int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
diff --git a/lib/fragments.c b/lib/fragments.c
index 4d5478f..7591718 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -326,12 +326,21 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-struct erofs_inode *erofs_mkfs_build_packedfile(void)
+int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
 {
+	struct erofs_inode *inode;
+
+	if (!erofs_sb_has_fragments(sbi))
+		return -EINVAL;
 	fflush(packedfile);
+	if (!ftello(packedfile))
+		return 0;
 
-	return erofs_mkfs_build_special_from_fd(&sbi, fileno(packedfile),
-						EROFS_PACKED_INODE);
+	inode = erofs_mkfs_build_special_from_fd(sbi, fileno(packedfile),
+						 EROFS_PACKED_INODE);
+	sbi->packed_nid = erofs_lookupnid(inode);
+	erofs_iput(inode);
+	return 0;
 }
 
 void erofs_packedfile_exit(void)
diff --git a/lib/inode.c b/lib/inode.c
index e27399d..0bfaa56 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1533,21 +1533,22 @@ static void erofs_mark_parent_inode(struct erofs_inode *inode,
 
 static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
 {
-	struct erofs_inode *dumpdir;
+	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_inode *dumpdir = erofs_igrab(root);
 	int err;
 
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
-	(void)erofs_igrab(root);
-	dumpdir = root;
 
 	err = !rebuild ? erofs_mkfs_handle_inode(root) :
 			erofs_rebuild_handle_inode(root);
 	if (err)
 		return err;
 
-	erofs_mkfs_flushjobs(root->sbi);
+	erofs_mkfs_flushjobs(sbi);
 	erofs_fixup_meta_blkaddr(root);		/* assign root NID */
+	sbi->root_nid = root->nid;
+
 	do {
 		int err;
 		struct erofs_inode *dir = dumpdir;
@@ -1584,7 +1585,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		err = erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR_BH,
+		err = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
 				    &dir, sizeof(dir));
 		if (err)
 			return err;
diff --git a/mkfs/main.c b/mkfs/main.c
index 1b15bc5..a00231e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1136,7 +1136,7 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
-	struct erofs_inode *root, *packed_inode;
+	struct erofs_inode *root;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
@@ -1342,36 +1342,29 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 	}
-	sbi.root_nid = erofs_lookupnid(root);
 	erofs_iput(root);
 
 	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
 		sbi.devs[0].blocks = BLK_ROUND_UP(&sbi, erofstar.offset);
 
-	if (erofstar.index_mode || cfg.c_chunkbits || sbi.extra_devices) {
-		err = erofs_mkfs_dump_blobs(&sbi);
+	if (erofs_sb_has_fragments(&sbi)) {
+		erofs_update_progressinfo("Handling packed data ...");
+		err = erofs_flush_packed_inode(&sbi);
 		if (err)
 			goto exit;
 	}
 
-	sbi.packed_nid = 0;
-	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
-	    erofs_sb_has_fragments(&sbi)) {
-		erofs_update_progressinfo("Handling packed_file ...");
-		packed_inode = erofs_mkfs_build_packedfile();
-		if (IS_ERR(packed_inode)) {
-			err = PTR_ERR(packed_inode);
-			goto exit;
-		}
-		sbi.packed_nid = erofs_lookupnid(packed_inode);
-		erofs_iput(packed_inode);
-	}
-
 	/* flush all buffers except for the superblock */
 	err = erofs_bflush(NULL);
 	if (err)
 		goto exit;
 
+	if (erofstar.index_mode || cfg.c_chunkbits || sbi.extra_devices) {
+		err = erofs_mkfs_dump_blobs(&sbi);
+		if (err)
+			goto exit;
+	}
+
 	err = erofs_writesb(&sbi, sb_bh, &nblocks);
 	if (err)
 		goto exit;
-- 
2.39.3

