Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D2823001
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 16:00:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eixM+yzg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eixM+yzg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4tDj4tJlz3brK
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 02:00:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eixM+yzg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eixM+yzg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4tDf0cGhz30Q3
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 02:00:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704293999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdFCD8YJUNnwtU5qwz/M+xF7ih7tS/QW8qR9RpiR7QY=;
	b=eixM+yzgvB/ERuLHdREFkEZ69u6Zwq7WFd8ZBcq1c8smHw59USFxK8RYJ1j4rSuZ15H1cN
	1ZtttcH8446/ozU1nw3Kg810rMez4tGoRsxBUjHqjqa3pk903T2X8963ZODhH5AbRfyZ6I
	VZR/+NadI7T9mVUJ5Y99pmOpZhGk0Co=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704293999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdFCD8YJUNnwtU5qwz/M+xF7ih7tS/QW8qR9RpiR7QY=;
	b=eixM+yzgvB/ERuLHdREFkEZ69u6Zwq7WFd8ZBcq1c8smHw59USFxK8RYJ1j4rSuZ15H1cN
	1ZtttcH8446/ozU1nw3Kg810rMez4tGoRsxBUjHqjqa3pk903T2X8963ZODhH5AbRfyZ6I
	VZR/+NadI7T9mVUJ5Y99pmOpZhGk0Co=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-l-ZawQD_NwSxVHuoSJh8mg-1; Wed, 03 Jan 2024 09:59:54 -0500
X-MC-Unique: l-ZawQD_NwSxVHuoSJh8mg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 450EB83B826;
	Wed,  3 Jan 2024 14:59:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45F673C27;
	Wed,  3 Jan 2024 14:59:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
Date: Wed,  3 Jan 2024 14:59:25 +0000
Message-ID: <20240103145935.384404-2-dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Yiqun Leng <yqleng@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix __cachefiles_prepare_write() to correctly determine whether the
requested write will fit correctly with the DIO alignment.

Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Yiqun Leng <yqleng@linux.alibaba.com>
Tested-by: Jia Zhu <zhujia.zj@bytedance.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/cachefiles/io.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index bffffedce4a9..7529b40bc95a 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	loff_t start = *_start, pos;
-	size_t len = *_len, down;
+	unsigned long long start = *_start, pos;
+	size_t len = *_len;
 	int ret;
 
 	/* Round to DIO size */
-	down = start - round_down(start, PAGE_SIZE);
-	*_start = start - down;
-	*_len = round_up(down + len, PAGE_SIZE);
-	if (down < start || *_len > upper_len)
+	start = round_down(*_start, PAGE_SIZE);
+	if (start != *_start) {
+		kleave(" = -ENOBUFS [down]");
+		return -ENOBUFS;
+	}
+	if (*_len > upper_len) {
+		kleave(" = -ENOBUFS [up]");
 		return -ENOBUFS;
+	}
+
+	*_len = round_up(len, PAGE_SIZE);
 
 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 
 	pos = cachefiles_inject_read_error();
 	if (pos == 0)
-		pos = vfs_llseek(file, *_start, SEEK_DATA);
+		pos = vfs_llseek(file, start, SEEK_DATA);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		if (pos == -ENXIO)
 			goto check_space; /* Unallocated tail */
@@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if ((u64)pos >= (u64)*_start + *_len)
+	if (pos >= start + *_len)
 		goto check_space; /* Unallocated region */
 
 	/* We have a block that's at least partially filled - if we're low on
@@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 
 	pos = cachefiles_inject_read_error();
 	if (pos == 0)
-		pos = vfs_llseek(file, *_start, SEEK_HOLE);
+		pos = vfs_llseek(file, start, SEEK_HOLE);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), pos,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if ((u64)pos >= (u64)*_start + *_len)
+	if (pos >= start + *_len)
 		return 0; /* Fully allocated */
 
 	/* Partially allocated, but insufficient space: cull. */
@@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0)
 		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				    *_start, *_len);
+				    start, *_len);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_fallocate_error);

