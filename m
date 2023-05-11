Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 918936FF3CF
	for <lists+linux-erofs@lfdr.de>; Thu, 11 May 2023 16:15:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QHDT536kgz3fRJ
	for <lists+linux-erofs@lfdr.de>; Fri, 12 May 2023 00:15:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=axstHXsy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=axstHXsy;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QHDT04cf4z3fJL
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 May 2023 00:15:48 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AF09361384;
	Thu, 11 May 2023 14:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158CFC433D2;
	Thu, 11 May 2023 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683814545;
	bh=UBNgC0nJvZWbH9ZV4xw8Vst/6dWrv7d4JnFJkRg2lc0=;
	h=From:To:Cc:Subject:Date:From;
	b=axstHXsykGqtDXD1Ubyr0ynkZWZQemCh2hMsW+Naz+cysJhRTPMs63Y+5JdbHSgZ9
	 OHI3jom/Z0Z8aSpqevwW9b3W7Me01rYiXMKTPBgf+vn8ZRr9AymVlkZFz+E2MRoxjH
	 I8p2m9nS+SN7nFAPfQJhL7mgwSJxof+m7ZYzjQwsxbCemuEqDdDt08fkKbpF+zXRK3
	 BlPurT8tvHkLLt3u6V9wXE613viRWtUkDJFKaKK2ifZa83rhUOGpqhmVWNOJSBIR6h
	 cuU15VStPMFhl00JwemT8yaYiD5uxH9LlSR0AL0nq4+7ITCOLueYEtYDL0ID4DFJPN
	 6QSjd4NREwFSw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix an infinite loop of big pclusters
Date: Thu, 11 May 2023 22:15:20 +0800
Message-Id: <20230511141520.32835-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Chaoming Yang <lometsj@live.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Actually it's outdated code compared with kernel
commit b86269f43892 ("erofs: support parsing big pcluster compact indexes")

This will cause fsck.erofs works endlessly on some crafted images.

Reported-by: Chaoming Yang <lometsj@live.com>
Fixes: 418fb683fd96 ("erofs-utils: fsck: fix an infinite loop of big pcluster")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 7b0fd83..6d9b033 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -322,7 +322,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
 					continue;
 				}
-				if (lo == 1) {
+				if (lo <= 1) {
 					DBG_BUGON(1);
 					/* --i; ++nblk;	continue; */
 					return -EFSCORRUPTED;
-- 
2.30.2

