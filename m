Return-Path: <linux-erofs+bounces-3506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCIaKzSsHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:11:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918762C422
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:11:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66Q071cz3bps;
	Tue, 02 Jun 2026 20:10:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395053;
	cv=none; b=YB5Z0tDqohHpnhEv5LRw1rtmbqlxjejMpROGjmd7gJS7YFb3aDi/DHuK8iel9MUMKuLaRH70EUo/OBGrC/6SVF0WkU/39jsfoMPiW+VKIsFk7Px3r0Ym+dUswqY59GxYHLtBYsw60bfCMxzOLgV6oe9ogMbIAGVtcIOMe2LUx4GA4LEEwHhPhXIiURU5tel7SJNJXaeF37z4dVtBhUQZKrc4R7d/DHwImHoeF7Lu+yiIU63GTQL0RpuqXC/VH7DntElRif/ik1rbeBrWfKBrS6U7PWHR0KNDnZLP5vB/JMeUKL4tcO6FdN9jYBcBG13FyhxFdnI6QtqQ0h9ONCR2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395053; c=relaxed/relaxed;
	bh=xLOTdT8r5c8v5N1ZxNPQflZse6scSqS6hKPK2aBGU3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqjw4eXW7ODd3XRd9PYO8EnvFLdVkw9V0XEbm1yrB19Hp8jXQfMLxQHJgT1zhmC2OHRdCY7eYEyoWJ8uuWS4sBewKU/6txbjvimceJ5cf4/MpdfdZD2OI/j1546VpO50/rxfWjSF2IPpgWpq/gy1IRR4pDv6ml1HuPD1P58wNRW96dpSuQUYpFVbVM3aqKEeJszIppxC7cXz8fF5jd01ql9pRvESxEGpUkBBu55YglLWwqC3LSy4cBwOvspxtYe8KGaTsL88USncqbVEPAfkDlKGrYM7vdPJz0smlE7dI2jO4XTW9f0mA77dF62O/2BmR8OKpipS1USr0p8ngnJMFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKNi+CFk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKNi+CFk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66P2cDsz2yv0
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5F43F423D1;
	Tue,  2 Jun 2026 10:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83D01F0089B;
	Tue,  2 Jun 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395051;
	bh=xLOTdT8r5c8v5N1ZxNPQflZse6scSqS6hKPK2aBGU3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mKNi+CFkSwIzUT3XyErbW7NUlsQGaqz8SaV5mqOF5zpDbz/Z2aM0kkT5r/xonBqSS
	 vIFBYSRF+Y8Qd3Y6kSLOMq50Pny91d27GC/z9QyA+IJiPhCrRbZTVnGXRcDUVZ3Fci
	 g/R73rSa92eMq4puOjqbtYwgQAq7fvtIK8/LASaNsHS50nl3qVNyqz/HvQ5ro3+msv
	 fET0bfi0cVeWzh85VyG67UF1iASgo8srRq+Gid4B29ynv3MA+95OhVeC1VvC9f0QAk
	 /2TbB1DSzJrILBmkHgNiC4DL3kp8cR7aSg2Bs/ifoereNRYuW6WCHfDvwXCB1CYHaI
	 2Uc9x28TrzuRw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:14 +0200
Subject: [PATCH RFC 8/8] super: make fs_holder_ops private
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
Message-Id: <20260602-work-super-bdev_holder_global-v1-8-bb0fd82f3861@kernel.org>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, 
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R23GnSj4U5c2eVlp7JGCCBg/KF5c+QIHjrFm4diCqAg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreGY//RPxrQiwUNbMteaBZSkHhQ+tUBJbYLZtUb7N
 /9tbhXXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyExYThn+0q8UN3BJ6GPdTU
 uvE8205tyuMZvh/sl79WLi21dk76FcPwvyRUiS+vibv687R6c4v1F9+JxWQGFKy13a/tYX3sksg
 tFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 0918762C422
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3506-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

There's no need to expose it anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index cea743f699e4..983c2fbf5202 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1643,13 +1643,12 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-const struct blk_holder_ops fs_holder_ops = {
+static const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
 };
-EXPORT_SYMBOL_GPL(fs_holder_ops);
 
 static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
 {

-- 
2.47.3


