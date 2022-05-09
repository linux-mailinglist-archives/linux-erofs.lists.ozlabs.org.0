Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51451F567
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:40:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY4k3Lv2z3c9b
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:40:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4c428fz3cBR
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:40:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCggc9B_1652082039; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCggc9B_1652082039) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:40 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 07/22] cachefiles: add tracepoints for on-demand read mode
Date: Mon,  9 May 2022 15:40:13 +0800
Message-Id: <20220509074028.74954-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add tracepoints for on-demand read mode. Currently following tracepoints
are added:

	OPEN request / COPEN reply
	CLOSE request
	READ request / CREAD reply
	write through anonymous fd
	release of anonymous fd

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/ondemand.c          |   7 ++
 include/trace/events/cachefiles.h | 174 ++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 3470d4e8f0cb..a41ae6efc545 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -30,6 +30,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	xa_unlock(&cache->reqs);
 
 	xa_erase(&cache->ondemand_ids, object_id);
+	trace_cachefiles_ondemand_fd_release(object, object_id);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	cachefiles_put_unbind_pincount(cache);
 	return 0;
@@ -55,6 +56,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 	if (ret < 0)
 		return ret;
 
+	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
 	if (!ret)
 		ret = len;
@@ -93,6 +95,7 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
 	if (!req)
 		return -EINVAL;
 
+	trace_cachefiles_ondemand_cread(object, id);
 	complete(&req->done);
 	return 0;
 }
@@ -166,6 +169,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	else
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	trace_cachefiles_ondemand_copen(req->object, id, size);
 
 out:
 	complete(&req->done);
@@ -213,6 +217,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	object->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
+	trace_cachefiles_ondemand_open(object, &req->msg, load);
 	return 0;
 
 err_put_fd:
@@ -426,6 +431,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 		return -ENOENT;
 
 	req->msg.object_id = object_id;
+	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
 
@@ -452,6 +458,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	req->msg.object_id = object_id;
 	load->off = read_ctx->off;
 	load->len = read_ctx->len;
+	trace_cachefiles_ondemand_read(object, &req->msg, load);
 	return 0;
 }
 
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 93df9391bd7f..d8d4d73fe7b6 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -673,6 +673,180 @@ TRACE_EVENT(cachefiles_io_error,
 		      __entry->error)
 	    );
 
+TRACE_EVENT(cachefiles_ondemand_open,
+	    TP_PROTO(struct cachefiles_object *obj, struct cachefiles_msg *msg,
+		     struct cachefiles_open *load),
+
+	    TP_ARGS(obj, msg, load),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj		)
+		    __field(unsigned int,	msg_id		)
+		    __field(unsigned int,	object_id	)
+		    __field(unsigned int,	fd		)
+		    __field(unsigned int,	flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->msg_id	= msg->msg_id;
+		    __entry->object_id	= msg->object_id;
+		    __entry->fd		= load->fd;
+		    __entry->flags	= load->flags;
+			   ),
+
+	    TP_printk("o=%08x mid=%x oid=%x fd=%d f=%x",
+		      __entry->obj,
+		      __entry->msg_id,
+		      __entry->object_id,
+		      __entry->fd,
+		      __entry->flags)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_copen,
+	    TP_PROTO(struct cachefiles_object *obj, unsigned int msg_id,
+		     long len),
+
+	    TP_ARGS(obj, msg_id, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj	)
+		    __field(unsigned int,	msg_id	)
+		    __field(long,		len	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->msg_id	= msg_id;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x mid=%x l=%lx",
+		      __entry->obj,
+		      __entry->msg_id,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_close,
+	    TP_PROTO(struct cachefiles_object *obj, struct cachefiles_msg *msg),
+
+	    TP_ARGS(obj, msg),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj		)
+		    __field(unsigned int,	msg_id		)
+		    __field(unsigned int,	object_id	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->msg_id	= msg->msg_id;
+		    __entry->object_id	= msg->object_id;
+			   ),
+
+	    TP_printk("o=%08x mid=%x oid=%x",
+		      __entry->obj,
+		      __entry->msg_id,
+		      __entry->object_id)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_read,
+	    TP_PROTO(struct cachefiles_object *obj, struct cachefiles_msg *msg,
+		     struct cachefiles_read *load),
+
+	    TP_ARGS(obj, msg, load),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj		)
+		    __field(unsigned int,	msg_id		)
+		    __field(unsigned int,	object_id	)
+		    __field(loff_t,		start		)
+		    __field(size_t,		len		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->msg_id	= msg->msg_id;
+		    __entry->object_id	= msg->object_id;
+		    __entry->start	= load->off;
+		    __entry->len	= load->len;
+			   ),
+
+	    TP_printk("o=%08x mid=%x oid=%x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->msg_id,
+		      __entry->object_id,
+		      __entry->start,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_cread,
+	    TP_PROTO(struct cachefiles_object *obj, unsigned int msg_id),
+
+	    TP_ARGS(obj, msg_id),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj	)
+		    __field(unsigned int,	msg_id	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->msg_id	= msg_id;
+			   ),
+
+	    TP_printk("o=%08x mid=%x",
+		      __entry->obj,
+		      __entry->msg_id)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_fd_write,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     loff_t start, size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj	)
+		    __field(unsigned int,	backer	)
+		    __field(loff_t,		start	)
+		    __field(size_t,		len	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->backer	= backer->i_ino;
+		    __entry->start	= start;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x iB=%x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_ondemand_fd_release,
+	    TP_PROTO(struct cachefiles_object *obj, int object_id),
+
+	    TP_ARGS(obj, object_id),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	obj		)
+		    __field(unsigned int,	object_id	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->object_id	= object_id;
+			   ),
+
+	    TP_printk("o=%08x oid=%x",
+		      __entry->obj,
+		      __entry->object_id)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */
-- 
2.27.0

