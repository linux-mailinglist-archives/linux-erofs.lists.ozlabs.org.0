Return-Path: <linux-erofs+bounces-2417-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNhsCPaan2mucwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2417-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 01:59:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6419FACA
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 01:59:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLtQS1L20z2xN8;
	Thu, 26 Feb 2026 11:59:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772067568;
	cv=none; b=bjY67hXH2nZvijAiTm8ft8qIRMERG/SFl6r9zIHRNbqVQXwAwXfHIiWIRhJQmzrdaLlFv6IC71gqOzVDiG9DJlz6uL4FALZDAtFXjgcQj8sddUDCYsv75JwVVaVaPfJpWF+cwKw2jLxQFKhEh4fCISj5E877jdgDaVbNEPjbykyq4zh6IqMt+15ES0bR46uKfWibR86jb/zbNInAXgKxzP2VntQj4NtBT4DeGnZ4PDdxV+l6rPrPUzPlkbqsqGd7SSIX+Hoe3SWkv1hgx86eB0f7xq6DFZ0vW9vSgh8Rd/BgxjsMurpXWn6+IHYWWbVTrbmTk7d+fSo2qXHM4nWLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772067568; c=relaxed/relaxed;
	bh=MeQ+dhzNJjYHei21VpjFqIoTjdhx04m5/gfTIyTTWgE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BiqsxiI981CsYNYNVSuPvIpOldmasdJdosq+DW3pNEzHeXYB7wlRDuB4AiCItNPQCO3D1DtEReIUY59ZTATV5wXY+ygreMK6bU6Do5DA6zHGAH6bMq2Y4rrHDmnS8xHjyCYm8Tm3xIDbLaNFs8eTb0PLrthLW5FEbF7Zc7NUWY2lntn1Y4OkUhbm6i0zMhBgOfM3ULhnBTbr/aApvod7jwd0iTY9HoYe8OoL/+OaMRCkub3GvXji61z3J/1fEsPFQYA2BYYoK2fRCGiW+wA6t5drawOnHehcbxY5icQFFSkDPeW4rEdjqCIQiSiGPH5Rn0c/lF2NCzFZcFbV5CNxzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nOIaeUJt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=36pqfaqykc_ebglxhuzhhzex.vhfebgnq-xkhyleblml.hsetul.hkz@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nOIaeUJt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--inseob.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=36pqfaqykc_ebglxhuzhhzex.vhfebgnq-xkhyleblml.hsetul.hkz@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLtQQ3Vj4z2xN2
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 11:59:25 +1100 (AEDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b6097ca315bso1208270a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 16:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772067563; x=1772672363; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MeQ+dhzNJjYHei21VpjFqIoTjdhx04m5/gfTIyTTWgE=;
        b=nOIaeUJtmAgDAyIBJOWldT4SqB3s/EeYK/uwvQSfN36MyUeQN1/NIKmCi8R8/gN7QL
         tmKMOk4DzCRrbj/3bC82K3Uo1XLcKkq131Oqr+PjYU8mi+L8/sp1JQTtEKr99+LYAT8M
         BzCpoavHE3TyNsWYu6NYRal8l3z8gYU19eeG383QDeo50L7QKZ4RIS7qxEt2yNt6k2mU
         YPNV8LIeRSvWkKMi5yADstIrvpaq24SC/l5uh7wmPC0CE7OgrGKb4TOarFPgHV38yxyF
         JjjOjN+NcLnaiJFKaUaA7Ap1Rvvs785OtAZayO4EGyNxk8RFZ2KhW6OiwqjLLQwVDYKN
         Sj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772067563; x=1772672363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeQ+dhzNJjYHei21VpjFqIoTjdhx04m5/gfTIyTTWgE=;
        b=JpL6GszgjFCXBIYs5nrHXUIyq5/kyfkfsb4+eiL8kUrycwTUUjkZVqWsgCdNLU3Fcx
         Suurk+RJYkOpPiy3qZHloFHwnJu65nWpIOn9/BohFYKMmO3lYX+y14d6IyOf+gi2DU27
         szuRt9Tnn5YuiRaqLW9MdbbgtrEhlxCPrFFWCcBdnKJ2d6WY+6OwpotndNCu38ilfDnW
         IpHbv+E9rOHvHJcO4RvelrtUJ9IaIB9FGYgXY+KqXp1yGQl4gCSAtyEmJuHnUVq2TfTY
         coH5PVBEnBmvu9mlyKsfRSZKHgdG3nsDZT3YoLsvpBIFnjVtRZsQ6VChm8Q2SN7Zt3+U
         mSVw==
X-Gm-Message-State: AOJu0Yyud8JVZX50usfGzv60ddReem9AbVGjGrGvaxTPyJAYdjyJ62/F
	t8cnUzuugLpHiHbhtojBtJdpWYQDs8JjejUio1Xy+f/d+h9m9LJTX++vKvj5GlDwaS42CPFk4v2
	Eypz86V7N6D8SiCoLZRA86mqght+ci1HUyh2rKP4nnmyK8vaLUoUXti3J5l6usJ+AITQtDW7tnR
	TKhJShEzmIMz771aQLG1PwGjQ/IaCZ2sLVnxb7NJuXEC2f
X-Received: from pgbdo3.prod.google.com ([2002:a05:6a02:e83:b0:c61:3a69:b2bc])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431f:b0:394:f482:badf
 with SMTP id adf61e73a8af0-39545e523ddmr16127142637.11.1772067562482; Wed, 25
 Feb 2026 16:59:22 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:13 +0900
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226005913.3703242-1-inseob@google.com>
Subject: [PATCH] erofs-utils: fsck: support extracting subtrees
From: Inseob Kim <inseob@google.com>
To: linux-erofs@lists.ozlabs.org
Cc: Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2417-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[inseob@google.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 14C6419FACA
X-Rspamd-Action: no action

Add --nid and --path options to fsck.erofs to allow users to check
or extract specific sub-directories or files instead of the entire
filesystem.

This is useful for targeted data recovery or verifying specific
image components without the overhead of a full traversal.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 fsck/main.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ab697be..a7d9f46 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -39,6 +39,8 @@ struct erofsfsck_cfg {
 	bool preserve_owner;
 	bool preserve_perms;
 	bool dump_xattrs;
+	erofs_nid_t nid;
+	const char *inode_path;
 	bool nosbcrc;
 };
 static struct erofsfsck_cfg fsckcfg;
@@ -59,6 +61,8 @@ static struct option long_options[] = {
 	{"offset", required_argument, 0, 12},
 	{"xattrs", no_argument, 0, 13},
 	{"no-xattrs", no_argument, 0, 14},
+	{"nid", required_argument, 0, 15},
+	{"path", required_argument, 0, 16},
 	{"no-sbcrc", no_argument, 0, 512},
 	{0, 0, 0, 0},
 };
@@ -110,6 +114,8 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --nid=#                check or extract from the target inode of nid #\n"
+		" --path=X               check or extract from the target inode of path X\n"
 		" --no-sbcrc             bypass the superblock checksum verification\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
@@ -245,6 +251,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 14:
 			fsckcfg.dump_xattrs = false;
 			break;
+		case 15:
+			fsckcfg.nid = (erofs_nid_t)atoll(optarg);
+			break;
+		case 16:
+			fsckcfg.inode_path = optarg;
+			break;
 		case 512:
 			fsckcfg.nosbcrc = true;
 			break;
@@ -981,7 +993,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
-			.flags = EROFS_READDIR_VALID_PNID,
+			.flags = (pnid == nid && nid != g_sbi.root_nid) ?
+				0 : EROFS_READDIR_VALID_PNID,
 			.pnid = pnid,
 			.dir = &inode,
 			.cb = erofsfsck_dirent_iter,
@@ -1033,6 +1046,8 @@ int main(int argc, char *argv[])
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
 	fsckcfg.dump_xattrs = false;
+	fsckcfg.nid = 0;
+	fsckcfg.inode_path = NULL;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
@@ -1068,22 +1083,37 @@ int main(int argc, char *argv[])
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_init();
 
-	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
-		err = erofs_packedfile_init(&g_sbi, false);
+	if (fsckcfg.inode_path) {
+		struct erofs_inode inode = { .sbi = &g_sbi };
+
+		err = erofs_ilookup(fsckcfg.inode_path, &inode);
 		if (err) {
-			erofs_err("failed to initialize packedfile: %s",
-				  erofs_strerror(err));
+			erofs_err("failed to lookup %s", fsckcfg.inode_path);
 			goto exit_hardlink;
 		}
+		fsckcfg.nid = inode.nid;
+	} else if (!fsckcfg.nid) {
+		fsckcfg.nid = g_sbi.root_nid;
+	}
 
-		err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
-		if (err) {
-			erofs_err("failed to verify packed file");
-			goto exit_packedinode;
+	if (!fsckcfg.inode_path && fsckcfg.nid == g_sbi.root_nid) {
+		if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
+			err = erofs_packedfile_init(&g_sbi, false);
+			if (err) {
+				erofs_err("failed to initialize packedfile: %s",
+					  erofs_strerror(err));
+				goto exit_hardlink;
+			}
+
+			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
+			if (err) {
+				erofs_err("failed to verify packed file");
+				goto exit_packedinode;
+			}
 		}
 	}
 
-	err = erofsfsck_check_inode(g_sbi.root_nid, g_sbi.root_nid);
+	err = erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
 			erofs_err("Found some filesystem corruption");
-- 
2.53.0.414.gf7e9f6c205-goog


