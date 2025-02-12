Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD6A325E7
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 13:36:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtHr445PWz30WT
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 23:36:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739363810;
	cv=none; b=oxA3byER2NjqlzEqxfTzT1+mZZ8wYbXa64rYFD5sqRASsjT1wZJQrGlxoWuBYSwd0sAP6WQYT6cVAsXC1Y4Lzik26J8sn8sD7MmMfe55Pnn8CuaCsFxfpbpLRlr9vEK560FA0b33k9jFWc2R5/jYFWnIYiZlo/hPFGLJWwfRshtneWMtop8zajMlOd/2p9c4yrQ6YwlXNapg+u/fj27c9ZiFWigmS9Yl3eC5Q4X/IoE8hw5Aon0+hwebCwYvLzuZz4YReDRjhjusq8kXuWmISC2sfZIAaXsjhlM0Jikw23YlHklDrrRECzwCFK/YXw7FclcjPSxkt/qimKSraT2QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739363810; c=relaxed/relaxed;
	bh=VwaQhtT3dooH8oGFClEAADD59R5Nv/aFfonYee/4ANU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orbqZX1KIU08TIopPcrYWWDUQSYsJ6eGOqo/SK2j0KWLhGdZw/YvvAxc1y3AUk3+iobt4ESFb4BMda2iRkrEqbz+MunmvV12hZ4F97GEag6li/sCmNiqfuyljUry/DLnKVQUP3U9hI2QNDvBB9sR48QEFiBrHAH5U48LK4MWCvwuGFbSNhQSR3iYkqeQDr/otUDyTUWhgw/visDqCin1NRHmZBNJ3Bw15RMUXC6ZOCgtX6kQW0iTok0Ypq4o5dCXWdDjYhE6/ecKE+6XWadNRnSod+EWDbVGZxaKBjmqoDB/Gb4vvVJmBgDdVHHXdUjLFy0wo6IgoJTCxxS7OchEfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b9tCP5eW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b9tCP5eW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtHr11QP6z2xr4
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 23:36:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739363803; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VwaQhtT3dooH8oGFClEAADD59R5Nv/aFfonYee/4ANU=;
	b=b9tCP5eWqnpZfNwF7z0Vij1TmTri4xmiRRTG7uNYaHRZ51nP278EduRm7y6S2yEPVH8CIsa5LnVx4ftAaRVJppIQJx1ZCb/AwZLtNCXP1UYRiAZLEQX/XWWrnrJQ9LevnnIiQm5/+8T2pkJMhnOATYMzktyx4Ct87tfDsJp7Ok8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPKD0cE_1739363794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 20:36:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fragment: gracefully exit if temporary storage is low
Date: Wed, 12 Feb 2025 20:36:33 +0800
Message-ID: <20250212123633.40004-1-hsiangkao@linux.alibaba.com>
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

Currently, EROFS keeps all fragments into a temporary file for later
packed inode compression.  However, this could trigger an unexpected
segfault if temporary storage runs low.

Print a proper error message and gracefully exit.

Closes: https://github.com/erofs/erofs-utils/issues/13
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 3 ++-
 lib/fragments.c          | 4 ++++
 lib/inode.c              | 8 +++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5f5bc10..2f71557 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -256,7 +256,6 @@ struct erofs_inode {
 	unsigned int eof_tailrawsize;
 
 	union {
-		void *compressmeta;
 		void *chunkindexes;
 		struct {
 			uint16_t z_advise;
@@ -274,6 +273,8 @@ struct erofs_inode {
 #define z_idata_size	idata_size
 		};
 	};
+	void *compressmeta;
+
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
diff --git a/lib/fragments.c b/lib/fragments.c
index 32ac6f5..9633a2b 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -266,6 +266,10 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 	else
 		rc = 0;
 out:
+	if (rc)
+		erofs_err("Failed to record %llu-byte fragment data @ %llu for nid %llu: %d",
+			  inode->fragment_size | 0ULL,
+			  inode->fragmentoff | 0ULL, inode->nid | 0ULL, rc);
 	if (memblock)
 		munmap(memblock, inode->i_size);
 	return rc;
diff --git a/lib/inode.c b/lib/inode.c
index e51c0fc..434eafb 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -141,16 +141,14 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 		free(d);
 
 	free(inode->compressmeta);
-	if (inode->eof_tailraw)
-		free(inode->eof_tailraw);
+	free(inode->eof_tailraw);
 	list_del(&inode->i_hash);
-	if (inode->i_srcpath)
-		free(inode->i_srcpath);
+	free(inode->i_srcpath);
 
 	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 		erofs_diskbuf_close(inode->i_diskbuf);
 		free(inode->i_diskbuf);
-	} else if (inode->i_link) {
+	} else {
 		free(inode->i_link);
 	}
 	free(inode);
-- 
2.43.5

