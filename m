Return-Path: <linux-erofs+bounces-750-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DEB19D85
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 10:21:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwTzp6r1Vz3069;
	Mon,  4 Aug 2025 18:21:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754295702;
	cv=none; b=CwotTGXKJSutdln0L9AnYAHrxch7uEybPU+XgNybCMihdoERXVdHGW5sAfWJh8prOQ3z/exrdoq5irxP+TA0tPyW1NMjp1KLYmnxqexNcPmX+kxxwidlruup2B9y6O3+jHVFasxgG7QaqMraLDR/cN6qEL0a/y+hMveZ7w+E4aIJWe27u6YW4b6ZNKeH8NHivq5ZMDKw401OqPz1wgNAkoZSweXBCeVQNHPlb4d+rV9VdF4McN0gFE0XTuwZ2KE9LZGFPHXGXCnQf6JoFa+IQmMtGFv/SwqX8PKgF4XS3LPQJA9UkqJ8a/QLfPLCxzyngQ4PagJAhBakRC24UrJjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754295702; c=relaxed/relaxed;
	bh=xWMc5gIVslD2m7qCcmSOv878Vhx9knGZUvOI9vbZvJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yxxd/tbq2MG+BygwF2cA7OnwHmJ1BmpEuTSOVL5VzHnTAB5zAcF3dOaXlF5DZpUXTfEcb2LDAgO7FuWVuEWbRJKro7/93tJlqpP8FJK1P7MCGharnP5jU/Uz7i2CdB1ftJyeNuc0WWpXLoAxUwyYyl7qxSyZYAxyzXruvrpQ/Rhsf0TdFUdrR11LigxisfedTQayYiX6BQQ+SVYpHzM4/ehqP6h9lBsHQQe5v0zWOOxMYaQnk9ewsYiFwwpnqitxcgM1fwKTHXDAyTo16Z1CsV6JEkEX4FItOAUs2LJZgFU/p1a7pFkp5FV6n9zkBDjxYXH0847eQcKXTx2FjYORyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=xWaNusGp; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=xWaNusGp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwTzn6VFsz2yPS
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 18:21:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1754295702; x=1785831702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xWMc5gIVslD2m7qCcmSOv878Vhx9knGZUvOI9vbZvJ4=;
  b=xWaNusGpLs2q6KriBVA9l/CR4/z9F5RwMkI7h1lCkQtxBRiHF4f1cAnp
   9Tnx8j8jaWymRGZyBOz+bBPo7rf6ERxvTR6UqnASv/nFC54Cr8vZ+trUv
   pZhqbAEXXDIdmMZGLhBeLWxcDVbmZYoGXyCao5939ILHKjwjx6LhhGnqb
   c5aiu+Gu/9Qi/fE9NOuh3bCFG6BCX4I9v2KHICFhFJ9/JN54BfX/8h09U
   O22WNOWCvCoHmJz1df/p3KOLRKO5BnoSuQmkw1rS2ft0UUKMVTGDHSfNq
   /3ho+c92FbKgOINe73+Y3SVLizMUGO+9pP3i9YnclVV+zVhAO5EtDf29Y
   w==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:21:33 +0900
X-IronPort-AV: E=Sophos;i="6.17,258,1747666800"; 
   d="scan'208";a="13948604"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 04 Aug 2025 17:21:32 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Jacky Cao <jacky.cao@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v3] erofs: Fallback to normal access if DAX is not supported on extra device
Date: Mon,  4 Aug 2025 16:20:31 +0800
Message-ID: <20250804082030.3667257-2-Yuezhang.Mo@sony.com>
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

Changes of v3:
  - uniformly use erofs_info() to output the logs of turning off DAX

Changes of v2:
  - fix the indentation alignment of `dif->path`
  - remove the unnecessary comment

 fs/erofs/super.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1020aa60771..8c7a5985b4ee 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
+			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+					   dif->path);
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
@@ -338,7 +348,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (ret < 0)
 		goto out;
 
-	/* handle multiple devices */
 	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_sb_has_48bit(sbi))
@@ -671,14 +680,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
+		erofs_info(sb, "unsupported blocksize for DAX");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 
 	sb->s_time_gran = 1;
-- 
2.43.0


