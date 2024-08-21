Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3895931E
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209390;
	bh=+JjxFiMGh5qQzf/kQ0JuEEFiHsZlx1wpSgrcuES+TIg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gt3MbQAmYuU195b4K7XMin2pr2wc4xN2bXD833HS/+JUy1iCK/W5j5n70bY7rC/LG
	 tukU9kHEkvw9ixCouNgA1u0oPLLDd+BpC+3qfDKCYjZbHWJUYv/inoCqdDwjWG3BAL
	 k8r3cZk/61gMGjN/96eO62zr1V0GsJLLY75/Hfz2xUi8rDPr6cmUkqeDsvSbn9TfN2
	 ooc8NroX/u9aDq2aGxiCDyQ44Cq6GHr1h0uQeagacWWfEQcC4sUaGIVsL3rvbt0y3I
	 A4vgrchuJtnzDBbRDcdQfHtVg7PBN1pXO4w9Foj+9OY4bHU5QLFwkgIYu9vJ6AV0Qj
	 HcHV+95NesPdQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWNt4yNRz2yGf
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:03:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWNr1MLYz2xfP
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:03:08 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpW0g5B3kzhXs4;
	Wed, 21 Aug 2024 10:45:39 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 219B61401E0;
	Wed, 21 Aug 2024 10:47:40 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:38 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
Date: Wed, 21 Aug 2024 10:42:54 +0800
Message-ID: <20240821024301.1058918-2-wozizhi@huawei.com>
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

In the __cachefiles_prepare_write function, DIO aligns blocks using
PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
cache->bsize with the requirement that it must not exceed PAGE_SIZE.
However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
count will be incorrect in __cachefiles_prepare_write().

Set the block size to cache->bsize to resolve this issue.

Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index a91acd03ee12..59c5c08f921a 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -524,10 +524,10 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	struct cachefiles_cache *cache = object->volume->cache;
 	loff_t start = *_start, pos;
 	size_t len = *_len;
-	int ret;
+	int ret, block_size = cache->bsize;
 
 	/* Round to DIO size */
-	start = round_down(*_start, PAGE_SIZE);
+	start = round_down(*_start, block_size);
 	if (start != *_start || *_len > upper_len) {
 		/* Probably asked to cache a streaming write written into the
 		 * pagecache when the cookie was temporarily out of service to
@@ -537,7 +537,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 		return -ENOBUFS;
 	}
 
-	*_len = round_up(len, PAGE_SIZE);
+	*_len = round_up(len, block_size);
 
 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -563,7 +563,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	 * space, we need to see if it's fully allocated.  If it's not, we may
 	 * want to cull it.
 	 */
-	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	if (cachefiles_has_space(cache, 0, *_len / block_size,
 				 cachefiles_has_space_check) == 0)
 		return 0; /* Enough space to simply overwrite the whole block */
 
@@ -595,7 +595,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	return ret;
 
 check_space:
-	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	return cachefiles_has_space(cache, 0, *_len / block_size,
 				    cachefiles_has_space_for_write);
 }
 
-- 
2.39.2

