Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D91952378
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:39:49 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtqQ9ar6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=em91XSfJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wkg9H62Pnz2yYd
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:39:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtqQ9ar6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=em91XSfJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wkg9514Rnz2yZ0
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:39:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvz9YBrTPFQ9wVYP2d1umk84aV9uv83ek2O7Ma2LSP4=;
	b=dtqQ9ar6VENGgt1AKrLgXbraPEzVqjFKModKgUy1utC75fRRox89shlD0hWlBF3tqNzy5O
	jJibspMm6T2Fz/iQSCqJgJdOLfHDqiU2yC4+cHruAC6gBmLPKmU+2xyOoIVYb8GBY59MPy
	2UVsiwTSGSwkp+iOhOjBQtKEa6cUXrY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvz9YBrTPFQ9wVYP2d1umk84aV9uv83ek2O7Ma2LSP4=;
	b=em91XSfJ40Voc67RHpp8dMAR89omBaBnG3HTr+pn0vuGc9ZmLoS8Y4HHn0toopwsxUdknS
	yNTZcf3hsxMthGjgstZQW8cgoNy10BPQy/UQI6VbfI/oDndhBeELRWOSySIE4ZtTUNGM/1
	CFeAXX+tBd8Iv0ZudA0JFsgUgHoryv0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-9QbQ7aiUNXWL2QCGcnXXHA-1; Wed,
 14 Aug 2024 16:39:26 -0400
X-MC-Unique: 9QbQ7aiUNXWL2QCGcnXXHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AA841954B10;
	Wed, 14 Aug 2024 20:39:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90C961955E8C;
	Wed, 14 Aug 2024 20:39:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 02/25] cachefiles: Fix non-taking of sb_writers around set/removexattr
Date: Wed, 14 Aug 2024 21:38:22 +0100
Message-ID: <20240814203850.2240469-3-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Unlike other vfs_xxxx() calls, vfs_setxattr() and vfs_removexattr() don't
take the sb_writers lock, so the caller should do it for them.

Fix cachefiles to do this.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/xattr.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 4dd8a993c60a..7c6f260a3be5 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -64,9 +64,15 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write_file(file);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache, buf,
+					   sizeof(struct cachefiles_xattr) + len, 0);
+			mnt_drop_write_file(file);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -151,8 +157,14 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	int ret;
 
 	ret = cachefiles_inject_remove_error();
-	if (ret == 0)
-		ret = vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache);
+	if (ret == 0) {
+		ret = mnt_want_write(cache->mnt);
+		if (ret == 0) {
+			ret = vfs_removexattr(&nop_mnt_idmap, dentry,
+					      cachefiles_xattr_cache);
+			mnt_drop_write(cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -208,9 +220,15 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 	memcpy(buf->data, p, volume->vcookie->coherency_len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write(volume->cache->mnt);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache,
+					   buf, len, 0);
+			mnt_drop_write(volume->cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);

