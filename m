Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EB58FFFE7
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 11:53:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iHFjRXXB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vwc3B0d3Zz3cPl
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 19:53:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iHFjRXXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vwc331s1bz3bq0
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 19:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717754008; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3LgqfhycMRh3pWaKBOjKJxPobo4ib31jxBPAd44oOkg=;
	b=iHFjRXXBdzD1NEF6KQN6OmwlVoKCQoHPnPHE+4wRPQPSZr/yZVCnKewcLHmFCToxG2ADHGPiZkusTuZBOyioPc7IDLT8lYw8d0cRpJ6C+HdDMroXVutFhmNXO6AUBpj0Da+3l7ixEqqTMb8BcFGSc8yhDBEbi+weCDhuYmv4pwQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8-d9Ai_1717754005;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8-d9Ai_1717754005)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 17:53:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: split erofs_iflush()
Date: Fri,  7 Jun 2024 17:53:19 +0800
Message-Id: <20240607095319.2169172-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240607095319.2169172-1-hsiangkao@linux.alibaba.com>
References: <20240607095319.2169172-1-hsiangkao@linux.alibaba.com>
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

So that external programs can directly use it.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  1 +
 lib/inode.c           | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 5d6bc98..46d989c 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -31,6 +31,7 @@ struct erofs_inode *erofs_iget(dev_t dev, ino_t ino);
 struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
+int erofs_iflush(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
 int erofs_rebuild_dump_tree(struct erofs_inode *dir);
diff --git a/lib/inode.c b/lib/inode.c
index 9d7d518..14bd00a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -493,18 +493,22 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	return write_uncompressed_file_from_fd(inode, fd);
 }
 
-static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+int erofs_iflush(struct erofs_inode *inode)
 {
-	struct erofs_inode *const inode = bh->fsprivate;
-	struct erofs_sb_info *sbi = inode->sbi;
 	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
-	erofs_off_t off = erofs_btell(bh, false);
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t off;
 	union {
 		struct erofs_inode_compact dic;
 		struct erofs_inode_extended die;
-	} u = { {0}, };
+	} u = {};
 	int ret;
 
+	if (inode->bh)
+		off = erofs_btell(inode->bh, false);
+	else
+		off = erofs_iloc(inode);
+
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
 		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
@@ -616,7 +620,18 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 				return ret;
 		}
 	}
+	return 0;
+}
 
+static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+{
+	struct erofs_inode *inode = bh->fsprivate;
+	int ret;
+
+	DBG_BUGON(inode->bh != bh);
+	ret = erofs_iflush(inode);
+	if (ret)
+		return ret;
 	inode->bh = NULL;
 	erofs_iput(inode);
 	return erofs_bh_flush_generic_end(bh);
-- 
2.39.3

