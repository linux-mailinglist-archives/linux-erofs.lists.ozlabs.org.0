Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25D6A67E9
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 08:04:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRQGb0NsJz3c99
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 18:04:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SJQ1r2P/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SJQ1r2P/;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRQGT22mZz2xJ4
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 18:04:48 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11745150pjg.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 23:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677654285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7MP/ejAI3sruq8iFOBWkRKcy/cVwRiQeeMY1HpYcV4=;
        b=SJQ1r2P/WYtOeX7MwiIFp3r8lUoIY4iCZ4Kh8f/qVe3/AEb21nYPjUH4Hv18AlxL6o
         nVT66J/R/ENNcfrWJal9Qz4w0cc+bslDOrJZdbPYNnVSnTgdbZTaJK9WHrZXQyp5esb5
         5Yb5IfeL8mYmG7NirZaZnEAGLW3cOpU3SzqTbD2G1D2wcGOpHrMOGHukLzBrvcI2LfOK
         nyyyekRH4Vmof5eh3kwHztUg2NXk0tPlvHTc6LvetxHCdrpMGRsbCZszSca+yJa/vlTH
         m7gCcVmwIKNfkmga+j1x3I3yZL0OhUfNzvPCHP2joI67VeydZ+7WbSMdGDVFWXF8aWyA
         5x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677654285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7MP/ejAI3sruq8iFOBWkRKcy/cVwRiQeeMY1HpYcV4=;
        b=y7xyzB7YE0yeh2DrjLfuNxsyXxate9jq/2qtEUUoOlsvYf0O/F8lKyxG4KTQfL/xZI
         NmtK4fKhW6Hml0RPRrZF8BudDjV5HUwHJh94awR1uxCN7e1pdX7kgfY60Feg4ZKEKChJ
         TVvFEQFtEFMBg7zEfJUbput1QvkIM6ZWs9zzC/qKl9NX1jodjqHh34LYibbr8dyHYUKs
         9nacYdaVM8ggwjBLpcbs9+7DfdaG0QmpuWKPEYKmnS1xDnySls4Lc4s8WjtLJuRSGoA0
         dPgcxCuvJcNIlzgfUYH9H86Pqj4q79SCcAo/Qi9sGOIx+2++l0Cew84/ArMM3BGQ/jI9
         F89g==
X-Gm-Message-State: AO0yUKWdi233S58B5eVSCU25ZJ5vEWpBoK0UZ+UFf5YX/sI+qL0q2/IA
	1TRnbEcFWlHQ9nvtg9UEQRmB0w==
X-Google-Smtp-Source: AK7set+/jkVD/fqVCwDuBJSSHDh/BeXN+rwU+fD/gd7C3RkBNLPU9avj1wOQlqSbEwdnsqX5Ao/0Tg==
X-Received: by 2002:a05:6a20:4320:b0:cc:c557:9ce with SMTP id h32-20020a056a20432000b000ccc55709cemr7634102pzk.61.1677654285266;
        Tue, 28 Feb 2023 23:04:45 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 4-20020a630104000000b004f27761a9e7sm6701485pgb.12.2023.02.28.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:04:44 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: xiang@kernel.org,
	chao@kernel.org,
	gerry@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: support for mounting a single block device with multiple devices
Date: Wed,  1 Mar 2023 15:04:17 +0800
Message-Id: <20230301070417.13084-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to support mounting multi-layer container image as a block
device, add single block device with multiple devices feature for EROFS.

In this mode, all meta/data contents will be mapped into one block address.
User could directly mount the block device by EROFS.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/erofs/data.c  | 8 ++++++--
 fs/erofs/super.c | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..870b1f7fe1d4 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -195,9 +195,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
+	bool flatdev = !!sb->s_bdev;
 	int id;
 
-	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
@@ -210,12 +210,16 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return -ENODEV;
 		}
+		if (flatdev) {
+			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
+			map->m_deviceid = 0;
+		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
 		up_read(&devs->rwsem);
-	} else if (devs->extra_devices) {
+	} else if (devs->extra_devices && !flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
 			erofs_off_t startoff, length;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..4f9725b0950c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -226,6 +226,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct block_device *bdev;
+	bool flatdev = !!sb->s_bdev;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
@@ -248,6 +249,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
+	} else if (flatdev) {
+		dif->bdev = sb->s_bdev;
+		dif->dax_dev = EROFS_SB(sb)->dax_dev;
+		dif->dax_part_off = sbi->dax_part_off;
 	} else {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
-- 
2.20.1

