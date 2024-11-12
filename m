Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86DC9C4C36
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 03:08:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnVFw0Fcgz2yXm
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 13:08:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731377329;
	cv=none; b=TJ1h75osbElC0mVcqXUAwyl0SHVEEMZ2KMZ08tAZOuhHuovUgp1+KCHizVMdMcYK5Lz0Mj3GchGmFnw78siqTWpCLzrSgr07EROQ3lgyyFM9uFHStDHc5WTnv5AJApER/xFtOGsHfm+Z4IcTlo/5zOV7bLauYQWslTCQsD5cD0nnF7hFcxkH7e7HE7T2s/+PEz5E3n7SCFoI/3YuTZtzV05ObA/aK1lN7IOmrpfL4XBweb1xzjjlSreroJqqlHb+QgFdjJ+TgFyZCNjPt8oxmYkL0Pr3XzSChf+LT+e3XdLPP07FxGFHkBH5F8gdyE/GIIjD2L8xmiinHSlHNZp0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731377329; c=relaxed/relaxed;
	bh=YAXAHtQpywINQQ9j646N68G7lbT4FT/X77uT0S3LtAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UajgP9NkB0YhSG3WsrWTlfLpYo36CIO9J0Kepa7dN3yv7KEJ32ut3BzVR0zsOWhlHZjXQl9PNir8O6pa9Ym20SQyvaPZ3EQUnYq4v3gLf8RrGAOsXM4227whBVuQxsFhcyn55zIhR2FGPWrdjK3h1FneGZ2OEw5Sd+xQSEsGNbfvNvQBHdUBrlOYFsb0n5F0jXjZRxw2273PAhpN2zx5DNnvkzcYInae7cAnU5oODiCJzOV9iVp/7vF4VUx8KubZa+FOnCHxAI3bUBfHFpueLHzT2C0T6x85rqtG/ifZgblv2mGz0VUMRwlmdpGEV6B3bxlPlmJP9y75UmeaNFI/WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RrTqU7LL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RrTqU7LL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnVFp5ySjz2xnc
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 13:08:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731377313; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YAXAHtQpywINQQ9j646N68G7lbT4FT/X77uT0S3LtAU=;
	b=RrTqU7LLCuA2IOsgMHTKwnG0PzPwxG113+H6gxIQjR2NC+4SjmXnf+6KyYleHuIAU6Jv+w2wBGhweC47qBcxdF+TwZtASKY37mVK7xJM4T1fI6AfdbW+U7apd9O7E+rABKna53TJ5082Yp7xXk2f+91Hwt0EH1IfeRdNAdEqx8Y=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WJF8grv_1731377311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 10:08:32 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: capture errors from {mkfs,rebuild}_handle_inode()
Date: Tue, 12 Nov 2024 10:08:30 +0800
Message-ID: <20241112020830.849210-1-hongzhen@linux.alibaba.com>
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
in erofs_mkfs_dump_tree() may be ignored. This patch introduces `err2` to
capture errors from {mkfs,rebuild}_handle_inode().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Clean up the patch and revise the commit message.
v1: https://lore.kernel.org/all/20241111110926.3909753-1-hongzhen@linux.alibaba.com/
---
 lib/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7abde7f4a3b5..f553becb0be0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1706,7 +1706,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 {
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
-	int err;
+	int err, err2;
 
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
@@ -1733,7 +1733,6 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 	}
 
 	do {
-		int err;
 		struct erofs_inode *dir = dumpdir;
 		/* used for adding sub-directories in reverse order due to FIFO */
 		struct erofs_inode *head, **last = &head;
@@ -1770,10 +1769,10 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		err = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
+		err2 = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
 				    &dir, sizeof(dir));
-		if (err)
-			return err;
+		if (err || err2)
+			return err ? err : err2;
 	} while (dumpdir);
 
 	return err;
-- 
2.43.5

