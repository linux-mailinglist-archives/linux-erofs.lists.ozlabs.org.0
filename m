Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3013960E1
	for <lists+linux-erofs@lfdr.de>; Mon, 31 May 2021 16:31:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FtyQq3Y8zz2yXk
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Jun 2021 00:31:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZDnKmzm+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZDnKmzm+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FtyQm1v4Sz2xb8
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Jun 2021 00:31:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3976461042;
 Mon, 31 May 2021 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622471485;
 bh=vOtIEAH/8MnqIBK3exH+T8JWCpnoQ7/hXA5Z+wsayH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZDnKmzm+Ei9CQ5L5lQSqAHj5aRA19ctW6C0xSgoevmWmq0GJtYlR6ul2/4YIH0IRf
 vzS2uR2RpL9sBnRywg9A7K2gbPcbjrfW5dMTFI7vlx0xoAGL6QVPJLJvyxofFzrafl
 BAueUw48sznzLB3QJF1gBVzlJqzyQ8GAlbjLapLROIYTFO87S/zeVybM8/h737ErI3
 u4ntJ/Z8yMaK/M4tYHzS6HhQRQksQ8QIMcwlYvvHYLvAUfDknFUkDZqHrFSJ52Ku5X
 qVdVKH1IuufBX2pZFldxAr4KLo1s9sDot7W235sTSiOOqjbo2CRR2ZeKZikfeNDQCp
 MwUOOqSx1pNZg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs-utils: README: big pcluster feature update
Date: Mon, 31 May 2021 22:31:16 +0800
Message-Id: <20210531143117.6327-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531143117.6327-1-xiang@kernel.org>
References: <20210531143117.6327-1-xiang@kernel.org>
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

Add some description for end users to know its usage.

Link: https://lore.kernel.org/r/20210522055057.25004-2-xiang@kernel.org
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 README | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/README b/README
index bcf30e11aa52..af9cdf11c78a 100644
--- a/README
+++ b/README
@@ -74,6 +74,24 @@ In addition, you could specify a higher compression level to get a
 (slightly) better compression ratio than the default level, e.g.
  $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
 
+How to generate EROFS big pcluster images (Linux 5.13+)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In order to get much better compression ratios (thus better sequential
+read performance for common storage devices), big pluster feature has
+been introduced since linux-5.13, which is not forward-compatible with
+old kernels.
+
+In details, -C is used to specify the maximum size of each big pcluster
+in bytes, e.g.
+ $ mkfs.erofs -zlz4hc -C65536 foo.erofs.img foo/
+
+So in that case, pcluster size can be 64KiB at most.
+
+Note that large pcluster size can cause bad random performance, so
+please evaluate carefully in advance. Or make your own per-(sub)file
+compression strategies according to file access patterns if needed.
+
 How to generate legacy EROFS images (Linux 4.19+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.20.1

