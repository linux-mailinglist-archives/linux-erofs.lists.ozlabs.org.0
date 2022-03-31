Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0F4ED8CF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 13:58:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KThds33Bqz308M
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 22:58:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KThdd1cFZz2yRK
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Mar 2022 22:58:12 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R951e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8iqyDb_1648727879; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8iqyDb_1648727879) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 31 Mar 2022 19:58:00 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 04/19] cachefiles: implement on-demand read
Date: Thu, 31 Mar 2022 19:57:38 +0800
Message-Id: <20220331115753.89431-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the data plane of on-demand read mode.

A new NETFS_READ_HOLE_ONDEMAND flag is introduced to indicate that
on-demand read should be done when a cache miss encountered. In this
case, the read routine will send a READ request to user daemon, along
with the anonymous fd and the file range that shall be read. Now user
daemon is responsible for fetching data in the given file range, and
then writing the fetched data into cache file with the given anonymous
fd.

After sending the READ request, the read routine will hang there, until
the READ request is handled by user daemon. Then it will retry to read
from the same file range. If a cache miss is encountered again on the
same file range, the read routine will fail then.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h        |  9 ++++
 fs/cachefiles/io.c              | 11 +++++
 fs/cachefiles/ondemand.c        | 81 +++++++++++++++++++++++++++++++++
 include/linux/netfs.h           |  1 +
 include/uapi/linux/cachefiles.h | 13 ++++++
 5 files changed, 115 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 8a397d4da560..b4a834671b6b 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -281,6 +281,9 @@ extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
+extern int cachefiles_ondemand_read(struct cachefiles_object *object,
+				    loff_t pos, size_t len);
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -296,6 +299,12 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
 static inline void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
 }
+
+static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
+					   loff_t pos, size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 7c3037afae63..c8f43c51f9d6 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -95,6 +95,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
+retry:
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
 	 */
@@ -119,6 +120,16 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			if (read_hole == NETFS_READ_HOLE_FAIL)
 				goto presubmission_error;
 
+			if (read_hole == NETFS_READ_HOLE_ONDEMAND) {
+				ret = cachefiles_ondemand_read(object, off, len);
+				if (ret)
+					goto presubmission_error;
+
+				/* fail the read if no progress achieved */
+				read_hole = NETFS_READ_HOLE_FAIL;
+				goto retry;
+			}
+
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 8cbfba057616..4f07a7584f7c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -11,13 +11,30 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
 
+	xa_lock(xa);
 	/*
 	 * Uninstall anon_fd to the cachefiles object, so that no further
 	 * associated requests will get enqueued.
 	 */
 	object->fd = -1;
 
+	/*
+	 * Flush all pending READ requests since their completion depends on
+	 * anon_fd.
+	 */
+	xa_for_each(xa, index, req) {
+		if (req->msg.opcode == CACHEFILES_OP_READ) {
+			req->error = -EIO;
+			complete(&req->done);
+		}
+	}
+	xa_unlock(xa);
+
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return 0;
 }
@@ -61,11 +78,35 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 	return vfs_llseek(file, pos, whence);
 }
 
+static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
+					 unsigned long arg)
+{
+	struct cachefiles_object *object = filp->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	unsigned long id;
+
+	if (ioctl != CACHEFILES_IOC_CREAD)
+		return -EINVAL;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	id = arg;
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+	return 0;
+}
+
 static const struct file_operations cachefiles_ondemand_fd_fops = {
 	.owner		= THIS_MODULE,
 	.release	= cachefiles_ondemand_fd_release,
 	.write_iter	= cachefiles_ondemand_fd_write_iter,
 	.llseek		= cachefiles_ondemand_fd_llseek,
+	.unlocked_ioctl	= cachefiles_ondemand_fd_ioctl,
 };
 
 /*
@@ -279,6 +320,13 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 			goto out;
 		}
 
+		/* recheck anon_fd for READ request with lock held */
+		if (opcode == CACHEFILES_OP_READ && object->fd == -1) {
+			xas_unlock(&xas);
+			ret = -EIO;
+			goto out;
+		}
+
 		xas.xa_index = 0;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
 		if (xas.xa_node == XAS_RESTART)
@@ -358,6 +406,28 @@ static int init_close_req(struct cachefiles_req *req, void *private)
 	return 0;
 }
 
+struct cachefiles_read_ctx {
+	loff_t off;
+	size_t len;
+};
+
+static int init_read_req(struct cachefiles_req *req, void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct cachefiles_read *load = (void *)&req->msg.data;
+	struct cachefiles_read_ctx *read_ctx = private;
+	int fd = object->fd;
+
+	/* Stop enqueuing request when daemon closes anon_fd prematurely. */
+	if (WARN_ON_ONCE(fd == -1))
+		return -EIO;
+
+	load->off = read_ctx->off;
+	load->len = read_ctx->len;
+	load->fd  = fd;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -390,3 +460,14 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 				     sizeof(struct cachefiles_close),
 				     init_close_req, NULL);
 }
+
+int cachefiles_ondemand_read(struct cachefiles_object *object,
+			     loff_t pos, size_t len)
+{
+	struct cachefiles_read_ctx read_ctx = {pos, len};
+
+	return cachefiles_ondemand_send_req(object,
+					    CACHEFILES_OP_READ,
+					    sizeof(struct cachefiles_read),
+					    init_read_req, &read_ctx);
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..2a9c50d3a928 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -203,6 +203,7 @@ enum netfs_read_from_hole {
 	NETFS_READ_HOLE_IGNORE,
 	NETFS_READ_HOLE_CLEAR,
 	NETFS_READ_HOLE_FAIL,
+	NETFS_READ_HOLE_ONDEMAND,
 };
 
 /*
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index dba97d284899..efd18ef6453c 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEFILES_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /*
  * Fscache ensures that the maximum length of cookie key is 255. The volume key
@@ -13,6 +14,7 @@
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
 	CACHEFILES_OP_CLOSE,
+	CACHEFILES_OP_READ,
 };
 
 /*
@@ -41,4 +43,15 @@ struct cachefiles_close {
 	__u32 fd;
 };
 
+struct cachefiles_read {
+	__u64 off;
+	__u64 len;
+	__u32 fd;
+};
+
+/*
+ * For CACHEFILES_IOC_CREAD, arg is the @id field of corresponding READ request.
+ */
+#define CACHEFILES_IOC_CREAD	_IOW(0x98, 1, int)
+
 #endif
-- 
2.27.0

