Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F653823701
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 22:16:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QwDM5yw+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QwDM5yw+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T52ZV1lmTz30Np
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 08:16:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QwDM5yw+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QwDM5yw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T52ZP0jnFz2xgp
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 08:15:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704316552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz9BpuJT9ZqjBzLEQFTtycxe4tbIVPZFPrNygtaFHDI=;
	b=QwDM5yw+VmJ8YBM7dt5dcbVZuatQF/CCRbqDR+Rz+xbvFT1Ljwn7yXQUnOu/scH2Wt5ffv
	UCEUK76dhKR++7KEfzL6Cf5W9/zwOR+woc0U4EL1y+Zbxabqj+LHBQ4PCboTdghZtqGN69
	uf/gdVeb+8T0VX24meMydBOKaytxi5Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704316552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz9BpuJT9ZqjBzLEQFTtycxe4tbIVPZFPrNygtaFHDI=;
	b=QwDM5yw+VmJ8YBM7dt5dcbVZuatQF/CCRbqDR+Rz+xbvFT1Ljwn7yXQUnOu/scH2Wt5ffv
	UCEUK76dhKR++7KEfzL6Cf5W9/zwOR+woc0U4EL1y+Zbxabqj+LHBQ4PCboTdghZtqGN69
	uf/gdVeb+8T0VX24meMydBOKaytxi5Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-1v-GWHbRM9e1RxN52-Av-w-1; Wed,
 03 Jan 2024 16:15:48 -0500
X-MC-Unique: 1v-GWHbRM9e1RxN52-Av-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5354F3806710;
	Wed,  3 Jan 2024 21:15:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 576BF492BC6;
	Wed,  3 Jan 2024 21:15:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 7/5] netfs: Fix proc/fs/fscache symlink to point to "netfs" not "../netfs"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <900276.1704316543.1@warthog.procyon.org.uk>
Date: Wed, 03 Jan 2024 21:15:43 +0000
Message-ID: <900277.1704316543@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix the proc/fs/fscache symlink to point to "netfs" not "../netfs".

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---
 fs/netfs/fscache_proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
index ecd0d1edafaa..874d951bc390 100644
--- a/fs/netfs/fscache_proc.c
+++ b/fs/netfs/fscache_proc.c
@@ -16,7 +16,7 @@
  */
 int __init fscache_proc_init(void)
 {
-	if (!proc_symlink("fs/fscache", NULL, "../netfs"))
+	if (!proc_symlink("fs/fscache", NULL, "netfs"))
 		goto error_sym;
 
 	if (!proc_create_seq("fs/netfs/caches", S_IFREG | 0444, NULL,

