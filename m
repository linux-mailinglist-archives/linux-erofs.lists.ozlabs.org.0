Return-Path: <linux-erofs+bounces-2429-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBD0BWbFn2kRdwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2429-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 05:00:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFBA1A0BBF
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 05:00:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLyRQ5Fjfz2yFb;
	Thu, 26 Feb 2026 15:00:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772078434;
	cv=none; b=SyQcQhByBTlPlj6URZzaX+f31W7+E8WVUZDIht9Kg/ixImgyR+3A9/n16dyCH2qyMxki8Gla4QzEzIRUwr7aQqc+L/Zt1zuybU2a4z/1wFnOCDPFoUh/EFagkh8SsGTHfUIIV5CZ6Lmo7YC5TmeqHHOon5I2a6bPW1BDStWHWLhUJhzqSTlcsBk8gGxhp7ZQmu76AHDHLe26TTACmbHX0fRLIPwOa3kW9strPRIL5iasLKIkO1+tMfLlpYqUGosFAjoFdoyx6RtlRB58IY5jYvMBqSh1FaYDWz2jyjYqrxkvYZ/w3TKcVEWFl+Te+2ZVfuoeykg4w0O3bNIwWjUgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772078434; c=relaxed/relaxed;
	bh=X3z1s4R7WGggWbLTlFKPe7EWqNP/ePaVH5AZfRJoXLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jj2AKQlYYuNVEl1Ctqf32j5ePCXZwWxPtHXEdpcIO+qmGo5KT3rW8r+ufgcQtbfYZyaVUVAMHSifE7wea6k3A34hoEIpObJmiBIcyGTWfc9UTrdMgN0bheqRVED7QPkoaBUww8srvIdA6OQ/N54hnpjAQzKRN8Q1cIAHuRgi9vxx6gYE5hp4PLSWcamsrCGCT80GxCPDwiDjfwjvMZDi8iAbcZB84a+WoLpl0kdknqGDiiauQwzt+o1ayGzwnxNN2W3A7u9ZylmkE/P/CvWfo4uOi/B43oloJJbqKdtvKslL9T7NbR8aDaeBWKSXhWW8onwN3B1v/47awYdj7oQWMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Vts/YnTX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3x8wfaqykc7wkpugqdiqqing.eqonkpwz-gtqhunkuvu.q1ncdu.qti@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Vts/YnTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--inseob.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3x8wfaqykc7wkpugqdiqqing.eqonkpwz-gtqhunkuvu.q1ncdu.qti@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLyRQ0mPBz2xQs
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 15:00:34 +1100 (AEDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso1606821a91.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 20:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772078432; x=1772683232; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3z1s4R7WGggWbLTlFKPe7EWqNP/ePaVH5AZfRJoXLY=;
        b=Vts/YnTXue2jrSspUaSsm0odf+sV95C6QmP+chWUHvwKyXcshkiLlqyZMbctpFgTIc
         RPW3YVBdYB8cmTabzu5VqnM52T7msPF0f+AQAntyneBu51onLxMeoAtAwxP+/wxShAJ5
         /uSN4HVrcgeErShtFmxgjXGbcQrzCC8nUJtwlXlO60T+p/zJv4Ww/B993T6EY3yhhi3o
         +gXyp0w1XwQAUc97N2VaJYeZekJaiGlENzHPLc6xeo0zS5Ig7Nz2ZK8wJCC6HQ0+7Lsq
         WIljiJzCig8+RQEu0KNSw6BFpyLDbry8QY3JPuOe+XeYgi/eXi97ST5cRJp59ALSnaoo
         ACIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078432; x=1772683232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3z1s4R7WGggWbLTlFKPe7EWqNP/ePaVH5AZfRJoXLY=;
        b=Eq8kfAwKbr9jaTP+FiD/3dQu0NtGntMCCMDmJXfEVf8i1IRjb19KRLjm7JBZ8xx9fz
         eR8sRGwGsgc/VZBnJXaCkXr12Q5ccNmU529NVqJT6mD/+8C9BCv5SpGQJRws+gT32Ub5
         4mZDC4C/BiQvGG5t/9iIxZIFp5pIj75rTW99lU9AL1sEjYWf4cJWEL8JRNlBeLlkfSiD
         fgIVoCaSeKxYCjgZiTjT48lgLyfpbtMBcrfO6m0tcnd/5gtt3xzt7Lc8i83t/jjvdFY7
         IIYSztOyFeCZo1XAEcZSdGDBG+5HoUFUgZIYMDnAHQtBuPquIthAg3x3uFl8NzvDFN2L
         vCMA==
X-Gm-Message-State: AOJu0YwoUzDm3UhCbAMJvUss1M3FX4qmoUYxEuK5y2EQfM05Ge5iO/2V
	AHSr2A2ThKfSPsQnL3saF+sVIO+W04J9ue+sL+V3FUJQizpWO4EMg2Bz9I/AQmTkJqRhZXK205p
	3kJ3OUEOEy/D9zdivPIeP0I47/egtm63c6NQdesb/WwSA55HSVndFnUQL/tMimKumo44eyoxPfe
	2819S9Xfgw2VGlTpa66GS9bxI1ozav7EpGniq+3KORSWlo
X-Received: from pgac23.prod.google.com ([2002:a05:6a02:2957:b0:c6e:2252:1740])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4801:b0:394:f99a:2aaa
 with SMTP id adf61e73a8af0-395b492f3b3mr971076637.40.1772078431833; Wed, 25
 Feb 2026 20:00:31 -0800 (PST)
Date: Thu, 26 Feb 2026 13:00:24 +0900
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
Message-ID: <20260226040024.3917012-1-inseob@google.com>
Subject: [PATCH v2] erofs-utils: fsck: support extracting subtrees
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2429-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[inseob@google.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2DFBA1A0BBF
X-Rspamd-Action: no action

Add --nid and --path options to fsck.erofs to allow users to check
or extract specific sub-directories or files instead of the entire
filesystem.

This is useful for targeted data recovery or verifying specific
image components without the overhead of a full traversal.

Signed-off-by: Inseob Kim <inseob@google.com>

---

v2: retrieve pnid correctly rather than pnid == nid hack
---
 fsck/main.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ab697be..16cc627 100644
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
@@ -862,6 +874,22 @@ again:
 	return ret;
 }
 
+struct erofsfsck_get_parent_ctx {
+	struct erofs_dir_context ctx;
+	erofs_nid_t pnid;
+};
+
+static int erofsfsck_get_parent_cb(struct erofs_dir_context *ctx)
+{
+	struct erofsfsck_get_parent_ctx *pctx = (void *)ctx;
+
+	if (ctx->dot_dotdot && ctx->de_namelen == 2) {
+		pctx->pnid = ctx->de_nid;
+		return 1;
+	}
+	return 0;
+}
+
 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
 	int ret;
@@ -1033,6 +1061,8 @@ int main(int argc, char *argv[])
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
 	fsckcfg.dump_xattrs = false;
+	fsckcfg.nid = 0;
+	fsckcfg.inode_path = NULL;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
@@ -1068,22 +1098,56 @@ int main(int argc, char *argv[])
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
+		}
+	}
+
+	{
+		erofs_nid_t pnid = fsckcfg.nid;
+
+		if (fsckcfg.nid != g_sbi.root_nid) {
+			struct erofs_inode inode = { .sbi = &g_sbi, .nid = fsckcfg.nid };
+
+			if (!erofs_read_inode_from_disk(&inode) &&
+			    S_ISDIR(inode.i_mode)) {
+				struct erofsfsck_get_parent_ctx ctx = {
+					.ctx.dir = &inode,
+					.ctx.cb = erofsfsck_get_parent_cb,
+				};
+
+				if (erofs_iterate_dir(&ctx.ctx, false) == 1)
+					pnid = ctx.pnid;
+			}
 		}
+		err = erofsfsck_check_inode(pnid, fsckcfg.nid);
 	}
 
-	err = erofsfsck_check_inode(g_sbi.root_nid, g_sbi.root_nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
 			erofs_err("Found some filesystem corruption");
-- 
2.53.0.414.gf7e9f6c205-goog


