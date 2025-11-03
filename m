Return-Path: <linux-erofs+bounces-1342-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 32100C2C843
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTd12zhz3bf4;
	Tue,  4 Nov 2025 01:58:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181909;
	cv=none; b=gX7C6FuU/yZKMtaTK/qkfTryWn72Zp0NJlY8BeQSyN1x+J+cqIebM9XqMKCnj4MWBGlYnTh0TLoyC0QSBdJPsWfsyGnTvgSbZvANQWjZh8uvk+O34kMkJYHYp5sR12dKewDrzPppaAQm5wbQVKsI3E8itee/DpJvTin794N6APWIfCscanONbwylHxdbA4MIHBJeHWTnqaLzqHv3/8XJQmae5/TyMjfxqppSqVllDHYjoQvhBS+WcktnJzoufgX3gxJ/LP+SmxgOYyIwqkoVo5ZwhnIbegJYg/mpMJDhc2D8ISEwTmgTYz8MBWi7LXXRRf+N34P5Ojpj06lKsS/xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181909; c=relaxed/relaxed;
	bh=TUJDFcd7ymBRzvN0y6LdSNRjnY+0pjVwxV7yzVv2ltY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyvQ/UKLEMW6zPs1IY07hMfXfSlgpkL/0RVYQWXljBLbUM7vXU79vC3o+IO3dZMQChRyPqTDDNCaFO9czpaa13ks8YuOPY3cBcYyCubwVjC7Hl86tWBs4VmcqqxQTqv3tGlwlK58surtlbj71L68J6MkECJ8kfxzjm/9A9w3xwlxApiZqLtFXgoSh8b0Z5gClF58yxsQ2IhZTYhJrl7SsVigFNa5wV0ecygJsc23NAav/pmisBpIz73UdL9mysNZOBwbT1rlhb9BfFp+EbWbPHzLPAAGUQkVXih2Eo903wV2+AExo3ly6z0IlPvA3JFoL0TYPMW/vp0C+FJCwXPhww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kZuEia7i; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kZuEia7i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTc43mmz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B194B601B9;
	Mon,  3 Nov 2025 14:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B547C4CEE7;
	Mon,  3 Nov 2025 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181906;
	bh=bY8HkFfKRTUKYlL9vmR8hZHpb2HcHBiGKuybPYfCqeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kZuEia7iRAL2Bjn5nZLeUNYnK9vLIQ0tpub7eCFDFep21XV+b602XA/WZiuC1WTNH
	 jNV6GcU+Xy2gjGxgdZn/sViEQr2VjI5o/280FLspkYT2NJpPz4j9DAYKxSxfnrkOEk
	 kzQYCQg+drGBoAcWtQaZJ4xS109LWXgYTFngrR1O8dZ2DMftX4eGvta2sNcjfweor9
	 u6SXJaSC3Q7DXfHfCLKQ1QQzzuW0YPYZ19ecGVUUKkICfIWv8vO7w1tNU51OkO2d03
	 DUOXN+nKdZuhU8SOYw6qugDtmV35XWT0Vu/9q2T7mx/6Avcr4uAB2fmku4lmzXNGVE
	 jXft2fPTrYyjA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:37 +0100
Subject: [PATCH 11/12] trace: use prepare credential guard
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bY8HkFfKRTUKYlL9vmR8hZHpb2HcHBiGKuybPYfCqeY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpcNDaq2a+zY//ocYTf/xYLLX2nMNk8ZLGM18CH
 +6Wd5r0qqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi14UZ/ikFNje8yOwNi1i/
 /6DXbsUJs+ZtCVQS5Dc/P+Pt1olrLJ8zMlx4EcRg3LH5bP7d2JBzWf9e3RU4HtVuqP1zQVIjv+i
 tGHYA
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
 kernel/trace/trace_events_user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c428dafe7496..3461b1d29276 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1453,8 +1453,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	const struct cred *old_cred;
 	struct cred *cred;
 
-	cred = prepare_creds();
-
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return -ENOMEM;
 
@@ -1477,7 +1476,6 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 		ret = trace_remove_event_call(&user->call);
 
 	revert_creds(old_cred);
-	put_cred(cred);
 
 	return ret;
 }

-- 
2.47.3


