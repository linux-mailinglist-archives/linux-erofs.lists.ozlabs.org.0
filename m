Return-Path: <linux-erofs+bounces-2432-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBOEGLbln2ntegQAu9opvQ
	(envelope-from <linux-erofs+bounces-2432-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 07:18:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B01A147C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 07:18:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM1VT3ZDtz2yFc;
	Thu, 26 Feb 2026 17:18:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772086705;
	cv=none; b=chM7VWxHKzwgI0Gz58f/QaX7chMlDrFpwCeZ30968iFYl7gVzD0n3ZCyewpAibKMcg+HSBozavGodC5EJrO/hG6WBTKCJ3Y7EPe6waGebYYA9K4yfahtQET9qxUy2FJgCTociZvdo9Nnjg+Ue6tDN+t0kLqm4DQeFSdjtcNytDwYgAj83hKPDcvXH/I+z5tKLxr4Z17bFva+U1tHEdLI8YIwzUvcCjMtbOjo86q3SOTN4JEo4loKU5iwo/NuQszlXV173YiBiZdHR0C7WpYAqP6czybXI3jZVG62HBA+Je8OQr0aBNyZPSWA4fDI++zO7I6xskE9k/MSwUPVFSkmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772086705; c=relaxed/relaxed;
	bh=12fyl4J6M6zbHass4LIrYW+A/uBetDZPuf7/jU0emtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EMGDaHjk7Q5kRnK5ALL0/zxXCxtIIMO/Qgz8lxrOfKI/M2GEi7OYdn5V/pEnyALAeaO7aOJQPn3QNg6tBh2SCJUGQ/rtL2jqoBHSJmjRJfkWdg3q0valEpAj7s7fDvWodEAAx1ODWJy1TOHpHy2Yg7Q0LvpHGCHE5FdZoY4lf3rnrIQ6bUYEX6+nJCO0xpIX5ZqluLR5m8gubPBIu21S17va0dSEJSGwSdLOAtlkKdyKesFAdVXmr4hfJr6kRf2OtJgotQ97jMpAumji3J0XPZI9cMUJZvxFRLItCq2gLp2MjfY7IdXyWhfLXYWIWHRy326BEYuJUKas30bXbGkG5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JhBIDEcF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3rewfaqykc0ww16s2pu22uzs.q20zw18b-s52t6zw676.2dzop6.25u@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JhBIDEcF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--inseob.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3rewfaqykc0ww16s2pu22uzs.q20zw18b-s52t6zw676.2dzop6.25u@flex--inseob.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM1VR6lgrz2x99
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 17:18:23 +1100 (AEDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82442b44d94so266934b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 22:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772086701; x=1772691501; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=12fyl4J6M6zbHass4LIrYW+A/uBetDZPuf7/jU0emtk=;
        b=JhBIDEcF0bUNkK0HcXrJVIWOX/2QPYnmPdTQ4UB78WZzCT8AuD2AfpAq3EX9fTOi2M
         1AjjfJitgvmEzUVRr5rIoG3c8+DBsNTA2CV1K39wLVTSvKEv5APhth6NFlc/WprXIJrO
         OdyaR4j7SHdkLkW3eeUlpt08iGQkuelc4eB0CEcQ1hz9lSUFC+qeaQ2Nudevw/3zRqdj
         n9wOtZuLROWhd+XiE/YTlCFjdBYYgQx3aLG6+wbN/hiVZz+J5zDSnXoUbFukmqt8BQa5
         Hdm5yMcN0bPTIM9MhKbDEWUbbVChZAq6w8I9G8h5HHeqfftj5lTQhfyi6MtBvGa0TIHs
         piTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772086701; x=1772691501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12fyl4J6M6zbHass4LIrYW+A/uBetDZPuf7/jU0emtk=;
        b=vxz5L83m0vdtlxqTgXwW3vS0OhWZUXuIy/jXYEUmzMvLZhZeEoOeKzt7w3bwWAEZ6n
         iQ8ICE5kAFyaBoEuGfTUaqOLOaaIGKX214F7IPX/o1mR57ytEOSNi4sC4RJxquxdGOoq
         zbbn2qoGeqA9NKJmnbVsXEGg8OM1ihpB+Ekr/iJW+r94/dw9VlB8/R6eIQTk0ui+pcEH
         OlOsMKdXR0uso4kD12bVKC5flyqQ+0iwhYnqlz1FZT/+Ek8MMAWwis96/CZURT7kLa01
         PnxQ+QPvujTmr3v91ClxxM6OrZ97YifRS4fKRO1bNreWlWhfkL3py/Bf93rLJ393Ow69
         FNsw==
X-Gm-Message-State: AOJu0Yzb17K5lU5ek/vwohU4LX5IA3geI339MZs0cgrlNlKvMkYtsY5Y
	caSWV6jXde9AKusm0SCWpDuLEdzj6+zla/sKMQeieBCnjtWzxr+Uk1gvFt7QGKo84dRjxbyjtFV
	yEPCahD5Lhj9XjT5U7N/sTa9KfDyzZvNAn1Fla4gIEsQ5XNWHnqilba94SW3xsWNsSjsKzSPc39
	YVSs3lwekdBky+9wcIeIDq58sZYlMab6WvF+X+euvqMLYF
X-Received: from pfbif7.prod.google.com ([2002:a05:6a00:8b07:b0:827:1713:6de8])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8a:b0:827:4372:dd1f
 with SMTP id d2e1a72fcca58-8274372dfe8mr134305b3a.41.1772086701000; Wed, 25
 Feb 2026 22:18:21 -0800 (PST)
Date: Thu, 26 Feb 2026 15:18:07 +0900
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
Message-ID: <20260226061807.4101174-1-inseob@google.com>
Subject: [PATCH v3] erofs-utils: fsck: support extracting subtrees
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
	TAGGED_FROM(0.00)[bounces-2432-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 7A6B01A147C
X-Rspamd-Action: no action

Add --nid and --path options to fsck.erofs to allow users to check
or extract specific sub-directories or files instead of the entire
filesystem.

This is useful for targeted data recovery or verifying specific
image components without the overhead of a full traversal.

Signed-off-by: Inseob Kim <inseob@google.com>

---

v3: update the man page
v2: retrieve pnid correctly rather than pnid == nid hack
---
 fsck/main.c      | 82 ++++++++++++++++++++++++++++++++++++++++++------
 man/fsck.erofs.1 |  8 +++++
 2 files changed, 81 insertions(+), 9 deletions(-)

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
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index fb255b4..0f698da 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -37,6 +37,14 @@ Optionally extract contents of the \fIIMAGE\fR to \fIdirectory\fR.
 .B "--no-sbcrc"
 Bypass the on-disk superblock checksum verification.
 .TP
+.BI "\-\-nid=" #
+Specify the target inode by its NID for checking or extraction.
+The default is the root inode.
+.TP
+.BI "\-\-path=" path
+Specify the target inode by its path for checking or extraction. If both
+\fB\-\-nid\fR and \fB\-\-path\fR are specified, \fB\-\-path\fR takes precedence.
+.TP
 .BI "--[no-]xattrs"
 Whether to dump extended attributes during extraction (default off).
 .TP
-- 
2.53.0.414.gf7e9f6c205-goog


