Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057A50DFE1
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 14:22:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kn3zj1lHBz3bgR
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 22:22:09 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kn3zT526Mz309l
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Apr 2022 22:21:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R661e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VBE4bDb_1650889307; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VBE4bDb_1650889307) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Apr 2022 20:21:48 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v10 02/21] cachefiles: notify the user daemon when looking up
 cookie
Date: Mon, 25 Apr 2022 20:21:24 +0800
Message-Id: <20220425122143.56815-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
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
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fscache/CacheFiles used to serve as a local cache for a remote
networking fs. A new on-demand read mode will be introduced for
CacheFiles, which can boost the scenario where on-demand read semantics
are needed, e.g. container image distribution.

The essential difference between these two modes is seen when a cache
miss occurs: In the original mode, the netfs will fetch the data from
the remote server and then write it to the cache file; in on-demand
read mode, fetching the data and writing it into the cache is delegated
to a user daemon.

As the first step, notify the user daemon when looking up cookie. In
this case, an anonymous fd is sent to the user daemon, through which the
user daemon can write the fetched data to the cache file. Since the user
daemon may move the anonymous fd around, e.g. through dup(), an object
ID uniquely identifying the cache file is also attached.

Also add one advisory flag (FSCACHE_ADV_WANT_CACHE_SIZE) suggesting that
the cache file size shall be retrieved at runtime. This helps the
scenario where one cache file contains multiple netfs files, e.g. for
the purpose of deduplication. In this case, netfs itself has no idea the
size of the cache file, whilst the user daemon should give the hint on
it.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig             |  12 +
 fs/cachefiles/Makefile            |   1 +
 fs/cachefiles/daemon.c            |  81 ++++++-
 fs/cachefiles/internal.h          |  51 ++++
 fs/cachefiles/namei.c             |  16 +-
 fs/cachefiles/ondemand.c          | 378 ++++++++++++++++++++++++++++++
 include/linux/fscache.h           |   1 +
 include/trace/events/cachefiles.h |   2 +
 include/uapi/linux/cachefiles.h   |  50 ++++
 9 files changed, 577 insertions(+), 15 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 include/uapi/linux/cachefiles.h

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 719faeeda168..8df715640a48 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -26,3 +26,15 @@ config CACHEFILES_ERROR_INJECTION
 	help
 	  This permits error injection to be enabled in cachefiles whilst a
 	  cache is in service.
+
+config CACHEFILES_ONDEMAND
+	bool "Support for on-demand read"
+	depends on CACHEFILES
+	default n
+	help
+	  This permits userspace to enable the cachefiles on-demand read mode.
+	  In this mode, when a cache miss occurs, responsibility for fetching
+	  the data lies with the cachefiles backend instead of with the netfs
+	  and is delegated to userspace.
+
+	  If unsure, say N.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 16d811f1a2fa..c37a7a9af10b 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -16,5 +16,6 @@ cachefiles-y := \
 	xattr.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
+cachefiles-$(CONFIG_CACHEFILES_ONDEMAND) += ondemand.o
 
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..d5417da7f792 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -75,6 +75,9 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "inuse",	cachefiles_daemon_inuse		},
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	{ "copen",	cachefiles_ondemand_copen	},
+#endif
 	{ "",		NULL				}
 };
 
@@ -108,6 +111,8 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
+	xa_init_flags(&cache->ondemand_ids, XA_FLAGS_ALLOC1);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -126,6 +131,39 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
+{
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
+
+	/*
+	 * Make sure the following two operations won't be reordered.
+	 *   1) set CACHEFILES_DEAD bit
+	 *   2) flush requests in the xarray
+	 * Otherwise the request may be enqueued after xarray has been
+	 * flushed, leaving the orphan request never being completed.
+	 *
+	 * CPU 1			CPU 2
+	 * =====			=====
+	 * flush requests in the xarray
+	 *				test CACHEFILES_DEAD bit
+	 *				enqueue the request
+	 * set CACHEFILES_DEAD bit
+	 */
+	smp_mb();
+
+	xa_lock(xa);
+	xa_for_each(xa, index, req) {
+		req->error = -EIO;
+		complete(&req->done);
+	}
+	xa_unlock(xa);
+
+	xa_destroy(&cache->reqs);
+	xa_destroy(&cache->ondemand_ids);
+}
+
 /*
  * Release a cache.
  */
