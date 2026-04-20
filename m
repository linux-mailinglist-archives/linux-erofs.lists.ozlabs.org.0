Return-Path: <linux-erofs+bounces-3340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG2LI6l75mkHxAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 21:16:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9D43336C
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 21:16:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzwGC4RYVz2yqT;
	Tue, 21 Apr 2026 05:16:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776712611;
	cv=pass; b=FlqRbypSJeSoe2ktz3AnSl2UYsdWP3e4Zr/NJvlgtEBCnBCwyiIqEY59VnK6aWQnT8xVMZL6rE6v6goOpQim/3Q6FHJMR5uEKadXUo7/ZlPIBAoRnnmKs45ROr7dky3rjjUGaSbxJr0l2wxRPuCndD4w8QUfSfS0+AsD1iZWz1PVlm9SegChk2Ev5N/K8OMnLCELHE95BZXogLD6HU/Ju3gt33IEObBDYVDncCidwOdOxVOCUpewokDd5UzmJ8OOYxFA+YbdAJW7aadFU++o3VvzKNygMjzydSH1+tJe+1aINLqOxwyujhcbWCgKV6fwrwXucylyGgOjKVPCevEMhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776712611; c=relaxed/relaxed;
	bh=wHPhsJ56NziDuRq0Cg7GMkLz2qfAutJ9HvJRIZaOIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU8hPRVrTtkqhlAsZWOmRtUI6OPlmiav/x8pW686MOYkCqnqkwgMEc1V0/yIBC4UaQLaFwmAbCmYrXnnKOvu82FkVZQnbIt2poHvsFm/VIA/jB+s6iEDZfYY8ON4SonBHfKemxc0RsKol7Map1PM8e30m2evZd8XfFx/WXh3wXDP5u4L95k5Or6FIa6bNNTARiFE+PfwHzmsX6qzpktZZOtg6YXsxGvaKh2qG5jwZv67R2jyZi1qMKYALS49lKHRwDSSsFaRy0w0UiUm/ZINb63muIm1pPns8/qeVKxbb4M3zkqozhH1yUYeVu9JdUOviGZ399oiISA790MkCcyFYw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=agDrJjnr; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=agDrJjnr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzwGB5Mhhz2ypw
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 05:16:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776712606; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=LfMFaeBDkQxJAuN7naxtd6pM+4LyA3l7gvnOMKVzRmXBOscWgBvD+JC4N8W1NYPmRvnxE0fhvb5vLqnnUWhQHx8Tm0wXHKdo7cn9EmRO+9HNsfZNYyiH9yvA0Kg7y9TSQAaaLhrueCR6WRuC/pv8lps0LZW4kT6AsZcfQi5Uv9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1776712606; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wHPhsJ56NziDuRq0Cg7GMkLz2qfAutJ9HvJRIZaOIgM=; 
	b=MqnNOa/1JaWrXxpALj5K1GDTitLMcDZIPjXHyQ7eW21UfeASAptoI8T2s6LFDE+YjJMhA4dKDD5FFspTzgHtOmMfa0A/yj/10ksjBHOb+cUGDi7U5RQd1jUIPJzo1quWSgz6G36eKL9xWEYoMlIsF+RsORnIK+PtP+f8XX5CTV0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776712606;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wHPhsJ56NziDuRq0Cg7GMkLz2qfAutJ9HvJRIZaOIgM=;
	b=agDrJjnr00oRrlvTFM9691vXjWLvxNsoO77tcZE1A66toWJVBJI9mc16VBBN7fC9
	msEf5OVbbCAgU4yom+USBGlCHE4VryIkOk37n2UQbjgZNOiHE4PH6Dz88gqeeMKvieb
	S6wB4OoD2zVpbSnBJpNF/0FmPlDvikVbb4qnAg0s=
Received: by mx.zoho.in with SMTPS id 1776712604445807.7006698145101;
	Tue, 21 Apr 2026 00:46:44 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: restore path on erofs_rebuild_get_dentry() errors
Date: Tue, 21 Apr 2026 00:46:43 +0530
Message-ID: <20260420191643.73204-1-ch@vnsh.in>
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3340-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[vnsh.in:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 97E9D43336C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_rebuild_get_dentry() temporarily writes '\0' over each '/'
in the caller's path to NUL-terminate segments, but two error
returns skip the restoration and leave the path truncated.

Restore the slash before those returns.

Fixes: 73e321a0fb3b ("erofs-utils: lib: consolidate erofs_rebuild_get_dentry()")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/rebuild.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 74bbeda..14013cf 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -123,8 +123,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 			d = erofs_d_lookup(pwd, s);
 			if (d) {
 				if (d->type != EROFS_FT_DIR) {
-					if (slash)
+					if (slash) {
+						*slash = '/';
 						return ERR_PTR(-ENOTDIR);
+					}
 				} else if (to_head) {
 					list_del(&d->d_child);
 					list_add(&d->d_child, &pwd->i_subdirs);
@@ -132,8 +134,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 				pwd = d->inode;
 			} else if (slash) {
 				d = erofs_rebuild_mkdir(pwd, s);
-				if (IS_ERR(d))
+				if (IS_ERR(d)) {
+					*slash = '/';
 					return d;
+				}
 			} else {
 				d = erofs_d_alloc(pwd, s);
 				if (IS_ERR(d))
-- 
2.43.0


