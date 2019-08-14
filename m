Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C738CA0F
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 06:08:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467bg04XtXzDqZb
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 14:08:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467bfs5gP3zDqXl
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 14:08:36 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 454CF1D7FAA01BD20600;
 Wed, 14 Aug 2019 12:08:28 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 12:08:18 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 2/2] staging: erofs: differentiate unsupported on-disk format
Date: Wed, 14 Aug 2019 12:25:25 +0800
Message-ID: <20190814042525.4925-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190814042525.4925-1-gaoxiang25@huawei.com>
References: <20190814042525.4925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For some specific fields, use ENOTSUPP instead of EIO
for values which look sane but aren't supported right now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c | 4 ++--
 drivers/staging/erofs/zmap.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 461fd4213ce7..1088cd154efa 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -24,7 +24,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported data mapping %u of nid %llu",
 		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 
 	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
@@ -95,7 +95,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported on-disk inode version %u of nid %llu",
 		      __inode_version(advise), vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 
 	if (!nblks)
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 16b3625604f4..f955d0752792 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -178,7 +178,7 @@ static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		break;
 	default:
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 	m->type = type;
 	return 0;
@@ -362,7 +362,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 		errln("unknown type %u at lcn %lu of nid %llu",
 		      m->type, lcn, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -ENOTSUPP;
 	}
 	return 0;
 }
@@ -436,7 +436,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	default:
 		errln("unknown type %u at offset %llu of nid %llu",
 		      m.type, ofs, vi->nid);
-		err = -EIO;
+		err = -ENOTSUPP;
 		goto unmap_out;
 	}
 
-- 
2.17.2

