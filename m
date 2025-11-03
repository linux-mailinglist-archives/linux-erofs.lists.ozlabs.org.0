Return-Path: <linux-erofs+bounces-1343-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B48C2C846
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTh3K17z3bfN;
	Tue,  4 Nov 2025 01:58:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181912;
	cv=none; b=Fy+79mBjIEZZCmOYIZY5I/Y8ZrZXcGYsy3yCpzOjVyFmHFChTWJLKwxCHy0dpOElyoUk/KZLnDAUdXFKGhPmGqmUQd5YCo21Bq2CYYF7Nh6OGdCh1etMS6bJJEGM/XJD4UZzeOYtyEBdsxssdYBJpJrj++4q4rwlClcvD2y/2FqizjeWplYwknu+XBq/jClGmivB4Aerzn33SwslHpNTe9GEhRv2yPRhaifT6DMuu6nk1O0RqweyJW3vo3PNToPzAXgbnfLE0WAlk98ZsIf6FZeLCFRIancTqj8OAIg4EGlNwwHOpxOnkOAHuM1Dsb7ucldk9fGESinZtMURAucHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181912; c=relaxed/relaxed;
	bh=S8vrKrEU5ypiEXMUzfA8Su5FEAzsk7lEbTx82gesw/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWAvcDcr/ie0SzhwTYfm9m65G+LwUUNqJYLgUgU5FcppOg/RK5XFq/t2HEiSJI0Z+wl+Ci2zczaEUcImvxT9WHEXfggEcI4JpXlE6Dm7CM5Y88UQ0qEz/viEmx1PLJkV875x/WMyDVeYud3QpwRSkAVOpAtBzoj6T00NPVMaj7smzcVHT05jbDe6SqwwgO1wZuNOpapM8l2KWCy7dltW0trARz4iJCdwcJrmHUdDSbjQTHCJyT6omyXMqtHtfQgx40omY/cfZ1JWL3wRUf5B0qFbhmMHUiIlDkfbmyt50Pcb/OPGp/j2VFZeLyOyERa5dzgN7nxClcbN4Rz5XxBU8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rpBZwE5Z; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rpBZwE5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTh0PRdz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 329D4601BD;
	Mon,  3 Nov 2025 14:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F91C116C6;
	Mon,  3 Nov 2025 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181909;
	bh=CN70SPaB9uDUTmoTMFQEikVK97VTOop0si2tr6t5dG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rpBZwE5Zcf6RBsQu6RQgpC/IOnpRjzOaYYoomnODvXeBO85TArXHgKIPf4o1KLwv+
	 RzbpwGM3RxPzCzAdgmmMBq25UmuptGH+6wBUSwwshEax8fSLZR8yw1RvBLk8qqC/aH
	 KP5SheycNIKw15+ZoULoPxIOaz0zpAswNDYLIql7dCo2kLGz/ij6CMdf+3eWWVapx6
	 RZ1qngT/jX1ctwOiKGTwXqW3OsUQjlbR1YFn6LrpLXVUirPAj1UyARzoJNT8UMd9Tf
	 BurHwguSrbMYI64Yi9BpIUYlkZDPch+DB9a1ZZh9PiZppcpFnDUgTLvy+Qu3Rh8Uop
	 RJxn/Pes4VDBw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:38 +0100
Subject: [PATCH 12/12] trace: use override credential guard
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CN70SPaB9uDUTmoTMFQEikVK97VTOop0si2tr6t5dG8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHq5Of6I49wDL3cuF1ZOPtQr8766w3eGAQuLxusP1
 745yP973lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARwQ+MDN8aFc4c2FSw7vom
 C+OaYwbfUtlcVpxTr9tpcMK7rDm9Zg7DX5Gwnl2dczkKWLtTnGf/eyuVkLYqfc3KE1JmTosWnJ+
 jzAoA
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
 kernel/trace/trace_events_user.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 3461b1d29276..4528c058d7cd 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1449,8 +1449,6 @@ static struct trace_event_functions user_event_funcs = {
 
 static int user_event_set_call_visible(struct user_event *user, bool visible)
 {
-	int ret;
-	const struct cred *old_cred;
 	struct cred *cred;
 
 	CLASS(prepare_creds, cred)();
@@ -1470,14 +1468,11 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 
 	old_cred = override_creds(cred);
 
+	with_creds(cred);
 	if (visible)
-		ret = trace_add_event_call(&user->call);
-	else
-		ret = trace_remove_event_call(&user->call);
+		return trace_add_event_call(&user->call);
 
-	revert_creds(old_cred);
-
-	return ret;
+	return trace_remove_event_call(&user->call);
 }
 
 static int destroy_user_event(struct user_event *user)

-- 
2.47.3


