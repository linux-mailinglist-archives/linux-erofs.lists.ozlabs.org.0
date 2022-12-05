Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F4642AE5
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 16:01:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NQmvp4YYvz3bcN
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 02:01:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.7; helo=out30-7.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NQmvg4V6Zz3bY0
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 02:01:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWWWV0Z_1670252457;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWWWV0Z_1670252457)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 23:00:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] erofs: validate the extent length for uncompressed pclusters
Date: Mon,  5 Dec 2022 23:00:50 +0800
Message-Id: <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzkaller reported a KASAN use-after-free:
https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2

The referenced fuzzed image actually has two issues:
 - m_pa == 0 as a non-inlined pcluster;
 - The logical length is longer than its physical length.

The first issue has already been addressed.  This patch addresses
the second issue by checking the extent length validity.

Reported-by: syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 98eff1259de4..0150570c33aa 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -698,6 +698,11 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+		if (map->m_llen > map->m_plen) {
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 			map->m_algorithmformat =
 				Z_EROFS_COMPRESSION_INTERLACED;
-- 
2.24.4

