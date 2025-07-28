Return-Path: <linux-erofs+bounces-706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF7B132D0
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 03:50:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br1dG1b7bz30Lt;
	Mon, 28 Jul 2025 11:50:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753667410;
	cv=none; b=cKYK8+M8tX93Q9kjiTifZZlt/o5WifWeB9rBV5oy68qHXrWFTXx6LBYdunl9Kvqv9j/IK+EkHMqoCWfYzjF0XNWjTY0yMQqlkgu43h5/1+gvNLE4WYf8/oYhw91IfHAjfOjfwoKLtDDgKoE2z4qW+zSKD3/9SetiDMfXJRdvjOjaIeFBipxR9V/76IGC2pNIwzA107HEB4Yrlem+5GFlqWAQiI4tVwUn5buFufhaapZKguB87rIcz01yeeduk3OdmNz0t+QxqujP5O5dJR4q6q9NedWqjW/O+sMNwiDimSHhRvfsjrFIwCAT9rlxSwh3Uwzv86es9ErxzLJQCy8DAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753667410; c=relaxed/relaxed;
	bh=I4SgT10l9XAZGWUQALWBeUxuBgRbFqPNrqfhoSYHpmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOS3d2ww82P5Czn5dFM1KYExpRN9p7dG/QHMA2KBlA/cn+K2d7q9mABQEhTbs5vbJ6bY0xSSIW+nZd3TEoqr8xcBJj7tq1J4XDBHlvnIPkmN3R1ZbmNLKgx+bQj5t9thESLaJSQ3yGBqZ3VZp09wHnhULavFpKkcTyDLrde+F4H/bP7se2iTVGTl6xdmTbEg2i+vFo7dATOtTVpUaYOQZL2pr2nUNTIVMyAHP8YowTR3YcRueM8LMVMJV9TNqn2LB6vtUoNOFhFIOKK8DUfwCuJQnKzjtjXuZvY3PxF9rRQqkHPOJ1T6dx0PKh0ezzN5l4bi1ibj+H8qxbJ0WP0bkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=MNPCRPTi; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=MNPCRPTi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br1dD3lLlz307K
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 11:50:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1753667408; x=1785203408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4SgT10l9XAZGWUQALWBeUxuBgRbFqPNrqfhoSYHpmw=;
  b=MNPCRPTiQ51x0g1qj1qPrLivnSP7MFFQIRbiJESwRPz8Rawtkg8liiok
   WZBEpnT0Sn/6q+79KVdwr2/J8AnxpvJToaAeLCJmNrKOtoyRj++M8Ox3p
   iZKS0FGnm6VDgXRN9aWHUJ2vTdx0Nhzk28evu4NKSYjgKjXIINrLj/koy
   2h/0n1YddrUZzBF4VlBYoadYx9dCv+NBVefGcvZB31o5gWnHyXAdwAWIJ
   PutXHWes0mTHSTYt3Soax4IG3didBFOtu68rlK+Lp5ctceUBLPvBHs5Xw
   GpLS7PbhHq7oVIKGlPLeKsNKoB1QrI2W9plar/+redwZKP4RfzL+KmqIn
   A==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:50:01 +0900
X-IronPort-AV: E=Sophos;i="6.16,339,1744038000"; 
   d="scan'208";a="12639323"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 28 Jul 2025 10:50:01 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Jacky Cao <jacky.cao@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v1] erofs: Fallback to normal access if DAX is not supported on extra device
Date: Mon, 28 Jul 2025 09:49:21 +0800
Message-ID: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

If using multiple devices, we should check if the extra device support
DAX instead of checking the primary device when deciding if to use DAX
to access a file.

If an extra device does not support DAX we should fallback to normal
access otherwise the data on that device will be inaccessible.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Jacky Cao <jacky.cao@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 fs/erofs/super.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1020aa60771..ad1578bb0f7b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
+			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+						dif->path);
+				clear_opt(&sbi->opt, DAX_ALWAYS);
+			}
 		} else if (!S_ISREG(file_inode(file)->i_mode)) {
 			fput(file);
 			return -EINVAL;
@@ -210,8 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
 	}
-	if (!ondisk_extradevs)
+	if (!ondisk_extradevs) {
+		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
+			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 		return 0;
+	}
 
 	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
 		sbi->devs->flatdev = true;
@@ -671,14 +681,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return invalfc(fc, "cannot use fsoffset in fscache mode");
 	}
 
-	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		if (!sbi->dif0.dax_dev) {
-			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		} else if (sbi->blkszbits != PAGE_SHIFT) {
-			errorfc(fc, "unsupported blocksize for DAX");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		}
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && sbi->blkszbits != PAGE_SHIFT) {
+		errorfc(fc, "unsupported blocksize for DAX");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 
 	sb->s_time_gran = 1;
-- 
2.43.0


