Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F80536FCF
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 07:56:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9nq06Vsmz3blp
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 15:56:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NEWte+aA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NEWte+aA;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9nps5Xt7z2xXV
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 15:56:21 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D9CCD60DF2;
	Sun, 29 May 2022 05:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9FCC34119;
	Sun, 29 May 2022 05:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653803778;
	bh=ILHcOL+VeOJQPjhcWAot4jRYCJb0WUQYJb7FOE03RaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEWte+aAbfP1T1fPvnc0T551Ldf4jdMQjn0IxlI/JX9lDizQ+nVHQhs+900J1AnxV
	 clyZb9JohlaRK/lZIWHFoyBZJWddRdY6bU09JYQbB0Orl9D3ApGdCUdGE6DiooH+0l
	 +VHde9X8ixHF3xexJ1XCP9rUNkRJtLgS5uZfLvNbq39FGwz97nIrMNm77qOdmAfI67
	 HOj/PYJGB2kPLaSO6Pgurm4FJStC+CnlHbiK05AGcZTasizRzp/2tXYVHnMSZc0msc
	 6FiVC/ZPvjesP2gOJBno1Qv0t9XmCuu2HYGLqGkSkJ//ldMuusg5yL/US+n9AnUdPK
	 p7eHU0e+0WHVQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] erofs: get rid of label `restart_now'
Date: Sun, 29 May 2022 13:54:24 +0800
Message-Id: <20220529055425.226363-3-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
References: <20220529055425.226363-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Simplify this part of code. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fd66a66c5f9..6dd858f94e44 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -643,28 +643,23 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 repeat:
 	cur = end - 1;
 
-	/* lucky, within the range of the current map_blocks */
-	if (offset + cur >= map->m_la &&
-	    offset + cur < map->m_la + map->m_llen) {
+	if (offset + cur < map->m_la ||
+	    offset + cur >= map->m_la + map->m_llen) {
+		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
+
+		if (z_erofs_collector_end(fe))
+			fe->backmost = false;
+		map->m_la = offset + cur;
+		map->m_llen = 0;
+		err = z_erofs_map_blocks_iter(inode, map, 0);
+		if (err)
+			goto err_out;
+	} else {
+		if (fe->pcl)
+			goto hitted;
 		/* didn't get a valid pcluster previously (very rare) */
-		if (!fe->pcl)
-			goto restart_now;
-		goto hitted;
 	}
 
-	/* go ahead the next map_blocks */
-	erofs_dbg("%s: [out-of-range] pos %llu", __func__, offset + cur);
-
-	if (z_erofs_collector_end(fe))
-		fe->backmost = false;
-
-	map->m_la = offset + cur;
-	map->m_llen = 0;
-	err = z_erofs_map_blocks_iter(inode, map, 0);
-	if (err)
-		goto err_out;
-
-restart_now:
 	if (!(map->m_flags & EROFS_MAP_MAPPED))
 		goto hitted;
 
-- 
2.30.2

