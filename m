Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBE4AE9B3
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:01:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5C6Wtvz2ybK
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:01:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq4y2SM7z2ybK
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zaQQi_1644386471; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zaQQi_1644386471) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:11 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 02/22] fscache: add a method to support on-demand read
 semantics
Date: Wed,  9 Feb 2022 14:00:48 +0800
Message-Id: <20220209060108.43051-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add .ondemand_read() callback to netfs_cache_ops to implement on-demand
read.

The precondition for implementing on-demand read semantics is that,
all blob files have been placed under corresponding directory with
correct file size (sparse files) on the first beginning. When upper fs
starts to access the blob file, it will "cache miss" (hit the hole).
Then .ondemand_read() callback can be called to notify backend to
prepare the data.

The implementation of .ondemand_read() callback can be backend specific.
The following patch will introduce the implementation for cachefiles,
which will notify user daemon the requested file range to read. The
.ondemand_read() callback will get blocked until the user daemon has
prepared the corresponding data.

Then once .ondemand_read() callback returns with 0, it is guaranteed
that the requested data has been ready. In this case, users can retry to
read from the backing file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/netfs_library.rst | 18 +++++++++++++++
 include/linux/fscache.h                     | 25 +++++++++++++++++++++
 include/linux/netfs.h                       |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..e544d6688100 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -466,6 +466,8 @@ operation table looks like the following::
 		int (*query_occupancy)(struct netfs_cache_resources *cres,
 				       loff_t start, size_t len, size_t granularity,
 				       loff_t *_data_start, size_t *_data_len);
+		int (*ondemand_read)(struct netfs_cache_resources *cres,
+				     loff_t start_pos, size_t len);
 	};
 
 With a termination handler function pointer::
@@ -552,6 +554,22 @@ The methods defined in the table are:
    It returns 0 if some data was found, -ENODATA if there was no usable data
    within the region or -ENOBUFS if there is no caching on this file.
 
+ * ``ondemand_read()``
+
+   [Optional] Called to make cache prepare for the data. It shall be called only
+   when on-demand read semantics is required. It will be called when a cache
+   miss is encountered. The function will make the backend somehow prepare for
+   the data in the region specified by @start_pos/@len of the cache file. It may
+   get blocked until the backend has prepared the data in the cache file
+   successfully, or error encountered.
+
+   Once it returns with 0, it is guaranteed that the requested data has been
+   ready in the cache file. In this case, users can retry to read from the cache
+   file.
+
+   It returns 0 if data has been ready in the cache file, or other error code
+   from the cache, such as -ENOMEM.
+
 Note that these methods are passed a pointer to the cache resource structure,
 not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index d2430da8aa67..efcd5d5c6726 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -514,6 +514,31 @@ int fscache_read(struct netfs_cache_resources *cres,
 			 term_func, term_func_priv);
 }
 
+/**
+ * fscache_ondemand_read - Make cache prepare for the data.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @len: The length of the file offset range in the cache file
+ *
+ * This shall only be called when a cache miss is encountered. It will make
+ * the backend somehow prepare for the data in the file offset range specified
+ * by @start_pos/@len of the cache file. It may get blocked until the backend
+ * has prepared the data in the cache file successfully, or error encountered.
+ *
+ * Returns:
+ * * 0		- Success (Data is ready in the cache file)
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_ondemand_read(struct netfs_cache_resources *cres,
+			  loff_t start_pos, size_t len)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	if (ops->ondemand_read)
+		return ops->ondemand_read(cres, start_pos, len);
+	return -EOPNOTSUPP;
+}
+
 /**
  * fscache_begin_write_operation - Begin a write operation for the netfs lib
  * @cres: The cache resources for the write being performed
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..81fe707ad38d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -251,6 +251,10 @@ struct netfs_cache_ops {
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
 			       loff_t start, size_t len, size_t granularity,
 			       loff_t *_data_start, size_t *_data_len);
+
+	/* Make cache prepare for the data */
+	int (*ondemand_read)(struct netfs_cache_resources *cres,
+			     loff_t start_pos, size_t len);
 };
 
 struct readahead_control;
-- 
2.27.0

