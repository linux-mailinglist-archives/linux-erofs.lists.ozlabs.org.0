Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id E56128CBA1D
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 05:56:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VkclF28pWz3gL1
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 13:50:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkcky6S0zz3g2g
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 13:50:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckg118sz4f3lgS
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AFFD1A01B9
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S9;
	Wed, 22 May 2024 11:49:57 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
Date: Wed, 22 May 2024 19:43:01 +0800
Message-Id: <20240522114308.2402121-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHGBFea01mxlBXNQ--.57627S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3ArWDtw1kKF18Jr1kKrg_yoW5Wr43pF
	WSyay7Kry8WF48Crn7A3W5X34rt3y8Z3ZrW3y0qw1fArnIqr15Zr18tF15ZFy5ArWvgrsx
	tw18CFZrGryjq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREMKZDUUUUU==
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

The err_put_fd label is only used once, so remove it to make the code
more readable. In addition, the logic for deleting error request and
CLOSE request is merged to simplify the code.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/cachefiles/ondemand.c | 45 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 3dd002108a87..bb94ef6a6f61 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -305,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
-	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
@@ -340,49 +339,37 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
-	id = xas.xa_index;
-
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
 		if (ret) {
 			cachefiles_ondemand_set_object_close(req->object);
-			goto error;
+			goto out;
 		}
 	}
 
-	msg->msg_id = id;
+	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
-		goto err_put_fd;
-	}
-
-	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	/* CLOSE request has no reply */
-	if (msg->opcode == CACHEFILES_OP_CLOSE) {
-		xa_erase(&cache->reqs, id);
-		complete(&req->done);
+		if (msg->opcode == CACHEFILES_OP_OPEN)
+			close_fd(((struct cachefiles_open *)msg->data)->fd);
 	}
-
-	cachefiles_req_put(req);
-	return n;
-
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
-error:
+out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	xas_reset(&xas);
-	xas_lock(&xas);
-	if (xas_load(&xas) == req) {
-		req->error = ret;
-		complete(&req->done);
-		xas_store(&xas, NULL);
+	/* Remove error request and CLOSE request has no reply */
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			req->error = ret;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+		xas_unlock(&xas);
 	}
-	xas_unlock(&xas);
 	cachefiles_req_put(req);
-	return ret;
+	return ret ? ret : n;
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
-- 
2.39.2

