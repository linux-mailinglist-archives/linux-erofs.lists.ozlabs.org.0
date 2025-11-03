Return-Path: <linux-erofs+bounces-1319-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87060C2B539
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpF3f0Yz3bdf;
	Mon,  3 Nov 2025 22:27:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169253;
	cv=none; b=T8+bi0ajEvvnLpe+vj3aNmkX/O/c1ZVoM4XF/7a/F4QwcbT7NwQW1GczVtFgV1sl1adUBj2o1eYi9SXesglxrQDfMUpx85D0EXPsBYH4QNHX/yLa6b9hVcuEwYxhWaOOKJLAC1usM06Gc5UnTZS9uT3XoYNTGQyVIqSAJmmQ27gyxw58SiMVLKY+Zo2mqvaGXmUSgwIERycUsu0NDfdMSOKkgeuDzOLzdHLYhOLVA5a4+55yQaISyvdczOEYZA1kVn6V7CicALHvJ8tImCVu/SVdm5fuTek1bd7v1c/wBLmx+753uxYnr6bfw8gTvF45s22DwkCdinIAMGMIxQ22Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169253; c=relaxed/relaxed;
	bh=CfQ3kH1WbYHYgcJzEYZsbqCBdGOMMgoySZnlLvtSlFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BH/jY0aPtwJLpl8tcVIGF1LJMN5Z/D2QFtEaZMm3kuUXXA+OFvX+MlZznuX7GHM4DCfrzusddC2uMLSypwW4JHuTLbahPbU0bfRcInOZCHnHSoUzA+CwUaS6XtdvvlDGG+X4JRXDJ43vWiiftopPDSUc4hx7YJbZOhqcA7rHy4x4MOPLJYone8x4heoKs8ZaU5T9DG1RynMCWLdJNq0NUaQs8bWydFGcT5Il6quknjuTGJTMs/M5FXUtCi0X6DsYIH5TCtx3X6un2JxxEXoDbVo+mee28L6uHeq9NDyfq8dOn0+ccPeNr2CB6eWiNKfx9CfA//VSRxIOaeBz6IWvGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STqrMrI4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STqrMrI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpD6tfhz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E10E60055;
	Mon,  3 Nov 2025 11:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286ADC4CEE7;
	Mon,  3 Nov 2025 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169250;
	bh=mYlstSLu9EjMbm9NKODOYBWD+LPqr6dAu0tzrPktmzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STqrMrI4HTdVciHFTQo6X/rWq9AuCwH8cjr9x8+n6+sG8Ivb5pFAr/LHYe5ukSl3Y
	 /xOm63eQeS5pMMZE5xjNg9VDY4XYAN5G6gQqED6X5+od9W9xPQXtK4d8Iv2e02+w0i
	 Wd6O2dhyK3zL3U11rEGhZdsx5Z0pLVA83ls9eVzpGSPPSbL0iICNZDfbyoPPyZ1ZL2
	 0UPGQZun8LiPfvFilfZkttbHKMGAv17ErlWMEg9EcML+jOM4Mv0+FbKtSqZ3hFRVwg
	 e5YDmEPGlN2ZfqtZWOK6oD41JlWuDosnLjx1hNgTh3glvEN5HiztiFysvvXU3DoIe4
	 7GNQ753m8/85w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:56 +0100
Subject: [PATCH 08/16] binfmt_misc: use credential guards
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
Message-Id: <20251103-work-creds-guards-simple-v1-8-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mYlstSLu9EjMbm9NKODOYBWD+LPqr6dAu0tzrPktmzQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz/+WIFh9nrxRFbP9Uf+F5deo/n7QrmSybR9YfeC
 tz4fe/fm45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ1OsyMtxbwXNRcorXnde1
 VRofdN8wFEYdEtv4JnqO0e+9GibWf2cz/I/OXytfrjPh+IulfbmKUgKiPxLjXAWTRDaHFx95/kj
 sGDMA
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
 fs/binfmt_misc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a839f960cd4a..558db4bd6c2a 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -782,8 +782,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		return PTR_ERR(e);
 
 	if (e->flags & MISC_FMT_OPEN_FILE) {
-		const struct cred *old_cred;
-
 		/*
 		 * Now that we support unprivileged binfmt_misc mounts make
 		 * sure we use the credentials that the register @file was
@@ -791,9 +789,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds(file->f_cred);
-		f = open_exec(e->interpreter);
-		revert_creds(old_cred);
+		scoped_with_creds(file->f_cred)
+			f = open_exec(e->interpreter);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);

-- 
2.47.3


