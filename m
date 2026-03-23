Return-Path: <linux-erofs+bounces-2965-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLHBGH5qwWnVSwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2965-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 17:29:50 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE72F82C7
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 17:29:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffdtK0nCtz2yFb;
	Tue, 24 Mar 2026 03:29:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774283385;
	cv=pass; b=ZoL4nV6CA+m6pArQYsXNb0sILaqXTb0VG3l8noNOsubzoPdjK330ccyD0dNqp/N49YpkJYNEDwTcQ1NTkk3etDO8n0o13M2hFwYiIt2KRLaAzVCrdQc1HrgjYvqLeQVrtbBYcKU2o89wmqlVp1LPaynPEFBjZ34B7THZ7i/3r4b5ntYamacEoj3/8Luyc9bLtlnfof2e2vPFxnWAiSZnd6cm54fMdD7kHLbf1pbzYmCgnw0upxv1UgHP43r7RRtbvNRZ9q/FC+xsUZs8IUbsg7eXkLxDQk/3/mJOXwv444NDOBY0qbD4gW0Jk4ifF4PLWO6PvpNmbFga4ayaagG0pg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774283385; c=relaxed/relaxed;
	bh=5ksqxqVRWn9KE5cEGBoeY1aIvXK2j62daRaLiIZPN6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4GWP/Az/Y+ApC7fZqe+1CIrGCCUz6W2UBKuI3rHEK7vl6qRqyHw+MUitjLy57ra49zZGryre00VuBm5VCMxBJlhM2QDhKBnvopA/ts2e83bRz44KE7TGIfkeVys2AwwfKpvgE93V0Qswwl+HJEZJ4hwzc3TPQgX/ZQGQtwQSNLZaHJgX/LXtgFnE0ICiBhBSeDNGEDLhTlTjFqORUNlyoMeF4Rb/q7vOidSte1TJMuBX2hU0ImIckd2XDT4J4y/Zp1V3dh+Bb3MnlznikpMq7UjVy9w6Lo5XBydzU5zSy+lQ1IeltWYIm9+Bpx1UPSK7BAI9ylmr7ioqhf08sK+gw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=o9z/0H8p; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=o9z/0H8p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffdtH4xtpz2xs4
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 03:29:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774283377; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=NpMAfhoC9kEELcETSlT+b2c0LMsxnPmsc0pwEmDe/yUeu80gIqRa4iwPG0t/OdUswCGeuKTMIBYIObDxuUTqNofwis81ijPkSDtNujVZ0+M899m9BJCu+7WRfNP7C5kwre+KnSIvcdaDP0lkoPVYXpyf4R49neCurj1BLYoPxho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774283377; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5ksqxqVRWn9KE5cEGBoeY1aIvXK2j62daRaLiIZPN6U=; 
	b=C3DsxXXUTJr8uBUVbC/Qv+lvgqgsJ4VV2nN3xkDLjtWtkefVy1OA+S5PJ0Z4y3jwe5gBXezgtsLoUq9E1CDRJLftelhYeW1RaFAdePXUoMcmDtbuGNF+GuL4DAsh5D0cjl8fbULUesEZ/0X9gara7j8AaXfFNwP4cEcet6H9cDM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774283377;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5ksqxqVRWn9KE5cEGBoeY1aIvXK2j62daRaLiIZPN6U=;
	b=o9z/0H8p/FqBeWLU9RLRALoduB9kWrgzqNlLPQMLoJGB09vsfy7/iZ0mY4wrZNPW
	XU4KWWUWptl2VH4hkjETlCk38/tQSW8qWZCUWFE5VxakacGkjYnaFt6aLHwaxDqkRhn
	/E1hY0uT3/SANA13dA4TsDfA7ImapU9+/NsANOv0=
Received: by mx.zoho.in with SMTPS id 1774283375484914.6398791807734;
	Mon, 23 Mar 2026 21:59:35 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: validate tar entry sizes
Date: Mon, 23 Mar 2026 16:29:34 +0000
Message-ID: <20260323162934.42547-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-2965-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: BDEE72F82C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject negative PAX and header sizes before they are used to advance tar\noffsets or populate inode sizes.\n\nAlso bound GNU long name and long link records before allocation and\nfail cleanly on ENOMEM.\n\nThis avoids malformed tar inputs from driving bogus allocations or\nwrapping tar offsets.\n\nFixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 26461f8..cb77f39 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -540,7 +540,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 			} else if (!strncmp(kv, "size=",
 					sizeof("size=") - 1)) {
 				ret = sscanf(value, "%lld %n", &lln, &n);
-				if(ret < 1 || value[n] != '\0') {
+				if(ret < 1 || value[n] != '\0' || lln < 0) {
 					ret = -EIO;
 					goto out;
 				}
@@ -811,9 +811,11 @@ out_eot:
 		st.st_size = eh.st.st_size;
 	} else {
 		st.st_size = tarerofs_parsenum(th->size, sizeof(th->size));
-		if (errno)
+		if (errno || st.st_size < 0)
 			goto invalid_tar;
 	}
+	if ((u64)st.st_size > (u64)-1 - tar->offset)
+		goto invalid_tar;
 
 	if (th->typeflag <= '7' && !eh.path) {
 		eh.path = path;
@@ -888,17 +890,25 @@ out_eot:
 		goto restart;
 	case 'L':
 		free(eh.path);
+		if (st.st_size > PATH_MAX)
+			goto invalid_tar;
 		eh.path = malloc(st.st_size + 1);
+		if (!eh.path)
+			goto nomem;
 		if (st.st_size != erofs_iostream_bread(&tar->ios, eh.path,
-						       st.st_size))
+						      st.st_size))
 			goto invalid_tar;
 		eh.path[st.st_size] = '\0';
 		goto restart;
 	case 'K':
 		free(eh.link);
+		if (st.st_size > PATH_MAX)
+			goto invalid_tar;
 		eh.link = malloc(st.st_size + 1);
-		if (st.st_size > PATH_MAX || st.st_size !=
-		    erofs_iostream_bread(&tar->ios, eh.link, st.st_size))
+		if (!eh.link)
+			goto nomem;
+		if (st.st_size != erofs_iostream_bread(&tar->ios, eh.link,
+						      st.st_size))
 			goto invalid_tar;
 		eh.link[st.st_size] = '\0';
 		goto restart;
@@ -1149,4 +1159,7 @@ invalid_tar:
 	erofs_err("invalid tar @ %llu", tar_offset);
 	ret = -EIO;
 	goto out;
+nomem:
+	ret = -ENOMEM;
+	goto out;
 }
-- 
2.43.0


