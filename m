Return-Path: <linux-erofs+bounces-3254-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KC/Ajv012llVAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3254-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 20:47:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD67C3CED41
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 20:47:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs8795vzpz2yS9;
	Fri, 10 Apr 2026 04:47:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775760437;
	cv=pass; b=cVMiWh81fEBQCPFShFhEWFOiuXOGF++seH+iXCIkNVorS6GambIJLS7FCivN2546IT6CcMwcvU6X+3WLtvtDXrXujo/gnlIKEYu28C9VTN8NRoAeOXzeX1OLi+XZtgpinTenrjpM/oL6Mn3kuff4Y436fn4M1i5viDzjeiCcLTyBz12XtxM3cpr4lJ2E8pWPjnuPJmEfC5OIBBSY0dqytv0E7lh0wnoG4gn/bTo/8f5EQ8Opd6QCFO4I6qNIo+patb9Ds7y4ZfLbtHTvfKXEy+zbBvbFDuUBKOfjPu9+XPzkjvcu/DSby+bKbxfO7S7YsY/B8DOtaDp3NBnbJzSQfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775760437; c=relaxed/relaxed;
	bh=oJAXsI2wHsiq/w7sK5qWw5vKQqgD5Y4+NGZfX9hEMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/Nlx4gM0xKxsIYDiybjvFQDaRZY+lIMSuSxpsKcnN+ohIsQa+kS6cMdcUHkVdHS0eGSiKziA9iZ6QFp53AtUbRmGPqveddIWaaRj4SxWTLjNqkvc5pH7jRx/pdpTDOWGdwdJTxkJpEfoMn6QkS+Jq6NiGNwjMz3xdPbpUgacF9VTTrsVTD1G6UpwDIbBD29HHlIuYBP7cBdROeTmDrqz5U9WbuBMFXOJ6WurzuDctt3GHyfx3gKMAQ55g52nGeFk1HrNu61m67mgRginMSLaYIOpV/G3TDw6gKezA2SyO1fldy7p9bfhd5iMSUwRixmq6hljriSeE/4tAoE0wmk4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=IzAmOqSz; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=IzAmOqSz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs8784mXyz2xpn
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 04:47:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1775760431; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=KrHQB1xX21v+okEPjAQtfxSi+2XG65W/Pv0wgjMEWuTQIZcZux52C/OPfWIdfa8ck5OSrvkBg/XoXZZFs5K/almcOhda/FADQqMVEaRbk2gqUyAYlEJmaK8Kli1hR8kT14l/bNrtJAgdoI7WK0rUaaXMwG1BM07logV0AP8RZPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1775760431; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oJAXsI2wHsiq/w7sK5qWw5vKQqgD5Y4+NGZfX9hEMEs=; 
	b=Zc6RNUrcqEqUKWbdpsfMk3Yt+Px9RK3hIbx4KvQFPc/Wc6r2XcUNnIcVCASah6hsYiJZQqBYe0pQwIFjz7nFIEtIjn9BKhhqLRKMSeTvGyKY8tcFiVun8vPPjAVeHQV/XxjiKmGyINGyXy39DJA1gRpL2JBd+yncP3nakyVqxW8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775760431;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oJAXsI2wHsiq/w7sK5qWw5vKQqgD5Y4+NGZfX9hEMEs=;
	b=IzAmOqSzW14rn2qMwjiriKdwEJsoj0yFcR3LBWyDty65D+IAltFGs1asJKku2f+Z
	77U3/UewC0USuQladTgFTBUEGM5Z1Z8jxCWGYPq1dNZtV4+wguRn8FCnYXNmc16ghQP
	g0pE5PgLp5RPSrlPI2OKL9Xx9zMnVPLJm4K8XuKo=
Received: by mx.zoho.in with SMTPS id 1775760430696677.0223559549927;
	Fri, 10 Apr 2026 00:17:10 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: fsck: fix extract path length check
Date: Thu,  9 Apr 2026 18:46:27 +0000
Message-ID: <20260409184709.108742-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3254-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BD67C3CED41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofsfsck_dirent_iter() misses the extra '/' and trailing NUL byte
when checking if the extraction path still fits in the PATH_MAX-sized
buffer.

Account for both bytes to avoid writing past the end of the buffer.

Fixes: 27aeef179bf1 ("erofs-utils: fsck: block insane long paths when extracting images")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 fsck/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 1254112..daac434 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -902,6 +902,7 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
 	int ret;
 	size_t prev_pos, curr_pos;
+	size_t required;
 
 	if (ctx->dot_dotdot)
 		return 0;
@@ -909,7 +910,11 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	prev_pos = fsckcfg.extract_pos;
 	curr_pos = prev_pos;
 
-	if (prev_pos + ctx->de_namelen >= PATH_MAX) {
+	required = prev_pos + ctx->de_namelen;
+	if (fsckcfg.extract_path)
+		required += 2;	/* reserve space for '/' and trailing '\0' */
+
+	if (required >= PATH_MAX) {
 		erofs_err("unable to fsck since the path is too long (%llu)",
 			  (curr_pos + ctx->de_namelen) | 0ULL);
 		return -EOPNOTSUPP;
-- 
2.43.0


