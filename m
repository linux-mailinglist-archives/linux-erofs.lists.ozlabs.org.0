Return-Path: <linux-erofs+bounces-1338-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF55C2C831
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTL5NRXz3bdf;
	Tue,  4 Nov 2025 01:58:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181894;
	cv=none; b=HfRII8efk3bfNsGLU6hLMVLYS1Xg3HP6KT2P5FMf/i3Mpzw6SC0K/tpXTEIGzenV9AshGDbXnZTh3yW9AwtrHfNFbtFYBEZ+D5WIWgNkM4luT10+8R/E/e+6XoVL+0Hs73WhHhyYmmu4GaafvXBn81q2nM2z63WwAwNwrPp+KVOUYQvHJmSic7dCErVrTXAXIuNPXtsu2pVKbFD2FWR4KqztD8KTOPyoH9RyJw6NOict2ooNYUqFvHmrMJPKapREbEPdrdvjgRkBbQ1NjoCJcAD70TrklU8Iu/DjNPcWsQoIZvSORiOHiFmXaO505au7qnyRUo8qhVoZCqTnf98a0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181894; c=relaxed/relaxed;
	bh=0sm9lOFHvz1OPQu2/KWHZ+Mn10iWGcEA60mIOP/CJ2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG7b/W2LAwkHHx69FA3E1zL2pE7vQRoH6cOo8pg1OheB0rPb3vzZR0tNx+NleGzPUPZ0QARgXvBD1eg7rzEy0ubvMssU/nBbNl8bwc3pPFRxNJyMJuZiVVXkem74vhi0ZZj/+fKLtx2Q0mC6GARUu3YfEr/LGf/amKJunERLrmjTpZe2h7E9jxYKg97AqElOv8BJWYx7QpjMsOUc6eTd+69Il5EkjtgKC6WUg7k4ngVr6dNnozlroGSjFfw4fTnf//0ugYrxhh3+BeVxOWPMM+2QPf08RjcV1p07NR17j4XA6YBpbZTGq/9LVpc6e0Ddo4UFQ4zuuqIS1psyki6bCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LokUB/Mc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LokUB/Mc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTL1mycz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB07540542;
	Mon,  3 Nov 2025 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB73C19424;
	Mon,  3 Nov 2025 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181892;
	bh=9EsH2Da/6UhJaCMVF0omDPDa4FG+ogIUAttbOM8Fjec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LokUB/McgJ3/29UMikpNosikAQqnLwDTX7X8gxMGompKPQe50GAhAhDb9V7MfeH+N
	 WybYX5a9QtVgpXPUoJ6vGEf9fR2uq2Wk54rlzuExUqBjsdwfBgwQsIIfnmlrAzf9qV
	 a+dc5BpxypOmzwR2uyHJV3EX4rB6mTVjR9FvQ2wpYVIw9umJ2FK9IaDqpvMTLYkQ2X
	 zfmkvjMdH9mOWJq1wxUGfSxH5UFk04bsEYNaykTa/vg0JJTJlQsZ5bPl35IO0r8rDr
	 SMdKGofW3CBbq6NsS3+vuh9+wtWJxOv+YbsNLt7xRnVZX+xa0wBXmZj9/2V2bawz5M
	 e6KCSLn3GkgTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:33 +0100
Subject: [PATCH 07/12] coredump: mark struct mm_struct as const
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-7-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9EsH2Da/6UhJaCMVF0omDPDa4FG+ogIUAttbOM8Fjec=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpe3G1dtnTrr4PBwxfP/m/JmXpzS8lXwrj/c5Ki
 8hLXajk7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpzTDP9XcpOfRU9T6lQR3
 qW7o3hXK6sfa0fVU60Y727FFC86tl2P476eY7rGk7Xh2TtfP72zTJ7wMexFh1GyRX6i5//1LPwZ
 7HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

We don't actually modify it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c                  | 2 +-
 include/linux/sched/coredump.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 590360ba0a28..8253b28bc728 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1092,7 +1092,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	size_t *argv __free(kfree) = NULL;
 	struct core_state core_state;
 	struct core_name cn;
-	struct mm_struct *mm = current->mm;
+	const struct mm_struct *mm = current->mm;
 	const struct linux_binfmt *binfmt = mm->binfmt;
 	const struct cred *old_cred;
 	int argc = 0;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index b7fafe999073..624fda17a785 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -8,7 +8,7 @@
 #define SUID_DUMP_USER		1	/* Dump as user of process */
 #define SUID_DUMP_ROOT		2	/* Dump as root */
 
-static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
+static inline unsigned long __mm_flags_get_dumpable(const struct mm_struct *mm)
 {
 	/*
 	 * By convention, dumpable bits are contained in first 32 bits of the

-- 
2.47.3


