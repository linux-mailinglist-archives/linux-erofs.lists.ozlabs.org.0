Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC447FD24
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 14:00:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMySV2K8sz2yph
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 00:00:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMySR2htnz2x9B
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 00:00:07 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.w7GWF_1640609687; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.w7GWF_1640609687) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:48 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 03/23] cachefiles: detect backing file size in demand-read
 mode
Date: Mon, 27 Dec 2021 20:54:24 +0800
Message-Id: <20211227125444.21187-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When upper read-only fs uses fscache for demand reading, it has no idea
on the size of the backed file. (You need to input the file size as the
@object_size parameter when calling fscache_acquire_cookie().)

In this using scenario, user daemon is responsible for preparing all
backing files with correct file size (though they can be all sparse
files), and the upper fs shall guarantee that past EOF access will never
happen.

Then with this precondition, cachefiles can detect the actual size of
backing file, and set it as the size of backed file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/namei.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 074722c21522..54123b2693cd 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -511,9 +511,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
  */
 static bool cachefiles_create_file(struct cachefiles_object *object)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file;
 	int ret;
 
+	/*
+	 * Demand read mode requires that backing files have been prepared with
+	 * correct file size under corresponding directory. We can get here when
+	 * the backing file doesn't exist under corresponding directory, or the
+	 * file size is unexpected 0.
+	 */
+	if (test_bit(CACHEFILES_DEMAND_MODE, &cache->flags))
+		return false;
+
 	ret = cachefiles_has_space(object->volume->cache, 1, 0,
 				   cachefiles_has_space_for_create);
 	if (ret < 0)
@@ -530,6 +540,32 @@ static bool cachefiles_create_file(struct cachefiles_object *object)
 	return true;
 }
 
+/*
+ * Fs using fscache for demand reading may have no idea of the file size of
+ * backing files. Thus the demand read mode requires that backing files have
+ * been prepared with correct file size under corresponding directory. Then
+ * fscache backend is responsible for taking the file size of the backing file
+ * as the object size.
+ */
+static int cachefiles_recheck_size(struct cachefiles_object *object,
+				   struct file *file)
+{
+	loff_t size;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	if (!test_bit(CACHEFILES_DEMAND_MODE, &cache->flags))
+		return 0;
+
+	size = i_size_read(file_inode(file));
+	if (size) {
+		object->cookie->object_size = size;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+
+}
+
 /*
  * Open an existing file, checking its attributes and replacing it if it is
  * stale.
@@ -569,6 +605,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
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

