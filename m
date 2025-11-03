Return-Path: <linux-erofs+bounces-1318-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0CDC2B536
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpB1FNXz3bd8;
	Mon,  3 Nov 2025 22:27:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169250;
	cv=none; b=FnG0iRrBpEHifY99mNlTfHoP1d6TYAbtQ6m3Xr5xA3gm8HtOagur4cgm0spdA1yOQmRKYZAkm65yJbmq1qa0tMnyGmhTCfl5shH2hYGoHbGG/B83krf5pN36H4P+iQJIZwt8OP5z0cFQ86pdKIPe/26vaY+nW0lrvcz1e3kM2bD2vOiJpHwwSgggP7315bHhB7SxC2eas5rO94OWZAxXPrx4pigxi4DLK+5J3h/v/bJ1jluoBXbWnA6X29P1lFLXm1VWMQt7e8qIc2YNcrXYvIR99wMZEqJJjD0MaxLKFx4qOG5XocLkAvYL0IWOJeNe7se5ZSXng8wQ4Xe+/5FkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169250; c=relaxed/relaxed;
	bh=26tsVUR9OYeWQfc3jMTI1pn8RR5ZAs1ODgOOASyzws8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7wY82FwSq9Gbzp8YaiwX9+KSU6P5dDXoRoC/cpXDSGpHVS9+r7qNB2Vsgwkw+teHbJDyQOHOulBbZBUe0pWwt/btHEJ0xrkdE2BC24jRMaXBqplbysZhZk3TnZ5mp4VwODATQJ9CZ+7gcJli1gCFSLp0AeLQ+HuynNROBLaWatbvX/Anm8EplvUKALypJNeZ2ZI0gNMXkk4un0EKz3F8UwKJ10U4hyejT9d3VXBIBB1yBHxGNiUKT+UsGAuf19JEikQHquSNWyZb8YspjIsySd57/KEd7fs9SqbyNOsNRqJN9dgbGdHtZAdl09zMvenYWHGea3JBMuQLxzI+0tzZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t/7pepPe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t/7pepPe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tp95LPhz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC3C9600BB;
	Mon,  3 Nov 2025 11:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F83C4CEF8;
	Mon,  3 Nov 2025 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169247;
	bh=xUgfCnEjAJd8zsIOSMA0urqHXlAuN0jLc7ICsbqbewI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t/7pepPe+E2EpzUMqDzgHBspZi4YmYJq/8kyKPd8F4ea0WwzTWUKxbhr9BQn21g5p
	 4vUpHCHemXB6WCn+RWve8MTpNaOMgVq+V0G5Yt9dQGt0TYSSpSuF+1vBLHm6cV79V4
	 /Ef3Br+/I9RsZpUSXomjNPfGTamKACdaOSk0aWyoYYbif609YCwiJSx2Jh98aQ0Ofq
	 CUodanmAKxk14DxR2ZdZsqfrSW1kzhfNI30558rjyOaZaOOTPVDEixp7GSLHnmdi6W
	 X5H+Gu6tSKRCbmMwJz3DH/sLJXc1koIR94pNFloTG1GIny0GDGT2y0+626ZCaEyXMX
	 Gic7qzrFm9jUA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:55 +0100
Subject: [PATCH 07/16] backing-file: use credential guards for mmap
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
Message-Id: <20251103-work-creds-guards-simple-v1-7-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xUgfCnEjAJd8zsIOSMA0urqHXlAuN0jLc7ICsbqbewI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGx/tYdp5/3NnxKWxT267pvpVHLYZbnKu5ednnuOs
 ptrr97xpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiB3oYGf7bPVoYHBDtkvTm
 j0NBZrlhXOds+5m3OFIvVuu+nu7zMJ6RYXlZ6M8HAc6f/y7vskkP+syb1GXX780bzNOpyb/ifMp
 edgA=
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
index 9c63a3368b66..5cc4b59aa460 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -331,7 +331,6 @@ EXPORT_SYMBOL_GPL(backing_file_splice_write);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	struct file *user_file = vma->vm_file;
 	int ret;
 
@@ -343,9 +342,8 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
-	ret = vfs_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		ret = vfs_mmap(vma->vm_file, vma);
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);

-- 
2.47.3


