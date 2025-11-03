Return-Path: <linux-erofs+bounces-1341-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD33C2C840
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTY4PSNz3bf3;
	Tue,  4 Nov 2025 01:58:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181905;
	cv=none; b=XN9flCoMs/Rd5oPs7LzMnjaxDWTZtKowN9XOBm46IKneLm0lPIntVnNDT27UkOVpU8M2pnGwdENUFcWuesI7AtbfsjEOm8mVgQ/AKbCzZdMzgPdZVQEIWQTlO6cInHwyIICJwlCm94UgRScrDHT+M3X6OEODkQDCMersS+eg+6kDnAKOWXPElXxttgE80a9bLtGJFXpKeKMDFjGYfSvRB/ln/MTyuKPjLtywPWJnrlAiKXKOcDbBGlE+1JJwLYLwiy+k02fgZ3sy/OSf+lE8mAHP7l5bw9vmnjqGbDH1TLrbwnz7FqDHwC/F6hLE5rHnaf6HNpcXZt1V+JUFeHTgew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181905; c=relaxed/relaxed;
	bh=jhyNcU45PddyG6NY5QYYlCxnoDT1LIXJQcp1Oi81baQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSpDpGkdZEchH6t8Z7T785L8tU92/STRvIzBskzR9YjAw4+Eu8srkBFvd7so59wDCB6LwtZgTappAqKRvh4JeL3X9hPR69mgIPN9dy3FbRaESvvzbonJaNiEVX6I7Jxje7llRnMapD05UMgWwympQlh7U/Bde4DWgN5zI7VRwWO2AMCxsxw6+z/qFAFEw5tJOF7H8gmVtQLVTRaPJ3v+iypxMdibcRrtC7p3eWG90eXShpcLbf/F0FD1EPrriPXdr7HnM4Tb1+nozdp59on3eMLIeDY1deJQBc5RI3KxwSE9NbUA09yl0ZJgTz36cGjlNpuHtmUaKzyTRaJCx0hDwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UnuQoRf/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UnuQoRf/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTY0P66z2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 32B68601BB;
	Mon,  3 Nov 2025 14:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91CC116C6;
	Mon,  3 Nov 2025 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181902;
	bh=owV/Eekd/Ucg3vFKIrGEVlXyUSEK1yiGGOB8cDqW0Rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UnuQoRf/PeJwNPDSGCW5mXyEpJLYPzFpeFhGdPnORVWh9sUnFHudllQ2hCaEiSieE
	 sQnAMSiLhBe/vmsUDa5iNxOiGFFVOSJEZKtdfxAiuCdHHuhcswxKiFHvKjxgxnmAWu
	 nSKDXMMfW64z3Xzp8RDcImZQNaMF2egtEHfPntmsGgAO4fU1HdFij85WQePDZrqgSm
	 IoEvuRDLjlgYchNMe0/g6aolzcal0Zrpkkrid8v/zHOIYeI32EQv+GYeq/0/uJFtWN
	 kgcpZ12d40QJ1Y609PLC0HH122AaBxWx/ovfUwUvL/L5/0x59a1/4gakZQSfpepqK+
	 2B3sUf9scN0Eg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:36 +0100
Subject: [PATCH 10/12] coredump: use override credential guard
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-10-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=brauner@kernel.org;
 h=from:subject:message-id; bh=owV/Eekd/Ucg3vFKIrGEVlXyUSEK1yiGGOB8cDqW0Rk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrJHLgt8mK/gm2Pdu3sfU8ef16VdHmq4JPOMMWFb
 5faX6/83lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCROzcY/idvX1jNd5BRW/f2
 F4dktuv/bzTfmXf9EgtL0ge5zQ1nL9oz/GL+lVZz5LsjL1eit9uyJ8sy75sE7j4qdm9aTZlPq5S
 fMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use override credential guards for scoped credential override with
automatic restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5424a6c4e360..fe4099e0530b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1160,7 +1160,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct core_name cn;
 	const struct mm_struct *mm = current->mm;
 	const struct linux_binfmt *binfmt = mm->binfmt;
-	const struct cred *old_cred;
 	int argc = 0;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
@@ -1197,11 +1196,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
 		return;
 
-	old_cred = override_creds(cred);
-
-	do_coredump(&cn, &cprm, &argv, &argc, binfmt);
-
-	revert_creds(old_cred);
+	scoped_with_creds(cred)
+		do_coredump(&cn, &cprm, &argv, &argc, binfmt);
 	coredump_cleanup(&cn, &cprm);
 	return;
 }

-- 
2.47.3


