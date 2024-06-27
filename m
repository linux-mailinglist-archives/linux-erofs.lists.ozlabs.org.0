Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBA91A24C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 11:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719479447;
	bh=0OttcRHJP5dyZvcWKtFHqqgYJNDS1+x3U8B+EssAKtU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Am0PO6gSb7K67x9ti87BpbW+QSI5tPkfv0PlLzlyD2AIELaNXjjfF4x6Thzb2fI0X
	 RD1gXnXVEOs3hjvvH9uM03pu95mEI75KOcUz1lfH63D6aQIzWTaJAVRrO5bq6lIh5T
	 0+0P8YqUW4gYUNUd5uqu+MR06Ha2mppbzggXU8ErEHanwYz8nOoozeJlvujUA9AOj5
	 mOp6/8WzZ3cuwdEs5K5+XQrRcU3CMdAFguzFS4oP3Sb5Z26ZbDy3MuQuQGyuix2DZy
	 XbnHH2NM5Dpo5IUBD19DF3+PtNj1kLyvHXF6JJEKCJyms+Ve15vy64/TqoSJFHTZw9
	 OJSlRAN+Z3fvg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8t8R4Wrmz3cbF
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 19:10:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8t8G4QRfz3cZ6
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 19:10:33 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W8t3r0mwLzMrLw;
	Thu, 27 Jun 2024 17:06:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FBE914037E;
	Thu, 27 Jun 2024 17:10:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 17:10:29 +0800
To: <gregkh@linuxfoundation.org>
Subject: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in fscache mode
Date: Thu, 27 Jun 2024 17:13:45 +0800
Message-ID: <20240627091345.3569167-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20231114070704.23398-1-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
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
2.34.1

