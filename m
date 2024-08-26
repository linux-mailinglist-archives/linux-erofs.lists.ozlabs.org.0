Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9095EFD2
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2024 13:35:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WspWT6zvLz2yQ9
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2024 21:35:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724672116;
	cv=none; b=Qdy2rEJ9lRMa0U+uHBmn+PUIf28/KSeyDpoiWUtC3qckeAqePrx3H1NeJkAXm9teSjSNsV3mi+rA7t1+NZCnQnBSxHrJ5CKAGwoC0M4Ar/gmJGBlh00X+sSGza4zEPODZUbdQkCYK71HVnA4XKRP40q/Xw8agyOCIzKtoK4EVEMw6v3p8Q/Ue85he5n+waqFtZAennRMt9+16olOTAbFUCgcY9ftPEk++EF7qi5v4E+2ysaPD+4XJLAgu2/TMR3u8FXHzYhpM0dnpbJ5nvqC909D3RPhOBnnxhTDJW8zjKp0C0bDJ5eQm6fly7K4dC+NMUqRVgzZBICLkeLH30/4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724672116; c=relaxed/relaxed;
	bh=lia5ZSQ2KvJ//E/6qFw/dxVRU4YqqIyMNmg/Y75Puos=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=kdei3inOWGYUlc/j+HM8EFxwqGShvdNnf0WT6FY0QRp9Z3vfkF9MA1GH8PFtebIXHHWos0zWLhXAouc9rODvnp4XL6/qT7b7TPyJIa2sOqFN2N4RQFaMbr25nKc4mY3zoL7vRGXkdQ3hNUq3qnnJoKVKMMKDxjkGQrVriVJBFfe3f+LbN/+VJAk6IfbwFZI4AWeRniYwE8tOqb6MXFvEGj6CDeODiYgo8LTU6eP9L6Px5SjWMuH4deLwjIr9L6XmDSBnL3KiHAZh1KbLVl50ghdDxAjN0KF9aNZ74zH0JcfXVWVC864TIR4JWUOz0lMsMJjxKcjFWHD98SMxGWYxgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WspWQ6SY3z2xXp
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 21:35:13 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WspW53g18z4f3kq3
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 19:34:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60E341A0359
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 19:35:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4VoaMxmkUITCw--.22524S4;
	Mon, 26 Aug 2024 19:35:07 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Date: Mon, 26 Aug 2024 19:34:04 +0800
Message-Id: <20240826113404.3214786-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3n4VoaMxmkUITCw--.22524S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xXr1kCFyxXr1UCrWxJFb_yoW8ZFWxp3
	ZrZryxGr1jqryUJF45Ja1Utr1UZF1qg3W7GryxCr1fZan7Aw1UX3W0qr15ZFy2kF48AFs8
	t3W8trnYvr15Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1bdb5UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEIwADs+
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, stable@kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
deleting its subtree. This triggers the following WARNING:

==================================================================
remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
Modules linked in: netfs(-)
CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
RIP: 0010:remove_proc_entry+0x160/0x1c0
Call Trace:
 <TASK>
 netfs_exit+0x12/0x620 [netfs]
 __do_sys_delete_module.isra.0+0x14c/0x2e0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

Therefore use remove_proc_subtree instead() of remove_proc_entry() to
fix the above problem.

Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/netfs/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..9d6b49dc6694 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -142,7 +142,7 @@ static int __init netfs_init(void)
 
 error_fscache:
 error_procfile:
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 error_proc:
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
@@ -159,7 +159,7 @@ fs_initcall(netfs_init);
 static void __exit netfs_exit(void)
 {
 	fscache_exit();
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 	mempool_exit(&netfs_subrequest_pool);
 	kmem_cache_destroy(netfs_subrequest_slab);
 	mempool_exit(&netfs_request_pool);
-- 
2.39.2

