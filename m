Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916A7D04FC
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Oct 2023 00:44:32 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kLzHuStq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SBN7f07bsz3cdn
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Oct 2023 09:44:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kLzHuStq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SBN7W0f88z30hY
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Oct 2023 09:44:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BFA90CE3240
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Oct 2023 22:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB4C433C7;
	Thu, 19 Oct 2023 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697755460;
	bh=jwjsjCNs3ACN+OVlb9BQPd4sjLb4O+P90TjsKI2ym+8=;
	h=From:To:Cc:Subject:Date:From;
	b=kLzHuStqVWuOZBfFLClJQSlDRNkj+8v6zO71XOH+rbWnODr+lEkx5YDaHF5AnL1JB
	 hb19nwiKIaU7+/fPJ/adnVhyJFO3e1uUsc1JCtxi/uCy8s23GCqSHxiEZXLHaizU6z
	 LfyQZaxW8DabxPLa5Sh1z9JfIfHPWjk0igU7esUBPcIhIECbZ1yEcvZapUeDwfaCN7
	 XPYo9AJRVmDzkLuI6dqchFNfnAiaMvmwhylLVkcgFj2VLvgAWlofkj93VEZWKP+rWn
	 smFi9TL7zve5LfpJt7DLzwZPBzQxsIU8MEgv7B6trxnJs98DPQWFoFNLgUUfH2X416
	 kJNpOeCjt2kIg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix reference leak in erofs_mkfs_build_tree_from_path()
Date: Fri, 20 Oct 2023 06:43:28 +0800
Message-Id: <20231019224328.26015-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 8cbc205185a1 ("erofs-utils: mkfs: fix corrupted directories
with hardlinks") introduced a reference leak although it has no real
impact to users.  Fix it now.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 71af396..8409ccd 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1271,13 +1271,18 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 		if (S_ISDIR(inode->i_mode)) {
 			inode->next_dirwrite = dumpdir;
 			dumpdir = inode;
+		} else {
+			erofs_iput(inode);
 		}
 	} while (!list_empty(&dirs));
 
-	for (; dumpdir; dumpdir = dumpdir->next_dirwrite) {
-		erofs_write_dir_file(dumpdir);
-		erofs_write_tail_end(dumpdir);
-		dumpdir->bh->op = &erofs_write_inode_bhops;
+	while (dumpdir) {
+		inode = dumpdir;
+		erofs_write_dir_file(inode);
+		erofs_write_tail_end(inode);
+		inode->bh->op = &erofs_write_inode_bhops;
+		dumpdir = inode->next_dirwrite;
+		erofs_iput(inode);
 	}
 	return root;
 }
-- 
2.30.2

