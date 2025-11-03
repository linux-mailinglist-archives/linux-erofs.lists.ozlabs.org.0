Return-Path: <linux-erofs+bounces-1322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 68265C2B54B
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpQ31nLz3bf2;
	Mon,  3 Nov 2025 22:27:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169262;
	cv=none; b=IU8QCeGMDfeyg0kb95ROFirenq8um8jq6ePi5uuiO7h0CsKZPgl4vLUXqJkFibtZS65dgNRJuNuVQP96r9S5uAb9HtK4ZmZkrYDrGjylxZOEnubH631q1NBOod+K0/hd2CEsHxgbbC7Seb/h25m+ZTQiT7at+m6a3oL8J34fYCgwOwskz8JtDChEwVdp/1Vgzc7sY/CAAMCEeFNIrSVf72W+9xk7i32JxCvvlfMb+8HFNwhS7nObW4/g7sN5wfDtHL8AB7S5/MgtWuXhTAXzfWP1WGRMLmvjbh/L8VRqrg4Gp7lLuLn9wfBJe43HdX1crg5x4BJbQC1sweKT2lh6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169262; c=relaxed/relaxed;
	bh=3R3jv4VNgZ6nB2LEeF5Abbcc9d4+q1O3mX5rb2Jvw1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULy3sIaCwHBkw8pq65HM0A0C6vCouuM8sTB/dxSfIxO6Yc+4z6prSOJPPHaFZzakyqxJJ6ASkvoNdWg1OUCctn5HmIqM1TMSaYEhLjDDLBYCFogwodaBCDFzi/eH51M5/x5OEtmjN0tWDTRjQ/45F4uinXQjbIUMEfm0gkNsegliT6bxj06w6mFhbWBNGXyupSW5ewBFwW5quKu8ncnDX5K/OuwVVVozDcz0VQNegRO+Ub+xS0tnNnqbVni2zpyTiUiU0aG75iK/3Q8hVm/YtV4vMhzzJlD1chdBWjbLfiCgqQQPvpwAJ1ykAGs6R/QMzAOxS39Ozb3TjNMNAsUdIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O0ftDU25; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O0ftDU25;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpP4xjbz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B29241AA0;
	Mon,  3 Nov 2025 11:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48643C4CEFD;
	Mon,  3 Nov 2025 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169260;
	bh=S5SWhHP1AKnpAS9cvNavzXbz6fN+yKJB66DWhHiIX8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O0ftDU2583umsexJKbRZVn9zJiuCwK3OrzAB25iAlfQ7R7sQ3Wg+ni4/AJfDhnhjG
	 4sDpwHzKXBwubFvBfYWQMXDlKurxb2ZgEJ79NWi4SCcFCXm+zWmu2LuA8Tqx7G/IOY
	 7sPCsPHcSWjteCW4PWnclWDwdP9tGopfXU8zy72JJ8O9aN2A/pSkwH2dtX13myu8Hh
	 IhxXoJ8ywUtbTTYpubuBigy2vviCiWcKk65gjwbfPw/ciGpKjVC3DO8s5l4z0fblkX
	 5KOX/B1Zv8juI/9V1O/vLt3bfgwjTw+pxFJ4697kdWV1JOXmUS4OCoxuuX1ZVlQ9w6
	 vskR40Jqe+pRw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:59 +0100
Subject: [PATCH 11/16] nfs: use credential guards in nfs_local_call_write()
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
Message-Id: <20251103-work-creds-guards-simple-v1-11-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S5SWhHP1AKnpAS9cvNavzXbz6fN+yKJB66DWhHiIX8U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGy/fqQ6cGfSIttn8vfUa1PqJGbNeRPqc9AtXFnob
 Umq+DPljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEpTIyfDkp9167567kgjTx
 sybv0n+tLPm0yiJlToyM+hQ/j+9WwowM17SSNCR0XDy0jbrcLXwm+AmtYerabNC6nH3apOAdm/w
 4AQ==
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
 fs/nfs/localio.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 48bfe54b48a4..0c89a9d1e089 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -781,18 +781,11 @@ static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
 }
 
-static void nfs_local_call_write(struct work_struct *work)
+static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
+				       struct file *filp)
 {
-	struct nfs_local_kiocb *iocb =
-		container_of(work, struct nfs_local_kiocb, work);
-	struct file *filp = iocb->kiocb.ki_filp;
-	unsigned long old_flags = current->flags;
-	const struct cred *save_cred;
 	ssize_t status;
 
-	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(filp->f_cred);
-
 	file_start_write(filp);
 	for (int i = 0; i < iocb->n_iters ; i++) {
 		if (iocb->iter_is_dio_aligned[i]) {
@@ -837,7 +830,22 @@ static void nfs_local_call_write(struct work_struct *work)
 	}
 	file_end_write(filp);
 
-	revert_creds(save_cred);
+	return status;
+}
+
+static void nfs_local_call_write(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	unsigned long old_flags = current->flags;
+	ssize_t status;
+
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
+	scoped_with_creds(filp->f_cred)
+		status = do_nfs_local_call_write(iocb, filp);
+
 	current->flags = old_flags;
 
 	if (status != -EIOCBQUEUED) {

-- 
2.47.3