@@ -139,6 +177,8 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	set_bit(CACHEFILES_DEAD, &cache->flags);
 
+	if (cachefiles_in_ondemand_mode(cache))
+		cachefiles_flush_reqs(cache);
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
@@ -152,23 +192,14 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/*
- * Read the cache state.
- */
-static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
-				      size_t buflen, loff_t *pos)
+static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
+					 char __user *_buffer, size_t buflen)
 {
-	struct cachefiles_cache *cache = file->private_data;
 	unsigned long long b_released;
 	unsigned f_released;
 	char buffer[256];
 	int n;
 
-	//_enter(",,%zu,", buflen);
-
-	if (!test_bit(CACHEFILES_READY, &cache->flags))
-		return 0;
-
 	/* check how much space the cache has */
 	cachefiles_has_space(cache, 0, 0, cachefiles_has_space_check);
 
@@ -206,6 +237,25 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 	return n;
 }
 
+/*
+ * Read the cache state.
+ */
+static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
+				      size_t buflen, loff_t *pos)
+{
+	struct cachefiles_cache *cache = file->private_data;
+
+	//_enter(",,%zu,", buflen);
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	if (cachefiles_in_ondemand_mode(cache))
+		return cachefiles_ondemand_daemon_read(cache, _buffer, buflen);
+	else
+		return cachefiles_do_daemon_read(cache, _buffer, buflen);
+}
+
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
@@ -297,8 +347,13 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
-	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-		mask |= EPOLLIN;
+	if (cachefiles_in_ondemand_mode(cache)) {
+		if (!xa_empty(&cache->reqs))
+			mask |= EPOLLIN;
+	} else {
+		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
+			mask |= EPOLLIN;
+	}
 
 	if (test_bit(CACHEFILES_CULLING, &cache->flags))
 		mask |= EPOLLOUT;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e80673d0ab97..4f5150a96849 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,8 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/xarray.h>
+#include <linux/cachefiles.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -58,8 +60,13 @@ struct cachefiles_object {
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	int				ondemand_id;
+#endif
 };
 
+#define CACHEFILES_ONDEMAND_ID_CLOSED	-1
+
 /*
  * Cache files cache definition
  */
@@ -98,11 +105,30 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+	struct xarray			reqs;		/* xarray of pending on-demand requests */
+	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
+	u32				ondemand_id_next;
 };
 
+static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
+{
+	return IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+		test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+}
+
+struct cachefiles_req {
+	struct cachefiles_object *object;
+	struct completion done;
+	int error;
+	struct cachefiles_msg msg;
+};
+
+#define CACHEFILES_REQ_NEW	XA_MARK_1
+
 #include <trace/events/cachefiles.h>
 
 static inline
@@ -250,6 +276,31 @@ extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
 extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 				      struct cachefiles_object *object);
 
+/*
+ * ondemand.c
+ */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen);
+
+extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
+				     char *args);
+
+extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+
+#else
+static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	return 0;
+}
+#endif
+
 /*
  * security.c
  */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ca9f3e4ec4b3..facf2ebe464b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -452,10 +452,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
 	struct path path;
-	uint64_t ni_size = object->cookie->object_size;
+	uint64_t ni_size;
 	long ret;
 
