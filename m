Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECF473A3B
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 02:34:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCgrx5ZlRz3036
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 12:34:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R5h/T8fp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R5h/T8fp; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCgrs5TVZz2xDv
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 12:34:05 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BE29BB811E0
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 01:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C29CC34603;
 Tue, 14 Dec 2021 01:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639445641;
 bh=SHXteZ7pU3EwpTJmr9tf8RnTTJJbjtWrQVtm0bMxavQ=;
 h=From:To:Cc:Subject:Date:From;
 b=R5h/T8fp8Uw6SP69Aofe40mNL59UOwA7KrJrisLogMVnCCbmck3rsO3IQRqz1fLsB
 Uq6atrSQMVJFD3egm1Tx/n2FlABtPFy20LhJTbcaSG1VYU5o0abtWaU5j9tHdRHnPr
 BYGNbUS0qpPNictjdEHhjpWlR0ZVY+/AXrdSUdy2ylLypEb5Vyy4RMLiU4s40RgPbe
 xZgbfpAT26Or2y++voB1QpWrlEor+Goj+rT8jz3QOU+VfNjW1wkUzN05EeqXG4/2jP
 /SkUL+dp9pXc9X8ueRQ7cUnUrbDWJK2L5B2Lq1ngFeuQP0x7Dnqn5NCmCAfOfBWQtA
 viFcbFEG3A42g==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: clear compacted_2b if compacted_4b_initial >
 totalidx
Date: Tue, 14 Dec 2021 09:33:22 +0800
Message-Id: <20211214013322.4638-1-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Keep in sync with the latest kernel
commit c40dd3ca2a45 ("erofs: clear compacted_2b if compacted_4b_initial > totalidx")

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/zmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 09d5d35e65ee..abc8babd6763 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -315,7 +315,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial < totalidx)
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
-- 
2.20.1

