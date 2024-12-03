Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8529E141A
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 08:28:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2XMG6RFqz302D
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 18:28:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733210921;
	cv=none; b=G2Nw+9y9rVXVAGUkW6l/12v62CgHimtaPAVerRqTA48F0o30Gd0lB+uGctyMezxYLE/Sv/yvgEtmMv6Yff+fAOm7oOnfMKc+Wx0X1R4BWjLnvUEj81Un0wqitiJD9jLtg/LsPgg9UZ/2cJZEmwLc+WKUBGTxvL47iZRO+OND5Bxkw0nNj+mLVVLlF4/x7ONM1vs/EEpl5aWNtWmh0dPdY+VYbGHraiyPWkVmBsqtzIx4lB09hyDD+PJx+HnOPQ8vXjEP2md2WoGSEusXLje9wssd4AFNQFFhlU3mhGTNmYII2BCYW1M23heFP0DhsQgAjN+7UwMAsvEYnSRaeyYVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733210921; c=relaxed/relaxed;
	bh=ffVwQCplrSSi42sdO0aUOX+pWOHj43NN6iV37ZyGKPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWJipfk23FgPj2iC0JXgX29RlgzTpJkIafUz47qMKEOfKmnOiDrxkcxS0XgPVb7iJhPu2n6Q19WJL2bL50iJdjPYHuEKhAb3Xv6vuR6ZKnOoAynkhKbsle51S7SWeWu2805k0LY2P+NnZozRajrSGuOjTGrcThcm4wTLNlyqRuEmN+d7+R0eJ7GE6kmmWbeVd+qXCfDlON0gvCSMkczsSufq5O6Z0qwI3R8Im3QVz25UdOJKnxzteM44267jYaxuEE4xTHR3zH6Tv9pMC+GIUwiEKXjxnxh1jUMRbO/yLW7a4DIIiaYty1LW/GyAyGt/33UreNojczm8KxcQVDPx4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZMv2xMC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZMv2xMC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2XM90y84z2yNn
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 18:28:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733210909; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ffVwQCplrSSi42sdO0aUOX+pWOHj43NN6iV37ZyGKPo=;
	b=WZMv2xMCc77pQrw1/V2BhuPjHhMotN8PgmyWsIAEc2pMC4FHC3s0cIDKZb2rayXhF166ipN5lwZQKDPNwTtpLEsAK1JgXNldH9JigtQ2Z5V6b9xuqfiBWopX8enr7FTmer9Z0W59jaiQaq5PYtESYOZu2eA2SFy3QeWOFflsAzE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKlm0CQ_1733210902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 15:28:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix rare pcluster memory leak after unmounting
Date: Tue,  3 Dec 2024 15:28:21 +0800
Message-ID: <20241203072821.1885740-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <674c1235.050a0220.ad585.0032.GAE@google.com>
References: <674c1235.050a0220.ad585.0032.GAE@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There may still exist some pcluster with valid reference counts
during unmounting.  Instead of introducing another synchronization
primitive, just try again as unmounting is relatively rare.  This
approach is similar to z_erofs_cache_invalidate_folio().

It was also reported by syzbot as a UAF due to commit f5ad9f9a603f
("erofs: free pclusters if no cached folio is attached"):

BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
..
 queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
 do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
 __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
 _raw_spin_trylock+0x20/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 z_erofs_put_pcluster fs/erofs/zdata.c:959 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
 z_erofs_decompress_queue+0x3798/0x3ef0 fs/erofs/zdata.c:1425
 z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1437
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

However, it seems a long outstanding memory leak.  Fix it now.

Fixes: f5ad9f9a603f ("erofs: free pclusters if no cached folio is attached")
Reported-by: syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/674c1235.050a0220.ad585.0032.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zutil.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 75704f58ecfa..0dd65cefce33 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -230,9 +230,10 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining pclusters in memory */
-	z_erofs_shrink_scan(sbi, ~0UL);
-
+	while (!xa_empty(&sbi->managed_pslots)) {
+		z_erofs_shrink_scan(sbi, ~0UL);
+		cond_resched();
+	}
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
 	spin_unlock(&erofs_sb_list_lock);
-- 
2.43.5