-	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
@@ -481,6 +480,15 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		goto out_dput;
 	}
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0) {
+		file = ERR_PTR(ret);
+		goto out_unuse;
+	}
+
+	ni_size = object->cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
+
 	if (ni_size > 0) {
 		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
@@ -586,6 +594,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0)
+		goto error_fput;
+
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)
 		goto check_failed;
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
new file mode 100644
index 000000000000..64fc312b16d3
--- /dev/null
+++ b/fs/cachefiles/ondemand.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/fdtable.h>
+#include <linux/anon_inodes.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+static int cachefiles_ondemand_fd_release(struct inode *inode,
+					  struct file *file)
+{
+	struct cachefiles_object *object = file->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	int object_id = object->ondemand_id;
+
+	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	xa_erase(&cache->ondemand_ids, object_id);
+	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+	return 0;
+}
+
+static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
+						 struct iov_iter *iter)
+{
+	struct cachefiles_object *object = kiocb->ki_filp->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct file *file = object->file;
+	size_t len = iter->count;
+	loff_t pos = kiocb->ki_pos;
+	const struct cred *saved_cred;
+	int ret;
+
+	if (!file)
+		return -ENOBUFS;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
+	cachefiles_end_secure(cache, saved_cred);
+	if (ret < 0)
+		return ret;
+
+	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
+	if (!ret)
+		ret = len;
+
+	return ret;
+}
+
+static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
+					    int whence)
+{
+	struct cachefiles_object *object = filp->private_data;
+	struct file *file = object->file;
+
+	if (!file)
+		return -ENOBUFS;
+
+	return vfs_llseek(file, pos, whence);
+}
+
+static const struct file_operations cachefiles_ondemand_fd_fops = {
+	.owner		= THIS_MODULE,
+	.release	= cachefiles_ondemand_fd_release,
+	.write_iter	= cachefiles_ondemand_fd_write_iter,
+	.llseek		= cachefiles_ondemand_fd_llseek,
+};
+
+/*
+ * OPEN request Completion (copen)
+ * - command: "copen <id>,<cache_size>"
+ *   <cache_size> indicates the object size if >=0, error code if negative
+ */
+int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	struct fscache_cookie *cookie;
+	char *pid, *psize;
+	unsigned long id;
+	long size;
+	int ret;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (!*args) {
+		pr_err("Empty id specified\n");
+		return -EINVAL;
+	}
+
+	pid = args;
+	psize = strchr(args, ',');
+	if (!psize) {
+		pr_err("Cache size is not specified\n");
+		return -EINVAL;
+	}
+
+	*psize = 0;
+	psize++;
+
+	ret = kstrtoul(pid, 0, &id);
+	if (ret)
+		return ret;
+
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	/* fail OPEN request if copen format is invalid */
+	ret = kstrtol(psize, 0, &size);
+	if (ret) {
+		req->error = ret;
+		goto out;
+	}
+
+	/* fail OPEN request if daemon reports an error */
+	if (size < 0) {
+		if (!IS_ERR_VALUE(size))
+			size = -EINVAL;
+		req->error = size;
+		goto out;
+	}
+
+	cookie = req->object->cookie;
+	cookie->object_size = size;
+	if (size)
+		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	else
+		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+
+out:
+	complete(&req->done);
+	return ret;
+}
+
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_open *load;
+	struct file *file;
+	u32 object_id;
+	int ret, fd;
+
+	object = cachefiles_grab_object(req->object,
+			cachefiles_obj_get_ondemand_fd);
+	cache = object->volume->cache;
+
+	ret = xa_alloc_cyclic(&cache->ondemand_ids, &object_id, NULL,
+			      XA_LIMIT(1, INT_MAX),
+			      &cache->ondemand_id_next, GFP_KERNEL);
+	if (ret < 0)
+		goto err;
+
+	fd = get_unused_fd_flags(O_WRONLY);
+	if (fd < 0) {
+		ret = fd;
+		goto err_free_id;
+	}
+
+	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
+				  object, O_WRONLY);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
+	fd_install(fd, file);
+
+	load = (void *)req->msg.data;
+	load->fd = fd;
+	req->msg.object_id = object_id;
+	object->ondemand_id = object_id;
+	return 0;
+
+err_put_fd:
+	put_unused_fd(fd);
+err_free_id:
+	xa_erase(&cache->ondemand_ids, object_id);
+err:
+	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+	return ret;
+}
+
+ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_msg *msg;
+	unsigned long id = 0;
+	size_t n;
+	int ret = 0;
+	XA_STATE(xas, &cache->reqs, 0);
+
+	/*
+	 * Search for a request that has not ever been processed, to prevent
+	 * requests from being processed repeatedly.
+	 */
+	xa_lock(&cache->reqs);
+	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	if (!req) {
+		xa_unlock(&cache->reqs);
+		return 0;
+	}
+
+	msg = &req->msg;
+	n = msg->len;
+
+	if (n > buflen) {
+		xa_unlock(&cache->reqs);
+		return -EMSGSIZE;
+	}
+
+	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
+	xa_unlock(&cache->reqs);
+
+	id = xas.xa_index;
+	msg->msg_id = id;
+
+	if (msg->opcode == CACHEFILES_OP_OPEN) {
+		ret = cachefiles_ondemand_get_fd(req);
+		if (ret)
+			goto error;
+	}
+
+	if (copy_to_user(_buffer, msg, n) != 0) {
+		ret = -EFAULT;
+		goto err_put_fd;
+	}
+
+	return n;
+
+err_put_fd:
+	if (msg->opcode == CACHEFILES_OP_OPEN)
+		close_fd(((struct cachefiles_open *)msg->data)->fd);
+error:
+	xa_erase(&cache->reqs, id);
+	req->error = ret;
+	complete(&req->done);
+	return ret;
+}
+
+typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
+
+static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
+					enum cachefiles_opcode opcode,
+					size_t data_len,
+					init_req_fn init_req,
+					void *private)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	XA_STATE(xas, &cache->reqs, 0);
+	int ret;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return 0;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->object = object;
+	init_completion(&req->done);
+	req->msg.opcode = opcode;
+	req->msg.len = sizeof(struct cachefiles_msg) + data_len;
+
+	ret = init_req(req, private);
+	if (ret)
+		goto out;
+
+	do {
+		/*
+		 * Stop enqueuing the request when daemon is dying. The
+		 * following two operations need to be atomic as a whole.
+		 *   1) check cache state, and
+		 *   2) enqueue request if cache is alive.
+		 * Otherwise the request may be enqueued after xarray has been
+		 * flushed, leaving the orphan request never being completed.
+		 *
+		 * CPU 1			CPU 2
+		 * =====			=====
+		 *				test CACHEFILES_DEAD bit
+		 * set CACHEFILES_DEAD bit
+		 * flush requests in the xarray
+		 *				enqueue the request
+		 */
+		xas_lock(&xas);
+
+		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+			xas_unlock(&xas);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* coupled with the barrier in cachefiles_flush_reqs() */
+		smp_mb();
+
+		xas.xa_index = 0;
+		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART)
+			xas_set_err(&xas, -EBUSY);
+		xas_store(&xas, req);
+		xas_clear_mark(&xas, XA_FREE_MARK);
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	ret = xas_error(&xas);
+	if (ret)
+		goto out;
+
+	wake_up_all(&cache->daemon_pollwq);
+	wait_for_completion(&req->done);
+	ret = req->error;
+out:
+	kfree(req);
+	return ret;
+}
+
+static int cachefiles_ondemand_init_open_req(struct cachefiles_req *req,
+					     void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_volume *volume = object->volume->vcookie;
+	struct cachefiles_open *load = (void *)req->msg.data;
+	size_t volume_key_size, cookie_key_size;
+	void *volume_key, *cookie_key;
+
+	/*
+	 * Volume key is a NUL-terminated string. key[0] stores strlen() of the
+	 * string, followed by the content of the string (excluding '\0').
+	 */
+	volume_key_size = volume->key[0] + 1;
+	volume_key = volume->key + 1;
+
+	/* Cookie key is binary data, which is netfs specific. */
+	cookie_key_size = cookie->key_len;
+	cookie_key = fscache_get_key(cookie);
+
+	if (!(object->cookie->advice & FSCACHE_ADV_WANT_CACHE_SIZE)) {
+		pr_err("WANT_CACHE_SIZE is needed for on-demand mode\n");
+		return -EINVAL;
+	}
+
+	load->volume_key_size = volume_key_size;
+	load->cookie_key_size = cookie_key_size;
+	memcpy(load->data, volume_key, volume_key_size);
+	memcpy(load->data + volume_key_size, cookie_key, cookie_key_size);
+
+	return 0;
+}
+
+int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_volume *volume = object->volume->vcookie;
+	size_t volume_key_size, cookie_key_size, data_len;
+
+	/*
+	 * CacheFiles will firstly check the cache file under the root cache
+	 * directory. If the coherency check failed, it will fallback to
+	 * creating a new tmpfile as the cache file. Reuse the previously
+	 * allocated object ID if any.
+	 */
+	if (object->ondemand_id > 0)
+		return 0;
+
+	volume_key_size = volume->key[0] + 1;
+	cookie_key_size = cookie->key_len;
+	data_len = sizeof(struct cachefiles_open) +
+		   volume_key_size + cookie_key_size;
+
+	return cachefiles_ondemand_send_req(object, CACHEFILES_OP_OPEN,
+			data_len, cachefiles_ondemand_init_open_req, NULL);
+}
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index e25539072463..72585c9729a2 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -39,6 +39,7 @@ struct fscache_cookie;
 #define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
