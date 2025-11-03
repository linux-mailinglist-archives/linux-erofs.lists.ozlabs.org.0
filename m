Return-Path: <linux-erofs+bounces-1325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4BC2B55D
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tpb4Pz0z30Vl;
	Mon,  3 Nov 2025 22:27:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169271;
	cv=none; b=WhzZDkYzjIHv3To4sAdZyUZbzPiAyMmqyF0/EuNiYEozqNi+Q++2W5ix59MJH8OQzqjkuCYuv5/H+gE/Qwqxl7v8SjqP/jY0clYKn6sff763sUY/ZUsY1Z4LqgIhJK4VTaDxQ1GaZppc1LbI3znfEIy0W/uGrlTa5NSr100zxab97C8QSoQp4cPeV++6gYGLy82s93adIpKNCa1TnlKXEYVBJ10rF5PuCS7KMPgi6wLprBdQbN+g/Uu3i6berlzuJLWy/fsVKXzLUGBf7Cv8LezYm2zjrObrio1zwO8ZTqnpVU+C6aFwPsRqgS/DNzi3cNuarfkmcFmhkcKWq1OwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169271; c=relaxed/relaxed;
	bh=7Ufhy2aRUm2q3R3N7ZpIl2UUbxAsbPd20b57HFjxvco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNFqAtKmwqHylmaaalH47H3jxmA9NtV1QgsWH68UhR0L1m9cPtOS3p4uLhwRPsRdJM962TAZpMOjfuDkom9JerMR/GZD7/yU3nWMvv7ywkvITmoo2xPsN3R6xTtcfbOnghEnJxR4yHmnUx8uuJGPJ6SPbSSU7XwGb/QAGPwrjpVrBHHaRmdEvPXMIXB3LZsiPck5niYV4owROovl+eme1S9FXCpPQ2Bb+jw+KOWfauwa/p6Yjx0P0kTRGrf32Ch8ZBqat2CstKESBFS3FFhRdtWSkgdtslCq+RfWGbUUAi181K1TqEfYa5yZQpLWwY6Yv/nH0nHUMTbKd15fdTyNQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LDRfwTg0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LDRfwTg0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tpb1DVvz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E2196013B;
	Mon,  3 Nov 2025 11:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E30CC116B1;
	Mon,  3 Nov 2025 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169269;
	bh=levEAcCe3qHl8KZRvufqmIV0fvjVebO71tbqxGWp4c8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDRfwTg0QjpeDhA96LiFXb2SmOmHJAJ6a9dSzCXfvQqX9nLZUjs+D0oIZPvsD13Cc
	 DC6K459GxA2yHnye+Axchx4DJiiXPzjjzX0+hfnaBz9If5gYv7tBIXbx7+ChxrTMoL
	 eS+yXl4PmkrV50ukt73jIWiKBHPVuVdCOOufeSS+jY7GWhmcnPx/+pqpJT+RU1h/Xl
	 bbMQWziX/brtBe2/isOU1UN5rPdGXSRPfAU+36rZSsnXEhX3gdnqj2NlA9FcZqZEZa
	 GbyQk5XcmL7JqQ2K0EJtLBN04m+wUYPmKmFMRgaRw8gBIKYkRSI3FjwzjbLJpOx2BP
	 UJmL0TJCELZEg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:02 +0100
Subject: [PATCH 14/16] act: use credential guards in acct_write_process()
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
Message-Id: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=levEAcCe3qHl8KZRvufqmIV0fvjVebO71tbqxGWp4c8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOy4whNlJb48P2yuqN7RhJvSEzzP//y2iuGPXsCzX
 Y79DkUqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZeJ/hf8Fepp9pKmwlwSsn
 TzMRt3+Rap1ikW1ZHB53xcU9JfJCJ8Mf7tQYZ9mT/wXrbzy9nL06/M9HjkUTSsPLr+ZxdvjP2jy
 ZEwA=
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
 kernel/acct.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 61630110e29d..c1028f992529 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -520,12 +520,10 @@ static void fill_ac(struct bsd_acct_struct *acct)
 static void acct_write_process(struct bsd_acct_struct *acct)
 {
 	struct file *file = acct->file;
-	const struct cred *cred;
 	acct_t *ac = &acct->ac;
 
 	/* Perform file operations on behalf of whoever enabled accounting */
-	cred = override_creds(file->f_cred);
-
+	with_creds(file->f_cred);
 	/*
 	 * First check to see if there is enough free_space to continue
 	 * the process accounting system. Then get freeze protection. If
@@ -538,8 +536,6 @@ static void acct_write_process(struct bsd_acct_struct *acct)
 		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-
-	revert_creds(cred);
 }
 
 static void do_acct_process(struct bsd_acct_struct *acct)

-- 
2.47.3


