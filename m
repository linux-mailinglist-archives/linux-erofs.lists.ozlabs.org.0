Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C815F837634
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:33:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFEP3Dnz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFEP3Dnz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJlPT55YXz3bs2
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 09:33:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFEP3Dnz;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFEP3Dnz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJlNk5brJz3bmH
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 09:33:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H/QyaTEJT6yM0W34T+DHhl8mPiadWYAfCey1J2x+wk=;
	b=IFEP3DnzzlXIAQpSVqahcD+wL3BIbEBdR3tGMtbZkOAdtVgvb4tkeVd0LvUh1PyoDD9CUh
	bUpRnddSWkMkGwkHUSGZlLv2oOfkSUXMXmTHfiMxMFNXnDtMXAIBom32XiIXOB9B5f7CMd
	7cGnO8F7mtZqgSb7+8pS7f6gF61/0a8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H/QyaTEJT6yM0W34T+DHhl8mPiadWYAfCey1J2x+wk=;
	b=IFEP3DnzzlXIAQpSVqahcD+wL3BIbEBdR3tGMtbZkOAdtVgvb4tkeVd0LvUh1PyoDD9CUh
	bUpRnddSWkMkGwkHUSGZlLv2oOfkSUXMXmTHfiMxMFNXnDtMXAIBom32XiIXOB9B5f7CMd
	7cGnO8F7mtZqgSb7+8pS7f6gF61/0a8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--HGPYFG7OMq08y4wHZqsJA-1; Mon, 22 Jan 2024 17:33:01 -0500
X-MC-Unique: -HGPYFG7OMq08y4wHZqsJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F87A185A780;
	Mon, 22 Jan 2024 22:33:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAB4C0FDCA;
	Mon, 22 Jan 2024 22:32:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 09/10] afs: Remove afs_dynroot_d_revalidate() as it is redundant
Date: Mon, 22 Jan 2024 22:32:22 +0000
Message-ID: <20240122223230.4000595-10-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove afs_dynroot_d_revalidate() as it is redundant as all it does is
return 1 and the caller assumes that if the op is not given.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dynroot.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d3bc4a2d7085..c4d2711e20ad 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -258,16 +258,7 @@ const struct inode_operations afs_dynroot_inode_operations = {
 	.lookup		= afs_dynroot_lookup,
 };
 
-/*
- * Dirs in the dynamic root don't need revalidation.
- */
-static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	return 1;
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
-	.d_revalidate	= afs_dynroot_d_revalidate,
 	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,

