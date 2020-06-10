Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9943C1F5A02
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2020 19:17:52 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49htwY4dgvzDqlV
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2020 03:17:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1591809469;
	bh=wyBe8SWYiQXrM+Pfciz6JIxBK4q1b1+aEsgW4YtWsgg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=CZn+Lc0LDAD7/A4qnY9dS61nE+dYEhQETb0vpfbZki/YxhwmG+Vc566TdqMgTV3XX
	 vuwfPvKL4teflWICPPabf7Ul9ggFqcaxOECN4Zt6W/oV4fd1ZCddRdqvsZ6TovXk+p
	 h2zw/1zpkg4ELCyhqwfYHWJ/m8IG+ikpJVTN9uhUjHV4NkX2m72lnh97TPQB2tXOnh
	 gv41nseek6jv61dfWpo0Gt+VBQNdnQ9/GcexlcnmmJlZ9ut3fC2l3Az17aFnd+JBnN
	 eypbVJ+rzifFBuIm0Zr6sDFvHkfvSZMjRJBN3iJRR4xCTw3tfhY+W1j2ukM0SQ8u1g
	 7WZ0MGslHTKww==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=bBbQnwrM; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49htwM212QzDqjW
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2020 03:17:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1591809452; h=From:To:Subject:Date:Message-Id;
 bh=Biy5C8CKWXJhiFJq1K4bmwKkrKTvxSVxWKs3+E8lbp8=;
 b=bBbQnwrMcknUNNfvMhr7kk3YpSKWyBGajBT+DZxAqK/CoVA/XJFExugxpP+INAv7tQI8Cez1Y7HHncT3xZARAf4wOLmluPM9Z9nF5fqwDGjcP3neTf0qG2HkDNSVJW3OZCd+FkgtGUaXe2EDVwASv4hCbpbkFFUBnklYaC9QJ6s=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357959|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0305189-0.00170529-0.967776;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U.CCo97_1591809451; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U.CCo97_1591809451) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 11 Jun 2020 01:17:31 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: introduce segment size to limit the max input
 stream
Date: Thu, 11 Jun 2020 01:17:28 +0800
Message-Id: <20200610171728.7303-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Cc: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Limit the max input stream size by adding segment compression
(e.g. 4M segment size), it will benefits:
 - more friendly to block diff (and more details about this);
 - it can also be used for parallel compression in the same file.

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
---
 include/erofs/config.h |  1 +
 lib/compress.c         | 11 +++++++++++
 lib/config.c           |  1 +
 3 files changed, 13 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f09749..9125c1e 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -36,6 +36,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
+	unsigned int c_compr_seg_size;	/* max segment compress size */
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
diff --git a/lib/compress.c b/lib/compress.c
index 6cc68ed..8fdbfb2 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,8 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	unsigned int comprlimits;
+	unsigned int comr_seg_size;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -158,6 +160,12 @@ static int vle_compress_one(struct erofs_inode *inode,
 	while (len) {
 		bool raw;
 
+		if (ctx->comprlimits >= ctx->comr_seg_size ||
+			ctx->comprlimits + EROFS_BLKSIZ >= ctx->comr_seg_size) {
+			ctx->comprlimits = 0;
+			goto nocompression;
+		}
+
 		if (len <= EROFS_BLKSIZ) {
 			if (final)
 				goto nocompression;
@@ -202,6 +210,7 @@ nocompression:
 
 		++ctx->blkaddr;
 		len -= count;
+		ctx->comprlimits += count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
@@ -422,6 +431,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
+	ctx.comprlimits = 0;
+	ctx.comr_seg_size = cfg.c_compr_seg_size;
 
 	while (remaining) {
 		const u64 readcount = min_t(u64, remaining,
diff --git a/lib/config.c b/lib/config.c
index da0c260..1c39403 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_seg_size = 1024U * EROFS_BLKSIZ;
 }
 
 void erofs_show_config(void)
-- 
2.17.1

