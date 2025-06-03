Return-Path: <linux-erofs+bounces-379-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0DACBEAF
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:08:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBFz93BWvz2yGM;
	Tue,  3 Jun 2025 13:08:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748920117;
	cv=none; b=mbb/BwPoZVX4ayofb8SRCGk/UTMeNQkm5vcr/Nqses1eIaD5MlyeWpnNY3wIHOirr5M7YH6FwXINMxdUFQpGf74tJ3btpSuOvNdyPv/rrcFRomxztDFtP5nQDPoI1Cv60dUdOMnTs7cfWk0Tntn5jmV9CTx0b+BQEzSkRkLPhlTaAnaZKOOKxYjG8tr0IraXFUwon4S1oz8SV6FHYcYBlchHDmGr7nTKwRcZ/4OhzR+hY+EYLpFzpyh04ytBXZBdIbs3Sklmnx41srDgDH8t057YJ2xDLBaW6AebGc1RUbFYiJgkA82xlHgce+nx/WEO9c1jsAf+qIhiUUO5SRRzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748920117; c=relaxed/relaxed;
	bh=YZmeCfH5LWWp7BXtD1PuEh0gAPBJYiWVLxMg6cDuq0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTHe8aoMjmqpw2KCNcowkviiB7bQJJ+RFIYMAs35z4HCiBOads/DIHg4g+j9L0w+lcGaLrP6/DcNhPKnpy+A0tU98Qzmhbcq9S50s9Z32r6A84dX0verP0w6Q8zoaOUulKUFuTtLHdIxIFgwRUjTVdgc7JKWjoW0rnUNrEUaZga8LJmJGOccJmLD+TSkg7pZfecZyYLYv/XwEVUuo/CJJX03nu+eDthg/2j+tOd/zVrbg/YmliMqhQGwshD6Pcgcml5jjfw04aZz5qDKzEN3FwGBuL0evEg6/9j8arwZczlbcLv+FbpeqT1dFMbEHg3WP5q9snmmdVJWdxIi0lSdqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBFz765XNz2xpl
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:08:33 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bBFws3wjGz13LxV;
	Tue,  3 Jun 2025 11:06:37 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CF03180A9E;
	Tue,  3 Jun 2025 11:08:29 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 11:08:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3] erofs-utils: mkfs: fix image reproducibility of `-E(all-)fragments`
Date: Tue, 3 Jun 2025 03:08:14 +0000
Message-ID: <20250603030814.487212-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
References: <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

The timestamp of the packed inode should be fixed to the build time.

Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
[hongbo: minor adjust]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
change since v2:
 - compare path with strcmp;

change since v1:
 - fix time assignment (assign `i_mtime_nsec` too) [Hongbo];
---
 lib/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 108aa9e..46eb686 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -929,7 +929,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != inode->sbi->build_time ||
+	if (strcmp(inode->i_srcpath, EROFS_PACKED_INODE) &&
+	    (inode->i_mtime != inode->sbi->build_time ||
 	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
@@ -1021,6 +1022,11 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		erofs_err("gid overflow @ %s", path);
 	inode->i_gid += cfg.c_gid_offset;
 
+	if (path == EROFS_PACKED_INODE) {
+		inode->i_mtime = sbi->build_time;
+		inode->i_mtime_nsec = sbi->build_time_nsec;
+		return 0;
+	}
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
@@ -1034,7 +1040,6 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	default:
 		break;
 	}
-
 	return 0;
 }
 
-- 
2.22.0


