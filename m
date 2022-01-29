Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D914A2C97
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 08:46:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm5wq3yW5z3bP4
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 18:46:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Qla4K757;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Qla4K757; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm5wj3Km6z2xtv
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 18:45:57 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 817EFB80D6D
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 07:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D67EC340E5;
 Sat, 29 Jan 2022 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643442348;
 bh=vzvpheEOKlPOO+8Tcft/IAvxzQLzptsphQCoLxpY7Lk=;
 h=From:To:Cc:Subject:Date:From;
 b=Qla4K757PSRbN0L75t+6FcKdHSVPhVhHPzr+bhlqfSrLlYKmxHuSWqvVB7tdx2EOD
 UvwnVO4vl0+3Lgdjih4UXdf2pHllGs1WyWI97QXm6NBAeGXkxS5KfA41R/Kej1/rqp
 h/xnTh9fmV8hK4xAgYhN4cKZZ1KLFVVV40+iyMhRTUIcpjLpXEWQpe0hOdVVE38x0N
 zoryZPSFAuFHd1kQ13l9+1cHdI0eB6oJl/kSFFC1hXVffKGlFtv/b5fjfLCGtJPE7d
 ndqDWLGZl8TNF9SyCbyOEAVnYaZ5lG+MlcYQaMaca2xKtHN4NhtLAfyuMKIBqysGWn
 0s9v6bL0pGxUw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: check extract_path in
 erofsfsck_set_attributes()
Date: Sat, 29 Jan 2022 15:45:40 +0800
Message-Id: <20220129074540.5501-1-xiang@kernel.org>
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

Just cleanup.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fsck/main.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index a906ee85cf7a..42f7751be1ee 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -219,15 +219,17 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 {
 	int ret;
 
-#ifdef HAVE_UTIMENSAT
-	const struct timespec times[2] = {
-		[0] = { .tv_sec = inode->i_ctime,
-			.tv_nsec = inode->i_ctime_nsec },
-		[1] = { .tv_sec = inode->i_ctime,
-			.tv_nsec = inode->i_ctime_nsec },
-	};
+	/* don't apply attributes when fsck is used without extraction */
+	if (!fsckcfg.extract_path)
+		return;
 
-	if (utimensat(AT_FDCWD, path, times, AT_SYMLINK_NOFOLLOW) < 0)
+#ifdef HAVE_UTIMENSAT
+	if (utimensat(AT_FDCWD, path, (struct timespec []) {
+				[0] = { .tv_sec = inode->i_ctime,
+					.tv_nsec = inode->i_ctime_nsec },
+				[1] = { .tv_sec = inode->i_ctime,
+					.tv_nsec = inode->i_ctime_nsec },
+			}, AT_SYMLINK_NOFOLLOW) < 0)
 #else
 	if (utime(path, &((struct utimbuf){.actime = inode->i_ctime,
 					   .modtime = inode->i_ctime})) < 0)
@@ -711,7 +713,7 @@ verify:
 		ret = erofs_iterate_dir(&ctx, true);
 	}
 
-	if (!ret && fsckcfg.extract_path)
+	if (!ret)
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
 out:
-- 
2.20.1

