Return-Path: <linux-erofs+bounces-1356-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD8C3F50F
	for <lists+linux-erofs@lfdr.de>; Fri, 07 Nov 2025 11:06:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2vpn0fKcz3054;
	Fri,  7 Nov 2025 21:06:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762509985;
	cv=none; b=jbooY9EdTx8vThrgVQcg34ywBqj7jZGdJR1P5b4bd6LIi/z2WbXMlJJzHDKLqwHmDiD1IelqjCm39ZIAKiIFjJTxxgewQ7MjQlXfWCNIHJHfX6vxQUb/KpLQEIwIwiZEolba4RnaIW/q1wP0fOffIOz1jUTb0d4tXi8+5VRs0LYNDuVJhsZVUWFs42agpHmmAA5kvnhQQWn4JC3BS+YW3GQwQDm8InJiLsQ6Tdb2Ap8SFK6wCjCSH5OCKgl4fyvk/2FMu5oSQQ/2h9+JHTIKdvvm/cbFRz5aGXkAZt7oJXHM3YD6rzNT1wSU3WG62eQdVQQbwt4Wq3iWmNG2CElPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762509985; c=relaxed/relaxed;
	bh=rCg3izmvkKfksJvpRWw54Qe/n/+a7E1iPbzYT1+WVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MamBnG6rMsiiGmHQCNc8xkCedR0AAJ29lAg/ga9KYeDSQtZse19g7VnyRFKW6QuBe66mq6NXPmYiZEDRzTnp8g+p0DDXBDYAJRAV1slqBw5dc9p0pFJUEBRGdzR/8exwCYwYZrxym0kpPm0UNrMDev4CHuQozC7vMGCLbM6kLVc9kMOA5s4fHSSAhdK6JCSPSLSwwdzWp9WvzPs11Pv9cL3I3CS7pKAC+e2qKTGtoei6st/NUDlfsM4Nmsq0PAm3yYNQ7q4S8lAVu7WB4XrTL7X8NeyNhE0GiIHEvANKoC1pJz7JZMCtqNAXaKCwZNtFS4VBLRu2rDzfxBqaddFXCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OVhg+dyv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OVhg+dyv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2vpj5h62z2yFJ
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Nov 2025 21:06:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762509977; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rCg3izmvkKfksJvpRWw54Qe/n/+a7E1iPbzYT1+WVPo=;
	b=OVhg+dyvFTPMl7KsLKfXTMI+iNUaChgn8QAzWeJQuP/ceTo54quLRQGetjy1l+v0YBiM5nOUYUh9bllOgFYvLrxpivtIqPs7HGW45DPQANv//nsaO7s3xS1dqfSBsprvd6juzIyWC5C076lBFOVPADMXYujqesio2+b2jRUvHAM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrsiSWZ_1762509974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 18:06:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: lib: ibmgr should be assigned in advance
Date: Fri,  7 Nov 2025 18:06:08 +0800
Message-ID: <20251107100609.2917122-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
References: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Otherwise, metabox won't keep several types of inodes.

Fixes: 7928074b7643 ("erofs-utils: introduce metadata compression [metabox]")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index f9b5ee997877..09b2e507c609 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -903,8 +903,7 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 {
 	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
-	struct erofs_bufmgr *bmgr = sbi->bmgr;
-	struct erofs_bufmgr *ibmgr = bmgr;
+	struct erofs_bufmgr *ibmgr;
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
 
@@ -922,6 +921,13 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 	if (inode->extent_isize)
 		inodesize = roundup(inodesize, 8) + inode->extent_isize;
 
+	if (!erofs_is_special_identifier(inode->i_srcpath) &&
+	    erofs_metabox_bmgr(sbi))
+		inode->in_metabox = true;
+
+	if (inode->in_metabox)
+		ibmgr = erofs_metabox_bmgr(sbi) ?: sbi->bmgr;
+
 	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN)
 		goto noinline;
 
@@ -942,12 +948,6 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	if (!erofs_is_special_identifier(inode->i_srcpath) &&
-	    erofs_metabox_bmgr(sbi))
-		inode->in_metabox = true;
-
-	if (inode->in_metabox)
-		ibmgr = erofs_metabox_bmgr(sbi) ?: bmgr;
 	bh = erofs_balloc(ibmgr, INODE, inodesize, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
-- 
2.43.5


