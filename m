Return-Path: <linux-erofs+bounces-1315-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D4C2B52D
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tp11jWNz30RJ;
	Mon,  3 Nov 2025 22:27:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169241;
	cv=none; b=ZG9Cx43CemxaPQzJjfhDkW63y4z/m5Xnp7y8YSCZLdUOiiq/X0zuGrXjPQOIvA/2ts8DRQxkon6uE7JlNJUcVFYOz++8jyZUydhW0PM9+PbPTKoaWTpLHccM+LC0CaxuZe/6iHXG5yqegU/fJUy1r5hKt8FdHuAUUZ2NpunbmlGazxqcrjczLQSGxI3wzjzSQP/9RLZ7LWQ8JY9O0BNPWztElf2XqIezjgxKOljIGBIpqBXKkTU04JwWIrUOjiBiciRkx+Az54lFu5B5E0bD9p555vyyqFgcXMQymeLTXZYg6OsqFN0v8zh5hMTH0OnqSEiobpJSGu66u1GJsylOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169241; c=relaxed/relaxed;
	bh=xYYlDn8qi4oWrTC/M6uA2XNgYryKe0xz2msiXDXKNNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e37kIuk1Gl2/r9F9yzMyUSKjZpAYomLyRTofIuiYaQOZLrIbLqmTEJtCIBqSw6rNOoMBLRGpqL9tJirJ9XNuUFPRavwlUzTTrBXyEis5HQLbY0Q6u1cZvmVTuivfNr6w2uPmilhL33+9QedVUgU61g7Oh0EDCJ3l7FLdhgvp/Yd2DPOzF4Z7ONLD6+fWZP0LeUvvvvt4iBoUbOUckGGf29l12evX70hsLDCaAkRxq5CxVDuool3636ueUxhaJ6Lbw33MIHL7Big15Yp0yUcITzgc4AqF3XfZUSA2+0Arr1SbHDK9iD639THkm6QpOY93S22n1cBkiI8tfTe1bmXZzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2H84mnV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2H84mnV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tp04HvHz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B37C41966;
	Mon,  3 Nov 2025 11:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D419C4CEFD;
	Mon,  3 Nov 2025 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169238;
	bh=nM6vUvQd4AMD+xtcLBWx9Qk09b196BZxjzjS13mYIcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2H84mnVSjhuIGEO5aLRQorevyb8zjgiiHeJZlPPmhXri/0/4PMO+OYDGVDt50NKB
	 t0kn67GHFwA3X/jWuiYZuKDHgD+g1gfQrcbGiNZwci38VGJ07IFFvQozVUJs/dGnV7
	 nJHrrn/pV9R7ErJ65CuBBGwYTj7bJhGRaUo4JKPKQLV43ib/wO415hgFNLv/frAmAs
	 hfp+Ykng5R99V6EcXlMks/+KbMSfMZHWO27TPXbywi+fYqp/PsHhqqHGmjW4AHNNkt
	 SLDK+VhWs+5h/66bqjmnvlcuVtCVf1CXZfdTPwJZG8V4GX4N4ddhJ5/LMW6Jutesb7
	 2Mmj5DXtPgLVw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:52 +0100
Subject: [PATCH 04/16] backing-file: use credential guards for writes
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nM6vUvQd4AMD+xtcLBWx9Qk09b196BZxjzjS13mYIcc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGzfO2uy4qzbchqXxHO5jrbyGT776n08N2zn67qjv
 IH3X6d87ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIeDXD/3DflS25m8pkl4uc
 /rlhwwKZR8KTu1oVjt2fl6HIqaf5Zx7D/9TpR5O508w/XTv+5owO47I/vx/cZDwjZ374u2TULvF
 ni5kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 74 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 4cb7276e7ead..9bea737d5bef 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -210,11 +210,47 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(backing_file_read_iter);
 
+static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				      struct kiocb *iocb, int flags,
+				      void (*end_write)(struct kiocb *, ssize_t))
+{
+	struct backing_aio *aio;
+	int ret;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+		if (end_write)
+			end_write(iocb, ret);
+		return ret;
+	}
+
+	ret = backing_aio_init_wq(iocb);
+	if (ret)
+		return ret;
+
+	aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+	if (!aio)
+		return -ENOMEM;
+
+	aio->orig_iocb = iocb;
+	aio->end_write = end_write;
+	kiocb_clone(&aio->iocb, iocb, get_file(file));
+	aio->iocb.ki_flags = flags;
+	aio->iocb.ki_complete = backing_aio_queue_completion;
+	refcount_set(&aio->ref, 2);
+	ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
+	backing_aio_put(aio);
+	if (ret != -EIOCBQUEUED)
+		backing_aio_cleanup(aio, ret);
+	return ret;
+}
+
 ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -237,40 +273,8 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
-
-		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
-		if (ctx->end_write)
-			ctx->end_write(iocb, ret);
-	} else {
-		struct backing_aio *aio;
-
-		ret = backing_aio_init_wq(iocb);
-		if (ret)
-			goto out;
-
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
-
-		aio->orig_iocb = iocb;
-		aio->end_write = ctx->end_write;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_flags = flags;
-		aio->iocb.ki_complete = backing_aio_queue_completion;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
-	}
-out:
-	revert_creds(old_cred);
-
-	return ret;
+	with_creds(ctx->cred);
+	return do_backing_file_write_iter(file, iter, iocb, flags, ctx->end_write);
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
 

-- 
2.47.3


