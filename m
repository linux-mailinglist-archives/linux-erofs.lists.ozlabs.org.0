Return-Path: <linux-erofs+bounces-10-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F9A5068E
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Mar 2025 18:39:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7KYs69LZz3bqP;
	Thu,  6 Mar 2025 04:39:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741196385;
	cv=none; b=WGsBxkUdSLys3Ge3RT71++vVSScnGrT1LGxzz7J+NxItLRab9V27cwLgTSuF841Secd+4rqFdm4xKyXwGSttJ1MwkDIlXrxr8hFhjyf5wcVIjgUeTi8hOHialOurgXJJ28ja5MJT8UAVF/mp/wBNrsDWRE4y9wwcJUFtZ9XYBNJsRD+/7vAoGpqv1aJ/gJ/b5f4wvt0zI5AsVvtbDxW6uZf53LoOblc33M0NjbK65VrWT322ePc+Vvu/E5on8a4sPbEVY6g+3nqLhFVLl3k3A3NRsNYXWc4JDifXNNIO6KJZ6ZG++YjXCooqWYGc2pHnTmSvzOUt0gF5fGudzif4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741196385; c=relaxed/relaxed;
	bh=fSM1ZrZzk78/A2PxjBkXEJUpOfqDqSdERmsOK0oZ6cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV7Y+6gibIZq33ZpSJVcJYjKCC41fIyPcGA//c6lGnfW64JbnNDhs6OYBLmJTZXc2JgWR6aUlcxFJz3aCx6EE6RMltspYaHSHjRvTCOJedus1Xt9tOf9ckvJElVPrerlIr1W659YvzQFVGXRKyWj7thWDmsct+CusYKk8Jp1fuuyhsOHK9On2h7924qM5olKXGwqThsZIz16nzYdneODpysTDJ/BUvCXmzkI7diH63fINzTvlst7g1kFL1LrhDnTlU1Fbm4jfOf6FcriRmh5IgPC4XJ7dSn3r9pTKNbCrxO7xf7AqDWBmnSrgOawHR/ey64b4uiX8PRRRLuo33dpFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tOEmo+XY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tOEmo+XY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7KYq32Y6z30Tq
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 04:39:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741196378; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fSM1ZrZzk78/A2PxjBkXEJUpOfqDqSdERmsOK0oZ6cs=;
	b=tOEmo+XYXw/kyEln0JTZcKKwpMkW3QWY7OExwDUfZHKy6AO/MGVHCwveuOuFJXNun8hJrH6klGN/2EBJF11LpxOmzcZPbTyRg+NPXdOfIRoqAYo2qaQHG88et2rwU91LvvXIxBQqxuHtRMZzceWed4fNCxF9PlQucpY+4utJmuQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQm8Yud_1741196376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 01:39:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: cleanup redundant logic in erofs_iflush()
Date: Thu,  6 Mar 2025 01:39:29 +0800
Message-ID: <20250305173930.2223550-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250305173930.2223550-1-hsiangkao@linux.alibaba.com>
References: <20250305173930.2223550-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 57 ++++++++++++-----------------------------------------
 1 file changed, 13 insertions(+), 44 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 434eafb..34c6128 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -592,6 +592,7 @@ int erofs_iflush(struct erofs_inode *inode)
 		struct erofs_inode_compact dic;
 		struct erofs_inode_extended die;
 	} u = {};
+	union erofs_inode_i_u u1;
 	int ret;
 
 	if (inode->bh)
@@ -599,6 +600,16 @@ int erofs_iflush(struct erofs_inode *inode)
 	else
 		off = erofs_iloc(inode);
 
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+		u1.rdev = cpu_to_le32(inode->u.i_rdev);
+	else if (is_inode_layout_compression(inode))
+		u1.compressed_blocks = cpu_to_le32(inode->u.i_blocks);
+	else if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+		u1.c.format = cpu_to_le16(inode->u.chunkformat);
+	else
+		u1.raw_blkaddr = cpu_to_le32(inode->u.i_blkaddr);
+
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
 		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
@@ -611,28 +622,7 @@ int erofs_iflush(struct erofs_inode *inode)
 
 		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
 		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
-
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			u.dic.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
-			break;
-
-		default:
-			if (is_inode_layout_compression(inode))
-				u.dic.i_u.compressed_blocks =
-					cpu_to_le32(inode->u.i_blocks);
-			else if (inode->datalayout ==
-					EROFS_INODE_CHUNK_BASED)
-				u.dic.i_u.c.format =
-					cpu_to_le16(inode->u.chunkformat);
-			else
-				u.dic.i_u.raw_blkaddr =
-					cpu_to_le32(inode->u.i_blkaddr);
-			break;
-		}
+		u.dic.i_u = u1;
 		break;
 	case sizeof(struct erofs_inode_extended):
 		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
@@ -648,28 +638,7 @@ int erofs_iflush(struct erofs_inode *inode)
 
 		u.die.i_mtime = cpu_to_le64(inode->i_mtime);
 		u.die.i_mtime_nsec = cpu_to_le32(inode->i_mtime_nsec);
-
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			u.die.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
-			break;
-
-		default:
-			if (is_inode_layout_compression(inode))
-				u.die.i_u.compressed_blocks =
-					cpu_to_le32(inode->u.i_blocks);
-			else if (inode->datalayout ==
-					EROFS_INODE_CHUNK_BASED)
-				u.die.i_u.c.format =
-					cpu_to_le16(inode->u.chunkformat);
-			else
-				u.die.i_u.raw_blkaddr =
-					cpu_to_le32(inode->u.i_blkaddr);
-			break;
-		}
+		u.die.i_u = u1;
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version of nid %llu",
-- 
2.43.5


