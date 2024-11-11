Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB1C9C3CBE
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 12:09:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn6Jf3B3Dz2yfj
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 22:09:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731323392;
	cv=none; b=BhXuUAvrPhZvUlkYMZVWTP3T8XlRfFG96RE0dpPTiGaCeZ0wwRmzUDMQH8jRrzBmRgSNYk39mjy+9cGemK45bjinR5kzzzbIN0OL1BZstlDZg8VGU9BOXtd+cFJeC4T1xjmr3i0GeRkik1O/kZO7AHj850bD0l5G5hGarQY64JX6QGQxRnRqYDzQhntPBF6VJ9Edpqx0kBjdK9PwHsxslISHkZJL/mUHvz+2O/GzsmaWDT9joR7Muo6r4DVxOjN1W0nfvs9v52l4OGO6VvFHG6X1D8LB9AnPsT7APWz1LtePWCMJELqz146+PDuptOzUQsqOQfzQ4lcsEicba58x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731323392; c=relaxed/relaxed;
	bh=rY0e5O4bkehmKpKnUG8JbkkSx5b3n1OFtLfURPglZY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1C9AZkJ0aLXPwjx331AfIl69PTYvw6XZ0mdprpTQNGKKsiDB73Emuu42uDOi1hooyzpm9dJdZAZ7dV5ONJca3V2BYbgaqODn8RrGZnhiM5PjPYe+RNndiFCYvlNGEqPeVtcoHO9EyQHBtQn1+MTeSWKulHzyQbBfP4Jlvq3z0aPhNcDWgwKvqaaChz16PimO2ZNu5VYtAMFFbuXtFw7H+rja3cKEsjyoV+gk64QzlcfBgqcBItn4vJbK51sOJnerpLmNc3mJ/cSrZctK4tr6WVaZ1vtRoz7WzEpnUCRZwr5h/e8rfxs1YV4CYuM2gUiyFBu4q9wDvanFxX0zvEDPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VBHIBnH2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VBHIBnH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn6JV0nTrz2yGq
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 22:09:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731323377; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rY0e5O4bkehmKpKnUG8JbkkSx5b3n1OFtLfURPglZY4=;
	b=VBHIBnH2EmimXd628pv6NTlzjPE1gz5zEWkof3RwyleQBDWhmG/CObqTa2VVEbJO08Vg1EQWxJRQiU9zrfb8HK1rnkqmB+inV249EGeTBUasWdPQ44yPhPjcTLvEWi4swUhIAtHOWw7hg6CB6vto7aHBiPVsq3831FqOrHGG6F4=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WJ9tNKI_1731323374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 19:09:35 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: capture errors from {mkfs,rebuild}_handle_inode()
Date: Mon, 11 Nov 2024 19:09:26 +0800
Message-ID: <20241111110926.3909753-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, the error code returned by erofs_{mkfs,rebuild}_handle_inode()
in erofs_mkfs_dump_tree() may be ignored. This patch introduces `err1` and
`err2` to capture errors from the {mkfs,rebuild}_handle_inode() functions.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7abde7f4a3b5..e2ca07f1c18c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1733,7 +1733,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 	}
 
 	do {
-		int err;
+		int err1, err2;
 		struct erofs_inode *dir = dumpdir;
 		/* used for adding sub-directories in reverse order due to FIFO */
 		struct erofs_inode *head, **last = &head;
@@ -1753,11 +1753,11 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 				erofs_mark_parent_inode(inode, dir);
 
 				if (!rebuild)
-					err = erofs_mkfs_handle_inode(inode);
+					err1 = erofs_mkfs_handle_inode(inode);
 				else
-					err = erofs_rebuild_handle_inode(inode,
+					err1 = erofs_rebuild_handle_inode(inode,
 								incremental);
-				if (err)
+				if (err1)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
 					*last = inode;
@@ -1770,10 +1770,10 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		err = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
+		err2 = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
 				    &dir, sizeof(dir));
-		if (err)
-			return err;
+		if (err1 || err2)
+			return err1 ? err1 : err2;
 	} while (dumpdir);
 
 	return err;
-- 
2.43.5

