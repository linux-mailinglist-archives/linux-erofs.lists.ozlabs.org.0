Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44935959323
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209510;
	bh=Pmkb7vCZe0X1h0iLptZUdKDBTMHVqer7/zRyZMmPCBg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FAv3ap0p6dswTDq6bVZWPCixxwVxpvdvSMSWH21BJb7CepgP7DpCysQQv87BUvVlM
	 lVUSlJQdrFqp9BG1mSYetTRbqeSKcLRI4ZBfZs91+QcEVnTQ8ctDxNC44cV8YRwaRW
	 afxH+HZo1w6oBF3BeHlnmz67Nl2iTXZPYrLXA11Ef5ZwTUbAG5FVRVOORKDokrXLAv
	 3R4IXSKqkc0A+zzQBcxi4PYzuS3mux1pjuBrm/L1Fpmy/NSdKhvsigyqiLMyZbO2zv
	 ojTEt05QSTCyrZQ5BZj90YyEo+g0LWNmhpusyqqRS4qxNBl2OO8VAf6T7Ylwc+TpI/
	 /7vXIDTZkIMIA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWRB21ZBz2yFK
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:05:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWR80Hjxz2xHl
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:05:07 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WpW333xTCz1j6hF;
	Wed, 21 Aug 2024 10:47:43 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B80C180019;
	Wed, 21 Aug 2024 10:47:45 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:44 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 6/8] cachefiles: Modify inappropriate error return value in cachefiles_daemon_secctx()
Date: Wed, 21 Aug 2024 10:42:59 +0800
Message-ID: <20240821024301.1058918-7-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In cachefiles_daemon_secctx(), if it is detected that secctx has been
written to the cache, the error code returned is -EINVAL, which is
inappropriate and does not distinguish the situation well.

Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
if it has already been defined once.

Fixes: 8667d434b2a9 ("cachefiles: Register a miscdev and parse commands over it")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..59e576951c68 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -587,7 +587,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->secctx) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	secctx = kstrdup(args, GFP_KERNEL);
-- 
2.39.2

