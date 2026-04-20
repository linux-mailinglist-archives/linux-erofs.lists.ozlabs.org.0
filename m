Return-Path: <linux-erofs+bounces-3337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPdjNodq5mmBwAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 20:03:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6EF4326EC
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 20:03:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fztdt4vKBz2yqT;
	Tue, 21 Apr 2026 04:03:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776708226;
	cv=pass; b=KYwtsl3RYyDy+po6NT6PiUUbXt5lzJNtsKGrIK4XQ6yaTzRO9cr/gU22kCzaMluheli9UtDksmcdWedy7fQUx49XQyXx/oSH3JezxzSr1lLfeeyV1DIRgTW5Che5l0/2EtIidJId6DjFkCl1ki1Ab9+aGyOIUKYJou97Ujjwosn5cdOdAYXO7JG0wzcS3600dFG5KzY7+RLA5hx7iEKe6j9hamspp/dW7ELmdM0JlbzwoggdJ8W7VY8Vbc2vq4fXDdtDBoXBLzgwoQ9Uxndl+0jRGDBB1IcEE8lRZylwS1+oRdAlAV/3r1Q3HqzpvNTjkk1X/XSi2vdVHmz/xZZM8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776708226; c=relaxed/relaxed;
	bh=SgUOfbZnXin0f6jp93S3AAxtyfERAhGLbYH8MnfkoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0d23R3BYpMc9hgxbSgAWficifhgGB9ae/xY9bAXvFHK54Nw4OJI+iueK/CRl/gRfPauBzP4oFAZG3pwwaPDT/pyTLxlmIy3aZR1eZXz6i7u4UzvvhalmElqhPkAKzuvwwxQXNbtD1BZSExAVAQRMMBHFrU0oSWLiYwbO/hujfO+cv1msY4PDzT46uLtjVjgiIvcidQXnFMutb0HlugocpSLqseaelUroRRNp+xmsHWMXM6twmM+7w0GQWOdlqaxlLfw2iqOdwJXD+o2QjbzuT7PVODD5HSV8MIYAKdbyOxKULdEyKAI2b+JZXXdXvTmPYqGsnNrSL6XWeI3xyJG1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=W4qcgcxV; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=W4qcgcxV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fztds3GYtz2xll
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 04:03:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776708219; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=KYXFE8WCtu3weJWrUq20ENkbEM9/dv/l5oyCnkCnQqhwvSDEB9ae/0y61AVyZXVxfabrfo4AzamuOQil5gZd9EojDECh6rNUHnouklCuNvv4+ZcVD7h7ifxPbyR9DzPV6Rtd0VfXOl/Pr6i+QJu64FWr1EFW5JUYSQgfodtH7Is=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1776708219; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SgUOfbZnXin0f6jp93S3AAxtyfERAhGLbYH8MnfkoeU=; 
	b=Thoz7mOBHH29+VMM01UhvfWdYh/yZFjvtL46jOpTKsD0ruTJyQnclhP13h/5KdA4gwV7mcEsBmRKw9iecb8l6a8jfwBqlXL25fMWl/DjG0XPJSAQsuoeEIDJzWK6RWpeAEPmxSzRQ3/lKQE6I5sh6Su6HepWOAUuGHUtOH9wt7E=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776708219;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SgUOfbZnXin0f6jp93S3AAxtyfERAhGLbYH8MnfkoeU=;
	b=W4qcgcxVxtv8QtKrU/8fvVa/n0+299gNsTe8YvmLW4EPcZv8rk1t1QPxabCyBH2D
	8HzUWGBMFDhnki9BSNAvc8SRbZ4IgrzqcvRDmrqzkKOhaSxI4mif0tjq1fmG18NSb3v
	zhFOYQez1slTr520JKVow6S/bM8J7X/rH6VJDkrI=
Received: by mx.zoho.in with SMTPS id 1776708216637118.35414160130381;
	Mon, 20 Apr 2026 23:33:36 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: fix dropped inode buffer write errors
Date: Mon, 20 Apr 2026 23:32:56 +0530
Message-ID: <20260420180335.56064-1-ch@vnsh.in>
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
	TAGGED_FROM(0.00)[bounces-3337-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:email,vnsh.in:dkim,vnsh.in:mid]
X-Rspamd-Queue-Id: 6C6EF4326EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_mkfs_handle_nondirectory() discards the return values of
erofs_prepare_inode_buffer() and erofs_write_tail_end() and always
returns 0, so ENOSPC, ENOMEM, and tail-write I/O errors silently
produce a corrupt image.

Return those errors to the caller. Fix the same dropped returns in
erofs_mkfs_jobfn() and erofs_mkfs_build_special_from_fd().

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 95fd93b..b3e5f62 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1574,9 +1574,10 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 	}
 	if (ret)
 		return ret;
-	erofs_prepare_inode_buffer(btctx->im, inode);
-	erofs_write_tail_end(btctx->im, inode);
-	return 0;
+	ret = erofs_prepare_inode_buffer(btctx->im, inode);
+	if (ret)
+		return ret;
+	return erofs_write_tail_end(btctx->im, inode);
 }
 
 static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
@@ -1650,7 +1651,9 @@ static int erofs_mkfs_jobfn(const struct erofs_mkfs_btctx *ctx,
 		ret = erofs_write_dir_file(ctx->im, inode);
 		if (ret)
 			return ret;
-		erofs_write_tail_end(ctx->im, inode);
+		ret = erofs_write_tail_end(ctx->im, inode);
+		if (ret)
+			return ret;
 		inode->bh->op = &erofs_write_inode_bhops;
 		erofs_iput(inode);
 		return 0;
@@ -2406,8 +2409,12 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 	if (ret)
 		return ERR_PTR(ret);
 out:
-	erofs_prepare_inode_buffer(im, inode);
-	erofs_write_tail_end(im, inode);
+	ret = erofs_prepare_inode_buffer(im, inode);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = erofs_write_tail_end(im, inode);
+	if (ret)
+		return ERR_PTR(ret);
 	return inode;
 }
 
-- 
2.43.0


