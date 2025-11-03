Return-Path: <linux-erofs+bounces-1327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C47C2B566
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tpj3Mpcz30RJ;
	Mon,  3 Nov 2025 22:27:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169277;
	cv=none; b=QIAIfF6oFCMPllyTEDhWBhLWLb/LV7XK/L55u/pBX7ZwFrp5EaEENXO9+hmbJe9MJgktaFmxzoRS6dfX8j42DaS7GbSRn+Twmpm3wf1Po6DjrNiNZNPnkERBP1DMt9XT7s+4vvFsuE/W4usBT+LizsIxa7JJIUq4mZFhzt1ePm0wvzpFUzsbogE4zJujqWlv6u8S6vMToHdvzij4+BqnXLsqsa4Aqq7/mtgS+mNNBf7gB4af5+AVVgrekaTxEx+LNKjjwvPfaoO5wPIRPa57dQRf8lgZoVf0S9NBr0ky+qPOt/SFpAEwCkSN8d/VdskUsiX18W6FT1YAn9JkaG+1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169277; c=relaxed/relaxed;
	bh=UKFO9w2e2gtmApgw4/MEowVF/CNyMUjqIFWubPtcFC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3jMvV34a/B1rF2Ii79d4US6g9E9wTwtuR0ZSWT6lhg2atplDu2gA3P63YBU8Hb7q4F6At7FpvGg2wHMfyUMya3qw3EOk5+aKDxLknMTzyE3FhtAkwLBMe7mbRbCrPbvLH5SAPrUTvB25kNa3YcvtW/ISIVn9+puDRlCAl3+TvZuc1XmRQ1Af0wDOGyDXIeakmH6rrdOmBWbV6Gigm+qad50jWEGas0Y+mv6hpCwRy6Y5KGGOwnQi4A7rHNZXz/XwxvI4mXV00LkYbbERJNa4XcIm8IBz4ILHi34G8ybfGG4V4zNjEHlgOEo9ZvYeaxZ9TBdc4vjI7LMARySV8b+CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YaZ0aFlr; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YaZ0aFlr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tph6Xyhz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 107EF6013C;
	Mon,  3 Nov 2025 11:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A1C116B1;
	Mon,  3 Nov 2025 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169274;
	bh=bCAyE7tmk17boyOhhm5qwpsQaMCqCnHI3pfKUhK/d+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaZ0aFlrmjLdV5jLyEWA8b2zPj7i9z0dEpY7E7rdwB2Ir37Qxszllxd+LNnnKGHpV
	 7g9uQsnEh6lDmbJfA/j3i7al14HMc1FhKJuhGYP5jeWI4FqTHyNwG4KUR4LgFazakm
	 9U6Bp0/ktbSbl18fmnOeWWaJYtfsjuu5jQIn2cic/xqnanYb+hX8H1N2l7eiHfwRYw
	 WlWwRJueDrp/N+huW0lQhpsaThRzloG3shyGhe98eUpBRrQtTyTnupElathvxWorr+
	 VU2h9Ct67bfNGBcgfYLonCedVqZrKUuW4QK8H0K+yeAQc3FViZrQoKtD29+DH9/Hq9
	 IHBHH4/ABmXuA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:04 +0100
Subject: [PATCH 16/16] net/dns_resolver: use credential guards in
 dns_query()
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
Message-Id: <20251103-work-creds-guards-simple-v1-16-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bCAyE7tmk17boyOhhm5qwpsQaMCqCnHI3pfKUhK/d+4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOz49t81KnHqZTWdoJ9Fp9KfSbosV32dkH//j7TF6
 wVfllVmdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkoZLhv8td6YzC5sipYZKb
 NNX9Ju62Zvq6u5zZbmpraeA33c0/dzIyHF19l68/b9H/cwesPoX/dN9tnRlh6/AjVdTxeV6q8Y6
 9rAA=
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
 net/dns_resolver/dns_query.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 82b084cc1cc6..53da62984447 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -78,7 +78,6 @@ int dns_query(struct net *net,
 {
 	struct key *rkey;
 	struct user_key_payload *upayload;
-	const struct cred *saved_cred;
 	size_t typelen, desclen;
 	char *desc, *cp;
 	int ret, len;
@@ -124,9 +123,8 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds(dns_resolver_cache);
-	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	revert_creds(saved_cred);
+	scoped_with_creds(dns_resolver_cache)
+		rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.47.3


