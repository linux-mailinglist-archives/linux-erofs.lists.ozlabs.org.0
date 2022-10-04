Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7C5F45E7
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 16:50:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhgcJ10CXz2xgN
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 01:50:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=leFOk6Ki;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.16; helo=m12-16.163.com; envelope-from=zbestahu@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=leFOk6Ki;
	dkim-atps=neutral
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhgc672Rlz2xGv
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 01:50:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FiGiW
	uqNMxRYmMEJen9U4DdoTiKrvBlJbml9qjjwVXc=; b=leFOk6Ki2fQv6j7ISe0yI
	RzwUAPTjLxp6gYyKMfLcIWHVQiQGCN+3AhbtoyKJjr5acde9vRPTKNEpdJ91Ta+6
	Kz5maqXSM1cfcivBUqIKn780FA8hXGOwtqbEFKjVLC+A1X9Lp23Hyt5J6DvGSWBB
	/4q7GR4b44cI8YzFhUUVO4=
Received: from localhost.localdomain (unknown [112.22.168.89])
	by smtp12 (Coremail) with SMTP id EMCowACno3UQSDxjXwxPBw--.264S2;
	Tue, 04 Oct 2022 22:49:58 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix the unmapped access in z_erofs_fill_inode_lazy()
Date: Tue,  4 Oct 2022 22:49:51 +0800
Message-Id: <20221004144951.31075-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACno3UQSDxjXwxPBw--.264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyfGFyxZF4rtw4rtw4rGrg_yoW8tw47pF
	42krWSyryrJrn7ZrWI9F18Xry3Kay8Jw4DGw13G34rZ3Z0g3ZagFy8tF9xJF45GrWrZr4F
	qF1jva4rurWxG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3OzsUUUUU=
X-Originating-IP: [112.22.168.89]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBoRaQEWI0VBeiqAAAsp
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
after calling erofs_put_metabuf(), that is not correct. Fix it.

Fixes: ab92184ff8f1 ("add on-disk compressed tail-packing inline support")
Fixes: b15b2e307c3a ("support on-disk compressed fragments data")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 44c27ef39c43..1a15bbf18ba3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -58,7 +58,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
-				   EROFS_KMAP_ATOMIC);
+				   EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out_unlock;
@@ -73,7 +73,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
 		vi->z_tailextent_headlcn = 0;
-		goto unmap_done;
+		goto init_done;
 	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
@@ -105,10 +105,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto unmap_done;
 	}
-unmap_done:
-	erofs_put_metabuf(&buf);
-	if (err)
-		goto out_unlock;
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
 		struct erofs_map_blocks map = {
@@ -127,7 +123,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			err = -EFSCORRUPTED;
 		}
 		if (err < 0)
-			goto out_unlock;
+			goto unmap_done;
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
@@ -141,11 +137,14 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 		if (err < 0)
-			goto out_unlock;
+			goto unmap_done;
 	}
+init_done:
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+unmap_done:
+	erofs_put_metabuf(&buf);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
-- 
2.25.1

