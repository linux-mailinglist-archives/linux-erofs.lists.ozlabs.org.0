Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA97EAAC3
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 08:07:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STy6d4y8Zz3c4s
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 18:07:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.7; helo=out199-7.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STy6R3XhNz2yG9
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 18:07:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwOdhoI_1699945624;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VwOdhoI_1699945624)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 15:07:05 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in fscache mode
Date: Tue, 14 Nov 2023 15:07:04 +0800
Message-Id: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
in fscache mode.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 RIP: 0010:erofs_map_dev+0xbd/0x1c0
 Call Trace:
  <TASK>
  erofs_fscache_data_read_slice+0xa7/0x340
  erofs_fscache_data_read+0x11/0x30
  erofs_fscache_readahead+0xd9/0x100
  read_pages+0x47/0x1f0
  page_cache_ra_order+0x1e5/0x270
  filemap_get_pages+0xf2/0x5f0
  filemap_read+0xb8/0x2e0
  vfs_read+0x18d/0x2b0
  ksys_read+0x53/0xd0
  do_syscall_64+0x42/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 029c761670bf..c98aeda8abb2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_handle->bdev;
+		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -238,7 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_handle->bdev;
+				map->m_bdev = dif->bdev_handle ?
+					      dif->bdev_handle->bdev : NULL;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
-- 
2.19.1.6.gb485710b

