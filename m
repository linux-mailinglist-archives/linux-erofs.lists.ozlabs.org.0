Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C1458749
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Nov 2021 00:58:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hy6nB1gjlz2yXv
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Nov 2021 10:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AKp8pwGO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AKp8pwGO; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hy6n74p97z2xDr
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 10:58:51 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD7676069B;
 Sun, 21 Nov 2021 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637539129;
 bh=Ub+mDs4ARemiJfRV9OAvAuXcsNwtzLjXCWSA7hmCPTA=;
 h=From:To:Cc:Subject:Date:From;
 b=AKp8pwGOYTT8YjIon+5W4PauYS7bQ7dMtGkKt7gDNaVQvOFhdxQ7nLKs85yUDPdzt
 L3/BkFoS33XXXyjCuH5s02qvv29drVAPSU63VRiFTDavdVHP8evJnmHCIUnhWGv1pB
 w0uMpaDMcNYtX/Hk5Re26v6S+gDhKS55oDb6e04hUEgSzCdQkWz0pMLDwZhjlB3xuv
 cwGjeqiF4I+JP2EawD4nw5xpKEzWN3vTm6xh993SXXeH7FXdTFesMlto+zAhX/Bb8/
 LFbZPjflFiqgak4w+3cICfza0qQ0XCrrokDDjPK1rLze7/SCZt63WmUW3l0yQpW1P9
 2/CaD2IcXZMhg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix Makefile for fsck.erofs manpage
Date: Mon, 22 Nov 2021 07:58:40 +0800
Message-Id: <20211121235840.17600-1-xiang@kernel.org>
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

Add the missing dependency for fsck.erofs manpage.

Fixes: f44043561491 ("erofs-utils: introduce fsck.erofs")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index 769b5578a175..4628b85df2ef 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dist_man_MANS = mkfs.erofs.1 dump.erofs.1
+dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
 
 EXTRA_DIST = erofsfuse.1
 if ENABLE_FUSE
-- 
2.20.1

