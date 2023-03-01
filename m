Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E26A6CAB
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 13:59:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRZ8356gNz3cJF
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 23:59:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lPIG3G15;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lPIG3G15;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRZ7w1YmYz3c81
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 23:59:38 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so12938054pjz.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Mar 2023 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677675574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XAn/70U2KKRnEeCtQ5XFnUlbnR3a/3Bch3Z2vbvSlig=;
        b=lPIG3G15MyTokv80LD68UclxPWFU/RcxnOm8xkfQ6aMTLSfEoxxlhxD1RVcj7ep//a
         CaePRL0ex8iU05sLdiFCH8lugVTXmID9zMyocGEZAaNPclJui3aVOtl9s95TdVzb9czj
         7R4FhxLvdrdiN5OFFxX+hn1hDiC/KntBUsYYey9VY2xbJZ8oA5s5jzXAyCQfQ/tufGLC
         l+u8PBOevZU8DZouyF1FNu6iH4qqZhsrfzW0Qd86h+F4PfRIJiSVv8l9MqXgAv7TKRmS
         wa8CUoO+9GOl9mcIX6wc7umm8FitwjLj166Hwgou63GjNqD9Ei6635pB4+/Kooh/Mk0q
         7HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677675574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAn/70U2KKRnEeCtQ5XFnUlbnR3a/3Bch3Z2vbvSlig=;
        b=WafaE7tlwpvqdGRBMHZrqgItpN0LxB3m7sqnFoCb0Qzgh1tTHkin0nu0kNLwdTDHcw
         pYyFkvyOdH618B94iup9BntjpsM1wBrKLZzvBNo8GfvkHJAUlxZnFA+bUBLui/df9aWX
         JFFvzGF9KnhxBnhMUnIKdCcNtEmQL1bcbnTB8iXNt2jTxSIMry/m+o4u6pyedjw94lPg
         sr9QeH2lcZ8JiH0RmEECxljJvhv1zu66ZhIPKsEXs//K+QYtmx+TgmKK9+U8U3zSQstb
         cHeR8Ue1MiBt9/dnIeurO7zf3IIfeUJAEp43DWSiZ/twODRiMzudegOIzQqXKEjvDEPi
         8rWQ==
X-Gm-Message-State: AO0yUKUWQcVmhuvkglkzXW+DU2zYMrFhTBgBfH5rCbdHKw1hY8dwFnf+
	gPg9sNaJAydzVXrVLmM8w8qwmQ==
X-Google-Smtp-Source: AK7set9ehn75y2XWNkPUpVRaBxTeSU/AIruLsrp991MJbOjiINawskgybpuVPxfn4XXVCiOAFPDYkw==
X-Received: by 2002:a17:902:a606:b0:19c:fa22:e984 with SMTP id u6-20020a170902a60600b0019cfa22e984mr5250803plq.48.1677675574111;
        Wed, 01 Mar 2023 04:59:34 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027d8900b0019e30e3068bsm3374458plm.168.2023.03.01.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:59:33 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: xiang@kernel.org,
	chao@kernel.org,
	gerry@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH V2] erofs: support flattened block device for multi-blob images
Date: Wed,  1 Mar 2023 20:59:08 +0800
Message-Id: <20230301125908.30879-1-zhujia.zj@bytedance.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to support mounting multi-blobs container image as a single
block device, add flattened block device feature for EROFS.

In this mode, all meta/data contents will be mapped into one block
address. User could compose a block device(by nbd/ublk/virtio-blk/
vhost-user-blk) from multiple sources and mount the block device by
EROFS directly. It can reduce the number of block devices used, and
it's also benefits in both VM file passthrough and distributed storage
scenarios.

You can test this using the method mentioned by:
https://github.com/dragonflyoss/image-service/pull/1111
1. Compose a (nbd)block device from multi-blobs.
2. Mount EROFS on mntdir/.
3. Compare the md5sum between source dir and mntdir/.

Later, we could also use it to refer original tar blobs.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2:
1. Supplement commit message.
2. Add a bool field in erofs_dev_context to indicate flattened block
   device mode.
---
 fs/erofs/data.c     | 8 ++++++--
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 6 +++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..818f78ce648c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	struct erofs_device_info *dif;
 	int id;
 
-	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
@@ -210,12 +209,17 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return -ENODEV;
 		}
+		if (devs->flatdev) {
+			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
+			up_read(&devs->rwsem);
+			return 0;
+		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
 		up_read(&devs->rwsem);
-	} else if (devs->extra_devices) {
+	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
 			erofs_off_t startoff, length;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3f3561d37d1b..4fee380a98d9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -81,6 +81,7 @@ struct erofs_dev_context {
 	struct rw_semaphore rwsem;
 
 	unsigned int extra_devices;
+	bool flatdev;
 };
 
 struct erofs_fs_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..307b3d2392cf 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-	} else {
+	} else if (!sbi->devs->flatdev) {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
 		if (IS_ERR(bdev))
@@ -281,6 +281,10 @@ static int erofs_scan_devices(struct super_block *sb,
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
 
+	if (!sbi->devs->extra_devices && ondisk_extradevs &&
+		!erofs_is_fscache_mode(sb))
+		sbi->devs->flatdev = true;
+
 	if (sbi->devs->extra_devices &&
 	    ondisk_extradevs != sbi->devs->extra_devices) {
 		erofs_err(sb, "extra devices don't match (ondisk %u, given %u)",
-- 
2.20.1

