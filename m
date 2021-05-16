Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C720A381E59
	for <lists+linux-erofs@lfdr.de>; Sun, 16 May 2021 12:56:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FjfMK4fTYz2ysp
	for <lists+linux-erofs@lfdr.de>; Sun, 16 May 2021 20:56:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cGAlQ/rW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cGAlQ/rW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FjfMD5k7Jz2y6C
 for <linux-erofs@lists.ozlabs.org>; Sun, 16 May 2021 20:56:08 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CC2661166;
 Sun, 16 May 2021 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621162565;
 bh=tNLRKIFImd0P/Errv9Mrf16OdLET6CcgGFmxQtDz4sM=;
 h=From:To:Cc:Subject:Date:From;
 b=cGAlQ/rWceBLlWQLVXvkbNlaFy5/7d3w6hRrWsUWQDDbt6MBM/0ShvxvgG6VRxrwf
 5lypNFSFEpfWFEST1ieBs/nRR4I5PYwJbG6ZtzdFlniaSZikUtYWalF2CRM8LpH9EH
 jpxfOYcI7sjFBnBnBAcyjuyZmWh+1PRuZdDYbPwXSPCTeQCRBVUb18DfF7LB8lblz4
 xb7013S6wlK0biDMfZdQVXteFTtUloBLBhEEA/lflbbCfpTnhxsXGuFV4G9uQZugYb
 25mEqCCbYsl04j8kmvDbXyGrKr7rtunGgmBQ+RhsPtPIH1A9B9bZt8kZx5o5DMc0Pt
 ULZUjZE6mg6eg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH] erofs-utils: fix Makefile for the erofsfuse manpage
Date: Sun, 16 May 2021 18:56:01 +0800
Message-Id: <20210516105601.711-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add the missing dependency for the erofsfuse manpage.

Fixes: c952430a8ce0 ("erofs-utils: manpage: add manual for erofsfuse")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index dcdbb35ce83a..ffcf6f81c255 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Makefile.am
 
-dist_man_MANS = mkfs.erofs.1
+dist_man_MANS = mkfs.erofs.1 erofsfuse.1
 
-- 
2.20.1

