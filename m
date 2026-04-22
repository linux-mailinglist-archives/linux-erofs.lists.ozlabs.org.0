Return-Path: <linux-erofs+bounces-3355-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TM8dHFx76GmsKwIAu9opvQ
	(envelope-from <linux-erofs+bounces-3355-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 09:40:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6D443094
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 09:40:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0rjP0Cscz2yZN;
	Wed, 22 Apr 2026 17:40:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776843608;
	cv=none; b=j7/oxjaaMLna/8vUuovWf9kDG568z9i8kdx0ESOnams49J/mYY6xp3YcTGK4dzUMTgeM5qS6ryksp3Gt2yNNHRXRWgwuvzOvfyZXe0Uj++rq8Xp3BCyBtya6s+KuUpTvzK3KfRBDtDJb+qEe2amz/ptMEzZRjRAkn4Id9zAePz1ltWIETvHKS1+XuDl6dZCu8/BD9nLldOFZbIHLo9yWucu5vvgLMNHjuqjhz0v4WXG+unOUe8RawFjBZ5p0P6K1oDed1JN5fmrJINcXmePXiDAHjkv6lz7WGAAROaCDk3lrzNjRt/BjjlJb8R65CdpGv1bt455x0nDm2YbGGfEHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776843608; c=relaxed/relaxed;
	bh=buqEBC1wsKDmXd/ln4USDOHtTvzRCsLy/023DbKK3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXurvCvlEtPx3R6JwI79ISuSn0I42ZUYDvZOyExLMR5G/06I/7zjUR6P/ew7C/qrSG9D0m4gNdVNX5gqIJfZ5UDOPwIijsemD+5RKBbt7u3LYfetga3r1R49CGZI2sQ8xtQxvVeJ4kb7ul2qNMtI4LJI6asMncvZ3O2z+hSdgsugzeHJgbBKaleb9anJt+IwqAU/FQkMqULxGdaSMw+XLbF2BosQKNDMsCfC1eGN0oBgmsdJ0kM6r8epnP24qNZaGBap28miTgvP4Fw85gPWc5J9XzNkFxvJnHDtqfK14zQf4QJrveUC3mkVfSpr3w6UJrCG2ZYDRu1exiejv3cXyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=aL2YNfP9; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=aL2YNfP9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0rjL32GJz2xSN
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Apr 2026 17:40:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1776843607; x=1808379607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=buqEBC1wsKDmXd/ln4USDOHtTvzRCsLy/023DbKK3Bc=;
  b=aL2YNfP9tUp2DLNq/2htHZ+7nHQYFig7+w7Ahk9WH6Q+HT8ib1nnL5Yu
   E7DssSzA3At2IWw18LqqTc3BhqWmbeTRa8vpxj+yaROigLfmF0MTDeOm3
   o5atcLCVRkdw9M0UhO8M3lWZeuRIAMilTFtD8KoO4Cu+JoMRo+DclLsVU
   ULrTgBewveEE0LER45p3A44GV7aL99KvVsKZDyHOhuuJYd5nieuR8eN4c
   VuAD3tN5IaG5Okwd+O0SIJVrDm9XFxjqVqPANbUimxTnTfJHCOnRDdJYS
   uCV6EXnqXtg6dwfZQR1MzMgEYrvCKNA4Vwyjewknf6GNrNc/gnMK0yOOY
   Q==;
X-CSE-ConnectionGUID: kOMNZp9+SCCHkgmE2Me5jg==
X-CSE-MsgGUID: fVjk5khNTC6SASF83drRew==
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 16:39:52 +0900
X-CSE-ConnectionGUID: 3uAgVVWjRGWzDX4Stti1aw==
X-CSE-MsgGUID: pWI8KX1FTyKASEQHzQlgYQ==
X-IronPort-AV: E=Sophos;i="6.23,192,1770562800"; 
   d="scan'208";a="62304056"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 22 Apr 2026 16:39:51 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v2] erofs-utils: mkfs: support set fingerprint for tar sort=none mode
Date: Wed, 22 Apr 2026 15:37:06 +0800
Message-ID: <20260422073705.1828301-2-Yuezhang.Mo@sony.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_DKIM_ALLOW(-0.20)[sony.com:s=s1jp];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3355-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yuezhang.Mo@sony.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.907];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,sony.com:email,sony.com:dkim,sony.com:mid]
X-Rspamd-Queue-Id: 87B6D443094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If "--tar=f" and "--sort=none" are enabled, ->datasource will be set
to "EROFS_INODE_DATA_SOURCE_NONE".

In erofs_mkfs_begin_nondirectory(), erofs_set_inode_fingerprint() is
only be called if ->datasource is EROFS_INODE_DATA_SOURCE_LOCALPATH
or EROFS_INODE_DATA_SOURCE_DISKBUF.

EROFS_INODE_DATA_SOURCE_NONE means that metadata is done and mkfs
dump will change nothing, so use erofs_setxattr() to set fingerprint
at settings ->datasource to EROFS_INODE_DATA_SOURCE_NONE.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---

v1: https://lore.kernel.org/all/20260410060539.417457-2-Yuezhang.Mo@sony.com/

 lib/tar.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 87a6a61..6171272 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -21,6 +21,7 @@
 #include "liberofs_cache.h"
 #include "liberofs_gzran.h"
 #include "liberofs_rebuild.h"
+#include "sha256.h"
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
@@ -631,10 +632,13 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 					    struct erofs_tarfile *tar)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
+	u8 ishare_xattr_prefix_id = sbi->ishare_xattr_prefix_id;
 	erofs_blk_t nblocks;
 	erofs_off_t pos;
 	void *buf;
 	int ret;
+	struct sha256_state md;
+	u8 out[32 + sizeof("sha256:") - 1];
 
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	nblocks = DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits);
@@ -643,6 +647,9 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 	if (ret)
 		return ret;
 
+	if (ishare_xattr_prefix_id)
+		erofs_sha256_init(&md);
+
 	for (pos = 0; pos < inode->i_size; pos += ret) {
 		ret = erofs_iostream_read(&tar->ios, &buf, inode->i_size - pos);
 		if (ret <= 0) {
@@ -656,11 +663,23 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 			ret = -EIO;
 			break;
 		}
+		if (ishare_xattr_prefix_id)
+			erofs_sha256_process(&md, buf, ret);
 	}
 	inode->idata_size = 0;
 	inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
 	if (ret < 0)
 		return ret;
+
+	if (ishare_xattr_prefix_id) {
+		erofs_sha256_done(&md, out + sizeof("sha256:") - 1);
+		memcpy(out, "sha256:", sizeof("sha256:") - 1);
+		ret = erofs_setxattr(inode, ishare_xattr_prefix_id, "",
+				     out, sizeof(out));
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


