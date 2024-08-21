Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36595959325
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209512;
	bh=x6idxY8T4x0Slp9B696BFSJmiipbwQTl7kDG0kBwmBw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EwqDIG9ag3HweYoX5QD/06Bojgwngig/gOWmSth8XkBNhEzAfv6suceGETnA3g8RH
	 fWxJJ790ZUACCTGiWCMvzoqf6r6DJKzt9UdeewJeF5I0uqnSltEQ9zQKRlLX3Dpxss
	 TtKg0D+3mHrmnwSZQOUgxkz3hWkTZ9e155CUylmS0TvZ8ipBYK+hg5ckgR7ZMul3OD
	 tXWIeGuf5nfJtkT3p+mbbUBn7R5JaRCTpZYgAKWTqBrAtaPfsgKpuOT7+gN1AFTr7/
	 yOux3D5mFUfbX/7m58kbXbP8Ejr50DFLPgvro58YYlQahyJxzEge5sQ+0VvLCD2ut9
	 66aMnGozm++mw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWRD1Fhsz2ytV
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:05:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWR838Tgz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:05:08 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WpW345j9Cz1S8Nd;
	Wed, 21 Aug 2024 10:47:44 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4132F1A016C;
	Wed, 21 Aug 2024 10:47:47 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:46 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 8/8] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Date: Wed, 21 Aug 2024 10:43:01 +0800
Message-ID: <20240821024301.1058918-9-wozizhi@huawei.com>
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

