Return-Path: <linux-erofs+bounces-1321-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D4C2B545
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpM0M8Hz306d;
	Mon,  3 Nov 2025 22:27:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169259;
	cv=none; b=Mb895S4o/fCl1FXWhaDUiSsAIsCpq1BJEMw3AmUYV3zBhF20ECDawdPQs+SPwx5EWL5wGG48fqaomsYfX9X23kftJ4EOvrrmi7AiOjgvIWAGbWh6I8fDdmfzR1D2brqrHFfV4BlYMDRbFgNXaXBGqw5geJXAaIH/MGDDWZYUdUzQVFD6DE/mC+RA8HFkkDlzOKLQrzJYfGqUBlRJiCeL4KlM+SYSmAowQl3/Yi1oncLpynmby1QD2BV4F0bxa0usBaWeMI3K78erZ2xZ6Ilxj4vRsj+z16bkfBaLJvi9wT1UK8B2qmEyq6eQ0trWgcSKZJKSQtFXiUIdwlPpnFBJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169259; c=relaxed/relaxed;
	bh=2Mtm4Z5JT34VOmvpxmZ6Zhtt5Qk2t5HkevkihuYl+QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mngeKBbi5Bwx1vjGfaTR3ROzwmVZBukR2yscub2thdulKSlAXzDq23EvFS/LmbyEFbJqOjBcL5r4uKSA6lEoVwADV4nCUD/hUwybkVKyCxwmNhmqynqR5zmYlR0zHshaH9f9yGQEVzzrIdMf1MMn+zknBmi+5jCB9BJZpAUdnJJpwKFEm+3z1dWXmYeGtE9BsVl3zwIfkc2PGSU75T2BKXw2PFWSVxeJYlu2idps+AnjxutcnqrN4+IL1SZArZgyEvFyg1W7BATe93YD5HThBH10Pc0nC3sya1+1BawcdFLFVtFwnuKRkl+YcUlz8xfCXASjI7r5mlZbCAikg64q9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZUPKtFV3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZUPKtFV3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpL3584z2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DA06041927;
	Mon,  3 Nov 2025 11:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A7CC4CEE7;
	Mon,  3 Nov 2025 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169256;
	bh=Dmlif8BKtwQInPdLdn5bmZmsNB9JrY68RKP9X41cJow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZUPKtFV3jOi39pVhMoqR8e+UPRvD8cPvGK/TkNTy8vTll6Oouo05sQCrhw0nfZDPU
	 s/jAhMT0H65hYbdhOeiQsxtVsMu2oucHMQDOrDCEgqIFKjvOArwVTj8WgZCS6WFiCK
	 39I4k2MygY4lp/9bXa20yBCHpwDKravlvwx76sjTw87aegmCG+byCk1eMVdNGNiHqr
	 OHcnSv4HAzT9yLtfFWHoxlCZUMAqe8rUAmhrVmli9jWYvaKUerYjqdhL1D1nTKJ68V
	 vZ3TmrcA0bbjAy30X9+q9DMuC7dsyD5S/UzDlGW3QS4t7q0Ztr6NeHeOg0KpTkY4RS
	 fk/zNlNTamaDg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:58 +0100
Subject: [PATCH 10/16] nfs: use credential guards in nfs_local_call_read()
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
Message-Id: <20251103-work-creds-guards-simple-v1-10-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Dmlif8BKtwQInPdLdn5bmZmsNB9JrY68RKP9X41cJow=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGyvbex6eulmk5e9TU2E55ZKDuFyts3v7um+t3b6t
 Hr52vMKHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM594mR4WpZv4bwwY7YjsAH
 WcGLKz+8a2Bepp/NKm93q73nZ8Kxuwx/hZS+es9b9zIiqKb7TOm2x+5T+/mNXhjklOs8fJVioju
 DHQA=
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
 fs/nfs/localio.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2c0455e91571..48bfe54b48a4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -595,29 +595,26 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct nfs_local_kiocb *iocb =
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
-	const struct cred *save_cred;
 	ssize_t status;
 
-	save_cred = override_creds(filp->f_cred);
-
-	for (int i = 0; i < iocb->n_iters ; i++) {
-		if (iocb->iter_is_dio_aligned[i]) {
-			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-			iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-		}
+	scoped_with_creds(filp->f_cred) {
+		for (int i = 0; i < iocb->n_iters ; i++) {
+			if (iocb->iter_is_dio_aligned[i]) {
+				iocb->kiocb.ki_flags |= IOCB_DIRECT;
+				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+			}
 
-		iocb->kiocb.ki_pos = iocb->offset[i];
-		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
-		if (status != -EIOCBQUEUED) {
-			nfs_local_pgio_done(iocb->hdr, status);
-			if (iocb->hdr->task.tk_status)
-				break;
+			iocb->kiocb.ki_pos = iocb->offset[i];
+			status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+			if (status != -EIOCBQUEUED) {
+				nfs_local_pgio_done(iocb->hdr, status);
+				if (iocb->hdr->task.tk_status)
+					break;
+			}
 		}
 	}
 
-	revert_creds(save_cred);
-
 	if (status != -EIOCBQUEUED) {
 		nfs_local_read_done(iocb, status);
 		nfs_local_pgio_release(iocb);

-- 
2.47.3


