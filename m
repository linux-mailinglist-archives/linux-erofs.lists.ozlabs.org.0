Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265476A7BBA
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 08:18:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PS2WZ6fG8z3cMN
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 18:18:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SI9qPKQI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SI9qPKQI;
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PS2WV1H6gz3bvZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Mar 2023 18:18:12 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id a2so6192297plm.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Mar 2023 23:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677741489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOEf7Xpb5mkHbizoh2yjcukV0fYIhk+yPMhArKvHWnk=;
        b=SI9qPKQILSUegSga9aDKDbESKV9QZgBmwdMURAH+J2GKA6miCPfU6DYdzqFMBWhjHf
         zvepFO+Q+xMrauermsFGfMkmtL/3oMenp0t5HG9PKS8XWOEux9iG83xqWqGmL50k/n9s
         5uKQ811tk6a+oTdG4X+nDcghxaEMfxY8YyJ4yV/1ShROkRohEXUqzbTAobTgXji3+QXx
         BB+pxlVQux58clo1ixnLbkE+NyUpJ3Xy7CPzeETzfa2f31tsLEnUVJXeG8N2igOjF0Yg
         pGP9P0wzV9k5gey+7HMMOUSdXVRA6CFY55ppRWxouMmg5hKiiTlHvRw2qDNXWzuIUGzR
         Tvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677741489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOEf7Xpb5mkHbizoh2yjcukV0fYIhk+yPMhArKvHWnk=;
        b=zbjn/xa0o0ovqjsRzjBm86U7Pe3ZFkVvbU2sMQK9l4ZA0MGZkmjCNdf1bHg6D7510T
         7H8GYuT+mzNnNqNxMzpqfJcUKuk+ChgFyMMPvZOVEV/yxuh1OxiYvzarQSHT+Q52lgHs
         k32SPObaglUJkuatcPd39zBiFVnwbjA+13nAIi8QmRth3QzFaSIyUUj7SJVog4gFiOst
         wah08YefKfl7pA7Z4dmLoA4Ezwymf7aYvDgyg+KNN77koYuYLvA2IHgVlFREbdh0B3MH
         H2MO8XieOfhZiiFWafhy4UXzag8zTKX9QqdPOfA70MAuelngF1Azh/sOZzzr0+erlGeH
         kzIA==
X-Gm-Message-State: AO0yUKWPpZBJIo2151gWKShR++Je1gYZhvy9MSGybNPj+j1lrrJzswPj
	g5BSJob9n1QiMYNbFd55/flG+w==
X-Google-Smtp-Source: AK7set+3fzNkZU+X9dxOT7UWt5ecBglYgwBmfTTzoARuALfR2zWAvXYO1qXMoiCTm0BC1/Ptiz0CPQ==
X-Received: by 2002:a05:6a20:a829:b0:cb:a64b:71d3 with SMTP id cb41-20020a056a20a82900b000cba64b71d3mr8003611pzb.26.1677741489032;
        Wed, 01 Mar 2023 23:18:09 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id m19-20020a637d53000000b0050300e81eb9sm8611097pgn.54.2023.03.01.23.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:18:08 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: xiang@kernel.org,
	chao@kernel.org,
	gerry@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V3] erofs: support flattened block device for multi-blob images
Date: Thu,  2 Mar 2023 15:17:51 +0800
Message-Id: <20230302071751.48425-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
References: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3:
1. Move the flatdev check down after all sanity checks.(Jingbo Xu)
2. Add Reviewed-by tag.
---
 fs/erofs/data.c     | 8 ++++++--
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

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
index 19b1ae79cec4..0afdfce372b3 100644
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
@@ -290,6 +290,9 @@ static int erofs_scan_devices(struct super_block *sb,
 	if (!ondisk_extradevs)
 		return 0;
 
+	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
+		sbi->devs->flatdev = true;
+
 	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	down_read(&sbi->devs->rwsem);
-- 
2.20.1

