Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92496CCE1
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 05:03:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzkhk4dHrz2ysf
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 13:03:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725505428;
	cv=none; b=LEVGu7/EpqQNTDxl2IbNl81m6N5zblBolCvuY6J6OTmOojXy4Ynl63ekSkFYTUDk85k9ApfSP/eF2HTpnA7pde9sZbzDFW/IyOe9cOAI6WIFLdRom/nUesfrotxuylT7X9QsizuVsLEpzxbX91WXmT77K55RfQfWhXxiDm/AGbLgy7lKTKEIYsiLNKPHPpiocokkXj/Bs9dhp8oICjBZmenGyPkNSnwgroQW6T1+UsM8K9+e43jJLSNkRRquT71bnc4k65nuGd1SSxAIH364g2IxQrs+9HkDLiQzy/va8Zdc2I53Pb42wQJ8zgWduJvhNSap2I/30bm4KAIgb9lv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725505428; c=relaxed/relaxed;
	bh=fC+vzKwLthbvHWWaMcb4VLaSEm+2MTEtjuhPVPFwODM=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=n0/F3k6ZLEwht7QXKxvmffY4wc2k5kVc+pJcnoYauYlFbxE+2dKP4mK8DZukRme9HJWND4hYAEcCmLj4GYq70fMPuKQG61ceageZS1KVQDQXmDNiwkMc0InPAlHcd4NLh4bAZANXjfVM+Bds491IfEn8PxdDJ+YpDCUci1pW7Y85IsDzMrmJfANP0COD1OHGoacRFOFShFOC7RmKdjoOGLd3HZRN2qWvdHulhrnZ3h8dS2Q5dpiuzTcVlpgFCuhXjIyXkXKLRq0LQ6VhZKiz7MMUr/pauFwzxzsZqS65M8VR/ERcSJsQEIAbcANN5KEGQ4NBogUqnEVk7ZVaCG2bRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJi7H1Wh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJi7H1Wh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzkhg1BDrz2xHg
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 13:03:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505421; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fC+vzKwLthbvHWWaMcb4VLaSEm+2MTEtjuhPVPFwODM=;
	b=YJi7H1Whq8vvsXtMtw69onN7c0+uZFz1Q4cODVnkY8kdxcvlrlo5NU7Azs2sPWjLm5CaYvGa8VmvJ+H5dVJOCz9Ec2BuSJ/OllM6ju6agZhurapfcWsMRh1Y9hqTCUUDCSxM7Sdz8OY+pSRb5QMPe2UOcfXq8MXpVIYPhFGLnRg=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEJdNyJ_1725505419)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:03:40 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
Date: Thu,  5 Sep 2024 11:03:39 +0800
Message-ID: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Get rid of redundant variables (nblocks, offset) and a dead branch
(!tailendpacking).

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..b13ef0019c92 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -75,38 +75,28 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 static int erofs_map_blocks_flatmode(struct inode *inode,
 				     struct erofs_map_blocks *map)
 {
-	erofs_blk_t nblocks, lastblk;
-	u64 offset = map->m_la;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+	erofs_blk_t lastblk = erofs_iblks(inode) - tailendpacking;
 
-	nblocks = erofs_iblks(inode);
-	lastblk = nblocks - tailendpacking;
-
-	/* there is no hole in flatmode */
-	map->m_flags = EROFS_MAP_MAPPED;
-	if (offset < erofs_pos(sb, lastblk)) {
+	map->m_flags = EROFS_MAP_MAPPED;	/* no hole in flat inodes */
+	if (map->m_la < erofs_pos(sb, lastblk)) {
 		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(sb, lastblk) - offset;
-	} else if (tailendpacking) {
+		map->m_plen = erofs_pos(sb, lastblk) - map->m_la;
+	} else {
+		DBG_BUGON(!tailendpacking);
 		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(sb, offset);
-		map->m_plen = inode->i_size - offset;
+			vi->xattr_isize + erofs_blkoff(sb, map->m_la);
+		map->m_plen = inode->i_size - map->m_la;
 
 		/* inline data should be located in the same meta block */
 		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "inline data cross block boundary @ nid %llu",
-				  vi->nid);
+			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
 		map->m_flags |= EROFS_MAP_META;
-	} else {
-		erofs_err(sb, "internal error @ nid: %llu (size %llu), m_la 0x%llx",
-			  vi->nid, inode->i_size, map->m_la);
-		DBG_BUGON(1);
-		return -EIO;
 	}
 	return 0;
 }
-- 
2.43.5

