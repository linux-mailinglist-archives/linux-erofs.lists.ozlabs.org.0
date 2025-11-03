Return-Path: <linux-erofs+bounces-1335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449D4C2C823
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZT9217fz30T8;
	Tue,  4 Nov 2025 01:58:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181885;
	cv=none; b=UBKBZGyDYa3ddxZAinnDiqgrh3HOwg/5k5syyg1+fsI2rRvt0nM0COj8OW8fH3GPJX1s4+eyu/HOrIb52lcUQQ6CgiVRO+gfQRAZHeHTpDQZlgOmBeYktROXHfJrEwcTuD+EnvWVoLMimmkd999//39E9RKHppcY0OVI8Na9+STRm7eScBHwkih3sYcTjU9jVaKjm5nNtI/dTqC8pDcCL1lixhCxoJq49X+qx+lcaMZ8svX0JczUzVeE/lARoB33B7V31rDMVOX3DWJ2uNzjKD9p26NcfV5HbySB/joAX+FdQ0FZivXRzOorXxFbEPawvXofMw5dQ+0H8pQnBkWeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181885; c=relaxed/relaxed;
	bh=An16JmwRErGAFvcppQV/AdZvEPkpyehlfG+X96BkJWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf1rDxrXKPqjR2JpnUyhd0KVrpXwJErc3kBELXN318s6Wx01U6YUY/kPlcHsYTq1afSttOl7dWplF5vzwS91Hxn0RMb3khi+xsfTy8upeM0Ha+CxHM7+fPfO3E0SgjEsQWgBJ2UF81SI2LHGo2bTMzIxzsjujJrplNEp1Y0HOiOROMCS1yU7SgLff2RfzcbLS9m6dd6Incn/6uQiIoeeWIE0xgmWwf1QggRyraZtz3MmKUo/M6i7Toubd9lrD8yquFFTmVZOGH1qO2II1NXl8AKVrYX1dRcNRmcBGdmFJGAtLghyOYykMvPbj6g2YTM1GYaKT4q5Q24WPTCPD2Ij/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=alKRJX9g; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=alKRJX9g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZT852wRz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F72060142;
	Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D09C4CEFD;
	Mon,  3 Nov 2025 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181882;
	bh=ueoshrmp4QkI9SU1ImHUS9AR0CCmoEPF5ceuQmXRIvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=alKRJX9gwXSRLScebUpvPp+WXVLotG0w/uaJLFrECQUZ63vpCvDlosEP2dAxHgLHR
	 kTJvdul0xoSMw5k3Pa5LBRuQdc0/WNZpMy0Wk1X5kyewz0yx46fZhRPZJpPpx0mc2C
	 3HfjCt0y5PQmwMqYrxHSnC8ZNj+knGDQJHg4dplRcZsO7ITLG0EUup06T7Rk+13Wz4
	 Enym8L6irtxbOcxOmMI4vj+2L9YN/9R+4R8/XaSIpQeYitGCSYDZti9Fzq36QP/SPP
	 RgEjzT3poQR4wuhtf0dCe1WHvj9hOX/XesxMCRfrhCMMj4AubqpdHZwmMM+Qvj2CZf
	 uLKVtSgEM3ZXg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:30 +0100
Subject: [PATCH 04/12] sev-dev: use override credential guards
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-4-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ueoshrmp4QkI9SU1ImHUS9AR0CCmoEPF5ceuQmXRIvA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHoRr9r1hv+5W0WMGeOOLXFW8udvTNFLt9i3+Zfz3
 GpL6/o7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpOcLwT2u3aUiVfWZX55uD
 vY9fmLBIr1j37saKbvHfLSd95+iudWD4H+2SYH7Gq99lz7utyzcsOKF7uEt9x/8oRqNlV0/96rq
 9hxkA
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
 drivers/crypto/ccp/sev-dev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 09e4c9490d58..19422f422a59 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -260,7 +260,6 @@ static int sev_cmd_buffer_len(int cmd)
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
 	struct path root __free(path_put) = {};
-	struct file *fp;
 	struct cred *cred;
 	const struct cred *old_cred;
 
@@ -273,13 +272,9 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 		return ERR_PTR(-ENOMEM);
 
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds(cred);
-
-	fp = file_open_root(&root, filename, flags, mode);
-
-	revert_creds(old_cred);
 
-	return fp;
+	with_creds(cred);
+	return file_open_root(&root, filename, flags, mode);
 }
 
 static int sev_read_init_ex_file(void)

-- 
2.47.3


