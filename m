Return-Path: <linux-erofs+bounces-3336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BlKCNpm5mmlvwEAu9opvQ
	(envelope-from <linux-erofs+bounces-3336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 19:48:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E69544321BB
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 19:48:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fztHm20rwz2yqT;
	Tue, 21 Apr 2026 03:48:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776707284;
	cv=pass; b=K1b8BPSQhJveKOCGPhSYSJvE0qbG3ONd2LzGjR3u2tijwmqo85tSzevCYFB3WLwKwL6IlMUmF76ycFnas7gu0C1A70TyrjGdXp/RF4EaHq4qu9mZvXkJMIrQIRoCv2KT+amGfB1ZDNOwp1gLVaWk+z4cagfSd313YWX6XECf9k1CPalt+Mlw8K4pT0kBYsW0UBEqrvMragYx2QdZadc8H0Qz9H7xbMhsCg1i4oQTS2gnGGMXMc6MP8wge1aZOl2gkOKDJGNQ8/1dsw6g/omBohOP1yu+MySsWr0J3a8oFNG6xg8PJ+3FTpG4ELcnANKJPor9koHyy3u0EqCgS3qhAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776707284; c=relaxed/relaxed;
	bh=fVE1QqhfUMfiQMv2NiZUXsvY4CKNsni8HJeHzW/ovGs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E1uoV4ctgydy1FTwkG54UQIAvddaSlMNh9mA3tJUlXXGck2kUlXN+YVorY65A4KNtHUy+fkBYox1CQkPcENRqvvyfOpPtdEhCIHfIWEVEmkPXdEMzhew6W9+CI6twLVWjRU4F7hTBoF+zLV+d7z2Q7YHrTsJfgeCqiUsynY+at2gJDQFoZVOrKxnNG0zXR4LsAHFPnXi1zP4D63gX2ZpVdcRtQjYLQHockgzUQkVhuR9akbGkF0k5M+Z6mowDAyl1SuiNjfDep2tBXYXdt1RjPpQn4/yahu72YNd1PLC6g3PPUESCR/EKEuVMF6ipESZSKuM2yKsg8d9PDJpAAMLzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=AZgp62O9; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=AZgp62O9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fztHk2LbPz2xll
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 03:48:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776707275; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=RC1gh1tbCQ0l5pUXJJGP/5oRFDGzUZo+QgLIwBArbDNNq1oTP71Ubq4Hwlseq5aLiNj8tdCpn9IYUcUCJYfuf8q99PeL3mq6SHpOEUxULIRc7KpQGKKlNwRSc+9+By92GVo3wRUIZAJO3CcWjX2c213wAgyMWzClc1qbUauIq5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1776707274; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=fVE1QqhfUMfiQMv2NiZUXsvY4CKNsni8HJeHzW/ovGs=; 
	b=YJpxWHyj5KahxVh1cod9/DWZC1bFhYRkyyxtPo2axu2IdfzTiNKeSMLP7+ziULYvR8qGJMjP73Zfd5bBVqQ9zmMUBndgw4f9Kjja5MxA2Lpe6VFnAmBbVwETTE7r3BQGyA3ng/boOgigh7Omzc36yLWoZa6pfxoXmN0U8Oc7690=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776707274;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=fVE1QqhfUMfiQMv2NiZUXsvY4CKNsni8HJeHzW/ovGs=;
	b=AZgp62O9HbpREF89u0CBXFvbNWUQEyGypkF3My2jl+uawhZ8FadQkWZNOYAok8Ox
	SJvYcH+Exr5GuY8WK/scqJBbxD0+iBDt3RaZsfSQtWjv41jDgf24q/Nul/CftBrDet2
	7vUi8UThP8Eej74FaIvHXz3EHb4QDTqp5vm44Hzw=
Received: by mx.zoho.in with SMTPS id 1776707273402195.3788380498354;
	Mon, 20 Apr 2026 23:17:53 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: check NULL from erofs_rebuild_get_dentry()
Date: Mon, 20 Apr 2026 23:17:52 +0530
Message-ID: <20260420174752.50132-1-ch@vnsh.in>
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
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-3336-lists,linux-erofs=lfdr.de];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.994];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E69544321BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_rebuild_get_dentry() returns NULL when the input path
normalizes to nothing (".", "/", "//", or paths that collapse via
".."). The tar hardlink branch and the S3 import loop only check
IS_ERR() and then dereference the result.

Reject a hardlink target that resolves to root with -EISDIR, and
treat a root-normalized S3 key as the root inode itself.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only image generation from S3")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/remotes/s3.c | 5 ++++-
 lib/tar.c        | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index e552ed0..d386a32 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1129,7 +1129,10 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 			ret = PTR_ERR(d);
 			goto err_iter;
 		}
-		if (d->type == EROFS_FT_DIR) {
+		if (!d) {
+			inode = root;
+			inode->i_mode = S_IFDIR | 0755;
+		} else if (d->type == EROFS_FT_DIR) {
 			inode = d->inode;
 			inode->i_mode = S_IFDIR | 0755;
 		} else {
diff --git a/lib/tar.c b/lib/tar.c
index d2dc141..b08bd77 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1024,6 +1024,10 @@ out_eot:
 			ret = PTR_ERR(d2);
 			goto out;
 		}
+		if (!d2) {
+			ret = -EISDIR;
+			goto out;
+		}
 		if (d2->type == EROFS_FT_UNKNOWN) {
 			ret = -ENOENT;
 			goto out;
-- 
2.43.0


