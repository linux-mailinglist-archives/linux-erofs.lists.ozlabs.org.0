Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E68C66C5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 15:02:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VfYKl2yHCz3cb7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 23:02:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VfYKL5bykz3cV5
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 23:02:12 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfYK41Kcqz4f3jdS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 21:02:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D54011A0B8F
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 21:02:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLskRmALLwMg--.18738S6;
	Wed, 15 May 2024 21:02:08 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v2 2/5] cachefiles: flush all requests for the object that is being dropped
Date: Wed, 15 May 2024 20:51:33 +0800
Message-Id: <20240515125136.3714580-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515125136.3714580-1-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAX6RFLskRmALLwMg--.18738S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15uFWrWFWrWFyrJF47Jwb_yoW8WFWxpF
	WayFy3KFy8uFsFkrZ3XFZ5trySy3ykuFnrX3Waqa95Arn8XryrZr1rtw1DXFy5A393Xr4x
	tw4YkF9xG3yqkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbhvtJUUUUU==
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

Because after an object is dropped, requests for that object are useless,
flush them to avoid causing other problems.

This prepares for the later addition of cancel_work_sync(). After the
reopen requests is generated, flush it to avoid cancel_work_sync()
blocking by waiting for daemon to complete the reopen requests.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 73da4d4eaa9b..d24bff43499b 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
+	unsigned long index;
+	struct cachefiles_req *req;
+	struct cachefiles_cache *cache;
+
 	if (!object->ondemand)
 		return;
 
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
+
+	if (!object->ondemand->ondemand_id)
+		return;
+
+	/* Flush all requests for the object that is being dropped. */
+	cache = object->volume->cache;
+	xa_lock(&cache->reqs);
 	cachefiles_ondemand_set_object_dropping(object);
+	xa_for_each(&cache->reqs, index, req) {
+		if (req->object == object) {
+			req->error = -EIO;
+			complete(&req->done);
+			__xa_erase(&cache->reqs, index);
+		}
+	}
+	xa_unlock(&cache->reqs);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.39.2

