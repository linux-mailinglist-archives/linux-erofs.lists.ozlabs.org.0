Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC84AE9B7
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:01:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5G4nx8z3bcF
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:01:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq510l2hz2ywt
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zg5IE_1644386473; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zg5IE_1644386473) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:14 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 04/22] cachefiles: detect backing file size in on-demand
 read mode
Date: Wed,  9 Feb 2022 14:00:50 +0800
Message-Id: <20220209060108.43051-5-jefflexu@linux.alibaba.com>
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

Fscache/cachefiles used to serve as a local cache for remote fs. The
following patches will introduce a new use case, in which local
read-only fs could implement on-demand reading with fscache. Then in
this case, the upper read-only fs may has no idea on the size of the
backed file.

It is worth nothing that, in this scenario, user daemon is responsible
for preparing all backing files with correct file size in the first
beginning. (Backing files are all sparse files in this case). And since
it's read-only, we can get the backing file size at runtime as the
object size.

This patch also adds one flag bit to distinguish the new introduced
on-demand read mode from the original mode. The following patch will
introduce a user configures it.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig    | 13 +++++++++
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/namei.c    | 60 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 719faeeda168..cef412cfd127 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -26,3 +26,16 @@ config CACHEFILES_ERROR_INJECTION
 	help
 	  This permits error injection to be enabled in cachefiles whilst a
 	  cache is in service.
+
+config CACHEFILES_ONDEMAND
+	bool "Support for on-demand reading"
+	depends on CACHEFILES
+	default n
+	help
+	  This permits on-demand read mode of cachefiles. In this mode, when
+	  cache miss, the cachefiles backend instead of the upper fs using
+	  fscache is responsible for fetching data, e.g. through user daemon.
+	  Then after the data's ready, upper fs can reinitiate a read from the
+	  cache.
+
+	  If unsure, say N.
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1a837de7b070..8400501bbd56 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -98,6 +98,7 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7ebc29210b70..90479cb55e0a 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -510,15 +510,69 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	return file;
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static inline bool cachefiles_can_create_file(struct cachefiles_cache *cache)
+{
+	/*
+	 * On-demand read mode requires that backing files have been prepared
+	 * with correct file size under corresponding directory in the very
+	 * first begginning. We can get here when the backing file doesn't exist
+	 * under corresponding directory, or the file size is unexpected 0.
+	 */
+	return !test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+
+}
+
+/*
+ * Fs using fscache for on-demand reading may have no idea of the file size of
+ * backing files. Thus the on-demand read mode requires that backing files shall
+ * be prepared with correct file size under corresponding directory by the user
+ * daemon in the first beginning. Then the backend is responsible for taking the
+ * file size of the backing file as the object size at runtime.
+ */
+static int cachefiles_recheck_size(struct cachefiles_object *object,
+				   struct file *file)
+{
+	loff_t size;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return 0;
+
+	size = i_size_read(file_inode(file));
+	if (!size)
+		return -EINVAL;
+
+	object->cookie->object_size = size;
+	return 0;
+}
+#else
+static inline bool cachefiles_can_create_file(struct cachefiles_cache *cache)
+{
+	return true;
+}
+
+static int cachefiles_recheck_size(struct cachefiles_object *object,
+				   struct file *file)
+{
+	return 0;
+}
+#endif
+
+
 /*
  * Create a new file.
  */
 static bool cachefiles_create_file(struct cachefiles_object *object)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file;
 	int ret;
 
-	ret = cachefiles_has_space(object->volume->cache, 1, 0,
+	if (!cachefiles_can_create_file(cache))
+		return false;
+
+	ret = cachefiles_has_space(cache, 1, 0,
 				   cachefiles_has_space_for_create);
 	if (ret < 0)
 		return false;
@@ -573,6 +627,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
+	ret = cachefiles_recheck_size(object, file);
+	if (ret < 0)
+		goto check_failed;
+
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)
 		goto check_failed;
-- 
2.27.0

