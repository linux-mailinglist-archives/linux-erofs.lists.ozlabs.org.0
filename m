Return-Path: <linux-erofs+bounces-1046-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206DEB857B2
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Sep 2025 17:13:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSJzk0N86z2xgX;
	Fri, 19 Sep 2025 01:13:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758208386;
	cv=none; b=Lq7tQMZj3ycEWzspnrqfV4Yl2gQtEphsqmYL9wsJSFQ7lsteNHMXN4G/lMLb37f4BEMkFzlu8suzfuE9Yy0rYXcq4OLLAouDlf5RAn3kDDtRMyhbWbx4DLKQawN7RXU+DdayqnPxiYrfAi+cc6/S4DjlUhfPpQtmjEfJENAWvuDa/JSJ0eg72PMYoDWhYNPbcwKT7dLPO5sl+zzES1S69udawL3a/uYfQwTDdRbfgFFPBLvkfnmAU8Nz7dVDNTCE6tevBdSUjE+FnTMyYm0hNwYaSsF7D5nMBelgLYjbHQgHZRMXdEH8QO6QmWAxD75jJ+2rxt8FZP8XogQX/PoiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758208386; c=relaxed/relaxed;
	bh=ynFoQnAZR68MeKSd09x7bjp75JV8duitCCvoXX7OqTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEEHFtRenR3QleDR6eUyCTxCkL3IPuIzUEmKjcA7uzzPcoAmuWcKenCvZcuYNeAaTmnW7riW5RWofc0XOONKV8R/L/dlrWNgEDVlxHOkc0me5NhMsMYvKDOIBP2qXxxt95siG39H3fCaKmvuN2cR2TS3CaCS6fQIweOO9U2rj56VvYOf5c1bvOTVlsUDEZXaDhngbJnxZjXoWfBonQrV9e9BexaSif1rQhx91PeEC7hYyvdwKFdqPZaDS34rMOaD6RMPn4QCaDwOctMdRHA9IfPPbM9v4TDPwfZYgVsm+kNyfVOrIqn+vhBzdVu6I0yAHpq8VZ0Zg/YrzDmnud9vOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSJzh4M9gz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Sep 2025 01:13:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSJzD4pGCz14MWf
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:12:40 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A5ED18007F
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:12:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Sep
 2025 23:12:56 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <lihongbo22@huawei.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
Subject: [PATCH 1/3] erofs-utils: add mount/mount.erofs to .gitignore
Date: Thu, 18 Sep 2025 23:12:43 +0800
Message-ID: <20250918151245.58786-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250918151245.58786-1-zhaoyifan28@huawei.com>
References: <20250918151245.58786-1-zhaoyifan28@huawei.com>
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
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index cc1c72c..47578ea 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,4 +36,5 @@ stamp-h1
 /fuse/erofsfuse
 /dump/dump.erofs
 /fsck/fsck.erofs
+/mount/mount.erofs
 /contrib/stress
-- 
2.46.0


