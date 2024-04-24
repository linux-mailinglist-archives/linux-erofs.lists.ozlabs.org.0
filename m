Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B38B000F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:49:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ2k0glQz3cjv
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:49:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ2F5TNxz3cDk
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:48:37 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPQ222hngz4f3knq
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1D581A016E
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S12;
	Wed, 24 Apr 2024 11:48:33 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 08/12] cachefiles: never get a new anon fd if ondemand_id is valid
Date: Wed, 24 Apr 2024 11:39:12 +0800
Message-Id: <20240424033916.2748488-9-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033916.2748488-1-libaokun@huaweicloud.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXaBELgShmKXE4Kw--.6143S12
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DJryUKF48CFyDKrW8tFb_yoW5Cw48pF
	WakF9xKryxuF4xWrZ7Aan5XryFy3ykZFnrWa4ag34rAFn0gr1rZr1Utr13ZF15A3sIgrsr
	ta1UWF9xtw1qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now every time the daemon reads an open request, it requests a new anon fd
and ondemand_id. With the introduction of "restore", it is possible to read
the same open request more than once, and therefore have multiple anon fd's
for the same object.

To avoid this, allocate a new anon fd only if no anon fd has been allocated
(ondemand_id == 0) or if the previously allocated anon fd has been closed
(ondemand_id == -1). Returns an error if ondemand_id is valid, letting the
daemon know that the current userland restore logic is abnormal and needs
to be checked.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index b5e6a851ef04..0cf63bfedc9e 100644
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
@@ -269,22 +276,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 		goto err_put_fd;
 	}
 
+	spin_lock(&object->ondemand->lock);
+	if (object->ondemand->ondemand_id > 0) {
+		spin_unlock(&object->ondemand->lock);
+		ret = -EEXIST;
+		/* Avoid performing cachefiles_ondemand_fd_release(). */
+		file->private_data = NULL;
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
@@ -367,10 +391,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
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

