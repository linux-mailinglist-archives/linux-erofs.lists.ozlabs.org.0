Return-Path: <linux-erofs+bounces-3121-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMJ5FF2xymkX/QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3121-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 19:22:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3BA35F42B
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 19:22:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkyjz27Qjz2xnl;
	Tue, 31 Mar 2026 04:22:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774891351;
	cv=pass; b=Xcxbvrlx+6FtNJMVIqSUDLjp2jOyGE4v0RuAebFyyf9jOHXs9EiP5+SHV8gSsjW3JjzM/HNH6g/qEk88y7B9Yvj3NihO7tnh+ajm0McStog6mJSjdcAaZCdR+JgbRvXQbp2YrBOmE0HvmWGPTNZ49ED/GVr6vca4UbyUBabxfp1vOaNVR4szTRKPpb4RDbhMoTw3bPr29hJC0RhSRn9Wtm8CNXHa3Qh0ON+NTGHM7o/KaSrdvaJolR3jOSjo9A0M21zQbMscVPMWV3vKDopylluJrUZldTHCu/TLy9KykrO7CxkKbPtT/ysiOUYEpkn1QXfWGWnDnImMlegalTfw7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774891351; c=relaxed/relaxed;
	bh=iSlZtuftpg3aP7CRG8SDyZ9Ajj80feW77rV82QlCfcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeUsuRxSHDNub5Rqxrvep5jS4zVmlzKTA2wWWk5jBvNim7vVrne5PX79YPeLxko0ks0AwcR+EO3mBpvKtHYtAbcoo5KhgJ8yvj/YvN0Zm1lTAHUXJZE1b+9oeA1BHAB23pmQk63cVSKxAiYBxJ+B8tKDy4H6XPsU35zb0F6vpcK5Hqs1999VFSfdrePklT3MGPzij8UWQjyBZm2fU0IpoQ8SZnCKfqOPDyY1+mtuo4znQpwd6NMMjvWSs/MZrLWSvoejY6I7Uy4ue0+RDIee6A1N+BjFYuLTGj00MX9Y0bhBSg8DDM8m3nEYqGW+bBfz/HgDWyXeHWKPqUMOO5NWdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=Z9xx4zsr; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=Z9xx4zsr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkyjy06Srz2xT6
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 04:22:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774891343; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=YnZ0TBY/g/a9Tsrojoxskve13505xs+qyV1W1q4PAkPK6bJ1WJ93wdgWpXIUqpp0MsEw077iXCH/Lwps4+Ri9nQKvmhohqXHC10WgnWFr++WAT+4DYx53KYRrCNU6fev327x9wx0PrOznUBtJ8wsnfPjHCG/gFmTogklXbdwDWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774891343; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iSlZtuftpg3aP7CRG8SDyZ9Ajj80feW77rV82QlCfcU=; 
	b=HA2uC1HZlWIi5jlrja825aBYPlOpIlqU9L3155hPZnmH7+pYIQ+99s7t/re6WVJH7Rb4gs9GxXtFD7UxYlDsZPI1+peZ4XViLhzUXxrQAq/7rvHyUNf9g1IqQzTHyc7ZqYDBARJyO0tlJVkJwxiB7VXKlC8rCFzw2ls2EUPglOQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774891343;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iSlZtuftpg3aP7CRG8SDyZ9Ajj80feW77rV82QlCfcU=;
	b=Z9xx4zsraKNgdmPLI1Vb1Wrs/FbNzOCH34LluXvLJOPWfSwnN97Qa07OiKhT7376
	A64294LSNfmi65CtJzAA+j+LwfU5bzjkV26tv1r0i9F6AjOv98Zt5zHkQpdna88Nh8z
	3+yiwwhB/mC1hvf2Ytsi5r55qSXuo1hRDK1Z9RTk=
Received: by mx.zoho.in with SMTPS id 1774891341039197.85659394318986;
	Mon, 30 Mar 2026 22:52:21 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: bound-check truncated directory blocks
Date: Mon, 30 Mar 2026 17:22:20 +0000
Message-ID: <20260330172220.224950-1-ch@vnsh.in>
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
	TAGGED_FROM(0.00)[bounces-3121-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: 4B3BA35F42B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject directory blocks smaller than one dirent, and validate the first
dirent nameoff against the bytes actually read rather than the block
size.

This avoids walking past valid data when the last directory block is
truncated in erofs_iterate_dir() or erofs_namei().

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/dir.c   | 8 ++++++--
 lib/namei.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/dir.c b/lib/dir.c
index 98edb8e..bf57849 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -172,9 +172,13 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 			return err;
 		}
 
+		if (maxsize < sizeof(struct erofs_dirent)) {
+			erofs_err("too small dir block %llu @ nid %llu, lblk %llu",
+				  maxsize | 0ULL, dir->nid | 0ULL, lblk | 0ULL);
+			return -EFSCORRUPTED;
+		}
 		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= erofs_blksiz(sbi)) {
+		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= maxsize) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %llu",
 				  nameoff, dir->nid | 0ULL, lblk | 0ULL);
 			return -EFSCORRUPTED;
diff --git a/lib/namei.c b/lib/namei.c
index 896e348..a4f68cb 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -247,9 +247,13 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 		if (ret)
 			return ret;
 
+		if (maxsize < sizeof(struct erofs_dirent)) {
+			erofs_err("too small dir block %llu @ nid %llu",
+				  maxsize | 0ULL, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
 		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= erofs_blksiz(sbi)) {
+		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= maxsize) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
 			return -EFSCORRUPTED;
-- 
2.43.0


