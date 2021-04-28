Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57136D109
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Apr 2021 06:04:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVQ3z2DdLz2yjK
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Apr 2021 14:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WtXAYBZd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WtXAYBZd; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVQ3w3JKvz2yx9
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Apr 2021 14:03:55 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75265613F9;
 Wed, 28 Apr 2021 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619582634;
 bh=Hiptm4aYTdiQEZXis1/XdouCn7EVs1t6ziX6CDTNHrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WtXAYBZdTOSCtf2Dr/l2yFplc4k3g5htGWw0yvVdXdDrCv93QjjTAW0E/AEKDJ6JH
 mJirU6v1bnxMyKiald6gjzm+NolJWMUzZbmWyKn1p6+wCpwfb+vsmxoSg1Tmugj2QV
 BmQ+L8Y+9yu6OIguKZCVgptHMYRWrVMJgjEA2WrZBbu7IyQFKArITDFP2Hc4BfePrJ
 wZN0ZVsklHhTcUjlqkpiTMmQRjjnEA4d4MQiM7qvVZAIfc1dMKNcR4y7dmWfppc3n5
 Xo/nur5DV0hM7ptefP6/2bd6hlBGu6IsV9RRdH9R8s3JnVCjOu/GxzV302xicglfhs
 Eu89PF496QzRA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v3 3/5] erofs-utils: manpage: add missing -C option for big
 pcluster
Date: Wed, 28 Apr 2021 12:03:43 +0800
Message-Id: <20210428040345.4047-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428040345.4047-1-xiang@kernel.org>
References: <20210428040345.4047-1-xiang@kernel.org>
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
index 2520b6a08974..4f2e43565799 100644
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
 Specify the level of debugging messages. The default is 2, which shows basic
 warning messages.
-- 
2.20.1

