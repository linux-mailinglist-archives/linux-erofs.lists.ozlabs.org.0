Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B383628E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 12:50:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4GDL6Mk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIsnYEFd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJT7Q0W41z3bqC
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 22:50:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4GDL6Mk;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIsnYEFd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJT744NSLz3bn0
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 22:50:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeeG0FfVujDf91nAvy13CDWA92gJt33lwcR42KZA7GE=;
	b=A4GDL6MkifPuWlXNuaEo44/KvtgumwqIx6eVrrxjQ/rgP+8BpRkVGbwZE9jsDYkHgCrlbY
	d1f+aOiKvF456yLRB0fjFVi7EtjmPDD9PoMCSMjyd/88ybFGSzQa47xlbidQiYVcahL55u
	D2wb7wuEDK+zsOVnNchhvPlQ0RNoq4c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeeG0FfVujDf91nAvy13CDWA92gJt33lwcR42KZA7GE=;
	b=CIsnYEFd/pTWekEKUkYb/yvvx52Ypl8IJRfrBZb6al9mMBQdVr1px/l3iUAU631uC0ImDx
	k30Tz9wIwqEXnX6qlCeLw9B/BhKmvoHtiiQaFX3F9TkbLxlXAUPtxhdxNWc7iWblmdJCwr
	f3ax+iDC4QITxKu5OHNx/10RA3+LfSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-AisSLAzPOYKrDxNVjIRW0w-1; Mon, 22 Jan 2024 06:50:18 -0500
X-MC-Unique: AisSLAzPOYKrDxNVjIRW0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50BEE80007C;
	Mon, 22 Jan 2024 11:50:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5369D400D7AB;
	Mon, 22 Jan 2024 11:50:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Subject: [PATCH 2/2] netfs: Add Jeff Layton as reviewer
Date: Mon, 22 Jan 2024 11:50:01 +0000
Message-ID: <20240122115007.3820330-3-dhowells@redhat.com>
In-Reply-To: <20240122115007.3820330-1-dhowells@redhat.com>
References: <20240122115007.3820330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add Jeff Layton as a reviewer in the MAINTAINERS file.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab5858d24ffc..2f4f4bf2e7f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8223,6 +8223,7 @@ F:	include/linux/iomap.h
 
 FILESYSTEMS [NETFS LIBRARY]
 M:	David Howells <dhowells@redhat.com>
+R:	Jeff Layton <jlayton@kernel.org>
 L:	netfs@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported

