Return-Path: <linux-erofs+bounces-1334-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B7C2C81F
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZT46cj3z30RJ;
	Tue,  4 Nov 2025 01:58:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181880;
	cv=none; b=BQL2JnV6Lfvicr+V1F+5UiKcA4kLa3NY64/03s5ywYfKUjxSHR0HuoXQpTQWa6xa/ifSdCm9v7Fbo/2P9E1ACPVVr4euEZRl5OTgV/vXjeSsYMlCmQJHMgV8A4Rx+cixOTq7Ru6MMhfXviw5kIWbhb/I4Y76XYUIA3kPepSbdjytAEBoIQPvlIIpMsRlG+/cZQgt4YX3TulHZUNmCz5DwEg02+bRngwFQlCb3gHIQfKSFhFBuXXhFiFdKJVxwhQdOxtkbHz9gAKfWnCb49Z94G1iENmELIBVpUYDB2dnmIjiF0rObLNaCpulR0OBx/VFb9kRHua5v1lMxpyhWAr6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181880; c=relaxed/relaxed;
	bh=+rW6VUqSu/td1hdYCtGB7T3A0CyF93L+A/wkUWGX9Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b06h+A/eJ96gTSKFvvYGBlD98I6Nwn6RpA6D/WqmDQlv+jwY9Pt1hmdS3h+/ZaGKw5tahMhSwc594jtnE8hQWjh6pQBHjrvSTy1brZbpWcy9MGA+w/v7v4ZBa1wXjSrZsX8uPteTKtX0H6kLIflu5qC15tzLs0LwUnaC/U6Irkrm/P5n7phWqMIY6QbwH+oVDGEQy0ckEFqNktuJ0j+1Gp+LqwZmcnclNfk4EStYS+OcXmuTRPQi4kUF/QFS4WKJUm7xGHtDICiEYurwiu0AbQ1bkcpb0IdSyKQbdaKQnJkAAVg3TICYFcjt4m7zx/NSrjBL2RM4Q9ZGh8lEDrbo5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3MQpftP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3MQpftP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZT42pVjz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D654343A06;
	Mon,  3 Nov 2025 14:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4FAC116B1;
	Mon,  3 Nov 2025 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181878;
	bh=2r6XwBdE0iLPZEXMmxkQmO5kEwjt0ojjL2pn4vmivn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s3MQpftPaJnXwoXay0TuEM3GQOP0qNMElUdNNxQ3VSDTxJNZ0o1pxV7Zah//h9Fb0
	 takiJgBfHtw+6pAcLl89M8RFgURS9kFwrEYk14tB6nEwBelMY130P3bDkvOLCicHmw
	 09WwSQh4BIPrkpTz2XIPKE12kmNnAUXjzCwilzjR5HZ+yUIVcSF+Df41oQHXTWerxH
	 5i+vHTmB2SepfDbTuCJJIUOzQJBrkgcqu/jq5Kt+LyOm+5x0laSTeAhxNqEQNy8Q2Q
	 fWKohrWZBXsLOmlGIMndvFJfdSnwUUf3idT27CiY6e5LJUJ5cnpiJhAAZVGkrPOcbU
	 uGherGB3g2jfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:29 +0100
Subject: [PATCH 03/12] sev-dev: use prepare credential guard
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-3-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2r6XwBdE0iLPZEXMmxkQmO5kEwjt0ojjL2pn4vmivn4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrxwK71ZMbFrb8PXdDnFNW5cZDbLmClQoSdmGlD7
 Q+eG/JrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS+paRYVnc2SvG9W9cb94p
 X/jDLzJdxCEix9Jyxs2bJ5/K32Du2snIsKG7mMPzwtmtrcccj8pMXvlDwWv94tPnYh9n3Zs97Wl
 OJiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use the prepare credential guard for allocating a new set of
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index c5e22af04abb..09e4c9490d58 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -268,15 +268,16 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
-	cred = prepare_creds();
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
+
 	cred->fsuid = GLOBAL_ROOT_UID;
 	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
 
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 
 	return fp;
 }

-- 
2.47.3


