Return-Path: <linux-erofs+bounces-3790-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4azJog1Q2rvUwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3790-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 05:18:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D54816E002A
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 05:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=rpPex5BS;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3790-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3790-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq7db44F3z2yY1;
	Tue, 30 Jun 2026 13:18:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782789507;
	cv=none; b=mhS2u98KI0C0k7M+8auxUP82ky1/7G3/dm8yzd6QA3bXYlMHri5k5CqyLxjEd1GlWn6BoKs6xa0NP+wbkXqeKwA0SM6ZdKQlfkeS3pqH4wst0yjUo4FiLV8VKyHq2fHdjMRZhhq0srjlKdePsuPBoMr2MTr+gZuZavJxUBvcsSPIwnWdLHSrdBhnPVNZE9qlRjS6txR4eKl6pSsfk8MROKqbsOqfQ48kH/UQz6zgd3S8v5KRSswVZzd7ihBVez+bYn1W9Ratoh1pRC2ef69OJrZN3jhY1SXckS4ZFSGdxuiJXFr72TEY6OY91LVSSXKClmQCBOuxxcRYQCNXR4/dwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782789507; c=relaxed/relaxed;
	bh=UIFfyklStT2rTwa1NawWQDEdc3GahqXjs8gDA8bQPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlaMUPvBk3QQyi6pOZWDz/YyV8b50fdTBPppDWqxU0/5u3v9T9xX8tefO7vPQf4kxuz6YDadZSlOu/8IF81CizxCx5zwStctL/n71QsNWBtpoDE1SWFhqCSk1h8kxyAfcAyBYeEb/0L5jSBUOLZ5nM8CH6qOi9iZ9vhn3+geSynrrJ0wRc6u5uzwBsY7yJ8tWMet4kkyhjzAhaQBW2oFK6yBQgWp5kBAkyNhbC96wfHmUuQ03E76ZXZ6vJeFyiugwWzY1OBaeJXQROXpnSxyajJXC1Ixxn+0XvpsX5+TDpSRoPQRhAVVbhI0AE1hEdUI2WGIxvVmFG3SjchrK74dWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rpPex5BS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq7dY0WR8z2yRM
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 13:18:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782789499; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UIFfyklStT2rTwa1NawWQDEdc3GahqXjs8gDA8bQPsk=;
	b=rpPex5BSgt4GlhKW6Ztynxg+vMR1OKHoyLqr8rZxvjJyt251yaxXMIv5/GBdIkmf7Kij/QKW7aB1/T5qjOSUPzeEneBhBgIggyNsken/kuxdoL+yQEQEc+xq5mWqEqZnaUtk6R25c8Me5HG+1HMsEZh2lQEHCgOMXq+7iMN/JL0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5zSann_1782789494;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zSann_1782789494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 11:18:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: use more informative s_id for file-backed mounts
Date: Tue, 30 Jun 2026 11:18:13 +0800
Message-ID: <20260630031813.3992408-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3790-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D54816E002A

For file-backed mounts, set sb->s_id to the MAJOR:MINOR of sb->s_dev
(which fstat() will return) so that kernel messages and the sysfs
name are more informative rather than just "erofs: (device erofs): ...".

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..c5881bb8d52b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -595,17 +595,6 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
-static void erofs_set_sysfs_name(struct super_block *sb)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-
-	if (erofs_is_fileio_mode(sbi))
-		super_set_sysfs_name_generic(sb, "%s",
-					     bdi_dev_name(sb->s_bdi));
-	else
-		super_set_sysfs_name_id(sb);
-}
-
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -657,12 +646,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
+
+		snprintf(sb->s_id, sizeof(sb->s_id),
+			 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
 	} else {
 		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
 			errorfc(fc, "failed to set initial blksize");
 			return -EINVAL;
 		}
-
 		sbi->dif0.dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
 				&sbi->dif0.dax_part_off, NULL, NULL);
 	}
@@ -740,7 +731,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	erofs_set_sysfs_name(sb);
+	super_set_sysfs_name_id(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
 		return err;
-- 
2.43.5


