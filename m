Return-Path: <linux-erofs+bounces-2956-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COjUF3ZDwWnpRwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2956-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A866F2F3306
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffZBB6mTZz2yYy;
	Tue, 24 Mar 2026 00:43:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774273394;
	cv=none; b=hYYkkMCWm2nMCN7ZxoFdUvpd8oaVZ5BraCMey72xI7MA9VnMLVf+bfoEDbvefkGSA1MGulTHJdyI7LMtyEAm4AAmMQdWvwUBiaAwkcMdLx//v2HS1fsJUpa1BmG7WtVhL56YQzlRV4WAf0B50kzE7WbacX8QAIUbpdpvV1VGyYbPnpBcXjgTKnOEx4isz8CE8NOaXaZAnQnw+iWzIfRyc+Q+eqwJCe4RhIfzWp1QKQR6ZHKe3jMI1HZlhcMTo3eHdOzkUOIO34a1Qz/DGqo9rsQ6AVlKXfsCCdFLU+ncnG8IVH6QJci2WT1cxQUcBsBrhewmoQuZrYJy3Iiy6/AMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774273394; c=relaxed/relaxed;
	bh=MtzXo3XKZ9h1mLrio+3VEZI7yf8tJN3S1M1X1U8Dsf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMyFzLyovCzDtYg1DrZSoaA/XO04F3rkjvGn5NUSIoRPx7LKIr3Sp2gpmchvf6UlxSzrTLdIbJ0ElCUzynSzwDAXc3pclfU3uEiFrEVnTgkfUtTkmpNYwLqN8gv6XlvwXQPPeBJaFkpAd2UBLdNxEu3uT4S5o4kAF+ND6jXy8zMIY46Xaa1URvRz0dX/igO3dkAULETiFgLlhhCYnQDGG0QAi4xZlgxonImNmd5r8e4GXnq283lGqcX0wmcBOFWOundTTbhrc0aFl2AL29EmXMVxSS+WSJrA+7QMoX8L5niV0PLvnC8KEYwr2glAeSHIzcAVX2x+6nBjBsrkipTsRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OsYwVLrj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OsYwVLrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffZBB2Ytrz2xs4
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 00:43:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0CCE041A0E;
	Mon, 23 Mar 2026 13:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B669BC2BCB1;
	Mon, 23 Mar 2026 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273391;
	bh=yDPVfTxI35j0hA1l166oAbje8y9DRqGM1ZF+anP+BR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsYwVLrjy4YpA2iKRxf2qjRkuKc+rrmCQtG2hcQ7xCCyzhL7lwX3orRKUmFw0YWR7
	 wJXLwOKmtWK1SjLCRuQ5mT8Gu+pj7Qh/Q24sIXAL2JR6LVxS2vdU2oTqpW+jq9SWnd
	 t6H4keIF1cAnJgn+iosz0lS1OV9y+Q2uq+GKnIl6+XHWeXlQvO4jaqr3sAUoUR7qDo
	 RCc/rBFHyBjQG4yYN1dzTqzZygZqARgjaGUECGILHxxRFkWBpJYDFUzzpa4kn5+O/b
	 p9yeGcWwROkmP8s9bCCCHQMwVxFfQ+h+uXc7jcPW2p+CcExFS0Cdfz4MTooN5pTicP
	 YVvep24zM5z/w==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org,
	u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/4] fs/erofs: align the malloc'ed data
Date: Mon, 23 Mar 2026 14:42:17 +0100
Message-ID: <20260323134305.2675822-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2956-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,m:mwalle@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,konsulko.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A866F2F3306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment). Use malloc_cache_aligned() to get
an aligned buffer.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/data.c     | 11 ++++-------
 fs/erofs/internal.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b58ec6fcc66..61dbae51a9a 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (map.m_plen > bufsize) {
-			char *tmp;
-
 			bufsize = map.m_plen;
-			tmp = realloc(raw, bufsize);
-			if (!tmp) {
+			free(raw);
+			raw = malloc_cache_aligned(bufsize);
+			if (!raw) {
 				ret = -ENOMEM;
 				break;
 			}
-			raw = tmp;
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
@@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 	}
-	if (raw)
-		free(raw);
+	free(raw);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1875f37fcd2..13c862325a6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/log2.h>
 #include <inttypes.h>
+#include <memalign.h>
 #include "erofs_fs.h"
 
 #define erofs_err(fmt, ...)	\
-- 
2.47.3