+#define FSCACHE_ADV_WANT_CACHE_SIZE	0x04 /* Retrieve cache size at runtime */
 
 #define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
 
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 311c14a20e70..93df9391bd7f 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -31,6 +31,8 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_see_lookup_failed,
 	cachefiles_obj_see_withdraw_cookie,
 	cachefiles_obj_see_withdrawal,
+	cachefiles_obj_get_ondemand_fd,
+	cachefiles_obj_put_ondemand_fd,
 };
 
 enum fscache_why_object_killed {
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
new file mode 100644
index 000000000000..521f2fe4fe9c
--- /dev/null
+++ b/include/uapi/linux/cachefiles.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_CACHEFILES_H
+#define _LINUX_CACHEFILES_H
+
+#include <linux/types.h>
+
+/*
+ * Fscache ensures that the maximum length of cookie key is 255. The volume key
+ * is controlled by netfs, and generally no bigger than 255.
+ */
+#define CACHEFILES_MSG_MAX_SIZE	1024
+
+enum cachefiles_opcode {
+	CACHEFILES_OP_OPEN,
+};
+
+/*
+ * Message Header
+ *
+ * @msg_id	a unique ID identifying this message
+ * @opcode	message type, CACHEFILE_OP_*
+ * @len		message length, including message header and following data
+ * @object_id	a unique ID identifying a cache file
+ * @data	message type specific payload
+ */
+struct cachefiles_msg {
+	__u32 msg_id;
+	__u32 opcode;
+	__u32 len;
+	__u32 object_id;
+	__u8  data[];
+};
+
+/*
+ * @data contains the volume_key followed directly by the cookie_key. volume_key
+ * is a NUL-terminated string; @volume_key_size indicates the size of the volume
+ * key in bytes. cookie_key is binary data, which is netfs specific;
+ * @cookie_key_size indicates the size of the cookie key in bytes.
+ *
+ * @fd identifies an anon_fd referring to the cache file.
+ */
+struct cachefiles_open {
+	__u32 volume_key_size;
+	__u32 cookie_key_size;
+	__u32 fd;
+	__u32 flags;
+	__u8  data[];
+};
+
+#endif
-- 
2.27.0

