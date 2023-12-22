Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065B81CA71
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Dec 2023 14:02:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KnVASD5X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KnVASD5X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SxSBZ12GQz3cR8
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Dec 2023 00:02:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KnVASD5X;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KnVASD5X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SxSBR1PFjz3c2F
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Dec 2023 00:02:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703250138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kygMq0mAMv991cW3YZ7Hd3ppnOgYBjhmi7vw/LesYI=;
	b=KnVASD5XV8titxuGCdCefAQy3tomOyV0j+Q5V3Ro/qqNYROo+8LowtfZhUj2sLBrJS7CmK
	QrbNtC0YLDuQ0mjdFrjFEdxWuF+1tg0qgMXWJPKf8yOCpASnhxIeWjEcXOrLd5hwluI5WX
	upxIWEwI4g9AMajdyiw81w7iW1d9As8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703250138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kygMq0mAMv991cW3YZ7Hd3ppnOgYBjhmi7vw/LesYI=;
	b=KnVASD5XV8titxuGCdCefAQy3tomOyV0j+Q5V3Ro/qqNYROo+8LowtfZhUj2sLBrJS7CmK
	QrbNtC0YLDuQ0mjdFrjFEdxWuF+1tg0qgMXWJPKf8yOCpASnhxIeWjEcXOrLd5hwluI5WX
	upxIWEwI4g9AMajdyiw81w7iW1d9As8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15--QeBZETQMO6dAe6PTzC6cQ-1; Fri,
 22 Dec 2023 08:02:12 -0500
X-MC-Unique: -QeBZETQMO6dAe6PTzC6cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5329D386914F;
	Fri, 22 Dec 2023 13:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82A9251E3;
	Fri, 22 Dec 2023 13:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-5-dhowells@redhat.com>
References: <20231221132400.1601991-5-dhowells@redhat.com> <20231221132400.1601991-1-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] Fix EROFS Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2265064.1703250126.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Dec 2023 13:02:06 +0000
Message-ID: <2265065.1703250126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Yue Hu <huyue2@coolpad.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This needs an additional change (see attached).

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1d318f85232d..1949763e66aa 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -114,7 +114,8 @@ config EROFS_FS_ZIP_DEFLATE
 =

 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
-	depends on CACHEFILES_ONDEMAND && (EROFS_FS=3Dm && FSCACHE || EROFS_FS=3D=
y && FSCACHE=3Dy)
+	depends on CACHEFILES_ONDEMAND && FSCACHE && \
+		(EROFS_FS=3Dm && NETFS_SUPPORT || EROFS_FS=3Dy && NETFS_SUPPORT=3Dy)
 	default n
 	help
 	  This permits EROFS to use fscache-backed data blobs with on-demand

