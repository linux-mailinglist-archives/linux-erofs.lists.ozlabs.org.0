Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8C8C66C1
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 15:02:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VfYKd0dyLz3cdn
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 23:02:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VfYKL1DgXz3cTr
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 23:02:13 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfYK45XKwz4f3jdX
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 21:02:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 713871A016E
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 21:02:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLskRmALLwMg--.18738S7;
	Wed, 15 May 2024 21:02:09 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v2 3/5] cachefiles: flush ondemand_object_worker during clean object
Date: Wed, 15 May 2024 20:51:34 +0800
Message-Id: <20240515125136.3714580-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515125136.3714580-1-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAX6RFLskRmALLwMg--.18738S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kur4fJF1DXFy7Zw1UKFg_yoW8uryUpF
	WakFy7KrW8WF4UCrWkZFs5JryrK3ykZFnrWFyYvrZ8Ar90qr4rZr12y3ZxXF15Aw1SgrZr
	tw4UCr9xt34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JUPHUDUUUUU=
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

From: Hou Tao <houtao1@huawei.com>

When queuing ondemand_object_worker() to re-open the object,
cachefiles_object is not pinned. The cachefiles_object may be freed when
the pending read request is completed intentionally and the related
erofs is umounted. If ondemand_object_worker() runs after the object is
freed, it will incur use-after-free problem as shown below.

process A  processs B  process C  process D

cachefiles_ondemand_send_req()
// send a read req X
// wait for its completion

           // close ondemand fd
           cachefiles_ondemand_fd_release()
           // set object as CLOSE

                       cachefiles_ondemand_daemon_read()
                       // set object as REOPENING
                       queue_work(fscache_wq, &info->ondemand_work)

                                // close /dev/cachefiles
                                cachefiles_daemon_release
                                cachefiles_flush_reqs
                                complete(&req->done)

// read req X is completed
// umount the erofs fs
cachefiles_put_object()
// object will be freed
cachefiles_ondemand_deinit_obj_info()
kmem_cache_free(object)
                       // both info and object are freed
                       ondemand_object_worker()

When dropping an object, it is no longer necessary to reopen the object,
so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
to complete.

Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/ondemand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d24bff43499b..f6440b3e7368 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 		}
 	}
 	xa_unlock(&cache->reqs);
+
+	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
+	cancel_work_sync(&object->ondemand->ondemand_work);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.39.2

