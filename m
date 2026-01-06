Return-Path: <linux-erofs+bounces-1686-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63468CF6A21
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 04:58:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlcpc4RSJz2xqr;
	Tue, 06 Jan 2026 14:58:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767671912;
	cv=none; b=HRTxUPHOPaKXOJCdhfjfwcVx0lQrUrQSokX341HXUqdW5zlWlOE3vuAyz2Fr2DHSY40LSG8pFq5pjb0AYdy1dyNDxAW15SWVX5qSFR7SpGM7t3TE99J4xZ3mGJ53OlijWgRROO2yz2xWGpnoHlTQ8PJ0ywUgLpxK7OtNyPqtyQBBpsXvptset1FUuKNW/d+MhW/Z+NWP/I/Hym+v5GKOVqCKEmPouoX+wxzml2PBrtjDt5hnJY6ZuUQ6pV2xsMBvsuhVn2DAr5vR4IWErOyTppX6Qz9iXIF6rUIu5z+i+xwuPEHghoWWngFueIQhwlOJmWMY9gfq9Mlexy4xwD+SkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767671912; c=relaxed/relaxed;
	bh=yjs6eTju93s/OUaBVFnVPLz9zznxz80rZtTMpkziujM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XV0Klyp53RMvv/OBqjxBrbdZS8qYXlbkOwiRi/5dG8Z1PM8+aeiA54VNUXg5E1UhGMbj3rvTDXdGu/uXsojn6i84FzDRSM3t7c7SeVrEAw7IEGYMmiAyLzAhiLVYesMzhxsm0Xd798yZb1Q/J0Wj4JtJQE1DNtwXtuoqkNclrMiSPByYcBmlB0DC/6uqZdXE4dySukyJ39AXSF4CUXkkfaAbzLIbGTCyZVDCsOriO/W2fegvmB8RjfCQl6eeEF4N6cSs5noDh+Ep3LaLDzu5H5/WkFjys0VAGdOiA3QSUAyTHLpUavmUlHu/A5CyDw03lUoRU2pgsVhvsJjs0untzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pHMRYEQN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pHMRYEQN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlcpY2tJhz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 14:58:27 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767671903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yjs6eTju93s/OUaBVFnVPLz9zznxz80rZtTMpkziujM=;
	b=pHMRYEQNNWHH8/nP5hUitd92dG+uKSTSSOm810TqF3nbQ9bSBOSQaFdl+PkPKOZLpIqDx+TiHpZYnd1tryzxFR1XFhGyDRMfnHBamXRD9FzeuqFAcRUioa8JNxJVY0/0tX4s8qTyxlZukF1kNUjKXVKwUaX+kqgfN8OthSxP+IM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwUMSO-_1767671899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 11:58:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: add fallback for SEEK_{DATA,HOLE}
Date: Tue,  6 Jan 2026 11:58:18 +0800
Message-ID: <20260106035818.3844165-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Since SEEK_{DATA,HOLE} are part of the POSIX standard [1].

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/lseek.html
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h | 11 +++++++++++
 lib/blobchunk.c    |  4 ----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 4bc216a2eace..9533efc2d20a 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -24,6 +24,17 @@ extern "C"
 #define O_BINARY	0
 #endif
 
+/*
+ * seek stuff
+ */
+#ifndef SEEK_DATA
+#define SEEK_DATA	3
+#endif
+
+#ifndef SEEK_HOLE
+#define SEEK_HOLE	4
+#endif
+
 struct erofs_vfile;
 
 struct erofs_vfops {
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 3b1c97b5d874..c66bd2020e45 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -277,14 +277,12 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	u8 *chunkdata;
 	int ret;
 
-#ifdef SEEK_DATA
 	/* if the file is fully sparsed, use one big chunk instead */
 	if (lseek(fd, startoff, SEEK_DATA) < 0 && errno == ENXIO) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
 		if (chunkbits < sbi->blkszbits)
 			chunkbits = sbi->blkszbits;
 	}
-#endif
 	if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
 		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
 	chunksize = 1ULL << chunkbits;
@@ -332,7 +330,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	}
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
-#ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
 
 		if (offset < 0) {
@@ -369,7 +366,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			len = 0;
 			continue;
 		}
-#endif
 
 		len = min_t(u64, inode->i_size - pos, chunksize);
 		ret = read(fd, chunkdata, len);
-- 
2.43.5


