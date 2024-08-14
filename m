Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F99523AD
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:42:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9uD5VJH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9uD5VJH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkgD20XCdz2yPq
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:42:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9uD5VJH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9uD5VJH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkgCy5ybKz2ykt
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:42:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFw+oU47qKVQiA+0YFU3Ycf5Gk6FAGXhwuof46YCCg=;
	b=Y9uD5VJHrbVx9LTSPzy8ObWADZx2MNcgZ+6mLxHe6sfnVINVL/62yHfuCJqLUrAeQiR7MD
	4UwIyBbiWlaDPWLMW0Tstn2COVtA+J19/7MweX2o4NVuk6WmKAZ2sK+9u1SZW1Lvt85z88
	z1DkwIyDJsrTfs2diThqdpxCa2lJA0o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFw+oU47qKVQiA+0YFU3Ycf5Gk6FAGXhwuof46YCCg=;
	b=Y9uD5VJHrbVx9LTSPzy8ObWADZx2MNcgZ+6mLxHe6sfnVINVL/62yHfuCJqLUrAeQiR7MD
	4UwIyBbiWlaDPWLMW0Tstn2COVtA+J19/7MweX2o4NVuk6WmKAZ2sK+9u1SZW1Lvt85z88
	z1DkwIyDJsrTfs2diThqdpxCa2lJA0o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-0YvQwBjyPzaCGwVpAix73g-1; Wed,
 14 Aug 2024 16:41:57 -0400
X-MC-Unique: 0YvQwBjyPzaCGwVpAix73g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C84201954B16;
	Wed, 14 Aug 2024 20:41:53 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 910B51955D88;
	Wed, 14 Aug 2024 20:41:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 23/25] cifs: Use iterate_and_advance*() routines directly for hashing
Date: Wed, 14 Aug 2024 21:38:43 +0100
Message-ID: <20240814203850.2240469-24-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Replace the bespoke cifs iterators of ITER_BVEC and ITER_KVEC to do hashing
with iterate_and_advance_kernel() - a variant on iterate_and_advance() that
only supports kernel-internal ITER_* types and not UBUF/IOVEC types.

The bespoke ITER_XARRAY is left because we don't really want to be calling
crypto_shash_update() under the RCU read lock for large amounts of data;
besides, ITER_XARRAY is going to be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsencrypt.c | 109 ++++++++----------------------------
 include/linux/iov_iter.h    |  47 ++++++++++++++++
 2 files changed, 70 insertions(+), 86 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 6322f0f68a17..991a1ab047e7 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -21,82 +21,10 @@
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/fips.h>
+#include <linux/iov_iter.h>
 #include "../common/arc4.h"
 #include <crypto/aead.h>
 
