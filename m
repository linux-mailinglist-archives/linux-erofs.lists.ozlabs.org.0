Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F11634DB0F7
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 14:18:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJW6b6bk7z30jZ
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 00:17:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJW6J27PXz30J6
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 00:17:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R511e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7N1EXY_1647436652; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7N1EXY_1647436652) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 21:17:33 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 06/22] cachefiles: implement on-demand read
Date: Wed, 16 Mar 2022 21:17:07 +0800
Message-Id: <20220316131723.111553-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
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
 fs/cachefiles/daemon.c          | 65 +++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h        |  9 +++++
 fs/cachefiles/io.c              | 11 ++++++
 include/linux/netfs.h           |  1 +
 include/uapi/linux/cachefiles.h |  7 ++++
 5 files changed, 93 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 2ecfdf194206..29af8943f270 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -47,6 +47,7 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 static int cachefiles_ondemand_cinit(struct cachefiles_cache *, char *);
+static int cachefiles_ondemand_cread(struct cachefiles_cache *, char *);
 #endif
 
 static unsigned long cachefiles_open;
@@ -82,6 +83,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "cinit",	cachefiles_ondemand_cinit	},
+	{ "cread",	cachefiles_ondemand_cread	},
 #endif
 	{ "",		NULL				}
 };
@@ -264,6 +266,36 @@ static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+/*
+ * Read request completion
+ * - command: "cread <id>"
+ */
+static int cachefiles_ondemand_cread(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	unsigned long id;
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
+	ret = kstrtoul(args, 0, &id);
+	if (ret)
+		return ret;
+
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
@@ -471,6 +503,28 @@ static int init_close_req(struct cachefiles_req *req, void *private)
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
+	/* Stop enqueuig request when daemon closes anon_fd prematurely. */
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
@@ -504,6 +558,17 @@ void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object)
 				     init_close_req, NULL);
 }
 
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
+
 #else
 static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache) {}
 static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache) {}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index eaac9fae74eb..770b37e23bcc 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -168,6 +168,8 @@ extern const struct file_operations cachefiles_daemon_fops;
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object);
+extern int cachefiles_ondemand_read(struct cachefiles_object *object,
+				    loff_t pos, size_t len);
 
 #else
 static inline
@@ -178,6 +180,13 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 static inline
 void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object) {}
+
+static inline
+int cachefiles_ondemand_read(struct cachefiles_object *object,
+			     loff_t pos, size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 8dbc1eb254a3..ee1283ba7a2c 100644
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
+				if (!cachefiles_ondemand_read(object, off, len)) {
+					/* fail the read if no progress achieved */
+					read_hole = NETFS_READ_HOLE_FAIL;
+					goto retry;
+				}
+
+				goto presubmission_error;
+			}
+
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
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
index 47e53043cfad..48a0dbac9a92 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -9,6 +9,7 @@
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
 	CACHEFILES_OP_CLOSE,
+	CACHEFILES_OP_READ,
 };
 
 /*
@@ -41,4 +42,10 @@ struct cachefiles_close {
 	__u32 fd;
 };
 
+struct cachefiles_read {
+	__u64 off;
+	__u64 len;
+	__u32 fd;
+};
+
 #endif
-- 
2.27.0

