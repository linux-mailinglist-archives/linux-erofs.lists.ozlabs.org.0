Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB644A8C1E
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Feb 2022 20:02:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JqShs4Bmsz3bVd
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 06:02:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PjqcSqb6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PjqcSqb6; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JqShl3Jc8z2x9F
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Feb 2022 06:02:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B32C8618FE;
 Thu,  3 Feb 2022 19:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707D8C340E8;
 Thu,  3 Feb 2022 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643914932;
 bh=cJG9o5eRJ7YKbd6n5DSg9CwYjNG9DgWrahvpoQ7Qonk=;
 h=From:To:Cc:Subject:Date:From;
 b=PjqcSqb60rsEKs3aCMdcvdPf2Cgl8zARK3XuFKckymcpDKk/Th5F7QVMJyaBPPmvi
 ab65P90ABnbMlJ97b0bKPJwTsAABhAjATHPmE1HzC13RYQtngQE9ZaUVZD7ATnxATK
 /TwWoZzsmPBGwUiTI5U3vJbWmaI2JMfjD6Rdrcb2/eaFu+2nzfeIj7eRdYQhyT48GF
 UXaHYNZ5igVT+w95Tqt/TEoCK7iCML23hjf9IMZ3vfLjbZwc6fYaZI3Yqxmv1R8omP
 V6tw9CEBrEwQoFcywDwBz+7UShnMjY+1UovbXs8rmDC6N2CLJaxFod0WmoxhPJeSPe
 3jYVAdISA9+bg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix small compressed files inlining
Date: Fri,  4 Feb 2022 03:02:03 +0800
Message-Id: <20220203190203.30794-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Prior to ztailpacking feature, it's enough that each lcluster has
two pclusters at most, and the last pcluster should be turned into
an uncompressed pcluster if necessary. For example,
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|

which should be converted into:
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 (uncompressed)' _|

That is fine since either pcluster n-1 or (uncompressed)' takes one
physical block.

However, after ztailpacking supported, the game is changed since the
last pcluster can be inlined now. And such case above is quite common
for inlining small files. Therefore, in order to inline such files
more effectively, special EOF lclusters are now supported which can
have three parts at most, as illustrated below:
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
                                   ^ i_size

Actually similar code exists in Yue Hu's original patchset [1], but I
removed this part on purpose. After evaluating more real cases with
small files, I've changed my mind.

[1] https://lore.kernel.org/r/20211215094449.15162-1-huyue2@yulong.com
Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 18d7fd1a5064..723ebfa6a27d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -630,6 +630,13 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			/*
+			 * For ztailpacking files, in order to inline data more
+			 * effectively, special EOF lclusters are now supported
+			 * which can have three parts at most.
+			 */
+			if (ztailpacking && end >= inode->i_size)
+				end = inode->i_size;
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-- 
2.20.1

