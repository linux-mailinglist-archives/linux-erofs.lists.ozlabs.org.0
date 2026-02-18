Return-Path: <linux-erofs+bounces-2331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iXVSD4VflWmbPwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB71537A9
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG6Qh4HP6z2yrn;
	Wed, 18 Feb 2026 17:43:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771396988;
	cv=none; b=jT50h+ppXAfIjf64aWXX7X6j7oQouB7KX6kJOIHDLKDf0znbimJaRwIKD6g1Bv9W7oFir5whanWlx+kDr/vPhE/nMTaDYx8eoWHaiKgjVduuPrqNFIdkk3pfzpTK3lercC9Wt9ZI71v1J8krFPUvlc0gfk9J7G5Gn/HRLudS3kXsi0FZ3lootM8eO+dDzSJ/OAkHuT+WlCCXoH/53hejJ4r2nPk7zL7sWwrFutf4UgxZp/usrgZQR8SFPC7niTeRqTH+7ufRXbss1XuYm81RdA5+c6aXeiqNSBGFPm5mvkrNeCpL8o4vXArlXo8haxeQgcAxm+hxb0DKg9ajRbe+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771396988; c=relaxed/relaxed;
	bh=kPqFc7VT4WeTeupOs5XWwsKh9ccAM01RIf7wn482VU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBOuNA0hmLNnhahrsP0NZfyZ2dEE/gAzhhQk11madlx36FpAqE00eL+4OW1whiMY43ya516/biHCyhlDyXgTJLaCoJaOdhv9VRUou3IzvlaEUYk5Yk8iWO3NqVoBQk0JxaorU/UuBlnA/A2APF/hJd9i7nKQ7QPFctlQcyt9pgahSve/PbAJFUXXEMNwM4noUu2fyRmyd20rA0i8TlMV3cKx5vrMRuEHE4EXl7Jv22MUlC50rs9JSKoiYvGrFNcwmsyj7N5L7gqGXuLl8t28F4pi1hiR7G7nZydce44iOQgdqKsk9TucYAthVNXu+BXc8QeVCenTbesNsz4gF7jdIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3tUYeSo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3tUYeSo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG6Qc64Tyz2xlk
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 17:43:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771396979; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kPqFc7VT4WeTeupOs5XWwsKh9ccAM01RIf7wn482VU0=;
	b=i3tUYeSogm5B0qkO//JlvVvbM1hUM11MJXyrKxvvjbMHrjRr2aY6bRE8Scl1GI5kuMrlSD08U4EBMEfBJF4aCBrnNcRuoPiITS6iH3YDi9CZvPOq5bbLJt5ipTqOmsoHA39xsG6hCEPP9dmGq7AS6Ok8L5jZRtqWgEw5sHjd0U8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRx9RU_1771396977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 14:42:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: mark 48bit and metabox as EXPERIMENTAL
Date: Wed, 18 Feb 2026 14:42:52 +0800
Message-ID: <20260218064252.3958518-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260218064252.3958518-1-hsiangkao@linux.alibaba.com>
References: <20260218064252.3958518-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2331-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 84BB71537A9
X-Rspamd-Action: no action

Keep in sync with the latest 7.0-rc kernel.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/super.c b/lib/super.c
index 40fc6554337b..088c9a01fc2f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -169,6 +169,12 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		sbi->devs = NULL;
 	}
 	sbi->sb_valid = !ret;
+	if (erofs_sb_has_48bit(sbi))
+		erofs_info("EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
+	if (erofs_sb_has_metabox(sbi)) {
+		erofs_info("EXPERIMENTAL metadata compression support in use. Use at your own risk!");
+		erofs_info("No in-memory cache for metadata compression: userspace parser for metabox remains slow.");
+	}
 	return ret;
 }
 
-- 
2.43.5