-/*
- * Hash data from a BVEC-type iterator.
- */
-static int cifs_shash_bvec(const struct iov_iter *iter, ssize_t maxsize,
-			   struct shash_desc *shash)
-{
-	const struct bio_vec *bv = iter->bvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	void *p;
-	int ret;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		size_t off, len;
-
-		len = bv[i].bv_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		len = min_t(size_t, maxsize, len - start);
-		off = bv[i].bv_offset + start;
-
-		p = kmap_local_page(bv[i].bv_page);
-		ret = crypto_shash_update(shash, p + off, len);
-		kunmap_local(p);
-		if (ret < 0)
-			return ret;
-
-		maxsize -= len;
-		if (maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	return 0;
-}
-
-/*
- * Hash data from a KVEC-type iterator.
- */
-static int cifs_shash_kvec(const struct iov_iter *iter, ssize_t maxsize,
-			   struct shash_desc *shash)
-{
-	const struct kvec *kv = iter->kvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		size_t len;
-
-		len = kv[i].iov_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		len = min_t(size_t, maxsize, len - start);
-		ret = crypto_shash_update(shash, kv[i].iov_base + start, len);
-		if (ret < 0)
-			return ret;
-		maxsize -= len;
-
-		if (maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	return 0;
-}
-
 /*
  * Hash data from an XARRAY-type iterator.
  */
@@ -145,27 +73,36 @@ static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
 	return 0;
 }
 
+static size_t cifs_shash_step(void *iter_base, size_t progress, size_t len,
+			      void *priv, void *priv2)
+{
+	struct shash_desc *shash = priv;
+	int ret, *pret = priv2;
+
+	ret = crypto_shash_update(shash, iter_base, len);
+	if (ret < 0) {
+		*pret = ret;
+		return len;
+	}
+	return 0;
+}
+
 /*
  * Pass the data from an iterator into a hash.
  */
 static int cifs_shash_iter(const struct iov_iter *iter, size_t maxsize,
 			   struct shash_desc *shash)
 {
-	if (maxsize == 0)
-		return 0;
+	struct iov_iter tmp_iter = *iter;
+	int err = -EIO;
 
-	switch (iov_iter_type(iter)) {
-	case ITER_BVEC:
-		return cifs_shash_bvec(iter, maxsize, shash);
-	case ITER_KVEC:
-		return cifs_shash_kvec(iter, maxsize, shash);
-	case ITER_XARRAY:
+	if (iov_iter_type(iter) == ITER_XARRAY)
 		return cifs_shash_xarray(iter, maxsize, shash);
-	default:
-		pr_err("cifs_shash_iter(%u) unsupported\n", iov_iter_type(iter));
-		WARN_ON_ONCE(1);
-		return -EIO;
-	}
+
+	if (iterate_and_advance_kernel(&tmp_iter, maxsize, shash, &err,
+				       cifs_shash_step) != maxsize)
+		return err;
+	return 0;
 }
 
 int __cifs_calc_signature(struct smb_rqst *rqst,
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index a223370a59a7..c4aa58032faf 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -328,4 +328,51 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
 	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
 }
 
+/**
+ * iterate_and_advance_kernel - Iterate over a kernel-internal iterator
+ * @iter: The iterator to iterate over.
+ * @len: The amount to iterate over.
+ * @priv: Data for the step functions.
+ * @priv2: More data for the step functions.
+ * @step: Function for other iterators; given kernel addresses.
+ *
+ * Iterate over the next part of an iterator, up to the specified length.  The
+ * buffer is presented in segments, which for kernel iteration are broken up by
+ * physical pages and mapped, with the mapped address being presented.
+ *
+ * [!] Note This will only handle BVEC, KVEC, FOLIOQ, XARRAY and DISCARD-type
+ * iterators; it will not handle UBUF or IOVEC-type iterators.
+ *
+ * A step functions, @step, must be provided, one for handling mapped kernel
+ * addresses and the other is given user addresses which have the potential to
+ * fault since no pinning is performed.
+ *
+ * The step functions are passed the address and length of the segment, @priv,
+ * @priv2 and the amount of data so far iterated over (which can, for example,
+ * be added to @priv to point to the right part of a second buffer).  The step
+ * functions should return the amount of the segment they didn't process (ie. 0
+ * indicates complete processsing).
+ *
+ * This function returns the amount of data processed (ie. 0 means nothing was
+ * processed and the value of @len means processes to completion).
+ */
+static __always_inline
+size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
+				  void *priv2, iov_step_f step)
+{
+	if (unlikely(iter->count < len))
+		len = iter->count;
+	if (unlikely(!len))
+		return 0;
+	if (iov_iter_is_bvec(iter))
+		return iterate_bvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_kvec(iter))
+		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_folioq(iter))
+		return iterate_folioq(iter, len, priv, priv2, step);
+	if (iov_iter_is_xarray(iter))
+		return iterate_xarray(iter, len, priv, priv2, step);
+	return iterate_discard(iter, len, priv, priv2, step);
+}
+
 #endif /* _LINUX_IOV_ITER_H */

