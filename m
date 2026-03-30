Return-Path: <linux-erofs+bounces-3122-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF1II0O0ymmE/QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3122-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 19:34:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F0535F559
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 19:34:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkz0G3y1Wz2xnl;
	Tue, 31 Mar 2026 04:34:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774892094;
	cv=pass; b=ZKU8fLLPvr9DDpU265ndKVr44EX1ItzrHV8zQQooA4j8woIWK0tRYXDprfEyEmNNfuBHxHmOn5ElX1XR6Yufd63+z/W1xDr2GTRTwfs82jaB/K1mbEKhVUVhfyN3bxYEQ//YmoHJ1Pq5yrqxa8Z2TgJtoxQneneJD5UdHdLU+l3mHM7aymYaaOIpNLTojgwwt7a0OZkZEAPOBH4+P5A9wi1Ej0sC/Phxu6kFG19uxdUOS6NgpL7jsnEWWIkjP9m0szrGRkgTv65dyic4xtS486ho1kHvu+5MoQAaK0WiVr/ZwiZ4Vn02IjuIOQAxvL7DQuGlPln+kgJZuCVu4YwTgA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774892094; c=relaxed/relaxed;
	bh=sk7HrboU/qnGnT2KPw3qMJkFhkeA0kJOjaEOHwnsZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEECRM0VX41lJPUwv++4yyh1Twq3eKVZUNTg5IVrrjmTbGVwqTHfuRL5TbnmiTM1y71lqn8s2qd7efgvMvWQ1Vb1J+mk+fabF4cz20nVaaZYpav1K27fd6FjpZJyo5IPDfMHMItyWhev0JXOgtRV347/hl+2spPLocAIZCP2Qau8wFTY8z500DjDGeWozgGDopvzOnUbtC0QoB4gG4oducHNMYgRYeU3siySNdReSB5GEIpTbir1VyOgXQ2jo1iUMH7stMtRD8ZO2Fu/0pRX6IV6sBzPAjbx6Zajgc17oZIjR1nWCez6etnOfC8EUmz6nxWSd0E+KV5it9xZK0NHaA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=bDpI+fD/; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=bDpI+fD/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkz0F2KDJz2xT6
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 04:34:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774892089; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=GOQkBgdaNi8qkDgcnS50+xdfEdlzz9H2IdYOCNu4nl/REN0QCDS5Qe4o5RnpUXtBhRbx9/15K/TF3uBs8JZkTxhR4UfBbGfEV8IFzVuIZkORO0vlAW0JtkTcyoj4DP3OFJM4D1riZ3yArpIj94nZu31QzOlsiyj3O5KwB12dx6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774892089; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sk7HrboU/qnGnT2KPw3qMJkFhkeA0kJOjaEOHwnsZQY=; 
	b=DRDXbhtYQy4PFNd4GX2Q1uzjftvGcXNyWOBwFsKMnX2t+rCig4myXLQpnAphFrENOvMflO0pewF1PfVcJoXbC3aoxurAc8jtXmyjDO1AY20NAS6JyB0LdTfPgi0eUCCD8KjNFI0Ra8WIzcjDWY2KGb8ADlKueT//MhMyveV9qqc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774892089;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sk7HrboU/qnGnT2KPw3qMJkFhkeA0kJOjaEOHwnsZQY=;
	b=bDpI+fD/c93LdfcSFEJ/Ft1snGwgOdIpNQErpfKdWdwTuFmG82510zAypk34MWCV
	P16AiRcmIuHwmxLGyeZ+uuQLs8xxeoll0PdcyPpLiavPT5FdonK8nQCc+4erCm4CqYA
	3xsoMAO6bi1P/+UAKy4Kmn9Q+DJi98usloQv4rkU=
Received: by mx.zoho.in with SMTPS id 1774892087660728.3978043974395;
	Mon, 30 Mar 2026 23:04:47 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: guard slash-only header names
Date: Mon, 30 Mar 2026 17:34:46 +0000
Message-ID: <20260330173447.486569-1-ch@vnsh.in>
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
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3122-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[vnsh.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83F0535F559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check that the assembled header path is non-empty before trimming
trailing slashes from it.

A malformed tar header name made up only of '/' characters could
otherwise drive the trim loop to read before the start of the buffer.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index 4e97522..39e2321 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -866,7 +866,7 @@ out_eot:
 			path[1] = '\0';
 		} else {
 			*_path = '\0';
-			while (path[j - 1] == '/')
+			while (j && path[j - 1] == '/')
 				path[--j] = '\0';
 		}
 	}
-- 
2.43.0


