Return-Path: <linux-erofs+bounces-3874-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SB2kK8nsUWooKgMAu9opvQ
	(envelope-from <linux-erofs+bounces-3874-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jul 2026 09:12:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FC740B1D
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jul 2026 09:12:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="cYMs/96q";
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="cYMs/96q";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3874-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3874-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy0J515DNz2yQL;
	Sat, 11 Jul 2026 17:12:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783753925;
	cv=none; b=ck5YSl7xdmJjWNcOMbM6TYbSo+n44QphoZjBjwjlgQtZP8YGBeXFmhQ5MryzmBosgKhL0LX0Kv52HlFzoJ+P2VwmjMUfixdaT5h8Hitbqsg1TuXcXUWL6+4LG36GllS1V5NFDWus1yWdkDvsX/sAk9yoJ53ysMAxGFywYtKzW/i80/+41VTASKJbt/dh7IkBeCxlPcG1dIVCpUg05NExF3tI0Ri+oQHri5vcNsN5QvxzK+JI0fIQYfV3v3mFTbWG0Mbw5tdhpmesM4mFXUA3G//knnjxNTHElbHcBuamlZXET4KLcDMpCo8o4M1O0OdhqPei0a4W1U0gpFBMTgXpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783753925; c=relaxed/relaxed;
	bh=OvublaibrtOMvG0eHQdKg2ge5aW5fO+X8CredtBGML4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=i+TMGbDvquXngBf+cJtFeQTsz6xXMC3GbgZN9XHJvZyyJxLeuorc57a3Jk0EiW5kj7HOD2L6hCNAw7Aq42vnQWxcDvfdJuRuEXuk1c4rRaP5jUCAFjs12SU1SidTC8nbfG+J66eMBc+wO+o9a3dKYkvE422rb/CAJ6Q7AsK1tTMyiqOBOQbL8kWgZRJjHIxkK94151qWSWJwXIDrlxu3cqPSHmxipS4akSNSq9ntySJtOnQuIUd4U86wwzhiYeDrzVes58FEFNJDsqEzJf4nH/gSOITSk1MW/LUJzlHrAUXeqn2OZcPjMgp2Tt7Sl0M1M04wJ/Tx6qLUNS03WBYyCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cYMs/96q; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cYMs/96q; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy0J34Xt5z2xq0
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jul 2026 17:12:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783753916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvublaibrtOMvG0eHQdKg2ge5aW5fO+X8CredtBGML4=;
	b=cYMs/96qI0IjwiBkd7lx8whpq5wZ6FOG9nyxSQYtLtVtIrA7srWiwfWnOm5CRQt1DPNi10
	gOUBpL22r+rYtag2m5JZwKoI1Iwe3gpBauvpRkdhdeL+9+8/He/zHg/pjziMx8hLglnumw
	IhZEuueVXI3kGZ0jLTAn6lE3RGUhpo0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783753916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvublaibrtOMvG0eHQdKg2ge5aW5fO+X8CredtBGML4=;
	b=cYMs/96qI0IjwiBkd7lx8whpq5wZ6FOG9nyxSQYtLtVtIrA7srWiwfWnOm5CRQt1DPNi10
	gOUBpL22r+rYtag2m5JZwKoI1Iwe3gpBauvpRkdhdeL+9+8/He/zHg/pjziMx8hLglnumw
	IhZEuueVXI3kGZ0jLTAn6lE3RGUhpo0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-qV8DHBUrMriZQRMkDxywZw-1; Sat,
 11 Jul 2026 03:11:52 -0400
X-MC-Unique: qV8DHBUrMriZQRMkDxywZw-1
X-Mimecast-MFC-AGG-ID: qV8DHBUrMriZQRMkDxywZw_1783753911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 207A1195605F;
	Sat, 11 Jul 2026 07:11:51 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.32.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D322F1800594;
	Sat, 11 Jul 2026 07:11:49 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	gscrivan@redhat.com
Subject: [PATCH v2] erofs: accept source file descriptor via fsconfig
Date: Sat, 11 Jul 2026 09:10:54 +0200
Message-ID: <20260711071137.4130824-1-gscrivan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: dJ4ALyyKsAb98zdx_5xPQBFd-CWL83gDHK-RQt2JLOw_1783753911
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3874-lists,linux-erofs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D7FC740B1D

Add fsparam_fd("source") so that userspace can pass an already-opened
file descriptor instead of a path string.  When the fd is provided via
fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.

This is useful for mount namespaces where the backing file may not be
reachable by path, and for tools that already hold an fd to the image
(e.g. composefs reusing an erofs mount's backing file).

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
I've moved this out of the previous series, as the second patch is on
hold for a design discussion.  Since the two patches were independent,
they do not need to be held together.

v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/#r

 fs/erofs/super.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..3040d4cf9b85 100644
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
 
@@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source_fd:
+		if (sbi->dif0.file)
+			return -EINVAL;
+		sbi->dif0.file = get_file(param->file);
+		break;
 	}
 	return 0;
 }
@@ -752,14 +759,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+	struct file *file = sbi->dif0.file;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
-		struct file *file;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {
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
@@ -767,12 +778,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+	    !file->f_mapping->a_ops->read_folio) {
+		errorfc(fc, "source is unsupported");
+		return -EINVAL;
+	}
+	return get_tree_nodev(fc, erofs_fc_fill_super);
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
-- 
2.55.0


