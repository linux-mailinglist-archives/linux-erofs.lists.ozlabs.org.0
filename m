Return-Path: <linux-erofs+bounces-3860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EZmDE8oZTmr5DAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF443723C80
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OvnoOb8E;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="d/6JW5z6";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3860-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3860-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwCcR3rbBz2xll;
	Wed, 08 Jul 2026 19:35:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783503303;
	cv=none; b=VQcrE7yVQZ6HTchi86eTwbsgwzlFR2kNMwdmoXkYNjjpwWK2basLPP+r1YCK5MoYvA77pYW83vE5xFKV0n52J+MYNMo2Y+CLJ0rngIRJNzxhXlXSn5FhfceZ2Q3IfHThg0DESAPZq96+AbMn/sjOO1HEkd1l44xobZVKL1V7iCzK78PQ2R1bkDEamiAcFLVKjVUnkB6lkaXr9p61UTHdpOCNxVUP9zp7Ky39HfJvEiChJ/84LIehLWJcMO7W/+uGWSewKXpUF+uWv3BWOb9leiBjDG59hNIpyaSRpcg8weo1B95MHn/OkIByJJv/WiBlYWsw19DgKcCVthAxkX0fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783503303; c=relaxed/relaxed;
	bh=W8ArRWsRiz74um4VX+cF6VY0Yq/5FxxLKqrkr4Kch6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KESXSdbeF5FIzecshhjbK0IjFDjxu5saz0abURo0iOhn+JJu/8D9ohNrKFKE7kZ1nOYJ6+rCezyWsxmtTCrpxV/TIl6+NFpj+NbMzsOJ4Cvng9lqY9dEcmsur805eHhZqoKTAY+UI2KUjFTqi6wGxgQNsFL1jHj0Ai2XutN267ctggbvILRaOk9xknTJq1WDj2tJVJPTvO4Q/kHYKw6qgoQuvnIwR/ePfnqNthp0IHO5sA7YaBmkpusulbaozHpsR3UuaAoN5pdBO8Inrjs3KYyKy5YCPRzdKv7r4yx7JlUbzCsBiOwwg9p+M/EIRgtKHV6gD9eeBBTiSjKoKhWDRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvnoOb8E; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/6JW5z6; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwCcP3PN7z2xpn
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 19:34:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8ArRWsRiz74um4VX+cF6VY0Yq/5FxxLKqrkr4Kch6M=;
	b=OvnoOb8EjwKIJH0x/fX/itv/ZfyqFVW6URThLd6dxrua1NMpHzKhAJAHccqUgMiR87Pzxb
	B/9YRJeT8k+FYVcf6gnKDL0Cwm7tEkOhBuvHG/mMGg7zNYEcZxEvOCUZTT6n7yJEPgjJSh
	MQzVMOhsmpJBfTsFRixUn/+Xruyy314=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8ArRWsRiz74um4VX+cF6VY0Yq/5FxxLKqrkr4Kch6M=;
	b=d/6JW5z6JMC2ye2smLvHSZdtVBNVdTWzKb8ib9aivJvoZweApZbnb8OEG9THi33ZqrCyMv
	A3V7Paek8UkSg9P/Jg+/R1OYBkl0djRkkjUuaFtV6aJritmrNN4BMIGhiTmIytipiHYyCs
	wLVsR3wQ5ESBR0PqSlLX/NXLa6GG0kY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-tT1Y3egvOZWD-oh3xDqXmw-1; Wed,
 08 Jul 2026 05:34:53 -0400
X-MC-Unique: tT1Y3egvOZWD-oh3xDqXmw-1
X-Mimecast-MFC-AGG-ID: tT1Y3egvOZWD-oh3xDqXmw_1783503292
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AEB51955F7C;
	Wed,  8 Jul 2026 09:34:52 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0352F1955F43;
	Wed,  8 Jul 2026 09:34:50 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 1/2] erofs: accept source file descriptor via fsconfig
Date: Wed,  8 Jul 2026 11:34:26 +0200
Message-ID: <20260708093446.3370200-2-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-1-gscrivan@redhat.com>
References: <20260708093446.3370200-1-gscrivan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: C7Ah1GjI43yG_kR77cdL0YDub08meKTnir1AF4DcuN0_1783503292
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3860-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF443723C80

Add fsparam_fd("source") so that userspace can pass an already-opened
file descriptor instead of a path string.  When the fd is provided via
fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.

This is useful for mount namespaces where the backing file may not be
reachable by path, and for tools that already hold an fd to the image
(e.g. composefs reusing an erofs mount's backing file).

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..8ad1689f74b2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source_fd,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
 	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_fd("source",		Opt_source_fd),
 	{}
 };
 
@@ -524,6 +526,15 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source_fd:
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
+			errorfc(fc, "source fd option not supported");
+			return -EINVAL;
+		}
+		if (sbi->dif0.file)
+			fput(sbi->dif0.file);
+		sbi->dif0.file = get_file(param->file);
+		break;
 	}
 	return 0;
 }
@@ -752,14 +763,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !sbi->dif0.file) {
 		struct file *file;
+		int ret;
+
+		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+				GET_TREE_BDEV_QUIET_LOOKUP : 0);
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
+		    ret != -ENOTBLK)
+			return ret;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -767,12 +782,11 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
+	    sbi->dif0.file->f_mapping->a_ops->read_folio)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	return -EINVAL;
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
-- 
2.55.0


