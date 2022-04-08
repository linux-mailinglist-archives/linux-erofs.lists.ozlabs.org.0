Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8294F9FDF
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 01:06:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZv4z20GJz3bbB
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 09:06:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKl0tddo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKl0tddo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aKl0tddo; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKl0tddo; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZv4r4t9Yz3bVN
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Apr 2022 09:06:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGbUzF7graB79Rh3XegsgbF3z1uVK5+1yUqI/JXGhJU=;
 b=aKl0tddo08O/ARV58gXVfV5/U+ZTPImwV+9BWTxKSjPYiOcd5XSEXxzc3E9x1wGXEBrdOq
 dMZdkYlkg0uB98s75dFUw5bN6mSW2HYvBRHGUEOYN1wat4Vz/j5FQFe8WZhTWF2vFTeAnv
 9knUtz8dJcM01em9GrWnifx69kCZDyE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGbUzF7graB79Rh3XegsgbF3z1uVK5+1yUqI/JXGhJU=;
 b=aKl0tddo08O/ARV58gXVfV5/U+ZTPImwV+9BWTxKSjPYiOcd5XSEXxzc3E9x1wGXEBrdOq
 dMZdkYlkg0uB98s75dFUw5bN6mSW2HYvBRHGUEOYN1wat4Vz/j5FQFe8WZhTWF2vFTeAnv
 9knUtz8dJcM01em9GrWnifx69kCZDyE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-iaGqU-IDN5arGSD3AMf9RQ-1; Fri, 08 Apr 2022 19:06:13 -0400
X-MC-Unique: iaGqU-IDN5arGSD3AMf9RQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5FE63C11C8F;
 Fri,  8 Apr 2022 23:06:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C43EC1415130;
 Fri,  8 Apr 2022 23:06:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/8] cachefiles: unmark inode in use in error path
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Date: Sat, 09 Apr 2022 00:06:10 +0100
Message-ID: <164945917002.773423.16291667819231402497.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
 Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jeffle Xu <jefflexu@linux.alibaba.com>

Unmark inode in use if error encountered. If the in-use flag leakage
occurs in cachefiles_open_file(), Cachefiles will complain "Inode
already in use" when later another cookie with the same index key is
looked up.

If the in-use flag leakage occurs in cachefiles_create_tmpfile(), though
the "Inode already in use" warning won't be triggered, fix the leakage
anyway.

Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-March/006615.html # v1
Link: https://listman.redhat.com/archives/linux-cachefs/2022-March/006618.html # v2
---

 fs/cachefiles/namei.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f256c8aff7bb..ca9f3e4ec4b3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -57,6 +57,16 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	trace_cachefiles_mark_inactive(object, inode);
 }
 
+static void cachefiles_do_unmark_inode_in_use(struct cachefiles_object *object,
+					      struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	inode_lock(inode);
+	__cachefiles_unmark_inode_in_use(object, dentry);
+	inode_unlock(inode);
+}
+
 /*
  * Unmark a backing inode and tell cachefilesd that there's something that can
  * be culled.
@@ -68,9 +78,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	struct inode *inode = file_inode(file);
 
 	if (inode) {
-		inode_lock(inode);
-		__cachefiles_unmark_inode_in_use(object, file->f_path.dentry);
-		inode_unlock(inode);
+		cachefiles_do_unmark_inode_in_use(object, file->f_path.dentry);
 
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			atomic_long_add(inode->i_blocks, &cache->b_released);
@@ -484,7 +492,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 				object, d_backing_inode(path.dentry), ret,
 				cachefiles_trace_trunc_error);
 			file = ERR_PTR(ret);
-			goto out_dput;
+			goto out_unuse;
 		}
 	}
 
@@ -494,15 +502,20 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
 					   PTR_ERR(file),
 					   cachefiles_trace_open_error);
-		goto out_dput;
+		goto out_unuse;
 	}
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
 		fput(file);
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		file = ERR_PTR(-EINVAL);
+		goto out_unuse;
 	}
 
+	goto out_dput;
+
+out_unuse:
+	cachefiles_do_unmark_inode_in_use(object, path.dentry);
 out_dput:
 	dput(path.dentry);
 out:
@@ -590,14 +603,16 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
-	if (ret == -ESTALE) {
-		fput(file);
-		dput(dentry);
+	fput(file);
+	dput(dentry);
+	if (ret == -ESTALE)
 		return cachefiles_create_file(object);
-	}
+	return false;
+
 error_fput:
 	fput(file);
 error:
+	cachefiles_do_unmark_inode_in_use(object, dentry);
 	dput(dentry);
 	return false;
 }


