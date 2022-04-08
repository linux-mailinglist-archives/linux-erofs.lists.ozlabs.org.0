Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1460C4F9FEA
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 01:07:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZv610w9lz3bY5
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 09:07:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IG3Yh8yH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IG3Yh8yH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=IG3Yh8yH; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IG3Yh8yH; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZv5y2N36z2xnL
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Apr 2022 09:07:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvSHWMhXrguWfA8ykwu8Ao+oi4066Cw7VetN1MG5uYo=;
 b=IG3Yh8yHrlGgENxmnxa7H+JaQ414itnCjpQrDePxXEFsC4nW45GBRNiSurfdL5sXGbzHA+
 hRbkxETdk/V+YS6WgXGhWjJ8FYS15UR3x+z1olkvmNJkApIIo2bzAUW+DCRlcroxNAwTaM
 Q6LStojIlQ4STK9zxarSZ8g9gb1VqbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvSHWMhXrguWfA8ykwu8Ao+oi4066Cw7VetN1MG5uYo=;
 b=IG3Yh8yHrlGgENxmnxa7H+JaQ414itnCjpQrDePxXEFsC4nW45GBRNiSurfdL5sXGbzHA+
 hRbkxETdk/V+YS6WgXGhWjJ8FYS15UR3x+z1olkvmNJkApIIo2bzAUW+DCRlcroxNAwTaM
 Q6LStojIlQ4STK9zxarSZ8g9gb1VqbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-2-7BPcXmMrKbgA_frKP0ww-1; Fri, 08 Apr 2022 19:07:12 -0400
X-MC-Unique: 2-7BPcXmMrKbgA_frKP0ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BC078038E3;
 Fri,  8 Apr 2022 23:07:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB388145;
 Fri,  8 Apr 2022 23:07:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/8] fscache: Use wrapper fscache_set_cache_state() directly
 when relinquishing
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Date: Sat, 09 Apr 2022 00:07:02 +0100
Message-ID: <164945922215.773423.3235931910808608985.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

We already have the wrapper function to set cache state.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006648.html # v1
---

 fs/fscache/cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 2749933852a9..d645f8b302a2 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -214,7 +214,7 @@ void fscache_relinquish_cache(struct fscache_cache *cache)
 
 	cache->ops = NULL;
 	cache->cache_priv = NULL;
-	smp_store_release(&cache->state, FSCACHE_CACHE_IS_NOT_PRESENT);
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_NOT_PRESENT);
 	fscache_put_cache(cache, where);
 }
 EXPORT_SYMBOL(fscache_relinquish_cache);


