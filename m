Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE79C037E
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 12:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730977845;
	bh=TiISMCGSbl/MEi6Uj+4tuAX5DXWUm+fP88j6qprCgy0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PKLoMIxWgPo4GcxWBduY6WKCSBgoyyl1qTtfSwJmoBfaRR7Say3TaUa7t4NuLH6Lz
	 gvDA2XenFCHDsI5mgHv2btykf6qKXhJPaIFqjReu8Z+1Tp3oxvsarGQBriFj8fj6bx
	 0Z6ayHFfg8ZdCErhrKvwlQakGUeZo+rCKscNexAtiK5sCTGRlXgNIJYvpvKP52mh7x
	 zqLPC/2I1cA0QsDNxtwt2UkjYAiT39Ezdd4jLgAb8gibDk5IAATigcqOzgTfifO4j9
	 wjCzQbBm87VMGEIQF0Q6nQuWajqQGeH7HJfFQKqE6tXfm9ZxfBYJgO5GjxG8HWrXZK
	 0pAOubVx3Qllg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfWT08KQz3bpL
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 22:10:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977843;
	cv=none; b=jqwtKXCoEiMkiMIip4c/KQGQJ0hVgQeDTQZnmeECwAJAZLPnrPoFVyimZVsXezCH837Mfg3l8FGZKb953XbPfM2AxiHvLaxROR7pmn5Tl54o1ulJw2uqEl4cQHM9wsqNlY9NY7C24dxS2Ef5lxfZNoDVNdtnh9b30CEwLJ+sXv/OMCDHw5YbIgQEY40PKziwunXvSlTQZh2MT43Mqd5PbptU8gOP/jcgtAgifgITAckWyP+sN6bIesk4Fj/yhiDY4F8hAplyDClVibZufW7jsfo5RucpDTNKkgGeOEy3uBZeJOQTuDZEnyrLnFu1O1ma9K9Em2oXOsh/OQYQaD+eug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977843; c=relaxed/relaxed;
	bh=TiISMCGSbl/MEi6Uj+4tuAX5DXWUm+fP88j6qprCgy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ3ORIf+ulNKFrAYfLOZXRCW52P9AcgtgwwuC1FD6pvI21XjOuQV8mBIn75eMuv3xEwkjwJdpj2v6Fxi1yIx+vQLGFf2j5nGCizrGDrRxloCQ94Q8FQsdXHV/5p2F3rdB/F7wlJJQnBNfOd3ijukQgbIu63ax1xK6eIDpL9TKarUzNH8NDWseLssJhgCxXPnE3g3my9VcJT9z8LHWc4pLXM7uwfaEzlEXcOHVJNgTybIECehXpKAaAnZoxJXE3KsRjbX5oCaCuIKMtWAQ1KWls0VDoInxtrS4ANNNzzjy/+1q2vw3Msn3qPcWkIccz51VtSZ7vx3QLl2rAn4OAhL/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfWL5cTzz3bmC
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 22:10:37 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkfT7637Rz1SGC6;
	Thu,  7 Nov 2024 19:08:43 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id C45F41A0188;
	Thu,  7 Nov 2024 19:10:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:25 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v2 5/5] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Date: Thu, 7 Nov 2024 19:06:49 +0800
Message-ID: <20241107110649.3980193-6-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

In fscache_create_volume(), there is a missing memory barrier between the
bit-clearing operation and the wake-up operation. This may cause a
situation where, after a wake-up, the bit-clearing operation hasn't been
detected yet, leading to an indefinite wait. The triggering process is as
follows:

  [cookie1]                [cookie2]                  [volume_work]
fscache_perform_lookup
  fscache_create_volume
                        fscache_perform_lookup
                          fscache_create_volume
			                        fscache_create_volume_work
                                                  cachefiles_acquire_volume
                                                  clear_and_wake_up_bit
    test_and_set_bit
                            test_and_set_bit
                              goto maybe_wait
      goto no_wait

In the above process, cookie1 and cookie2 has the same volume. When cookie1
enters the -no_wait- process, it will clear the bit and wake up the waiting
process. If a barrier is missing, it may cause cookie2 to remain in the
-wait- process indefinitely.

In commit 3288666c7256 ("fscache: Use clear_and_wake_up_bit() in
fscache_create_volume_work()"), barriers were added to similar operations
in fscache_create_volume_work(), but fscache_create_volume() was missed.

By combining the clear and wake operations into clear_and_wake_up_bit() to
fix this issue.

Fixes: bfa22da3ed65 ("fscache: Provide and use cache methods to lookup/create/free a volume")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/fscache_volume.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cb75c07b5281..ced14ac78cc1 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -322,8 +322,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait)
 	}
 	return;
 no_wait:
-	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
-	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
 }
 
 /*
-- 
2.39.2

