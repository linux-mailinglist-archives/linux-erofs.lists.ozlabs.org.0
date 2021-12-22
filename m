Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF9B47CB47
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 03:09:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJcFv4bk8z2yw9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 13:09:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DDuoUJLj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DDuoUJLj; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJcFq566Rz2xsL
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 13:09:19 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 52FF3B8196E;
 Wed, 22 Dec 2021 02:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567ABC36AE9;
 Wed, 22 Dec 2021 02:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640138954;
 bh=+yPtP0WuxgpvRxR12kUn0z631rcsyZ+IwaUwLQPL/Fc=;
 h=From:To:Cc:Subject:Date:From;
 b=DDuoUJLjQ8XAjb9tCe1AfG4r8Ez5nhU49sOOvqTGBQ4TgspxtXiRowjP6ZKbaj+QT
 TZRqE7DMS91TPKOmGqpD0a/Dbji2F1NrVjxjFJtZjgFTWXqtImDio9qQ3PYCfLrWfb
 mt4AkmaRlQd44jHkSxsIoLOi6Vwhc9KDyHggtZLHMRpA7U6HE06DahfrOej71AjxQH
 B5qZzFQYpEJ4euAfiks96Nr7AHk+ax3P7jAfmEdbSN7f5IOL0wT5f4K7xYIbTxDU1c
 yHcDqemYXucK/z/im+yYNIiKuaOh9j13OsgStIYDAAqeW5QfYkPbvNjeM9hqdTnix6
 Tpi/Ljdua/Brg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: lib: Add API to get on disk size of an inode
Date: Wed, 22 Dec 2021 10:08:22 +0800
Message-Id: <20211222020822.14156-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Kelvin Zhang <zhangkelvin@google.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Kelvin Zhang <zhangkelvin@google.com>

Marginally improve code re-use. It's quite common for users to query for
compressed size of an inode.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Kelvin,

I've removed the print message of API, and return -ENOTSUP instead.
Please check out if it's fine with you.

Thanks,
Gao Xiang

 dump/main.c              |  6 +++---
 include/erofs/internal.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 97c8750d40f1..9d05d89b4436 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -176,7 +176,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
-static int erofs_get_occupied_size(struct erofs_inode *inode,
+static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 		erofs_off_t *size)
 {
 	*size = 0;
@@ -194,7 +194,7 @@ static int erofs_get_occupied_size(struct erofs_inode *inode,
 		break;
 	default:
 		erofs_err("unknown datalayout");
-		return -1;
+		return -ENOTSUP;
 	}
 	return 0;
 }
@@ -270,7 +270,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 	stats.files++;
 	stats.file_category_stat[erofs_mode_to_ftype(vi.i_mode)]++;
 
-	err = erofs_get_occupied_size(&vi, &occupied_size);
+	err = erofsdump_get_occupied_size(&vi, &occupied_size);
 	if (err) {
 		erofs_err("get file size failed");
 		return err;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d2adf57d8ae2..2c7b611e811f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -320,6 +320,27 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+
+static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
+					  erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		*size = inode->i_size;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		break;
+	default:
+		return -ENOTSUP;
+	}
+	return 0;
+}
+
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-- 
2.20.1

