Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id CAA838CBA18
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 05:56:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VkclB2Kxgz3g8J
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 13:50:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkcky6V0Rz3g3B
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 13:50:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vkckg3zdbz4f3jcy
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7CCEE1A01B9
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S7;
	Wed, 22 May 2024 11:49:56 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
Date: Wed, 22 May 2024 19:42:59 +0800
Message-Id: <20240522114308.2402121-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHGBFea01mxlBXNQ--.57627S7
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrur1kZw45Gr1DurWrAFb_yoW7uFy8pF
	ZIkFyxtry8WrW8Cr4kAF15Jr1rJ3yvyFnrWry0q3s3AFn0vr1rZr1UtFyFqFy5CryvkanI
	qw18uFy7J34jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi5l1DUUUUU==
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

We got the following issue in a fuzz test of randomly issuing the restore
command:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962

CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
Call Trace:
 kasan_report+0x94/0xc0
 cachefiles_ondemand_daemon_read+0x609/0xab0
 vfs_read+0x169/0xb50
 ksys_read+0xf5/0x1e0

Allocated by task 626:
 __kmalloc+0x1df/0x4b0
 cachefiles_ondemand_send_req+0x24d/0x690
 cachefiles_create_tmpfile+0x249/0xb30
 cachefiles_create_file+0x6f/0x140
 cachefiles_look_up_object+0x29c/0xa60
 cachefiles_lookup_cookie+0x37d/0xca0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]

Freed by task 626:
 kfree+0xf1/0x2c0
 cachefiles_ondemand_send_req+0x568/0x690
 cachefiles_create_tmpfile+0x249/0xb30
 cachefiles_create_file+0x6f/0x140
 cachefiles_look_up_object+0x29c/0xa60
 cachefiles_lookup_cookie+0x37d/0xca0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]
==================================================================

Following is the process that triggers the issue:

     mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
 cachefiles_ondemand_init_object
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)

            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              cachefiles_ondemand_get_fd
              copy_to_user(_buffer, msg, n)
            process_open_req(REQ_A)
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                  xas_for_each(&xas, req, ULONG_MAX)
                                   xas_set_mark(&xas, CACHEFILES_REQ_NEW);

                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req

             write(devfd, ("copen %u,%llu", msg->msg_id, size));
             cachefiles_ondemand_copen
              xa_erase(&cache->reqs, id)
              complete(&REQ_A->done)
   kfree(REQ_A)
                                    cachefiles_ondemand_get_fd(REQ_A)
                                     fd = get_unused_fd_flags
                                     file = anon_inode_getfile
                                     fd_install(fd, file)
                                     load = (void *)REQ_A->msg.data;
                                     load->fd = fd;
                                     // load UAF !!!

This issue is caused by issuing a restore command when the daemon is still
alive, which results in a request being processed multiple times thus
triggering a UAF. So to avoid this problem, add an additional reference
count to cachefiles_req, which is held while waiting and reading, and then
released when the waiting and reading is over.

Note that since there is only one reference count for waiting, we need to
avoid the same request being completed multiple times, so we can only
complete the request if it is successfully removed from the xarray.

Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d33169f0018b..7745b8abc3aa 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
 struct cachefiles_req {
 	struct cachefiles_object *object;
 	struct completion done;
+	refcount_t ref;
 	int error;
 	struct cachefiles_msg msg;
 };
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..c011fb24d238 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -4,6 +4,12 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+static inline void cachefiles_req_put(struct cachefiles_req *req)
+{
+	if (refcount_dec_and_test(&req->ref))
+		kfree(req);
+}
+
 static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
@@ -330,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
+	refcount_inc(&req->ref);
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
@@ -356,15 +363,22 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 		complete(&req->done);
 	}
 
+	cachefiles_req_put(req);
 	return n;
 
 err_put_fd:
 	if (msg->opcode == CACHEFILES_OP_OPEN)
 		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
-	xa_erase(&cache->reqs, id);
-	req->error = ret;
-	complete(&req->done);
+	xas_reset(&xas);
+	xas_lock(&xas);
+	if (xas_load(&xas) == req) {
+		req->error = ret;
+		complete(&req->done);
+		xas_store(&xas, NULL);
+	}
+	xas_unlock(&xas);
+	cachefiles_req_put(req);
 	return ret;
 }
 
@@ -395,6 +409,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 	}
 
+	refcount_set(&req->ref, 1);
 	req->object = object;
 	init_completion(&req->done);
 	req->msg.opcode = opcode;
@@ -456,7 +471,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	wake_up_all(&cache->daemon_pollwq);
 	wait_for_completion(&req->done);
 	ret = req->error;
-	kfree(req);
+	cachefiles_req_put(req);
 	return ret;
 out:
 	/* Reset the object to close state in error handling path.
-- 
2.39.2

