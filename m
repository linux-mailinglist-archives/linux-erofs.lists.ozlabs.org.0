Return-Path: <linux-erofs+bounces-1314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D093C2B52A
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tny3dmlz306d;
	Mon,  3 Nov 2025 22:27:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169238;
	cv=none; b=MaRt5sgXA5U+SAHGqGld1f5805bA5AaqAOHkgPlhLosfqUwch+NlHXWPKjTxnb0IxkNPhc/VGldMehg+L7XfGBWy/RjgYBgeg2ZUL1AEwC+UUt8KdBjXElDqpNuzkfR68DLMyO1ZE8ixJ96P3SAt0sUUiedA+tswzAjLNzKBIB5fhcuX6E0zNJhq44DJga/rpAgAxMnYVB6UFlOVVnJ4HTvCwR+btu3xqyPb7TrxBJUiiXFgfmT9PHYNVHTREKkD3edxuDUFWz+Tj/UL98HDaqqYXo/G/84CgaoK3WpmV7TX8PqvH1os4KzZz5lz9qpqK03DNgeyKqKcxvHhLQmkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169238; c=relaxed/relaxed;
	bh=BR6rQdM5xg4t75aWCZ30LG+yk1lD2MgypdmjYxgKTLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ml0+b1Ql+naBGYAyeb72OyMNXcHs+fxZ+LQxRklcUpXhBIUxwWuOarFWuQ6cklur5I7i9XaYjouGAhVYkYuJUoX4+9OhRGf4qRtAdmdxgHHMi72xZ//WZ2mWI96dQoq3lSlxOR7N7Olz+a8T/cl8d7JMQX1Bx2PIwcPIo6o3eZ2LY01qTUlWEndOCzU/lIvq8ubCUoUFgg2ZRxQqQUAYWLktMIGCrujwIphrXL3sbpngjlTMujr1J5Jnvs/tLnbUnl9zXoW58+RFLi+aGuxrGcJiD6GhvB/2lk8RdwlahzCnWUCHOG6Wo3UNyjwlqdrFip2StW+mcX7Ymc4XHHVTZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sGzomzn+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sGzomzn+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tnx5R7Hz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CEDA4347E;
	Mon,  3 Nov 2025 11:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED62C116B1;
	Mon,  3 Nov 2025 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169236;
	bh=Te6t6WBv6LcIE3Mz3jIDSKVou5veHZxj8ddg+uVgoIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sGzomzn+PGDjvCwVJp7q7eb+dM1qxws72K6VH6xrXYmiGMTqrkYKH5g+ub4EUHZjN
	 jAnATZTZMkKxvekdh/YRrdgGycnz6CGT3CDuRJR2YY0e1Zr4UyVqpldjAjR+bNT1u7
	 iiMA1FmOiSALrUAa+gellLW9ZhHuuud6bFbDlSAT77tgEqHbbjHusLuF2KHjkqvsvX
	 VOetbNFCU0wnAJPhI53xqUam9lcXUp1hwNSpnKscop8OqOs6+t0/RoZDPoC30RwPkB
	 OFF9MtFrUp0bTHvXUuLg9O5p9VvocMC31CLCjvY2a7BtHOKWiZL8k6PtoNchqYTvOd
	 S3jdiMZckWqtw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:51 +0100
Subject: [PATCH 03/16] backing-file: use credential guards for reads
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
Message-Id: <20251103-work-creds-guards-simple-v1-3-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Te6t6WBv6LcIE3Mz3jIDSKVou5veHZxj8ddg+uVgoIk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz38X4ce1HzVa/FXFUmtYYbMyeKTlf3c6gz+HNeT
 UZ2t6dqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETmNzIyrAgrqVBzevihy0q+
 cEaCUKh4gH265rKLiUmZ3/MdWiJFGX4xPcraW37lS0tS87Zpued+eQrIv7x3fl4Qi0yXyfXruRy
 cAA==
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
 fs/backing-file.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 15a7f8031084..4cb7276e7ead 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -157,13 +157,37 @@ static int backing_aio_init_wq(struct kiocb *iocb)
 	return sb_init_dio_done_wq(sb);
 }
 
+static int do_backing_file_read_iter(struct file *file, struct iov_iter *iter,
+				     struct kiocb *iocb, int flags)
+{
+	struct backing_aio *aio = NULL;
+	int ret;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		return vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+	}
+
+	aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+	if (!aio)
+		return -ENOMEM;
+
+	aio->orig_iocb = iocb;
+	kiocb_clone(&aio->iocb, iocb, get_file(file));
+	aio->iocb.ki_complete = backing_aio_rw_complete;
+	refcount_set(&aio->ref, 2);
+	ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
+	backing_aio_put(aio);
+	if (ret != -EIOCBQUEUED)
+		backing_aio_cleanup(aio, ret);
+	return ret;
+}
 
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx)
 {
-	struct backing_aio *aio = NULL;
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -176,28 +200,8 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
-
-		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
-	} else {
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
-
-		aio->orig_iocb = iocb;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_complete = backing_aio_rw_complete;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
-	}
-out:
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		do_backing_file_read_iter(file, iter, iocb, flags);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);

-- 
2.47.3


