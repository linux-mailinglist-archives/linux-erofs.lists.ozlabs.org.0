Return-Path: <linux-erofs+bounces-1316-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BEC2B530
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tp36VLhz30T8;
	Mon,  3 Nov 2025 22:27:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169243;
	cv=none; b=eJFC9v+5j+ca1+EJOr5NwSVTHJ1HE+lcPiT3BmItp+pKZgokrY2hm//hiJ7rkq04IoK9syjAKFb7dWUD8zRwh3MScNQUduRH1Uo5T4pgDC/KQmQ+wpxsAuR+BGknE4diVzliSdR3ZUS0hC9RdV4Te/hVvKxwVzrSIzQSr5cUsp5UyY5aDv0anWggszmvT/+T9yo68GI5YBZLq5Ir0ZPl71ndDJsl1g/6oQC9Ian9mEp61YeSNVnqhREIcKKIGCvaHLOl9f8+qE8gEsfNSBrFuJlFRYIooUflG8z+tyt5my9iF0yD5viH0EG3hvfzsNBXVRCKLv0O3evLZySuA2UiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169243; c=relaxed/relaxed;
	bh=QELcS/TU1nH+Kj85USV3+titHj2/Bem9Xto05EsbVt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct1V3MkctVWD8hOeWXesYdZJA9pnMzyahMX61SAJwxtYa1YZ6jFUUAFtHpu4DN4B+P7jp6OElGX2gSojp4T/XBTMVYwoJdXP0nNLgSij9KtNt6K5aAVYATY3ZvamdgCNwUTnj9J5FEVkKgUqRcGXE35YhUFUOdZRDWfiNTbC4lJPvk+7TZ7xrjgm1gPFZ+2W58KzAXkB5FQFyXPMin/nM/qSKSBrK8tKJQb7u2O4lVa2053LpyHEJEHnHt2/dwwuDlPhmcxExRLSyvymhwuATbj8VGRF6iAXRtadheeYZ3tOMHVdvIxwEOr8MjDkCTnIVKF0MoC1d95XvAIQyckdMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mwSwtBJN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mwSwtBJN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tp33frCz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E878B4347E;
	Mon,  3 Nov 2025 11:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4BFC116C6;
	Mon,  3 Nov 2025 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169241;
	bh=AQ/Nv+Gm1iyA4MT1Cr+T/3KGkzWrrlBvcUFCgBNnIOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwSwtBJNrczmBeLlfXA5znjbKF562UqPh69bEu98DZ5XRywF891sJAKAL7N7Gg2+w
	 DB1h3pjxaVeeJBv3r961WONcu6m9YzhdpFb7vuefHWS16ZOhQCejJwH4OWnG4vBduW
	 6pPLAELxrWssqj4wrKct4I6KpAjrWpFyXBP0vXWhUSUCbOZT0a0GyBd0qaL6w4heK1
	 IMjF0/0GbHnKk9wL2jspcIyNQr2koBxUd5HJSK0KfPYo+CZkTCzzp7QYZZ+XQU+/YF
	 sGtJimvYvKECLQII6gkpylUAUqISFS62sDoYUuyQfOWLqmxpuxV3VL1B6MaRsGpLMM
	 uqMEtsDtsY3Vg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:53 +0100
Subject: [PATCH 05/16] backing-file: use credential guards for splice read
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
Message-Id: <20251103-work-creds-guards-simple-v1-5-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AQ/Nv+Gm1iyA4MT1Cr+T/3KGkzWrrlBvcUFCgBNnIOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGw/4lX90OxD2/XgZRU3XBsyapnSRLz73uuFJzSdy
 FHuyTvXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFTLxgZTr4N3npssUFilvmv
 iJMN6fdkjL//OFtaeaP49bfWg7u58xj+iuVXbjG7k7XtT/70zS/bDXP36c1mMZ+1PyBx08u41wn
 GnAA=
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
 fs/backing-file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 9bea737d5bef..8ebc62f49bad 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -283,15 +283,13 @@ ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
-	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);

-- 
2.47.3


