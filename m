Return-Path: <linux-erofs+bounces-2493-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HpEBf9lqGl3uQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2493-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 18:03:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33703204CB7
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 18:03:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQzXW42Z5z3btw;
	Thu, 05 Mar 2026 04:03:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772643835;
	cv=none; b=kuAKi3frNJYsMkj2xTIk1S/9H2HAOnNrdbGF+CtUYSn7+6Tf63OnmeqmDXJT/okKsynC3BodEVNudgc/A37lD6CxethpDZWcQ8Cv1OcTeY0RhYNrPgDum3DcluDemv4Q1Ww3IHi44u3u0Ru/yw8jpM/blFOPAHhBsbYWIy9S8D+v1zlcW5gRVod54PRPlpMrhQDU5tlIZJhMljej0zi6N1SaYf4VZVYkls5EFgCW6macpVYOXTDP2tkYJymI3I/bu7U2HLbEsv2t9rJzEVH/dbbYCDjew8J4IqR9qmYqvi81T8VWf4qoIxNA1QUJmGs4rnRAVrFSvQ6Rwt7tuSOpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772643835; c=relaxed/relaxed;
	bh=KATSwx3ZLNA01PVrPGXqfaG7CL7puBPc9EC4vVv2D58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzDETLsmBa8lfZqCFcZHLsyYdjFtB2tv2iAK2nv4SrcHxfQcmmxfKMh82DjG1B4dcg5ShU8upUh20WUcEJiFH0Sj3EG8Rhe3xqBodLwx/hGqKpGYOImVLwEwbmTUjcMpJ4GNEYJYywUn8OJvVHqs6DipS+9vyntrjh1bLnVfeTXxptYFU8IHOFcBAGnDnUL1k6zu/7xfrOFINr4MDmAYkmn3HRMjovraljXOFEC7ziE1OdgP4STjd1ROUpyuKxndUXpbDx2QFFxKWhs6SjFTMLu4/odm7o2FTYcC2FOEfh+7dVsDM91uhPQEI28SGT8pjY8EdfrMywjmp04jHhuolQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mU8cfxIr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mU8cfxIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQzXV2C5pz3bt9
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 04:03:54 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso553616a91.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643831; x=1773248631; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KATSwx3ZLNA01PVrPGXqfaG7CL7puBPc9EC4vVv2D58=;
        b=mU8cfxIrhT+Me/twxAgJMdmBws/MxxhmNNqIHZ1L7O97M5Gq4BNElX9kX5IOJ6Xibz
         mD5wRW0ZTwGDGG/Q2KJHMLVJQfcSZy9gosU26RtiLsSeNfoZUmm/AtDitz8FOfWNlUdt
         tLCMZk54zJ/klODpAkM81+T9vqHthc1c4UwDZUEE8fUhOJhpBhcIYpcwiAtGG5OTS4IN
         h25YedD392B9Om/GizS/V8j4RvRX5n0o7T83v+cP1CRAW4Xl687/EGslwkHe55fSJbtY
         uJfC93tTi3WZgHB+42Kzf/gPyugvhvv6DYnYw7CD2Cjjyxsx41kr/ZeyibvOzC9r0Cm/
         VOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643831; x=1773248631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KATSwx3ZLNA01PVrPGXqfaG7CL7puBPc9EC4vVv2D58=;
        b=ikxD/abMRrG72MIBplKiceP0rfhLDk6PWcDBw2qQjJIlE3SgPBMkV0qh99WP7pJFrx
         g/8DRBk789fXm21BnkqbtTZA+qIArcpjsl1k+m/vnRYZzZwyBhWtyk4+gJGZzKpRJn89
         NH3ZQN5yQbR/5+vv9O3HFPLoyh+U47bh5obg7015xIRZzE7950rBufHYNs9Sfj9G3h3d
         Bep0CIr/hHAbW6ViQXIZVTm8kYQhyonorTMijhKBYv+OlGHpV13iM5ptELbB6sFg0Noh
         PIjA4uEV8FT4Qq0RUul5yUr4Fij1YdCEs3vg2gE5rqiDuC56QWjf6vJuEIaOSGXva8lE
         AHMw==
X-Gm-Message-State: AOJu0YzZyPqf5hibK98lZ3vRGbH8+GbJshw3V0iLN3rzrVipRYCteMrk
	ygfmoiY82dX9pr8ZwTNVqDDX8RxAQKi2qVmfjXyl4xfvWqk+pkGBirdgzwpBFU74
X-Gm-Gg: ATEYQzwnNkq+HBIvaKIWA58xVlnT578qD8n5Q82wlVmwFbrFLF2xX1oWS1o8bHwxcAj
	KPgfGbHK2ZVnFgeTPYooHXF66/0MzXTUoSquYJeY9BJrM6uxyy4e/QLcHkNj2sLNWWuJVIsGJKE
	BKIjqNoEnxR2u3zfsAD9Rgs3Iy4gsczZHfOK+ZLhlYaAoHLJv+kVrtM5w3URBx7n/jSwuFixdJl
	pHeeZnb72IdYf9qqQ97pdwgsaigy4zbreKt7peSz22I5/Y34Yuiq6cjgEc1QwzsY/UXwZ4ACm31
	2PbTg38+atfhCc7YGEMrr5dKzAM0wzogQAXvdP2If3UaZk0UxamdNhe/mn3/3TYnL/5+D8deCXe
	QoiznbJigAObHQrZiYwh2QkVDmsKj0NO9IFQZE3KJhnwC6CMBHpTZbUtjvAZBDPPCHtq0ei3qE7
	RHIccfR1BKCm07TJiF/tGRNCEiyryXrT+X5l/H+gwTIqPm8WXDP+PpE1inh3X0Hr9sntLgJINbF
	u4dgoR4686bm0MznKdcpjCkR9tUls8BsKbnJg==
X-Received: by 2002:a17:90b:2ecb:b0:354:bcbe:7511 with SMTP id 98e67ed59e1d1-359a6a61556mr1714832a91.5.1772643831220;
        Wed, 04 Mar 2026 09:03:51 -0800 (PST)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm5593323a91.8.2026.03.04.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:03:50 -0800 (PST)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix undefined behavior in kite_deflate writebits()
Date: Wed,  4 Mar 2026 17:03:27 +0000
Message-ID: <20260304170327.14908-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 33703204CB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2493-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

When bitpos equals sizeof(inflightbits) * 8 (i.e., 32), the shift
'v << s->bitpos' has undefined behavior per C11 6.5.7p3, which states
that if the shift amount is greater than or equal to the width of the
promoted left operand, the behavior is undefined.

The original code used a branchless mask '(!rem - 1)' to zero out the
result when rem == 0, but the undefined shift is still evaluated before
the mask is applied. Replace with a conditional to avoid the shift
entirely when rem is zero.

Found via UBSan (-fsanitize=undefined). Similar to commit 2cd5114
("lib: fix undefined behavior in zstd dict_size bit shift").

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/kite_deflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index f9eb3fb..29e44b3 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -144,7 +144,7 @@ static void writebits(struct kite_deflate *s, unsigned int v, u8 bits)
 {
 	unsigned int rem = sizeof(s->inflightbits) * 8 - s->bitpos;
 
-	s->inflightbits |= (v << s->bitpos) & (!rem - 1);
+	s->inflightbits |= rem ? (v << s->bitpos) : 0;
 	if (bits > rem) {
 		u8 *out = s->out + s->pos_out;
 
-- 
2.43.0


