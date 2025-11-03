Return-Path: <linux-erofs+bounces-1332-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D65C2C819
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:57:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZSy758Nz304H;
	Tue,  4 Nov 2025 01:57:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181874;
	cv=none; b=dtwUtZOWIcmmADMEZr4axk3YKbN/PJKLJvBFizt+iYZjHCkLv9aIScid3wXfy4VzKEzDKC90iS7Dzbjg2s2mbusrbgLKjjTlDhu4KeZvcjNWfyN0X+ciLMrMJKy16RBEdpg/u63G/hz1GbzB6iX5HUVu7IUyE2htwChE11MKEyzmEyfT9ettFUEPaxnXdAddPZfwyD8S9FritO/4rGoeSvaZg/PZXiXZYPfbdqE9hSvGiIlFNYJCZOAChGawh06mkPZlEhyoOPjgCQy02dHXysFv+u8fegfCmlW7w9XtH7M+f7SOlt6ADPxO6wiqTZPEh4yLE3R2Pykea5FLdiOUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181874; c=relaxed/relaxed;
	bh=oWSBUH8frfHEyif7+O/4H74AAh6gHGcAk+EPPCOSD8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1FfmVjI4VHfvLK2nTRFNzrJzgo8N6mARGP9U79zXPPGl0I83u31k7BYf1cj4NvHHj+aLbiiM08hZ85VHjQ0eVMTDfUbSi+UXy140BNnvgw2Jtx9y84XMIiZQG3qPnwrY0uxwoGYUxlHcJklwu425xuzQIH6E9mEjrVDTUN7AhAEeURd0Q7x2wJZLbqdGLpVOQxsz1qN3qzXws/L4UwfS1WUR1JKdf7vWH6I2w4/xuSuG6WNnHWZvg0DyasBUSQzq14GLiR0RJew9MDfYA+uL5r6XF4dpUYby6gcA54e6j52I8o0/SRoODdvO8hnH2hofOgr9C+5WKR9Iy9HxINiZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vLjXuUoF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vLjXuUoF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZSy2Y0Jz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:57:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1220C43317;
	Mon,  3 Nov 2025 14:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA7C113D0;
	Mon,  3 Nov 2025 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181871;
	bh=4FIQe3VxffPxgRCmmS6I3GrfGBF+QoGj3ILC80hQv90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vLjXuUoFUJElIwFBAcCMlGSjdBOYo8gViAn1eihUG7yDV+RMuzPOA3H2d6sdWQVT0
	 iFCAm27lSJk35WgvtHROw9cceYwMa2ddvBviZRxwdG39lnt/3NBah/yI4tmRKIh9G8
	 xK4XU5iXq/PS+5lKtTsBYwdmNDPMAaauXKYm4J1BWqdU+kXHabP36pWK19zCvwdbS0
	 AxVVaD0g1CbYB38i4TSTjywMuKTIwRURV8jCuKbC4+I67e/LmA5asrlrRlZJO4wKxB
	 N6Btegr3aD6lhJsAi0L5m7psVMgrdxWm11EdNanu1fQMv7m1Ko+Rt253CMCHFHsqvx
	 woawv5v9qdMoA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:27 +0100
Subject: [PATCH 01/12] cred: add prepare credential guard
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-1-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4FIQe3VxffPxgRCmmS6I3GrfGBF+QoGj3ILC80hQv90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrhqf+l6336T+fDHRf3Tc271VSQHnqCe7JxX4K54
 fYSljWqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpPMTwz3J+wMbc/ScOHZih
 deWlNceNtc4zVJX3r9fltz/OpxEj4MHwV7LbYvuDVeLHeSfnrls3T/7vHqvOT4q+e7JsVbh/b+P
 O4QYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

A lot of code uses the following pattern:

* prepare new credentials
* modify them for their use-case
* drop them

Support that easier with the new guard infrastructure.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 1778c0535b90..a1e33227e0c2 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -285,6 +285,11 @@ static inline void put_cred(const struct cred *cred)
 	put_cred_many(cred, 1);
 }
 
+DEFINE_CLASS(prepare_creds,
+	      struct cred *,
+	      if (_T) put_cred(_T),
+	      prepare_creds(), void)
+
 DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 
 /**

-- 
2.47.3


