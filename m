Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5036BD68
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Apr 2021 04:37:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTmBp5dWHz2yxy
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Apr 2021 12:37:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PZNe/P0v;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PZNe/P0v; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTmBm3VC3z2y8P
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Apr 2021 12:37:36 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC68261073;
 Tue, 27 Apr 2021 02:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619491054;
 bh=chnXTw9Zar8MOjBk+aonoWKXtj02SVfZkIgvQ+eyezA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PZNe/P0vnuuhV3SFp/rH4/oRFJ5RBmbeN3vVU5Yf2CPNXy899NK/Nwd4KKC441dkn
 1/8xiDLZuqvn5NKbXxWNKKcYpvCBVovVaY1/YD/1F4LtJKQp7dX45jO1rbh5ETlcq+
 9bf0KE90lvMDggK86ZClEhDTYAnwnzeiS+w0lJwZUU1kmpKwvrBS6bISdXbXQ/BZzJ
 z+1OvWYtN6YipflPLtU4+Eb+7Pz5n3rqQCICxBOWg4qYm/hLlFoBABV8y+o6fyckOn
 dd51trseuBBAM6pIE9TUhJnfWdNcEWc4zlGIuQb9FOw7tGXCo3ZGHvz9jIwBe+fnEH
 uzGRw+Kcik9bg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 3/3] erofs-utils: man: add missing -C option for big pcluster
Date: Tue, 27 Apr 2021 10:37:22 +0800
Message-Id: <20210427023722.7996-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210427023722.7996-1-xiang@kernel.org>
References: <20210427023722.7996-1-xiang@kernel.org>
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

Update the manpage as well.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/mkfs.erofs.1 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 254c3ec4de41..d10f080a0534 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -24,6 +24,10 @@ from \fISOURCE\fR directory.
 Set an algorithm for file compression, which can be set with an optional
 compression level separated by a comma.
 .TP
+.BI "\-C " max-pcluster-size
+Specify the maximum size of compress physical cluster in bytes. It may enable
+big pcluster feature if needed (Linux v5.13+).
+.TP
 .BI "\-d " #
 Specify the level of debugging messages. The default is 0.
 .TP
-- 
2.20.1

