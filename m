Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA954790C
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 07:51:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LLP2S44Tpz3c7d
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 15:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TBg5snra;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TBg5snra;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LLP2M0DVNz3bmC
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jun 2022 15:51:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 064FE60A5A
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jun 2022 05:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50601C34115;
	Sun, 12 Jun 2022 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655013063;
	bh=8+sod72HDlOHSAJmswMpz5FXRyP0+ab0fVRFKd970c8=;
	h=From:To:Cc:Subject:Date:From;
	b=TBg5snraGCpAExvsObAiZGqsHwFFjfV6ggChvB2/5llF5MzFzKUTiP2C8NKLmvo2N
	 aDPdzO3N4WM2DCGBdQepiIKUOmfem/i3xm/6Hqtpe/m6//J6g1mE6upZQJvhuIMsQl
	 MwqvPG/ldSzAM1QUMYEd8RF6j/59GUp0WUzscKero07yHwvEO3h6tTJl9FezMj0jTq
	 lMqWoZSZcBeLmrrE6WsVDUV17VCBhcILw97q+lblpdAFCgwRJdnPtw7M5v+Y7ZM8Fs
	 OcK5GSVi7ByuEbJIOqnjF1OIfxxwcJs4rBxCDFccYeIlP8bNvp7UA5FjxINXQr6gpi
	 2Q7E/VQb73Xmw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: manpage: add missing -Eztailpacking option
Date: Sun, 12 Jun 2022 13:50:10 +0800
Message-Id: <20220612055010.485042-1-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Complete the manpage for ztailpacking feature and
clean up the whole subsection.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/mkfs.erofs.1 | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 6017760..59cb44d 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -42,24 +42,28 @@ and may take an argument using the equals ('=') sign.
 The following extended options are supported:
 .RS 1.2i
 .TP
-.BI legacy-compress
-Disable "decompression in-place" and "compacted indexes" support, which is used
-when generating EROFS images for kernel version < 5.3.
-.TP
 .BI force-inode-compact
 Forcely generate compact inodes (32-byte inodes) to output.
 .TP
 .BI force-inode-extended
 Forcely generate extended inodes (64-byte inodes) to output.
 .TP
-.BI noinline_data
-Don't inline regular files for FSDAX support (Linux v5.15+).
-.TP
 .BI force-inode-blockmap
 Forcely generate inode chunk format in 4-byte block address array.
 .TP
 .BI force-chunk-indexes
 Forcely generate inode chunk format in 8-byte chunk indexes (with device id).
+.TP
+.BI legacy-compress
+Drop "inplace decompression" and "compacted indexes" support, which is used
+to generate compatible EROFS images for Linux v4.19 - 5.3.
+.TP
+.BI noinline_data
+Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
+.TP
+.BI ztailpacking
+Pack the tail part (pcluster) of compressed files into its metadata to save
+more space and the tail part I/O. (Linux v5.17+)
 .RE
 .TP
 .BI "\-T " #
-- 
2.30.2

