Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8D8CBA1A
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 05:56:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VkclQ2MFpz3vcC
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 13:50:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkckz0xRYz3g4v
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 13:50:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckf44MKz4f3m7L
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0E0B31A016E
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S8;
	Wed, 22 May 2024 11:49:56 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
Date: Wed, 22 May 2024 19:43:00 +0800
Message-Id: <20240522114308.2402121-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHGBFea01mxlBXNQ--.57627S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UWF15tF4UWrW3XrWDJwb_yoW7Jw4fpF
	ZIyFyxtry8WFW8Cr4kAr15Jr1rJ3yDCFnrX340qr1xAwnIvr1rZr1UtF1rJFy5Cry2yrsr
	tw18CF9xtryjy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
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

We got the following issue in a fuzz test of randomly issuing the restore
command:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963

CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
Call Trace:
 kasan_report+0x93/0xc0
 cachefiles_ondemand_daemon_read+0xb41/0xb60
 vfs_read+0x169/0xb50
 ksys_read+0xf5/0x1e0

Allocated by task 116:
 kmem_cache_alloc+0x140/0x3a0
 cachefiles_lookup_cookie+0x140/0xcd0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]

Freed by task 792:
 kmem_cache_free+0xfe/0x390
 cachefiles_put_object+0x241/0x480
 fscache_cookie_state_machine+0x5c8/0x1230
 [...]
==================================================================

Following is the process that triggers the issue:

     mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
cachefiles_withdraw_cookie
 cachefiles_ondemand_clean_object(object)
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)

            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              msg->object_id = req->object->ondemand->ondemand_id
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                  xas_for_each(&xas, req, ULONG_MAX)
                                   xas_set_mark(&xas, CACHEFILES_REQ_NEW)

                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req
              copy_to_user(_buffer, msg, n)
               xa_erase(&cache->reqs, id)
               complete(&REQ_A->done)
              ------ close(fd) ------
              cachefiles_ondemand_fd_release
               cachefiles_put_object
 cachefiles_put_object
  kmem_cache_free(cachefiles_object_jar, object)
                                    REQ_A->object->ondemand->ondemand_id
                                     // object UAF !!!

When we see the request within xa_lock, req->object must not have been
freed yet, so grab the reference count of object before xa_unlock to
avoid the above issue.

Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/ondemand.c          | 3 +++
 include/trace/events/cachefiles.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index c011fb24d238..3dd002108a87 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -337,6 +337,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
 	refcount_inc(&req->ref);
+	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
@@ -357,6 +358,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 		goto err_put_fd;
 	}
 
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* CLOSE request has no reply */
 	if (msg->opcode == CACHEFILES_OP_CLOSE) {
 		xa_erase(&cache->reqs, id);
@@ -370,6 +372,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	if (msg->opcode == CACHEFILES_OP_OPEN)
 		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	xas_reset(&xas);
 	xas_lock(&xas);
 	if (xas_load(&xas) == req) {
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index e3213af847cd..7d931db02b93 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_see_withdrawal,
 	cachefiles_obj_get_ondemand_fd,
 	cachefiles_obj_put_ondemand_fd,
+	cachefiles_obj_get_read_req,
+	cachefiles_obj_put_read_req,
 };
 
 enum fscache_why_object_killed {
@@ -129,7 +131,9 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
 	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
 	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")	\
-	E_(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")
+	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")	\
+	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
+	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
-- 
2.39.2

