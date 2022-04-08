Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B004F9FE8
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 01:07:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZv5g6d0Xz3bYJ
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 09:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TUA6kVra;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TUA6kVra;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TUA6kVra; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TUA6kVra; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZv5d2HJ2z3bYq
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Apr 2022 09:07:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wf6Y5mRoiMWUztM6lpAzUiquRe1dvL2pPgHC7rsAV5g=;
 b=TUA6kVraUzFK0ACm8qrOA98L6m3gLRQpQ4FjOnmnuWTO4vsuqPxEj1mT9yEKDUG+DBkR/z
 /qCXyiGbigS7xnUVZl6/CEDkOMJf1gFCncV0f84VEIURIqHsaBjHQLok2q4Ynkc/7tzE1U
 au/qS9p/TpcDwF/K/Mhmh05LCPecO0k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wf6Y5mRoiMWUztM6lpAzUiquRe1dvL2pPgHC7rsAV5g=;
 b=TUA6kVraUzFK0ACm8qrOA98L6m3gLRQpQ4FjOnmnuWTO4vsuqPxEj1mT9yEKDUG+DBkR/z
 /qCXyiGbigS7xnUVZl6/CEDkOMJf1gFCncV0f84VEIURIqHsaBjHQLok2q4Ynkc/7tzE1U
 au/qS9p/TpcDwF/K/Mhmh05LCPecO0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-yXrh2nxMPki8q5VXNA9swg-1; Fri, 08 Apr 2022 19:06:57 -0400
X-MC-Unique: yXrh2nxMPki8q5VXNA9swg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E90AC802803;
 Fri,  8 Apr 2022 23:06:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6B4E434832;
 Fri,  8 Apr 2022 23:06:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/8] fscache: Move fscache_cookies_seq_ops specific code under
 CONFIG_PROC_FS
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Date: Sat, 09 Apr 2022 00:06:55 +0100
Message-ID: <164945921506.773423.5359381227919135073.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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

fscache_cookies_seq_ops is only used in proc.c that is compiled under
enabled CONFIG_PROC_FS, so move related code under this config. The
same case exsits in internal.h.

Also, make fscache_lru_cookie_timeout static due to no user outside
of cookie.c.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006649.html # v1
---

 fs/fscache/cookie.c   |    4 +++-
 fs/fscache/internal.h |    4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 9bb1ab5fe5ed..9d3cf0111709 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -30,7 +30,7 @@ static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
 static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
-unsigned int fscache_lru_cookie_timeout = 10 * HZ;
+static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
@@ -1069,6 +1069,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
+#ifdef CONFIG_PROC_FS
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
  */
@@ -1145,3 +1146,4 @@ const struct seq_operations fscache_cookies_seq_ops = {
 	.stop   = fscache_cookies_seq_stop,
 	.show   = fscache_cookies_seq_show,
 };
+#endif
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index ed1c9ed737f2..1336f517e9b1 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -56,7 +56,9 @@ static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
  * cookie.c
  */
 extern struct kmem_cache *fscache_cookie_jar;
+#ifdef CONFIG_PROC_FS
 extern const struct seq_operations fscache_cookies_seq_ops;
+#endif
 extern struct timer_list fscache_cookie_lru_timer;
 
 extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
@@ -137,7 +139,9 @@ int fscache_stats_show(struct seq_file *m, void *v);
 /*
  * volume.c
  */
+#ifdef CONFIG_PROC_FS
 extern const struct seq_operations fscache_volumes_seq_ops;
+#endif
 
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);


