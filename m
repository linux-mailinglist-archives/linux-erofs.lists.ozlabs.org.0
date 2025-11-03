Return-Path: <linux-erofs+bounces-1333-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F092DC2C81C
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:57:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZT2004qz306d;
	Tue,  4 Nov 2025 01:57:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181877;
	cv=none; b=Fz+Af07bYfebeXRNzZe87i0XrAuwmAj/+NfDAxVjcaH1w9NN5mHJM2yxlB0Ng8klOg4Q5JfhPS7x2Mlm2YSpZv7g4kJjb6cIASrSR6nOlHo59hMmxkE+ym5iXweFMvgBjooR6lhFO/X3SnEgQ07D1rkjHhQpCxq57bMpCTiWEithhFH+KSkX4fXpsSgvD28vlODIpIXPvGzupRkVey4y2Bc6KJY0yTW3hw0g7DAw9c+e9ZCVi984OGsWcEEZJM9pgI5v6piYfLpsihIGbQ//DG6PzXoNuu8FFXuqzQyE0I1wnMGVnHbtrqJaIP8XQFAeN18Y3c01Vm3QOeEkzyEn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181877; c=relaxed/relaxed;
	bh=YGZkD8w+n5kzn5I/hRa0Nu6EOSPEG3IUR1nHV+kazcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzL4ZdKV1WWppIeagyqSBbXOkpz56uY231g+iStNSu5SbZh3q/QbJ4Nj8e32J92MrLzu8Ps5Hx/ed8qW74YvqXIQDckgRIBCUlw6W2HGwmDpwfDRGeMEIiOk+KfxHC/ILobY13xG+ewwyElQzxgfzo1TIb7fZoTKCo05bx+NMEE+W9aC/GQhooJDn69v3gcZGGvxPoLS0Z+WAKY2PyXuCoRwxCTJ7hw/oxEsxnQBpipzJ5iRdjQzJFXunXPSKp77BtkycXH9Ap1di5nzw7hVfPikjIvYUu4dnvA3WwjPM3N64MDis8xMW1xzscuviLUbDj0H/TJOhBCj9C150xBHEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2wLd3sx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2wLd3sx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZT13spgz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:57:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A873F60142;
	Mon,  3 Nov 2025 14:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB4C4CEE7;
	Mon,  3 Nov 2025 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181875;
	bh=hgkklzfTerCwn6xW0BCQ41853TdMJYRvcgAE5M0xYQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2wLd3sxfx6r1r0GoodOvyvfY2BqexLnPkiaRjmgO4WFNcJOtSLd+mcA/t4apNfgF
	 Y15njJMrP6EshXnNLc8S93q27uPRutrlOAJ7DwqbRJGK8noAcHnvsW3epmMAf22T9l
	 343cSmpA9Kpt1SdAOPwqfrO2KPUxcotPK0xrR4sCOaVX+oyJMC+GLlE5GudrvZqES5
	 Unt0LXqT+5DyH8zm/AuSLWIfMjcM0sPrwt3YST18lDpb6QrPe8mZED99l5H2rfLk0E
	 rdXNQrvCp+bssYibRawYXm7uxvjB6n270+gewURxwnC/Bs2b5sv9Fd0zUT1Yv7Cr6q
	 5dI2M+G1dJZzA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:28 +0100
Subject: [PATCH 02/12] sev-dev: use guard for path
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-2-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hgkklzfTerCwn6xW0BCQ41853TdMJYRvcgAE5M0xYQw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHpx5VP+PfPGc9c+np/VuvH0v/bpz1u/Ml8UPLz+1
 rpIlt/7xDtKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAm8pGX4Z8FSwKz59Rc02gn
 GwcbnsI4h7+p4osfx+n0mDH3T+L1WMLwP23ZHsHkndXnPsv8ue4csto2fOqv8xnHq++8PMT3dLJ
 gIyMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Just use a guard and also move the path_put() out of the credential
change's scope. There's no need to do this with the overridden
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 0d13d47c164b..c5e22af04abb 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -259,8 +259,8 @@ static int sev_cmd_buffer_len(int cmd)
 
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
+	struct path root __free(path_put) = {};
 	struct file *fp;
-	struct path root;
 	struct cred *cred;
 	const struct cred *old_cred;
 
@@ -275,7 +275,6 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
-	path_put(&root);
 
 	put_cred(revert_creds(old_cred));
 

-- 
2.47.3


