Return-Path: <linux-erofs+bounces-1326-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF0C2B560
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tpf4rSVz30T8;
	Mon,  3 Nov 2025 22:27:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169274;
	cv=none; b=DqB+PAyZUvDKqs5f1h/LV+QLW7ojik/aQrrDngIxvubK6M+u+rGOvgM8pjHu1fLgL/VMm7lWmPXNAFb/gHMQEJWtR01Z8RStCwioMgFLFdpIuYgf8TBsLUf9wIg5mfHpW+ynUzQrtJE9//Ue3x8JvyV7MiRtZ2LewWD3Ag5SM427w7QC58KKc23c2VPT6Weyo6xo7NjCmTKeTgd3E7ApCun57NNr5k0DnjDs7Z+yiR7Vu056SQCHErjRkh37LT15c79nmNcAQFvC7lbQCR1jQRR5Q2iesTvlPp/CQu8UpoyhWrnnDuM7ino9FqW+dqbdudIU6b0uLWJlNfOaBGcE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169274; c=relaxed/relaxed;
	bh=1x66y+ZOuE2VjGknCaTnKtsuoOo4IqfUANe8eqsarfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy9IF5L7WyAYvyqs8hq3evOAICgcPGKklgDrlrrWszXcXucH4Qo1V4RVuLo/NZWU/L62vElI/JKjA9w1MdCtWAy3NR8ViUErr7UoMNwgYxzyLWxXpdwT/onGwP2uYomqp74nLgIMJWyouDDX6QQoaEVIffW3oZTdMWqwJwNFQxxWKkh8qWn9K696WsUzWXQ1Dbv0y/67L956kAOCbNg9jl546tWOUgSCVBygTlbef/veKtkPYnsL7pXI5qUw6IdSQgl78of0pRlCf3HPQ2Qlp9hwOFvsosHx227Ir8jNrGEzjQfQiff9Hf5K/IMEJo4XnNCID02paX5FzqWsHJmf4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BVEFfMfx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BVEFfMfx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tpf0Vh9z2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A3504345B;
	Mon,  3 Nov 2025 11:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA1C4CEFD;
	Mon,  3 Nov 2025 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169271;
	bh=M/gRfyTv5mKfZ+5BvhWQ76LEQ3tFhX77yWuNWTckzIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BVEFfMfxhAtcDHBJCjcRf39J+5yktLhjR/ZEOHo9p2nFmgkmjYFFNsz5oIU/U8ZTL
	 9irmY+G64LxOeURMJwzrYYPbRuyimLKkAsFmswkr6ayePhzuTycrYOMwvYBjeg44kL
	 fZh4MxKTDUwste9fqOKAyNQ2wYd7iH3XkjngIZOlmUGVNO+/HlDAszhoz8tfJHzN7K
	 A6ysUam7UPg/1PHBR93Mf6ID+j+UPcWIpBlrThXvVM3VzfY2pKJMW5jcUiwixDaa05
	 1ZHbalHthOrPVyftU1mntAlNvT/Fog0UCTJ0nGQl9ANDYuJecuRDHSA3zVl7E3MiBm
	 NqcPsTSXtAoHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:03 +0100
Subject: [PATCH 15/16] cgroup: use credential guards in
 cgroup_attach_permissions()
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
Message-Id: <20251103-work-creds-guards-simple-v1-15-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M/gRfyTv5mKfZ+5BvhWQ76LEQ3tFhX77yWuNWTckzIg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOwIF1HWiI55/L9ds6r6Ed+EQyobr71rc98e/UptT
 nKn4XWzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0SzH8sxB2VDhxXOsZr/O3
 xuBV7de9Su/HHFLoTA64c5B7742/KYwMa6dOZXfuuuMXXnvh69dXJwVX68SutZe8tXda4kPLf4u
 mMwEA
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
 kernel/cgroup/cgroup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fdee387f0d6b..9f61f7cfc8d1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5363,7 +5363,6 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
-	const struct cred *saved_cred;
 	ssize_t ret;
 	enum cgroup_attach_lock_mode lock_mode;
 
@@ -5386,11 +5385,10 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * permissions using the credentials from file open to protect against
 	 * inherited fd attacks.
 	 */
-	saved_cred = override_creds(of->file->f_cred);
-	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
-					of->file->f_path.dentry->d_sb,
-					threadgroup, ctx->ns);
-	revert_creds(saved_cred);
+	scoped_with_creds(of->file->f_cred)
+		ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+						of->file->f_path.dentry->d_sb,
+						threadgroup, ctx->ns);
 	if (ret)
 		goto out_finish;
 

-- 
2.47.3


