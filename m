Return-Path: <linux-erofs+bounces-1323-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74AC2B551
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpV0p0fz2ygD;
	Mon,  3 Nov 2025 22:27:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169266;
	cv=none; b=Gn4uD8j7MZFJGR3qQfLkwXatKHdtxqM5e3LsfaZk//dYMmcYUeevt2ughFgRjxhMapb6vybwHli/X2fxRWL/kEbMnTcngkUiHogwsAqYuz13knAUQNy7M19P5g8OJiORe0I67jTtystd95AZUEA+NFT72adLw6qm5L14BWM9AfZ4Xsvy7wFEgx/wC8G5ldM+kkKmDhw0+AkSNtVKcvKxev7bJ5pg6YXJD+sBK+8sSU+ZGFIJFWL2dCJuU5EUzQIQ3091WJyxlzo6+5hPmcrofiOyVLxY2TcbzrYEeO+XhsQLxN9jXqKWEgfCtVSV+475uluo/rBwZsaF3M+IASh+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169266; c=relaxed/relaxed;
	bh=UJfrrLUpdRrKiBWLmaVGMuxSF+PlKdaIV6dH5Tpjm/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jStOP7NXRlrarrI8XIUSVmH5poJ1zCXS0rWwUPCiWBjOmnFB4/O20kDed/9m0PTUP/PIP6xbk4tlUMt7/2H0VdbPF76jV4KriupiLT4YzPDFH4nkLRdGaOkMHla3QOxwOeB4Ta+3m2ZHsT9bhkfkPk31h8MOWe7T4SlK+mq9N0kMsvpvgy/6Xmjy2VLte1ouzEJP1PyRWBo6tbdkNVK4eiRlYeqWVUyNXRQh2D/0ORlZ5kP0IQxbizXJOEU13F2HRPFoZJSeUZn3P74IWCeU6WCLOxCO26a73Qmre35dcZzsNESgwQ7+CuR43GVDvLitKl0LJaRis+5BhriVu1U8fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FbAi9WBH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FbAi9WBH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpT3yDdz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6392E60052;
	Mon,  3 Nov 2025 11:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A109C4CEE7;
	Mon,  3 Nov 2025 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169263;
	bh=8jsM42EFf4c9yOO+A2KOodgf1ewjQpXoGxD8DKkZDoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbAi9WBHffHsH+Y9i4zEwgXGAIiJkLuU4I+HseYDgpqTCTPTC4jOxJ/zZUZ5zwjIv
	 AJnUHU9QLT9QwwAEE5tloDBUIKvCHD3verXxV4hMa02aXBOKbWgHdlKty0QYCpdXpW
	 3Ifm6xh7AQdPJsNCk5uRCEygGiUxHY9DAPFacy9ki7uVzyHze8Sj+E+LXUbFxtAEHJ
	 GdsaJ3uUOHhyuAPkJ4dtaUpiXHG/SjvRIuRuQHulLMUTEibpTwF1bUXJxV8MqlR4pW
	 4o6yWUebx2bMZ9we+Y6QHTIvHodYlxQ1H7j2dd9PzCAqbHYax4rP9lp4aZkxy1S2Hs
	 54jUU1Y9ewvIA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:00 +0100
Subject: [PATCH 12/16] nfs: use credential guards in nfs_idmap_get_key()
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
Message-Id: <20251103-work-creds-guards-simple-v1-12-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8jsM42EFf4c9yOO+A2KOodgf1ewjQpXoGxD8DKkZDoc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz/8FlG9YDSAfX+gxrnPsoU75DNi/u4Js3hnvXDu
 fsfFKe96ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI4h1Ghofx+8P5r81wY7Tw
 Pqs/Yab/mnsf9pdx3eXulD8ZphDZLcfIsHdXoNyrEO2lryvXNolyp1mxdn4pSFe3vMPLe/TRy2w
 WNgA=
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
 fs/nfs/nfs4idmap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 00932500fce4..9e1c48c5c0b8 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -306,15 +306,12 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 				 const char *type, void *data,
 				 size_t data_size, struct idmap *idmap)
 {
-	const struct cred *saved_cred;
 	struct key *rkey;
 	const struct user_key_payload *payload;
 	ssize_t ret;
 
-	saved_cred = override_creds(id_resolver_cache);
-	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
-	revert_creds(saved_cred);
-
+	scoped_with_creds(id_resolver_cache)
+		rkey = nfs_idmap_request_key(name, namelen, type, idmap);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);
 		goto out;

-- 
2.47.3


