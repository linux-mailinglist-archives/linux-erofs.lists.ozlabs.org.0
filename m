Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066574E7324
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 13:23:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQ1TC68gMz3bVP
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 23:23:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQ1T860Pmz30hh
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Mar 2022 23:23:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V89rBrD_1648210975; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V89rBrD_1648210975) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 25 Mar 2022 20:22:55 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 20/22] erofs: implement fscache-based data read for data
 blobs
Date: Fri, 25 Mar 2022 20:22:21 +0800
Message-Id: <20220325122223.102958-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implements the data plane of reading data from data blob file over
fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     |  3 +++
 fs/erofs/fscache.c  | 15 +++++++++++++--
 fs/erofs/internal.h |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b4571bea93d5..b9a05de3c3b2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -206,6 +206,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
+	map->m_fscache = EROFS_SB(sb)->bootstrap;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -217,6 +218,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
+		map->m_fscache = dif->blob;
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices) {
 		down_read(&devs->rwsem);
@@ -234,6 +236,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 				map->m_bdev = dif->bdev;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
+				map->m_fscache = dif->blob;
 				break;
 			}
 		}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d75958470645..cbb39657615e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -63,9 +63,20 @@ static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
 static inline int erofs_fscache_get_map(struct erofs_map_blocks *map,
 					struct super_block *sb)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_map_dev mdev;
+	int ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map->m_deviceid,
+		.m_pa = map->m_pa,
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		return ret;
 
-	map->m_fscache	= sbi->bootstrap;
+	map->m_fscache	= mdev.m_fscache;
+	map->m_pa	= mdev.m_pa;
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 94a118caf580..cea08f12a2c3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -487,6 +487,7 @@ struct erofs_map_dev {
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
 	u64 m_dax_part_off;
+	struct erofs_fscache *m_fscache;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.27.0

