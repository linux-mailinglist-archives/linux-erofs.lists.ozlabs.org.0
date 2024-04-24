Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 436998B0009
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:48:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ2M733Nz3cRs
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:48:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ2D0jRpz30gK
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:48:35 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPQ230L4nz4f3kJv
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD0771A0175
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S8;
	Wed, 24 Apr 2024 11:48:31 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
Date: Wed, 24 Apr 2024 11:39:08 +0800
Message-Id: <20240424033916.2748488-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033916.2748488-1-libaokun@huaweicloud.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXaBELgShmKXE4Kw--.6143S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UWF15tF4UWrW3XrWDJwb_yoWruF4rpF
	ZIyFyxtry8Way8Cr4kArn8Jr1rJ3yDuFnrX340qr1xAwn0vr1rZr17tF10yFy5Cry2yrsr
	tw1UCF9xJryjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
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
---
 fs/cachefiles/ondemand.c          | 2 ++
 include/trace/events/cachefiles.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 56d12fe4bf73..bb94ef6a6f61 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
 	refcount_inc(&req->ref);
+	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
@@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 			close_fd(((struct cachefiles_open *)msg->data)->fd);
 	}
 out:
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* Remove error request and CLOSE request has no reply */
 	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
 		xas_reset(&xas);
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index cf4b98b9a9ed..119a823fb5a0 100644
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
@@ -127,7 +129,9 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
 	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
-	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
+	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
+	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
+	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
-- 
2.39.2

