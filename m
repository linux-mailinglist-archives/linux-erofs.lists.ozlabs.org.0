Return-Path: <linux-erofs+bounces-38-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BECA5905B
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1b47LJz305v;
	Mon, 10 Mar 2025 20:55:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600515;
	cv=none; b=U2ILzYiHIIum2rtq7U962vROZStwYsNq/PL8V4TrYYl6tOPyqRRikBX/b0jE+quZt2TQ1rWvBCn6llNAVsLVQUuQDqnXGvjcIvvyzDoUKF1gGPVi8fdNOTBAWtmFVlIVUPzbvDISZ2MtV/imlToD+ZYXnCTAipbeyW7Pi8oyU2NV4Cqy2JfHYCTOYLxFX04qkToRd5KDkEv2kNPlf++9WVTYZkkxD3b1tKUR9wi9H0dSpE0GZX/qogo4HFFex/Kw4n00I0itpmxy3ZWiyh+LyNJq5rRftBfaUXE+swUSIjHw6X1a2cy+LZ8LnO2Bi+nv5Ikxti28tZEbmq5hsXWNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600515; c=relaxed/relaxed;
	bh=inQ7L5nN0a/HpCYRCvZiBbdUFWIni4CRkXK2nXN8wCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA6B5fi2zDCAnFSTuMwRX0UqKB/xAFi8uY1Dm3HD6f5gKIhnqXkz5WXkEZIZmoU1nz3BT3CyHdHin5yyFDAvUGpkQkLI/dayyTg/3v5YBilXTSrICj7MZoTzQBxTgOeTXeDsH/BDCyCdFScSnNYjPVn4xsMTc88WxU2hNSBP9RxXhUxmhDoEDOzPR2U91MJytADY7Mohzy9Dab8H12gBq1qZryegkqDmyaMbrRtUBxMS4ioAxJQEg2DOfjpy/MIYDZ3heHE4mr7+31e+NqtsNhcUd9CASaX7lhqQ81OvkuQbwwcJXHD5I09jPTmU2zPGvvh8TOUS7AE2maVc1vnDJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TddCjJi+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TddCjJi+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1Z09x8z30WR
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600509; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=inQ7L5nN0a/HpCYRCvZiBbdUFWIni4CRkXK2nXN8wCY=;
	b=TddCjJi+gZCv4yRktRir9mMKCbAQAzBtLVcGWOw/YSHHX4hsFTxjNIrW0eKPhamMOy8S5lnvul2SivggokVcIaYQ208jN2h3QD6iMOtO2VpHal7TKRgyCeQDFqyylyTNYKZHeCks+0mp7dIo+1R70nahgQ+OOUoGLxhAeK3UUWM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3zQ_1741600508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 05/10] erofs: support dot-omitted directories
Date: Mon, 10 Mar 2025 17:54:55 +0800
Message-ID: <20250310095459.2620647-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
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

There's no need to record "." dirents in the directory data (while
they could be used for sanity checks, they aren't very useful.)
Omitting "." dirents also improves directory data deduplication.

Use a per-inode (instead of per-sb) flag to indicate if the "." dirent
is omitted or not, ensuring compatibility with incremental builds.  It
also reuses EROFS_I_NLINK_1_BIT, as it has very limited use cases for
directories with `nlink = 1`.

Emit the "." entry as the last virtual dirent in the directory because
it is _much_ less frequently used than the ".." dirent.  It also keeps
`f_pos` meaningful, as it strictly follows the directory data when it's
less than i_size.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c      | 5 +++++
 fs/erofs/erofs_fs.h | 1 +
 fs/erofs/inode.c    | 4 +++-
 fs/erofs/internal.h | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index fa3c2d380cc9..2fae209d0274 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -90,6 +90,11 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		ofs = 0;
 	}
 	erofs_put_metabuf(&buf);
+	if (EROFS_I(dir)->dot_omitted && ctx->pos == dir->i_size) {
+		if (!dir_emit_dot(f, ctx))
+			return 0;
+		++ctx->pos;
+	}
 	return err < 0 ? err : 0;
 }
 
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 8330ca3b18d3..791124b3f57c 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -116,6 +116,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT	0
 #define EROFS_I_DATALAYOUT_BIT	1
 #define EROFS_I_NLINK_1_BIT	4	/* non-directory compact inodes only */
+#define EROFS_I_DOT_OMITTED_BIT	4	/* (directories) omit the `.` dirent */
 #define EROFS_I_ALL		((1 << (EROFS_I_NLINK_1_BIT + 1)) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 20d58228dfc9..3a5bb73a9397 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -137,8 +137,10 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 	switch (inode->i_mode & S_IFMT) {
-	case S_IFREG:
 	case S_IFDIR:
+		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
+		fallthrough;
+	case S_IFREG:
 	case S_IFLNK:
 		vi->startblk = le32_to_cpu(copied.i_u.startblk_lo) |
 			((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 07515a6f2534..91d0b400459c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -245,6 +245,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
+	bool dot_omitted;
 	unsigned int xattr_isize;
 
 	unsigned int xattr_name_filter;
-- 
2.43.5


