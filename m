Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0724D50AD
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 18:35:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDx6C2C3Zz3097
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 04:35:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDx631v5cz2yxV
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 04:35:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V6pLX5X_1646933689; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6pLX5X_1646933689) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 01:34:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: silence warnings related to impossible m_plen
Date: Fri, 11 Mar 2022 01:34:48 +0800
Message-Id: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 kernel test robot <lkp@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Dan reported two smatch warnings [1],
.. warn: should '1 << lclusterbits' be a 64 bit type?
.. warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?

In practice, m_plen cannot be more than 1MiB due to on-disk constraint
for the compression mode, so we're always safe here.

In order to make static analyzers happy and don't report again,
let's silence them instead.

[1] https://lore.kernel.org/r/202203091002.lJVzsX6e-lkp@intel.com

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 361b1d6e4bf9..b4059b9c3bac 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -494,7 +494,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
 	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
-		map->m_plen = 1 << lclusterbits;
+		map->m_plen = 1ULL << lclusterbits;
 		return 0;
 	}
 	lcn = m->lcn + 1;
@@ -540,7 +540,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedlcs << lclusterbits;
+	map->m_plen = (u64)m->compressedlcs << lclusterbits;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(m->inode->i_sb,
-- 
2.24.4

