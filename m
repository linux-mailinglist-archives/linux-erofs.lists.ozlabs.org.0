Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDA709E46
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 19:35:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNDW96fbFz3gKl
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 03:35:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dowl3uz1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dowl3uz1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dowl3uz1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dowl3uz1;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNDCb0Ntjz3fNQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 03:21:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684516887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KKXfGDHxrX+6XLdqChQuTj9B0h9lQtkKNegqRI3p6E=;
	b=dowl3uz1qy5reIHD8vdLlRZYl5H488JdhFTSjwZiP1EFmgDu9N0iAumPwLiULCQm5cml5z
	x1fpjObxSU+ca+0TYEfwnsvA/Wt82uXXAfWpAeHmEkIB4vaZ1sHKo8DPdWuT+nyymjZd3W
	f8+I8x0q1rtJnPKwzeXJXrtllq7eC8s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684516887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KKXfGDHxrX+6XLdqChQuTj9B0h9lQtkKNegqRI3p6E=;
	b=dowl3uz1qy5reIHD8vdLlRZYl5H488JdhFTSjwZiP1EFmgDu9N0iAumPwLiULCQm5cml5z
	x1fpjObxSU+ca+0TYEfwnsvA/Wt82uXXAfWpAeHmEkIB4vaZ1sHKo8DPdWuT+nyymjZd3W
	f8+I8x0q1rtJnPKwzeXJXrtllq7eC8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-OtPTiJeUNUe2Hj4TZRRGtg-1; Fri, 19 May 2023 13:21:21 -0400
X-MC-Unique: OtPTiJeUNUe2Hj4TZRRGtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 712A785A5A8;
	Fri, 19 May 2023 17:21:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA3C640D1B60;
	Fri, 19 May 2023 17:21:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Subject: [PATCH] cachefiles: Allow the cache to be non-root
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1853229.1684516880.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2023 18:21:20 +0100
Message-ID: <1853230.1684516880@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
Cc: dhowells@redhat.com, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

    =

Set mode 0600 on files in the cache so that cachefilesd can run as an
unprivileged user rather than leaving the files all with 0.  Directories
are already set to 0700.

Userspace then needs to set the uid and gid before issuing the "bind"
command and the cache must've been chown'd to those IDs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..66482c193e86 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,7 +451,8 @@ struct file *cachefiles_create_tmpfile(struct cachefil=
es_object *object)
 =

 	ret =3D cachefiles_inject_write_error();
 	if (ret =3D=3D 0) {
-		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
+		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath,
+					S_IFREG | 0600,
 					O_RDWR | O_LARGEFILE | O_DIRECT,
 					cache->cache_cred);
 		ret =3D PTR_ERR_OR_ZERO(file);

