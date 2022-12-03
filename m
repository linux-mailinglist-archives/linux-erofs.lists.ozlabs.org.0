Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796164156D
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Dec 2022 10:49:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NPQ4m1jDcz3bbX
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Dec 2022 20:49:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1670060952;
	bh=cQEt/QlRk75VA1tfV8jav2K0Kc/PE5eF3mJoLOKRQ5o=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=eRJ22H8nl3cd+weKTj86a0xTVy8ebtlPvmuz7Aebq88T/rCFeQa2ImQM1ikJpfUHW
	 8JbqZTW+3v5JbrmcW+VkOBPMm+/vFSZOdfvxKCDTS0PYjLfsrzASooBJxYvj8n2NUf
	 iCPQtfagBu5+6EV8cBlDLtyqwu8ad6kykGrp/1tErDFH8voKVHRnKYBQ9YnFVjwoTR
	 zr2SrKa1iyR0rjX80dNJUFW2zR9MVP46Y1MgeBBOGzFUPh3IBsfaRrBkMBgOjG6Ie4
	 EETgL+uNXs5UjUQd7F7StvbPwSu4OdbZM0/XV1jrYzGrv5zchNsTyLVUoxZsoPVs95
	 Ipak1va+vDeGg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=chenzhongjin@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NPQ4c712Mz3bSm
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Dec 2022 20:49:01 +1100 (AEDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NPQ304YqhzmVxm;
	Sat,  3 Dec 2022 17:47:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 17:48:25 +0800
To: <syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] erofs: Fix pcluster become inline when m_pa is zero
Date: Sat, 3 Dec 2022 17:45:27 +0800
Message-ID: <20221203094527.129869-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
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
From: Chen Zhongjin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chen Zhongjin <chenzhongjin@huawei.com>
Cc: chenzhongjin@huawei.com, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzkaller reported a memleak:
https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed

unreferenced object 0xffff88811009c7f8 (size 136):
  ...
  backtrace:
    [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
    [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
    [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
    ...

syzkaller constructed a case: in z_erofs_register_pcluster(),
ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index
become zero although pcl is not an inline pcluster.

Then following path adds refcount for grp, but the it won't be put
because pcl is inline, which makes pcl not released when shrink.

z_erofs_readahead()
  z_erofs_do_read_page() # for another page
    z_erofs_collector_begin()
      erofs_find_workgroup()
        erofs_workgroup_get()

To fix this, add an attribute in z_erofs_pcluster to mark the inline
state which not depends on index of grp.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/erofs/zdata.c | 2 +-
 fs/erofs/zdata.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b792d424d774..fef2624d19e3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -517,7 +517,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
 	if (ztailpacking) {
-		pcl->obj.index = 0;	/* which indicates ztailpacking */
+		pcl->is_inline = true;  /* which indicates ztailpacking */
 		pcl->pageofs_in = erofs_blkoff(map->m_pa);
 		pcl->tailpacking_size = map->m_plen;
 	} else {
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c95212985..35051ad27521 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -78,6 +78,9 @@ struct z_erofs_pcluster {
 		unsigned short tailpacking_size;
 	};
 
+	/* I:  whether it is inline or not */
+	bool is_inline;
+
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
@@ -115,7 +118,7 @@ struct z_erofs_decompressqueue {
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
 {
-	return !pcl->obj.index;
+	return pcl->is_inline;
 }
 
 static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
-- 
2.17.1

