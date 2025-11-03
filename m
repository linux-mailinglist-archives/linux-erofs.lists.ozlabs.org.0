Return-Path: <linux-erofs+bounces-1324-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F842C2B557
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpX0P1fz304H;
	Mon,  3 Nov 2025 22:27:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169268;
	cv=none; b=F2Fnfurbz4j+WiGSQg6vPnSBQX9YOT3tFcn8ZmgFT7uOEFIAu3qa56tZZhm8CrUj8uTOpBVh24DaME4jEkHdaglCbNcjoFAsZbv0UQSra7Fp6sWl+JGzY5t0s+IuXqT8MaOucHpKK0dzp8/xvz4rh/GzMAhULkdkTICf9y/kdoyODIiKgpURWje3JM+wrQNiDs3qHKOZahx5+C8BNmWtHSKvOwONqxvb52+mN3VJDwW5A4GBJOBRDFttl05OVIvWHwQ6gtVml+Tc8iU/qp4tdO25tl7ctiW904Ythunz/PkT9QF2M2QBiDvbO0oXAg2ZpGJN237mR1bbSQDfEAkjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169268; c=relaxed/relaxed;
	bh=KO7skuqqUsD98uvb4r8/7Z4hn6FjApA2cu0xWn4azh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiEJXzkkwVu8opeF551EcDKPV95xPjd+0bATzE3Gcbb+Seppuq5t5natNkZn3FLc9ianihCihu7zj8QIobuKpbAVO1i0WkEUsCvr80AfoRDYYhuJf8lqi8Kyph4tEzMqUWFSIdKXczq2J/LT0dStZGvMaUefufkjdo4rvQ81BVno+2LIIN6PuT7QQHpQ/dN5R11MwXiDbeM8CYNv3O5dBiHuMjKVbUcKFHerMTmUf8t0E/lhT5viSFFOP+oY5PYVdhdNfSUBr1VNBvxjBIofVCy9VfEodPhnUY0kGzWV7TfIVwUuadKl9VQt39gwojjqcv81Z8Lqvkx618VqAw/n+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WdXcmdeU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WdXcmdeU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpW4lXXz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FFEB4337D;
	Mon,  3 Nov 2025 11:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C00C4CEE7;
	Mon,  3 Nov 2025 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169266;
	bh=cI/wCkL2aCWjfu8Fn9+DnW9cfZKAM4aWc79J+WWc2Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdXcmdeUI7d7FY8An7/fIl/EVg+Uk/Gsp72iYPvHQI0TMM2ZwM+FkDEcH65fSeC4D
	 lNzRLyt/nrrMaxqugF5szXDc9alaK5CA03yFADWm/OTnxfiPAkCFM1OqzyCAJ0HK3l
	 VXHm3zRc1Bdg6sgv/WOuWWyHLMSdOtZzfNmt4hoFAGAnmp4lH55Y+6YtZBNCGREhhw
	 B77COT6wrCa+L5PGDqDnseQOs99bJgfmOow1aYPlfXjeyssIHhn8PY7emMUot6cT+C
	 ik2I+AlaNtzUU0XF4ol6l79HbigRNAT5Zg3vKGS6GXmAUSr3lyOXMu5tZ8llaYquKR
	 pHoWbORGrPuBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:01 +0100
Subject: [PATCH 13/16] smb: use credential guards in cifs_get_spnego_key()
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
Message-Id: <20251103-work-creds-guards-simple-v1-13-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cI/wCkL2aCWjfu8Fn9+DnW9cfZKAM4aWc79J+WWc2Og=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOxILb32Z+vLgE6nhY+mnF68VHJekZl+4OTFuT9+F
 C4KTI/w7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIzCeMDFM6cvZe2CyhUXbm
 V391qJP7NdHHgrxf58ez6pc7N2tPSGX4p/21dNKnHytYHyeuXL2ncu7aGzbbNxX7fM2M26B/TnT
 rYVYA
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
 fs/smb/client/cifs_spnego.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 9891f55bac1e..da935bd1ce87 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -90,7 +90,6 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	size_t desc_len;
 	struct key *spnego_key;
 	const char *hostname = server->hostname;
-	const struct cred *saved_cred;
 
 	/* length of fields (with semicolons): ver=0xyz ip4=ipaddress
 	   host=hostname sec=mechanism uid=0xFF user=username */
@@ -158,9 +157,8 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 		dp += sprintf(dp, ";upcall_target=app");
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds(spnego_cred);
-	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	revert_creds(saved_cred);
+	scoped_with_creds(spnego_cred)
+		spnego_key = request_key(&cifs_spnego_key_type, description, "");
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {

-- 
2.47.3


