Return-Path: <linux-erofs+bounces-2502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJisEkPYqGlmxwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 02:11:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6256209B61
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 02:11:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRBM25xm0z30MZ;
	Thu, 05 Mar 2026 12:11:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772673086;
	cv=none; b=DCatCOxWHk8QvDflVAP72C9pH+aAuwZSCqoLqpAor0pFJE3aBmJFJliefl6NnpidtNgRfpfxEn4WluAK3sbNGAz1S7NpbxoaEMxh/ARFT24zdyYr+qmyGtLzTPFaPG/rB/RzkkfRPO4sdKAOxfD0gjw4rX2r5uhoCnI226XF+6gy0k5PgLMMuaKbCBdVyeZgxKVBUQv9kAlH9jB1Tu8MX45YG+8ReQJbRxhanwdzBLYVN4XN4NmztoBQvi96ryoSAOKtE7RK0SoLl40w4u0MgpLkRt7Er6oPfS+hU1X+0zaO6AwLXLq4OH4kwtpnKstVfi5o9t8QKViZS4MC86w08A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772673086; c=relaxed/relaxed;
	bh=SKnQjkFTe12dAIAujOAXo1Z/SDTWWZtPhpHjK7rqYGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxDqAiwPrlCeCPxo/OQ+v4UXwieeu+proqjRqvTqJk8KV5w+j1R/xuEuV609P4DBcHCqNonEL9NfyA0U6Z1bR3SiUPwBE0D6V083cON7ncYPK0+pgekYf5H1WnvPv26hRAoqTF9lAAJH67m+jSLIDExgHMvd3K/mPIf8uklKhG4tBGx/nTuaSqygxpFNGTAPgFsrF33K9YTocsjK+GL5dmA0TboEX397SeSJENUr+sabXAX7msR1Rd4kvBP0GmFFd738ayXpTCb875joNWqe9SYcZFeUL8hhWqcsb45RaNixgMKLKAgSmrzto5ckiNQq9+8oz1UES0EmrV211QiWJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EJl8v1uk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EJl8v1uk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRBM15N50z30FF
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 12:11:24 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c6e734ba92bso3563913a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 17:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673083; x=1773277883; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKnQjkFTe12dAIAujOAXo1Z/SDTWWZtPhpHjK7rqYGw=;
        b=EJl8v1uk8ua7EWXiQxftNwp658Lk38ByX5U6aUzbh3GUT+KVq/nmMDCva4BnhmqzzU
         XF4AwxPpmbiKKIWQ8K6y9GZfJWRQnuPRmL036/At2SEW2Qmxu3qseSLidgl7qWgBWYSV
         vw2QL0G96kR49bibXBj+eBGgARLfHWBhiZsxXrqWNjVCyuJpMj6yYBIUtuiHZx3e/Gu9
         BmRKX0hyoC+qNCMsaaKSxpQVXeQ7+ASBoCkihM7+cBL6BSuHo1u1pAGu6bPUG5+hF46k
         n5cXgJ9Q4oLDT2SiAXAVXwMMo0YYrl0qMV8SLBx3mMQAGn6rtZNkH7gHrgeAn38jCg3c
         oQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673083; x=1773277883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKnQjkFTe12dAIAujOAXo1Z/SDTWWZtPhpHjK7rqYGw=;
        b=pmVELsPLhuR4f78W28GGHrkszbf7jk/nqT3AdckQU9Za1p9nLMCaJooar8er5cwEaj
         flm8IohjQ438TDBho4tTbXiSFPpc7GTqTtcTM2nywUkyTpb4WhWTsVcI74RYpW3FST5u
         PbPuqc2GfMzvFYSAH6s283aMaMqgjtFPK4NTNid5eaP+nCpN2Jl9TilX8jApK+lIORRt
         UbsbpYeT1tf00AIKBsrk/5NkZUrNeFGy7bWMzoVZjxmdMe3RyknRM13knJC1BTVwrmUj
         JT/rfiF/4m/mEqfKiVRxwdKkby/Unj3wsiRb4oJW93zuMz5H9rj460D5mDhfPJVplNP3
         sERg==
X-Gm-Message-State: AOJu0YwvD0PPndJOG82ElTtHW28seBwCy1lqEPiL8fOdqcoX0ZiZil6j
	zioDXdSltL/umV14beUULGmlG1eFoqa5js0SWt+xjnMPKewUhc+oyzlyHdFVuVY7
X-Gm-Gg: ATEYQzw4lvj4qOkgFR7vbBSMQjnMHOpB5Bu5TIGVND9vpkGYiyp5Z6wHJvaLWN3HlKv
	sSZrRsSshYscvHo6NnqgBxaXJ4+tMlhVACI3V7lPSqfFetqYc8bR8/Iioln7PrgDA8ppqlDXk63
	dSdF6t9ZfmCiA5oNDsrMeQg+Xy3QqjRcgngy5GdeGNId1fcIPSkzI3rqw1nlnzMXl89xvtk0mlj
	i7rvqUbk0q151uqA1Xhx2ek9bJIxkRhzFm8mGIYZbDDzNledLgB7amX+gkujrQ9XAcNz9mWzM76
	LwsgyUaaPrTZmIcMHxf246/8Pa74YCQIOU24dFDonrpI6eJ17IF0RLD1ocFHyL7CgMZVM1gWfny
	NnLGSkYaDnkGnhs+P+FkWElqNu0mHK5oXIgnNXHSWeXtEbBLtyp2ZkfTop/OESK+xYEu62Yqt7D
	a+EJ966UEz4LoraWAtvi+aXpqv2/opqv9y+rMv
X-Received: by 2002:a17:902:dac9:b0:2a9:5e25:46f6 with SMTP id d9443c01a7336-2ae6aa2b8b6mr40058995ad.17.1772673082565;
        Wed, 04 Mar 2026 17:11:22 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm120865625ad.87.2026.03.04.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:11:22 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] erofs-utils: fix undefined behavior in erofs_init_devices()
Date: Thu,  5 Mar 2026 06:41:15 +0530
Message-ID: <20260305011115.50506-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B6256209B61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2502-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Using roundup_pow_of_two() on (ondisk_extradevs + 1) triggers
a potential 64-bit shift warning because of the internal n-1 logic
in the macro.

Since ondisk_extradevs is already validated to be non-zero, use
fls_long() directly to calculate the device_id_mask. This resolves
the 'shiftTooManyBits' warning and is mathematically equivalent.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index 088c9a0..bff9b1e 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -29,7 +29,8 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 static int erofs_init_devices(struct erofs_sb_info *sbi,
 			      struct erofs_super_block *dsb)
 {
-	unsigned int ondisk_extradevs, i;
+	unsigned int i;
+	u16 ondisk_extradevs;
 	erofs_off_t pos;
 
 	sbi->total_blocks = sbi->primarydevice_blocks;
@@ -49,7 +50,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 		return 0;
 
 	sbi->extra_devices = ondisk_extradevs;
-	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
+	sbi->device_id_mask = (1UL << fls_long(ondisk_extradevs)) - 1;
 	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
 	if (!sbi->devs)
 		return -ENOMEM;
-- 
2.51.0


