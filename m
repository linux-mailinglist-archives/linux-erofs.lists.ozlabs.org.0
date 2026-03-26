Return-Path: <linux-erofs+bounces-3045-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGj3BK1vxWkB+QQAu9opvQ
	(envelope-from <linux-erofs+bounces-3045-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 18:41:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63C3394CE
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 18:40:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhWK54NpNz2yZc;
	Fri, 27 Mar 2026 04:40:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774546857;
	cv=pass; b=PPw/6LZrmn7URnkTGlM31f4LdnLN/hD9fq9r5WMj8XExTXL0wqQNQHkTQXfhVBSBM+JIir3dIVBDByr6O8yh844nf6b7g7ByidIJQqteZpLwG9Xws3XnF0Y2WzIxCaCaCuDftEWSdVyUx8xAswd+k3q6D4JRLnuu+TGSgHuOQzZBNUY+t4bvB4NUiCXpvkF7NCexP2JwkCEkJff1/J7OQVLtQihWLaMoqJvPxDEuevfgbrIrAbailsMkPgwOwjg4SzhuOdgEz6QxF239CeI+hi3YMFaJxM1H80D4EQ0hdx3ZdruT04ljpsnb58qLC1/eliapPOA5uhlRnCZmE7pbXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774546857; c=relaxed/relaxed;
	bh=QOs4qxkQdlC1PKQF8Ithf4E6EZVUS7McHYKw202WrrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cupv1Gu5tdrp94Gae+uCFHfs+xY25VmfhFKUdFrOhvKd9oD75Mkrap5GXm98DdMrtq2n8mJqrHc/KacZ7d6fo4SNvWCQg4GWqFeQVBvlsLPOf8Lf2DzHAuQZTR4YEvdIaW2eyCpffeWe0aSSavLwQ3PzMsaiqpeFzkhkbQScuWgh0CV0t0DUXo7g+k1Rw589sSiSy/HHRDyjTTYMIc8KmOfqCB47nzZPjQKNETOT7YmEJqdL5G6MjPsqBuHMoAiW4dq9MnE8f2JafU1yYCzKVv1kQRXaI8YFs+4Y7eI9QjsfWb1ixuYKc0NnGG7jKKgpFnW066W7uR5x5gJrqmYUhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=j1Vc4+jR; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=j1Vc4+jR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhWK42xSCz2yVL
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 04:40:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546852; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=NYMAFmQobzQeJMxfFDKFOCalQ48432hBqJeThqYEu/gbfbwkPp0Y49khqwRr5tRJUe+7L1HPWSg7ixvHt+aX0b2krlFZWcgWDcK+/+BeYJ1Z8By/5YPKxdijkqnszd3moyzTzfz8tw3qj9skJ7YKYLA+Kv64I2thy3smTtw2nGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774546852; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QOs4qxkQdlC1PKQF8Ithf4E6EZVUS7McHYKw202WrrM=; 
	b=buVtObAefQQxl2Vi2AFAscrmEmv7+UVvExilGbTk6Odx99qV3ZCfuvBUkj/hfs0bozY+Bvre2fPKvVyJpvDBmm98Pr/fANgMifM7F3bJuFn6G+ONT3ZpffQOz1y/7Mot6d31DYvSqNYksB4h58sh/SYOj39ItoxJu1QcwswngDw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774546852;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QOs4qxkQdlC1PKQF8Ithf4E6EZVUS7McHYKw202WrrM=;
	b=j1Vc4+jRcO7sCxqR5GzlzgLvYP1+1yvjLqCeUa7d9FfB5oU1sRY06bCahRXOdqFp
	OBJxF1Izhh4W4qdy52nyp4O6FiLqr9VHg640b2IU3alXmNs6cK5om/Hy891zbJBa2uc
	2mDaDBKs/QLdru2KO3YGvOWrEIwqMwMettJ9dNXA=
Received: by mx.zoho.in with SMTPS id 1774546850653807.1559066004564;
	Thu, 26 Mar 2026 23:10:50 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: guard NULL hardlink targets
Date: Thu, 26 Mar 2026 17:40:50 +0000
Message-ID: <20260326174050.119176-1-ch@vnsh.in>
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
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3045-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: 1F63C3394CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_rebuild_get_dentry() can return NULL for empty or dot-style
paths. Treat that like an unresolved hardlink target instead of
dereferencing d2->type.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index 24e0413..4eb0060 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1033,7 +1033,7 @@ out_eot:
 			ret = PTR_ERR(d2);
 			goto out;
 		}
-		if (d2->type == EROFS_FT_UNKNOWN) {
+		if (!d2 || d2->type == EROFS_FT_UNKNOWN) {
 			ret = -ENOENT;
 			goto out;
 		}
-- 
2.43.0


