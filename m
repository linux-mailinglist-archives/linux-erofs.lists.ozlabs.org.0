Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AAB87DC72
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 07:46:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ty7mQ2s2Xz3d4H
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 17:45:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ty7mH5dLvz3by8
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 17:45:49 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 4BDAD1008C2C3
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 14:45:40 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id DD17A37C921;
	Sun, 17 Mar 2024 14:45:38 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix out-of-bounds memory access in mt-mkfs
Date: Sun, 17 Mar 2024 14:45:09 +0800
Message-ID: <20240317064509.994918-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If a segment is smaller than the block size, sizeof(sctx->membuf) should
be at least as large as the block size, as memory write into the buffer
is done in block size.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/compress.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index aeb7013..67a86db 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1096,11 +1096,12 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct erofs_compress_wq_tls *tls = tlsp;
 	struct z_erofs_compress_sctx *sctx = &cwork->ctx;
+	struct erofs_sb_info *sbi = sctx->ictx->inode->sbi;
+	erofs_off_t blksz = erofs_blksiz(sbi);
 	int ret = 0;
 
-	ret = z_erofs_mt_wq_tls_init_compr(sctx->ictx->inode->sbi, tls,
-					   cwork->alg_id, cwork->alg_name,
-					   cwork->comp_level,
+	ret = z_erofs_mt_wq_tls_init_compr(sbi, tls, cwork->alg_id,
+					   cwork->alg_name, cwork->comp_level,
 					   cwork->dict_size);
 	if (ret)
 		goto out;
@@ -1109,7 +1110,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	sctx->destbuf = tls->destbuf;
 	sctx->chandle = &tls->ccfg[cwork->alg_id].handle;
 
-	sctx->membuf = malloc(sctx->remaining);
+	sctx->membuf = malloc(max(blksz, sctx->remaining));
 	if (!sctx->membuf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.44.0

