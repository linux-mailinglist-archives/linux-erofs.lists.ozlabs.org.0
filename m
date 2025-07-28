Return-Path: <linux-erofs+bounces-709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E83B133D4
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 06:55:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br5km44lYz307K;
	Mon, 28 Jul 2025 14:55:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753678512;
	cv=none; b=b0qg7pLIMBD0KrkutFGDzy7h3Wt0hVhFayby88aZKMT11ENchC1HvSLCsDwmDoRVIG/8UpIkbfU9wA3LXdyKhi8DZvpU01jJUMugpf36Jntl3DGExB+2BBhaZ6hbnmeTHUTiOtVCi9pz+pszTfibzfpMqOSSCxhQFiWyinxQX8BperYOTqbb0Tf1ZoOKycWhyCEfX02O+DHmb5CxajZZK2QUGdGrFFu99qTOahWrRI+B9BqB4FQG2rQVhDq99jnEipfshltHgIa6+e2msWVTXTaDWVC3pHnFoABmXhsyhaykJ8DDEvmJlUFfk6a/BwxU8LFoLycGoLnIiBb4F2KsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753678512; c=relaxed/relaxed;
	bh=bvw944BlOI34LSqEDKAeWp4zPErfAa0jlpdJm8SqtYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtU7HPTmdxTT/o6+2cdYpf1JoFeNG7HZaVPu76OCtx92tuOwMIgw6E9lfft45PDsdAMd9XdokgS5TY/lEronoAXxtwZVAMEcj+flvcgcrPwLGFhX7NRoNzq/mWpS1ct6NOb94na1G64mzbaV1c+y1EVzpq1Qe3QFrJM376ev6XGV3P5arp1vWDrdWDI8F7yEKMZ1EhP1cOoeC3JKR6JI9gLeXvy4x+uKyZ0e/lvhkCTGW0FTtD3MO8/LlHp5ZwLlZPsje4peLotK/g9hlwDLI3lQT4MGIflLYYla3zEAkQCWh0wOC7X+nd+1OKvOsdCKzSDMlmlr6sW8ikAYBcqS3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=CiUd9ZOu; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=CiUd9ZOu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br5kk6BRmz2xRq
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 14:55:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1753678511; x=1785214511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bvw944BlOI34LSqEDKAeWp4zPErfAa0jlpdJm8SqtYI=;
  b=CiUd9ZOuYaZ9xF2xKDvRMvcOuCZAegIWn8K6Rc5BJUMoQOvX2eavI7vb
   4CbBA0YpDye8pvF/IZQGtT/W0tqxOl8PFYXIKVw2EIpGBSu1hCR+ThDHm
   p3h9K8efsMY2Ewv+IklSZQX8grfzXJt+/5ZbEclJdcZJ8ODL2r279/eX1
   JniFgEL1KPfoSB/sw+22/hu32mThwAEYyIKRldf2ZScB/1S7RttVJ+vh3
   L6k4gE/lRgns6dWGdoDHa5Xr1UtlttCVm0m8BH+Y8JzpA+FfPas9/Ij1Z
   2isoLPIrKx1EZ3Dg7k+MtjEwnyNLXgo/qxeASompZLjiM2CvK1D1x8PLq
   g==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 13:55:03 +0900
X-IronPort-AV: E=Sophos;i="6.16,339,1744038000"; 
   d="scan'208";a="12701992"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 28 Jul 2025 13:55:02 +0900
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
Subject: [PATCH v2] erofs: Fallback to normal access if DAX is not supported on extra device
Date: Mon, 28 Jul 2025 12:54:10 +0800
Message-ID: <20250728045409.1678099-2-Yuezhang.Mo@sony.com>
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
 fs/erofs/super.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1020aa60771..b08016bf9d1e 100644
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
+		errorfc(fc, "unsupported blocksize for DAX");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 
 	sb->s_time_gran = 1;
-- 
2.43.0


