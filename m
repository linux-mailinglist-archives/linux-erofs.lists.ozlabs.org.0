Return-Path: <linux-erofs+bounces-1313-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBCC2B527
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tnv4zTnz304H;
	Mon,  3 Nov 2025 22:27:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169235;
	cv=none; b=IaRpte5Zkh35kDYpCEfjsRGa/m3QhaZg5+Hbd76OA3T7j+CAUzHmGuxIbt61SoCINY6t3oFs4wsmj5mI7rZrKQ/frvafqklSzhjSNDdQ1/CE7zP0OuxdLzsL0eaZJCGMlLqPfcbCl4GrcJ2/kcaMcbil85vlx/y9/ICsZUy8M6lrLoihcQ7I2L98R8j/BkSbSEoagI5Blwje/aIgUcEZzdfGoqrmVFb8XBa6Z4ZG9JpUC2SOY+GhJRjzteqlLpuYzXgkEZrCAOP62bpGxy+wPovIS6MteT4GxWTCHK67BbN2C3oU1ONBks3thtkCEu7Ad7dfAsniCb8IpMQfzyIoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169235; c=relaxed/relaxed;
	bh=KCK95wLl5uH+xPD1sAFKytYxcU9FgpYC4fe5sInRKxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVYVVrP87jWKtqFnGI3VmHoAWW5QqwEWN1S3dY6Yapuk4K/4iR6qT2g6rubEdpP2hKODMO3fsXmYDsUT7ZZAbwcaQLMF2PVoFxU8xz7Adh6ZtcFfsn1gDX6MOYfAqUkTsWlxEd7122pkoQzi2/jRZ/EMj6RqGscy+HdaQopEsR8KPy7hRpjv847sTiGv2UZ0m+EGtOYNgR7m83IOoOFijxaptLx69RdmDvy12xn4nJ3lvtxbfcGyDe7HEOCsLfofK8q9KyjuTLWBLHFx2Fw53ghqeXt2YQJZAGmRd7IvhsqL3Cii0mN+7Y7dnyWU47R3u45x9t+0g3+MjE5JpnWzKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IGnAQ3tR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IGnAQ3tR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tnv1f4dz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F2A4434C3;
	Mon,  3 Nov 2025 11:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71722C4CEF8;
	Mon,  3 Nov 2025 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169233;
	bh=VcUIGwwKN/fhXkDTSmha7C+Rr/wXO/1VNsCTsLfj5Z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IGnAQ3tRPPjorQ1+iD6J8WpE2snil5nXhlYYaMzMblC27Q7UW1C8AUCNkhTTnHmXB
	 ojpglavzAw+t7jnhjOOKrx9FgI8J3v6b1yj54L+7I7QGmMWwbJuwjf0EK6tgMoXOP9
	 Ln6zCdjmMlbCeXOKTzDRpiGH+o+4Oflmm6UMSvDT2G8VsOMkO01JezyGV6I8IrczaX
	 cAhLr8VJSQFB1BDpdoSNdcEOz01LjdagIuipmDSHu6PXHBFcl4xH9qgiSwQlcJq9x+
	 wBteyF/8mfMS8WG4rFcgzyVYXm7b1kaP5ppeCVQCxt0TOfrzSXjpdsIVXMnZoH+wKy
	 Cijms8FKajLOA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:50 +0100
Subject: [PATCH 02/16] aio: use credential guards
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
Message-Id: <20251103-work-creds-guards-simple-v1-2-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VcUIGwwKN/fhXkDTSmha7C+Rr/wXO/1VNsCTsLfj5Z0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGx34UuK1y8Wn/fcvmTfbgm2oJ3Rc9hyGCcu6knct
 GCXTrtRRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ25jL84Qx9qzArhc+RXZhj
 5Z3Lq1eYP7C/eGoZWwtvAtfjurrJaYwM7/3/v9Q8HpPxIqeDceLPo1ZfbuxaZBP6Wp8ndtW908r
 CLAA=
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
 fs/aio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5bc133386407..0a23a8c0717f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1640,10 +1640,10 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
-	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
-	revert_creds(old_cred);
+	scoped_with_creds(iocb->fsync.creds)
+		iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+
 	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }

-- 
2.47.3


