Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529FA14A5D
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 08:46:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZBcp5NPVz3clL
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 18:46:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737099977;
	cv=none; b=jjX26UaoY/Q055OwucQ2gHFE2hnSvDiTlKfjKiuESBSDKXsuyrHlmkHwOjK6NdVqf6L/MiDSTdNfkk19UXGjzFLtALYQWdVdcwMCiZuptMqjrT+kOY4lHfZ4ucHfPYBgnJBz6GRxdQpCI7fXvR/zjbuL7kNRCmDgPOJhMo02uFqOmUnNQGCm+m36vpv+PdlqIU3mkzXJ3htPE3rv1Eb47W8f3kF3fH25mJBzrYxtPUtxUBZWeAZ/O2ZP86YBs1lHHn5Ff+CyQb9HJBtSlDouRfjVbsK9YuRA0T06QpKmSpIQLuibuWVOsx/tlPKYETThBcWvccGLZyYf/XGZu51nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737099977; c=relaxed/relaxed;
	bh=nU8UGsI+C7nhXTkToAzqIL5sI02OfYwOv/L05bAuf2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIdYSgurhFrJXVmazQ+48IZc5y/6fZ1RdB3ifhvuN8t5eS8dy3bSAulr0nwhBFQuWlMpc2Gba8l2kqE0fFhjNYwsjTgqqKPz13j/DrBxB3PQPRQ+Onto8uIMkAA3geKeSQjGRVi29jJRQN3V6uBS96807NlJPiDbUI3imfX2CpbTgiJ8LHhhQsABaXtgqyLMYLA/VlPIUSaPFjYE41KKz+WMc/mhiAfp8ZmzLXBJtMUMcCESYqO1Skc0e9wD51j43RGmwA9megkG7lSNTgA2FP+QWhQjCgrx3LYwFwjl6egF6WE01UVS9BAzHVEvPwI1x6sCW3wJgfuCWVTi4E/+Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oGKEwAjW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oGKEwAjW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZBcl3LZ2z30VX
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 18:46:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737099970; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nU8UGsI+C7nhXTkToAzqIL5sI02OfYwOv/L05bAuf2c=;
	b=oGKEwAjW17lJ/KgoDwS3UO+YQEhIJ9DOnSxRE+qxKBNqRE/CT8h2JF+YQUjdwOlPYKDz1dc1vw62C6XT868EsjFxKOTncqWkU5MiOd677G+G/iZBbU2740lmwvMmSYpzjVYKNFp0ye1d9qcxXT/D9Oxy+PhA+L7sPAiHMuSLPSs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNo5San_1737099963 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 15:46:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: use erofs_map_blocks() for all datalayouts
Date: Fri, 17 Jan 2025 15:46:00 +0800
Message-ID: <20250117074602.2223094-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It simplifies the codebase a bit.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 11 +----------
 fsck/main.c | 23 ++---------------------
 lib/data.c  | 12 ++++++++++--
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 860ee5a..44f65da 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -359,14 +359,6 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 	return 0;
 }
 
-static int erofsdump_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags)
-{
-	if (erofs_inode_is_data_compressed(inode->datalayout))
-		return z_erofs_map_blocks_iter(inode, map, flags);
-	return erofs_map_blocks(inode, map, flags);
-}
-
 static void erofsdump_show_fileinfo(bool show_extent)
 {
 	const char *ext_fmt[] = {
@@ -461,8 +453,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	while (map.m_la < inode.i_size) {
 		struct erofs_map_dev mdev;
 
-		err = erofsdump_map_blocks(&inode, &map,
-				EROFS_GET_BLOCKS_FIEMAP);
+		err = erofs_map_blocks(&inode, &map, EROFS_GET_BLOCKS_FIEMAP);
 		if (err) {
 			erofs_err("failed to get file blocks range");
 			return;
diff --git a/fsck/main.c b/fsck/main.c
index f20b767..f56a812 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -527,31 +527,12 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
 		  inode->nid | 0ULL, inode->datalayout);
 
-	switch (inode->datalayout) {
-	case EROFS_INODE_FLAT_PLAIN:
-	case EROFS_INODE_FLAT_INLINE:
-	case EROFS_INODE_CHUNK_BASED:
-		compressed = false;
-		break;
-	case EROFS_INODE_COMPRESSED_FULL:
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		compressed = true;
-		break;
-	default:
-		erofs_err("unknown datalayout");
-		return -EINVAL;
-	}
-
+	compressed = erofs_inode_is_data_compressed(inode->datalayout);
 	while (pos < inode->i_size) {
 		unsigned int alloc_rawsize;
 
 		map.m_la = pos;
-		if (compressed)
-			ret = z_erofs_map_blocks_iter(inode, &map,
-					EROFS_GET_BLOCKS_FIEMAP);
-		else
-			ret = erofs_map_blocks(inode, &map,
-					EROFS_GET_BLOCKS_FIEMAP);
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
 		if (ret)
 			goto out;
 
diff --git a/lib/data.c b/lib/data.c
index f37f8f0..8033208 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -62,8 +62,8 @@ err_out:
 	return err;
 }
 
-int erofs_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags)
+int __erofs_map_blocks(struct erofs_inode *inode,
+		       struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -132,6 +132,14 @@ out:
 	return err;
 }
 
+int erofs_map_blocks(struct erofs_inode *inode,
+		     struct erofs_map_blocks *map, int flags)
+{
+	if (erofs_inode_is_data_compressed(inode->datalayout))
+		return z_erofs_map_blocks_iter(inode, map, flags);
+	return __erofs_map_blocks(inode, map, flags);
+}
+
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 {
 	struct erofs_device_info *dif;
-- 
2.43.5

