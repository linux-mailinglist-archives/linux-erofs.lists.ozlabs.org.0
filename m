Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 696E28B0010
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:49:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ2n12K8z3cLL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:49:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ2G1jWPz3cNt
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:48:38 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPQ226Tlnz4f3knv
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1D51A0175
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:48:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S13;
	Wed, 24 Apr 2024 11:48:34 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
Date: Wed, 24 Apr 2024 11:39:13 +0800
Message-Id: <20240424033916.2748488-10-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033916.2748488-1-libaokun@huaweicloud.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXaBELgShmKXE4Kw--.6143S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfGw15WryUKFWxuFyfJFb_yoWruFWfpF
	WakFy3Kry8WFW8ur97ArZ8XFyfA34kA3ZrW3s0g34rArnIgryYvr10yr98uF15Ar97Grsx
	ta1UuF93Gr1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

After installing the anonymous fd, we can now see it in userland and close
it. However, at this point we may not have gotten the reference count of
the cache, but we will put it during colse fd, so this may cause a cache
UAF.

To avoid this, we will make the anonymous fd accessible to the userland by
executing fd_install() after copy_to_user() has succeeded, and by this
point we must have already grabbed the reference count of the cache.

Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0cf63bfedc9e..7c2d43104120 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -4,6 +4,11 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+struct anon_file {
+	struct file *file;
+	int fd;
+};
+
 static inline void cachefiles_req_put(struct cachefiles_req *req)
 {
 	if (refcount_dec_and_test(&req->ref))
@@ -244,14 +249,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
 	return 0;
 }
 
-static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
+				      struct anon_file *anon_file)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_open *load;
-	struct file *file;
 	u32 object_id;
-	int ret, fd;
+	int ret;
 
 	object = cachefiles_grab_object(req->object,
 			cachefiles_obj_get_ondemand_fd);
@@ -263,16 +268,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	if (ret < 0)
 		goto err;
 
-	fd = get_unused_fd_flags(O_WRONLY);
-	if (fd < 0) {
-		ret = fd;
+	anon_file->fd = get_unused_fd_flags(O_WRONLY);
+	if (anon_file->fd < 0) {
+		ret = anon_file->fd;
 		goto err_free_id;
 	}
 
-	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
-				  object, O_WRONLY);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
+	anon_file->file = anon_inode_getfile("[cachefiles]",
+				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
+	if (IS_ERR(anon_file->file)) {
+		ret = PTR_ERR(anon_file->file);
 		goto err_put_fd;
 	}
 
@@ -281,15 +286,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 		spin_unlock(&object->ondemand->lock);
 		ret = -EEXIST;
 		/* Avoid performing cachefiles_ondemand_fd_release(). */
-		file->private_data = NULL;
+		anon_file->file->private_data = NULL;
 		goto err_put_file;
 	}
 
-	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
-	fd_install(fd, file);
+	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 
 	load = (void *)req->msg.data;
-	load->fd = fd;
+	load->fd = anon_file->fd;
 	object->ondemand->ondemand_id = object_id;
 	spin_unlock(&object->ondemand->lock);
 
@@ -298,9 +302,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	return 0;
 
 err_put_file:
-	fput(file);
+	fput(anon_file->file);
+	anon_file->file = NULL;
 err_put_fd:
-	put_unused_fd(fd);
+	put_unused_fd(anon_file->fd);
+	anon_file->fd = ret;
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
@@ -357,6 +363,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	struct cachefiles_msg *msg;
 	size_t n;
 	int ret = 0;
+	struct anon_file anon_file;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
 	xa_lock(&cache->reqs);
@@ -390,7 +397,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xa_unlock(&cache->reqs);
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
-		ret = cachefiles_ondemand_get_fd(req);
+		ret = cachefiles_ondemand_get_fd(req, &anon_file);
 		if (ret)
 			goto out;
 	}
@@ -398,10 +405,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
-	if (copy_to_user(_buffer, msg, n) != 0) {
+	if (copy_to_user(_buffer, msg, n) != 0)
 		ret = -EFAULT;
-		if (msg->opcode == CACHEFILES_OP_OPEN)
-			close_fd(((struct cachefiles_open *)msg->data)->fd);
+
+	if (msg->opcode == CACHEFILES_OP_OPEN) {
+		if (ret < 0) {
+			fput(anon_file.file);
+			put_unused_fd(anon_file.fd);
+			goto out;
+		}
+		fd_install(anon_file.fd, anon_file.file);
 	}
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-- 
2.39.2

