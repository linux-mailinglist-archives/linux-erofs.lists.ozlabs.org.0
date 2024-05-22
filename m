Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id E01098CBA14
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 05:56:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vkclf4P9Hz3w4p
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 13:50:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkcl03F4wz3g5X
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 13:50:04 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckn3kxWz4f3jkr
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F2F01A016E
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 11:49:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S12;
	Wed, 22 May 2024 11:49:59 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
Date: Wed, 22 May 2024 19:43:04 +0800
Message-Id: <20240522114308.2402121-9-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHGBFea01mxlBXNQ--.57627S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47CrWUZw1xtr4fArW8JFb_yoW7XFW3pF
	WakFy3KryxWF4xGrZ7AFs5XryrC3ykZFnrWw1aga48Arn8Zr1rZr1Yyr1SvFy5A3sIgrsr
	tw4UuF9xt34qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRupB-UUUUU
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

Now every time the daemon reads an open request, it gets a new anonymous fd
and ondemand_id. With the introduction of "restore", it is possible to read
the same open request more than once, and therefore an object can have more
than one anonymous fd.

If the anonymous fd is not unique, the following concurrencies will result
in an fd leak:

     t1     |         t2         |          t3
------------------------------------------------------------
 cachefiles_ondemand_init_object
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)
            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              cachefiles_ondemand_get_fd
                load->fd = fd0
                ondemand_id = object_id0
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                   // restore REQ_A
                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req
                                      cachefiles_ondemand_get_fd
                                        load->fd = fd1
                                        ondemand_id = object_id1
             process_open_req(REQ_A)
             write(devfd, ("copen %u,%llu", msg->msg_id, size))
             cachefiles_ondemand_copen
              xa_erase(&cache->reqs, id)
              complete(&REQ_A->done)
   kfree(REQ_A)
                                  process_open_req(REQ_A)
                                  // copen fails due to no req
                                  // daemon close(fd1)
                                  cachefiles_ondemand_fd_release
                                   // set object closed
 -- umount --
 cachefiles_withdraw_cookie
  cachefiles_ondemand_clean_object
   cachefiles_ondemand_init_close_req
    if (!cachefiles_ondemand_object_is_open(object))
      return -ENOENT;
    // The fd0 is not closed until the daemon exits.

However, the anonymous fd holds the reference count of the object and the
object holds the reference count of the cookie. So even though the cookie
has been relinquished, it will not be unhashed and freed until the daemon
exits.

In fscache_hash_cookie(), when the same cookie is found in the hash list,
if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then the new
cookie waits for the old cookie to be unhashed, while the old cookie is
waiting for the leaked fd to be closed, if the daemon does not exit in time
it will trigger a hung task.

To avoid this, allocate a new anonymous fd only if no anonymous fd has
been allocated (ondemand_id == 0) or if the previously allocated anonymous
fd has been closed (ondemand_id == -1). Moreover, returns an error if
ondemand_id is valid, letting the daemon know that the current userland
restore logic is abnormal and needs to be checked.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d04ddc6576e3..d2d4e27fca6f 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
-	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_ondemand_info *info = object->ondemand;
+	struct cachefiles_cache *cache;
+	struct cachefiles_ondemand_info *info;
 	int object_id;
 	struct cachefiles_req *req;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, NULL, 0);
+
+	if (!object)
+		return 0;
+
+	info = object->ondemand;
+	cache = object->volume->cache;
+	xas.xa = &cache->reqs;
 
 	xa_lock(&cache->reqs);
 	spin_lock(&info->lock);
@@ -288,22 +295,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 		goto err_put_fd;
 	}
 
+	spin_lock(&object->ondemand->lock);
+	if (object->ondemand->ondemand_id > 0) {
+		spin_unlock(&object->ondemand->lock);
+		/* Pair with check in cachefiles_ondemand_fd_release(). */
+		file->private_data = NULL;
+		ret = -EEXIST;
+		goto err_put_file;
+	}
+
 	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 	fd_install(fd, file);
 
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	object->ondemand->ondemand_id = object_id;
+	spin_unlock(&object->ondemand->lock);
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
 	return 0;
 
+err_put_file:
+	fput(file);
 err_put_fd:
 	put_unused_fd(fd);
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
+	spin_lock(&object->ondemand->lock);
+	/* Avoid marking an opened object as closed. */
+	if (object->ondemand->ondemand_id <= 0)
+		cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&object->ondemand->lock);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return ret;
 }
@@ -386,10 +410,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
-		if (ret) {
-			cachefiles_ondemand_set_object_close(req->object);
+		if (ret)
 			goto out;
-		}
 	}
 
 	msg->msg_id = xas.xa_index;
-- 
2.39.2

