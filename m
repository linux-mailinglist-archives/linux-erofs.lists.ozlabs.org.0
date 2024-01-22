Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A4837624
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:33:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHud4XwU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHud4XwU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJlNd5DpVz3btc
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 09:33:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHud4XwU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHud4XwU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJlNM3TDQz3bn0
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 09:32:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CJ3I/7LDGs8hexTud6zRTfvlS0atGDHH81M3ADEHcQ=;
	b=aHud4XwUiCzDnHmLUdWbyaRsy41l+XdKyxF2Gi94FY8gavgVyTDB9tvcB/Fogc1IKFfSfc
	ma+Tm+RyjEmkiZ705cgmeeTYZIG1LeGoBlwcxokVmqwbt8nc+FqzBMUWZ3GnFCB1dUCADl
	s/RawRz1+bH5hmzX7YatSVELGxTP37s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CJ3I/7LDGs8hexTud6zRTfvlS0atGDHH81M3ADEHcQ=;
	b=aHud4XwUiCzDnHmLUdWbyaRsy41l+XdKyxF2Gi94FY8gavgVyTDB9tvcB/Fogc1IKFfSfc
	ma+Tm+RyjEmkiZ705cgmeeTYZIG1LeGoBlwcxokVmqwbt8nc+FqzBMUWZ3GnFCB1dUCADl
	s/RawRz1+bH5hmzX7YatSVELGxTP37s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-kqQQMgafNgqLwRACAr_1zQ-1; Mon, 22 Jan 2024 17:32:45 -0500
X-MC-Unique: kqQQMgafNgqLwRACAr_1zQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D92CC106CFE2;
	Mon, 22 Jan 2024 22:32:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 040A32026D66;
	Mon, 22 Jan 2024 22:32:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 04/10] netfs, fscache: Prevent Oops in fscache_put_cache()
Date: Mon, 22 Jan 2024 22:32:17 +0000
Message-ID: <20240122223230.4000595-5-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Dan Carpenter <dan.carpenter@linaro.org>

This function dereferences "cache" and then checks if it's
IS_ERR_OR_NULL().  Check first, then dereference.

Fixes: 9549332df4ed ("fscache: Implement cache registration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/e84bc740-3502-4f16-982a-a40d5676615c@moroto.mountain/ # v2
---
 fs/netfs/fscache_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index d645f8b302a2..9397ed39b0b4 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -179,13 +179,14 @@ EXPORT_SYMBOL(fscache_acquire_cache);
 void fscache_put_cache(struct fscache_cache *cache,
 		       enum fscache_cache_trace where)
 {
-	unsigned int debug_id = cache->debug_id;
+	unsigned int debug_id;
 	bool zero;
 	int ref;
 
 	if (IS_ERR_OR_NULL(cache))
 		return;
 
+	debug_id = cache->debug_id;
 	zero = __refcount_dec_and_test(&cache->ref, &ref);
 	trace_fscache_cache(debug_id, ref - 1, where);
 

