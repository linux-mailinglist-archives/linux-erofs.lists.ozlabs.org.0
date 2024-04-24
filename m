Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FA8B017C
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 08:02:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ulZuaZ33;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPT0c1B28z3cFN
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 16:02:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ulZuaZ33;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPT0V5pqYz3bnL
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 16:02:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 73EA961975;
	Wed, 24 Apr 2024 06:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600BFC113CE;
	Wed, 24 Apr 2024 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713938536;
	bh=dLDF8GJkHDpHyhGsRP5M1F0o5PGP5MbWw6JN9ttkRZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulZuaZ33Zdk4+FqpijfqbSYF6al9cbcXxeKjHTkWMpbMb83qR3SFrUCmMmiQhtx/p
	 uveV6gSR9rBrYMvhJAM3vLivRwqw3cf4hJFRVskkl/ZlWsjJn2DvK5RbkS+r94KjSZ
	 Ej8bU++TBvOOJKvisb9itt8YhdKDl9fIDSR61LxGaUZoqOlgT41ML+tmVi7Lnsqcrc
	 Ay+G5IkE2ZjNMOV80R13TKNjYZageh2rimE+LfLV6CSq7FDaazCljPnhdoOwI30ecE
	 97DmI3kiHq+FJeq/YEbtCc93ls152CCKB5i22CT/9Fihp/R57QMwj8FTeTsJVOiwBP
	 qRRREW0v43vKg==
Date: Wed, 24 Apr 2024 14:02:11 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: fsck: extract chunk-based file with hole
 correctly
Message-ID: <ZiigY6wpJDb6SMx9@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
 <20240422113132.276631-1-zhaoyifan@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422113132.276631-1-zhaoyifan@sjtu.edu.cn>
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

On Mon, Apr 22, 2024 at 07:31:32PM +0800, Yifan Zhao wrote:
> Currently fsck skips file extraction if it finds that EROFS_MAP_MAPPED
> is unset, which is not the case for chunk-based files with hole. This
> patch handles the corner case correctly.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

I will apply the following version:

From 56e2f73cec3fa45d8b1dd1e9ec571b1f075d2275 Mon Sep 17 00:00:00 2001
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Date: Mon, 22 Apr 2024 19:31:32 +0800
Subject: [PATCH] erofs-utils: fsck: extract chunk-based file with hole correctly

Currently fsck skips file extraction if it finds that EROFS_MAP_MAPPED
is unset, which is not the case for chunk-based files with holes.

This patch handles the corner case correctly.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index e5c37be..4dcb49d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -470,9 +470,18 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		pos += map.m_llen;
 
 		/* should skip decomp? */
-		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
+		if (map.m_la >= inode->i_size || !fsckcfg.check_decomp)
 			continue;
 
+		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
+			ret = lseek(outfd, map.m_llen, SEEK_CUR);
+			if (ret < 0) {
+				ret = -errno;
+				goto out;
+			}
+			continue;
+		}
+
 		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
 			if (compressed) {
 				erofs_err("invalid pcluster size %" PRIu64 " @ offset %" PRIu64 " of nid %" PRIu64,
-- 
2.30.2

