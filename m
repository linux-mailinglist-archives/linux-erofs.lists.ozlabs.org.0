Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEC87DC74
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 08:08:34 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dISKkGHL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ty8GS4Lwtz3d4D
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 18:08:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dISKkGHL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ty8GJ5Vj8z3by8
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 18:08:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F061A6069F;
	Sun, 17 Mar 2024 07:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D81FC433F1;
	Sun, 17 Mar 2024 07:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710659300;
	bh=yC1F5/PWraL+8ufGjjeKqRJW4CJ3gTtJ2G4i8F4PY5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dISKkGHL/Bf1Zv6zfHekem8t26eo/hgB75zhOh2qQ/QCyT/5OKRv2y7dVB8xP5rkq
	 TwJJalh5t+IX1KdFmA3Z2h4q0rj97zr/48u8rtrMS7KgehLckq7p03SLIRROBN7mNd
	 wLeNAHVVRru8s886eKg4oOX5DnAHCfJ5gjiaoN2LdHM9ysinygkbClMt53o2uzSqtM
	 PYBexf5mUSSD6ujGxBaSyTl5m6Tg/pVjiGLfW4mVf5NHhNZzztTPUqfa5zqnIF80D8
	 kpTRdFKZDZADcHgnrO7W5GxHjzE6XZ9tNdhkJnC8DG9Rbrfu2pn/E1Yq28sBkvToND
	 eHS4quPBz2PIA==
Date: Sun, 17 Mar 2024 15:08:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH] erofs-utils: mkfs: fix out-of-bounds memory access in
 mt-mkfs
Message-ID: <ZfaW3oLe8Q2621DV@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240317064509.994918-1-zhaoyifan@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317064509.994918-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Mar 17, 2024 at 02:45:09PM +0800, Yifan Zhao wrote:
> If a segment is smaller than the block size, sizeof(sctx->membuf) should
> be at least as large as the block size, as memory write into the buffer
> is done in block size.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---

Folded the following diff into the original patch:

diff --git a/lib/compress.c b/lib/compress.c
index aeb7013..8d88dd1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1096,11 +1096,11 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct erofs_compress_wq_tls *tls = tlsp;
 	struct z_erofs_compress_sctx *sctx = &cwork->ctx;
+	struct erofs_sb_info *sbi = sctx->ictx->inode->sbi;
 	int ret = 0;
 
-	ret = z_erofs_mt_wq_tls_init_compr(sctx->ictx->inode->sbi, tls,
-					   cwork->alg_id, cwork->alg_name,
-					   cwork->comp_level,
+	ret = z_erofs_mt_wq_tls_init_compr(sbi, tls, cwork->alg_id,
+					   cwork->alg_name, cwork->comp_level,
 					   cwork->dict_size);
 	if (ret)
 		goto out;
@@ -1109,7 +1109,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	sctx->destbuf = tls->destbuf;
 	sctx->chandle = &tls->ccfg[cwork->alg_id].handle;
 
-	sctx->membuf = malloc(sctx->remaining);
+	sctx->membuf = malloc(round_up(sctx->remaining, erofs_blksiz(sbi)));
 	if (!sctx->membuf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.30.2

