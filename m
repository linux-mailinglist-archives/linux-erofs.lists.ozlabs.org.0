Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741FD8B0013
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:49:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ2y14q7z30gK
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:49:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ2H5VM9z3c3K
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:48:39 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPQ225RG7z4f3lgQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ECDB11A016E
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S16;
	Wed, 24 Apr 2024 11:48:35 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 12/12] cachefiles: make on-demand read killable
Date: Wed, 24 Apr 2024 11:39:16 +0800
Message-Id: <20240424033916.2748488-13-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033916.2748488-1-libaokun@huaweicloud.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXaBELgShmKXE4Kw--.6143S16
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7JryDCF4DJr4kXFy7Jrb_yoW8Wr1kpF
	Wava4rKrykuF4I9rn3A3W8X3ySy3ykAFnrWrySqrW3AanIqrnYvr48t3WYqF45A395WrW3
	tr9YgFWxK3Wjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUUNBMtUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

Replacing wait_for_completion() with wait_for_completion_killable() in
cachefiles_ondemand_send_req() allows us to kill processes that might
trigger a hunk_task if the daemon is abnormal.

But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
is initiated from kworker context and the signal is prohibited in these
kworker.

Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
means that a process will complete the current request soon, so wait
again for the request to be completed.

Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 673e7ad52041..b766430f4abf 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -525,8 +525,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 
 	wake_up_all(&cache->daemon_pollwq);
-	wait_for_completion(&req->done);
-	ret = req->error;
+wait:
+	ret = wait_for_completion_killable(&req->done);
+	if (!ret) {
+		ret = req->error;
+	} else {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			xas_store(&xas, NULL);
+			ret = -EINTR;
+		}
+		xas_unlock(&xas);
+
+		/* Someone will complete it soon. */
+		if (ret != -EINTR) {
+			cpu_relax();
+			goto wait;
+		}
+	}
 	cachefiles_req_put(req);
 	return ret;
 out:
-- 
2.39.2

