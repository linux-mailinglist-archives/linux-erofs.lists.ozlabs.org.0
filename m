Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64591B719
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 08:31:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9QZQ5Frsz3cZB
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 16:31:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9QYm138yz3cHH
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 16:31:08 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9QYT25YTz4f3l1m
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:30:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 863691A0568
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:31:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S13;
	Fri, 28 Jun 2024 14:31:05 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 9/9] cachefiles: add missing lock protection when polling
Date: Fri, 28 Jun 2024 14:29:30 +0800
Message-Id: <20240628062930.2467993-10-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXwIWfWH5mZZVAAg--.52859S13
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rWr4Dtr4furW3uw4rZrb_yoW8WrWfpF
	WSya45try8ur48uF1qv3WkA34FyaykGa4DW3ykXwsIv3srXr15XF1Sk34a9rn5Jr4kAF43
	Jw15KF9xA3yUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUB89_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-xKAADsH
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Add missing lock protection in poll routine when iterating xarray,
otherwise:

Even with RCU read lock held, only the slot of the radix tree is
ensured to be pinned there, while the data structure (e.g. struct
cachefiles_req) stored in the slot has no such guarantee.  The poll
routine will iterate the radix tree and dereference cachefiles_req
accordingly.  Thus RCU read lock is not adequate in this case and
spinlock is needed here.

Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 06cdf1a8a16f..89b11336a836 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -366,14 +366,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 
 	if (cachefiles_in_ondemand_mode(cache)) {
 		if (!xa_empty(&cache->reqs)) {
-			rcu_read_lock();
+			xas_lock(&xas);
 			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 				if (!cachefiles_ondemand_is_reopening_read(req)) {
 					mask |= EPOLLIN;
 					break;
 				}
 			}
-			rcu_read_unlock();
+			xas_unlock(&xas);
 		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-- 
2.39.2

