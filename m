Return-Path: <linux-erofs+bounces-2909-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGZVL02svmmlWQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2909-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 15:33:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE662E5D1A
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 15:33:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdMPQ0xPVz2ydq;
	Sun, 22 Mar 2026 01:33:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774103626;
	cv=pass; b=XS3HO02ofdkqhVqJCWc1Hrq5Z+MsRptWnbWWHcfmEJ5jyBYeGa3LC6b2t7nYgxexVCK9n60tIslnvW6xcqx0EYC8Ix1esguaQ+0dSQMYMYBgYskc8x4/htqzLsc1FiXDo4G3NP6hUyorbykY8Wwr12t8NoIqSuak5N6ksAM9wlGtiFMuqVhkAiz31TovN9+ZCGgqOpwP4MD3jsMwx0a8Wdlnfcjy+0f7bHATSFldfmR4K0q/kYRAr4UwNqepVzv6lfBe5uU+gBG+PM810Yldda/JuecKlz2SouaThMeCPh0GxZle9RThtqZsxO9V50cBwxSqsug87250Alw+5HRtpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774103626; c=relaxed/relaxed;
	bh=7YNZtSTPPo/mVI/GslQF9w4oezfxMiMMgwGZpy2HgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5hWEG1HS6FRs4cM/lBr80a6681NNvbNe1tsv5mEqJOwuU8hVxizvuJaoZsid7AUXw3YaYb+pIqWDXkEyJTUEIRDQuTY+qX5o9R7T0pyGNGVD02LVKBDK+x5j45NjASyiJ8azXbxfVXOJsPb3WP/YSD5zhUpFtSi8lpZUgL93DKmMCQWcOcHZE0JQlyGvuDOy9+x+ssraaAZBKlhTUBMGma/42OOaWS6RPev1Rr/enDG2FIskmELcq8IWihXdkdAGNJlXJIFE7KyC6zxGsgjAKxySjJ/LO/jDa5ZsdXFc7UAqE3t0h/lfUKlSvZPMZNDvg18aKZpvnP7vx1rdtu4HA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=hm/rS6qd; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=hm/rS6qd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdMPN6sn0z2xWP
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 01:33:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774102714; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=akTujlwhRswskzTQwqsBAa5vAm9aWQ1ugS7ne8oLGRoIaB+41bVnGY//nbFfUgZq3yn0uiVjL4S5bAbwH6OAamQeZIlVypqUK48f2WCOdtXHf1/bxwSBkI1YZcba0u+XkJ/bMcd1JVkPwWTFmgtAkR5M0R1cf4pPaIFL3l4H3O8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774102714; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7YNZtSTPPo/mVI/GslQF9w4oezfxMiMMgwGZpy2HgIs=; 
	b=LeKRUfV3ZQihsfshT+LTk7NZl/oIOeiwMrI3G318z4wmE8VUM6YJchrboPm//5vEgteQcQY5WTAg3ii3ol+ts0UsXsARInsd5k+9n5d9QpSmCjvgI6ctP6U5hEV3TLkOjS+cu+58qhckLCHGrB1+QAdMqtU8Dz53yMFlnEo/3lE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774102714;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7YNZtSTPPo/mVI/GslQF9w4oezfxMiMMgwGZpy2HgIs=;
	b=hm/rS6qd9gEYYiJLJc93RTwV5/3SFhV9KVCt7LU7q0fpspDp6KsJf+NcDP9CP5Vm
	HrMLvHOJoue7P1N5prNBjr5QZ+nL0UtPOzNydPUlnvmySYFAJsFcm+acYpGH1HCvsIW
	tN+isWIjkRIwYyyLwjISmpcgMuDLFH3D3rBE5I44=
Received: by mx.zoho.in with SMTPS id 1774102711840565.086949488715;
	Sat, 21 Mar 2026 19:48:31 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: man: fsck: document extraction options
Date: Sat, 21 Mar 2026 19:48:30 +0530
Message-ID: <20260321141830.32334-1-ch@vnsh.in>
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
	TAGGED_FROM(0.00)[bounces-2909-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: DCE662E5D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the existing fsck.erofs extraction-related options in the
manpage, including --offset and the extraction-only force,
overwrite, and preserve flags.

Also normalize the option markup for --no-sbcrc and --[no-]xattrs to
match the surrounding manpage style.

This keeps the manpage in sync with the current CLI help output.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 man/fsck.erofs.1 | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 0f698da..1659dea 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -34,7 +34,10 @@ take a long time depending on the image size.
 
 Optionally extract contents of the \fIIMAGE\fR to \fIdirectory\fR.
 .TP
-.B "--no-sbcrc"
+.BI "\-\-offset=" #
+Skip # bytes at the beginning of IMAGE.
+.TP
+.B "\-\-no\-sbcrc"
 Bypass the on-disk superblock checksum verification.
 .TP
 .BI "\-\-nid=" #
@@ -45,11 +48,31 @@ The default is the root inode.
 Specify the target inode by its path for checking or extraction. If both
 \fB\-\-nid\fR and \fB\-\-path\fR are specified, \fB\-\-path\fR takes precedence.
 .TP
-.BI "--[no-]xattrs"
+.BI "\-\-[no\-]xattrs"
 Whether to dump extended attributes during extraction (default off).
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
+.PP
+The following options are only meaningful when used with \fB\-\-extract\fR=\fIX\fR:
+.TP
+.B \-\-force
+Allow extracting to the root directory.
+.TP
+.B \-\-overwrite
+Overwrite files that already exist.
+.TP
+.B "\-\-[no\-]preserve"
+Same as \fB\-\-[no\-]preserve\-owner\fR \fB\-\-[no\-]preserve\-perms\fR.
+.TP
+.B "\-\-[no\-]preserve\-owner"
+Whether to preserve the ownership from the filesystem (default for
+superuser), or to extract as yourself (default for ordinary users).
+.TP
+.B "\-\-[no\-]preserve\-perms"
+Whether to preserve the exact permissions from the filesystem without
+applying umask (default for superuser), or to modify the permissions
+by applying umask (default for ordinary users).
 .TP
 \fB\-a\fR, \fB\-A\fR, \fB-y\fR
 These options do nothing at all; they are provided only for compatibility with
-- 
2.51.0


