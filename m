Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B24C51F569
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:40:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY4m22fzz3cGk
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:40:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.17;
 helo=out199-17.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com
 [47.90.199.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4d6MQ7z3cCF
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:40:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCfxsXb_1652082041; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCfxsXb_1652082041) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:42 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 08/22] cachefiles: document on-demand read mode
Date: Mon,  9 May 2022 15:40:14 +0800
Message-Id: <20220509074028.74954-9-jefflexu@linux.alibaba.com>
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

Document new user interface introduced by on-demand read mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 .../filesystems/caching/cachefiles.rst        | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index 8bf396b76359..fc7abf712315 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -28,6 +28,7 @@ Cache on Already Mounted Filesystem
 
  (*) Debugging.
 
+ (*) On-demand Read.
 
 
 Overview
@@ -482,3 +483,180 @@ the control file.  For example::
 	echo $((1|4|8)) >/sys/module/cachefiles/parameters/debug
 
 will turn on all function entry debugging.
+
+
+On-demand Read
+==============
+
+When working in its original mode, CacheFiles serves as a local cache for a
+remote networking fs - while in on-demand read mode, CacheFiles can boost the
+scenario where on-demand read semantics are needed, e.g. container image
+distribution.
+
+The essential difference between these two modes is seen when a cache miss
+occurs: In the original mode, the netfs will fetch the data from the remote
+server and then write it to the cache file; in on-demand read mode, fetching
+the data and writing it into the cache is delegated to a user daemon.
+
+``CONFIG_CACHEFILES_ONDEMAND`` should be enabled to support on-demand read mode.
+
+
+Protocol Communication
+----------------------
+
+The on-demand read mode uses a simple protocol for communication between kernel
+and user daemon. The protocol can be modeled as::
+
+	kernel --[request]--> user daemon --[reply]--> kernel
+
+CacheFiles will send requests to the user daemon when needed.  The user daemon
+should poll the devnode ('/dev/cachefiles') to check if there's a pending
+request to be processed.  A POLLIN event will be returned when there's a pending
+request.
+
+The user daemon then reads the devnode to fetch a request to process.  It should
+be noted that each read only gets one request. When it has finished processing
+the request, the user daemon should write the reply to the devnode.
+
+Each request starts with a message header of the form::
+
+	struct cachefiles_msg {
+		__u32 msg_id;
+		__u32 opcode;
+		__u32 len;
+		__u32 object_id;
+		__u8  data[];
+	};
+
+where:
+
+	* ``msg_id`` is a unique ID identifying this request among all pending
+	  requests.
+
+	* ``opcode`` indicates the type of this request.
+
+	* ``object_id`` is a unique ID identifying the cache file operated on.
+
+	* ``data`` indicates the payload of this request.
+
+	* ``len`` indicates the whole length of this request, including the
+	  header and following type-specific payload.
+
+
+Turning on On-demand Mode
+-------------------------
+
+An optional parameter becomes available to the "bind" command::
+
+	bind [ondemand]
+
+When the "bind" command is given no argument, it defaults to the original mode.
+When it is given the "ondemand" argument, i.e. "bind ondemand", on-demand read
+mode will be enabled.
+
+
+The OPEN Request
+----------------
+
+When the netfs opens a cache file for the first time, a request with the
+CACHEFILES_OP_OPEN opcode, a.k.a an OPEN request will be sent to the user
+daemon.  The payload format is of the form::
+
+	struct cachefiles_open {
+		__u32 volume_key_size;
+		__u32 cookie_key_size;
+		__u32 fd;
+		__u32 flags;
+		__u8  data[];
+	};
+
+where:
+
+	* ``data`` contains the volume_key followed directly by the cookie_key.
+	  The volume key is a NUL-terminated string; the cookie key is binary
+	  data.
+
+	* ``volume_key_size`` indicates the size of the volume key in bytes.
+
+	* ``cookie_key_size`` indicates the size of the cookie key in bytes.
+
+	* ``fd`` indicates an anonymous fd referring to the cache file, through
+	  which the user daemon can perform write/llseek file operations on the
+	  cache file.
+
+
+The user daemon can use the given (volume_key, cookie_key) pair to distinguish
+the requested cache file.  With the given anonymous fd, the user daemon can
+fetch the data and write it to the cache file in the background, even when
+kernel has not triggered a cache miss yet.
+
+Be noted that each cache file has a unique object_id, while it may have multiple
+anonymous fds.  The user daemon may duplicate anonymous fds from the initial
+anonymous fd indicated by the @fd field through dup().  Thus each object_id can
+be mapped to multiple anonymous fds, while the usr daemon itself needs to
+maintain the mapping.
+
+When implementing a user daemon, please be careful of RLIMIT_NOFILE,
+``/proc/sys/fs/nr_open`` and ``/proc/sys/fs/file-max``.  Typically these needn't
+be huge since they're related to the number of open device blobs rather than
+open files of each individual filesystem.
+
+The user daemon should reply the OPEN request by issuing a "copen" (complete
+open) command on the devnode::
+
+	copen <msg_id>,<cache_size>
+
+where:
+
+	* ``msg_id`` must match the msg_id field of the OPEN request.
+
+	* When >= 0, ``cache_size`` indicates the size of the cache file;
+	  when < 0, ``cache_size`` indicates any error code encountered by the
+	  user daemon.
+
+
+The CLOSE Request
+-----------------
+
+When a cookie withdrawn, a CLOSE request (opcode CACHEFILES_OP_CLOSE) will be
+sent to the user daemon.  This tells the user daemon to close all anonymous fds
+associated with the given object_id.  The CLOSE request has no extra payload,
+and shouldn't be replied.
+
+
+The READ Request
+----------------
+
+When a cache miss is encountered in on-demand read mode, CacheFiles will send a
+READ request (opcode CACHEFILES_OP_READ) to the user daemon. This tells the user
+daemon to fetch the contents of the requested file range.  The payload is of the
+form::
+
+	struct cachefiles_read {
+		__u64 off;
+		__u64 len;
+	};
+
+where:
+
+	* ``off`` indicates the starting offset of the requested file range.
+
+	* ``len`` indicates the length of the requested file range.
+
+
+When it receives a READ request, the user daemon should fetch the requested data
+and write it to the cache file identified by object_id.
+
+When it has finished processing the READ request, the user daemon should reply
+by using the CACHEFILES_IOC_READ_COMPLETE ioctl on one of the anonymous fds
+associated with the object_id given in the READ request.  The ioctl is of the
+form::
+
+	ioctl(fd, CACHEFILES_IOC_READ_COMPLETE, msg_id);
+
+where:
+
+	* ``fd`` is one of the anonymous fds associated with the object_id
+	  given.
+
+	* ``msg_id`` must match the msg_id field of the READ request.
-- 
2.27.0

