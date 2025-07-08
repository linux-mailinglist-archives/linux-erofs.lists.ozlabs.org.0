Return-Path: <linux-erofs+bounces-553-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF08AFCA10
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 14:06:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc0FN2SY2z3bcW;
	Tue,  8 Jul 2025 22:06:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751976376;
	cv=none; b=NpzER1fqm5IV6kzKf9wfrDz4O2SqjRjH04WGNGCCO2YdLz/pOCRLfWI+9Ko9GZ3AHUGX9tg2j3MhM54OEA5IDTXK0AKeJcIdZNH+T3sClbPnFZP5WJb29Z0lM0t4KUo+8fkACl/z4pxlyhveyYm9w+VJRTf3U+9eSzlwV1/e2AONQN1uzUhZP19fBEoZLQ07JpsiWhQ2fNf1i1H9SwTycKD3KYwjWtQWZJm2TYQ4FZcmKrAARcJqhP5jcDPGrWqiF7kDK0kw2d2g1CNGZknvG3BGk8cBkm47REBrcgXrY6WAKSLezVTZvyBXYtW0i1+p7OPyGGmxF9ptZmKDk3CU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751976376; c=relaxed/relaxed;
	bh=eDL4bZCN/Hd+ZTMnrXEf0RkqRKBtUaVY+5Qfxo+Sp5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8t+jYh22NB3kgx3LCWndNBmVvKZe9WWyy6QK7ViAYXCPjUNJw2hlJh6J79TopnDWHJyGoDaRBa3VJRI00L5rHHNASEJC7kl77TTqpp/9XaDNrl3I8A5ELsD+Nt4UL/N5FmZOaUx6hISiC12jrXy2Ou4EyXvKpTzbOVTMit9Vbom3PJcO9JqY2vUgWet9pVzU2ZDXIJF3G/NI5AAdXljKKTMyR1SBhn//kZY9lV5IFfY6wl8Wc6Nwglahshl1CB+GSRbHIiQdatc6ciAxMZRzFCSa7ciZF+kBTcYd8IJoi2j9myB1cN8RbnorjfIMnerx/dSfzid9MsmjoxeB2XD3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Tue, 08 Jul 2025 22:06:12 AEST
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc0FJ4H5fz30Wn
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 22:06:12 +1000 (AEST)
Received: from jtjnmail201610.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507082004536617;
        Tue, 08 Jul 2025 20:04:53 +0800
Received: from localhost.localdomain (10.94.5.51) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 8 Jul 2025 20:04:55 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: support metadata compression
Date: Tue, 8 Jul 2025 08:01:43 -0400
Message-ID: <20250708120143.3572-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
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
Content-Type: text/plain
X-Originating-IP: [10.94.5.51]
tUid: 202570820045303427c2756c5b6d41fb4883f4037d374
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.7 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Filesystem metadata has a high degree of redundancy, so
should compress well in the general case.
To implement this feature, we make a special on-disk inode
which keeps all metadata as its data, and then compress the
special on-disk inode with the given algorithm.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/data.c     |  4 +++-
 fs/erofs/erofs_fs.h |  2 +-
 fs/erofs/internal.h |  7 +++++++
 fs/erofs/super.c    | 10 ++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..34c82421af4c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -55,7 +55,9 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	buf->off = sbi->dif0.fsoff;
-	if (erofs_is_fileio_mode(sbi)) {
+	if (erofs_is_metadata_comp_mode(sbi))
+		buf->mapping = sbi->meta_inode->i_mapping;
+	else if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 767fb4acdc93..bf1ef306ca3c 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -82,7 +82,7 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 meta_nid;	/* meta data nid */
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..a2437e5eada2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -125,6 +125,7 @@ struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
+	struct inode *meta_inode;
 	struct erofs_dev_context *devs;
 	u64 total_blocks;
 
@@ -148,6 +149,7 @@ struct erofs_sb_info {
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
 	erofs_nid_t packed_nid;
+	erofs_nid_t meta_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
@@ -190,6 +192,11 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+static inline bool erofs_is_metadata_comp_mode(struct erofs_sb_info *sbi)
+{
+	return sbi->meta_inode;
+}
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..9bc40083cd00 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -324,6 +324,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
+	sbi->meta_nid = le64_to_cpu(dsb->meta_nid);
 
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
@@ -691,6 +692,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sbi->packed_inode = inode;
 	}
 
+	if (sbi->meta_nid) {
+		inode = erofs_iget(sb, sbi->meta_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->meta_inode = inode;
+	}
+
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -845,6 +853,8 @@ static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
 {
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
+	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
-- 
2.31.1


