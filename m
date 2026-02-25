Return-Path: <linux-erofs+bounces-2412-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICW6MsMEn2mZYgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2412-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 15:18:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BD1989AE
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 15:18:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLcC34SV6z3f4b;
	Thu, 26 Feb 2026 01:18:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772029119;
	cv=none; b=ouX/jCd+cqfabN9y4INi/nVlj/xVnyFv00TmvzO+1fRjtKS9uqC/82Q+bxnHNM0XZfJQ1D0oEMM4bFs4C39Tz4HwSAH3n6NwOH3B/XH4ujGnxJO7UWhmTWyyvGqcTaMWBZizlY0KqXsuDp/Ydw3Tuu5GITrNF9FyLEOMiXnZHmGIEirc6Qx77z/Sc2uAS7xR1P0JaeHMrl2zFAyJGVMF7aM2BHb97ZQpXDrL1WIQcNRqOz+cA+ZRJFS1wBDvEmDkPzWMc08gTckbH9xiv2JGSuZ88wZAfQgXqjYEUUUj6ynk/kmtlESyHw9extEPV2u+mUC90bzXLs/fUjFWxUTqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772029119; c=relaxed/relaxed;
	bh=L95wrIKVa6v1TwctFgaKbTwBmW2hwLtw32z+bqB7Qik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlajL1JalKTDe/LtPdg2m67regeenVJn4TuL/dpJJZMvqmkdNH8lE+E4gVvzU+qlxXMBHMnsHPssUNnZ/BwQjp/YeXh4rJj8KVIdAzg51VJkXKue+sSxo10vBPs+o5s6cM1lrsbg9mSHHz71hdoNUqWap3+wp6Zy56/L2D7ijTzAXX90ZMvzfpAnbGmw7dA0pI7RtpM+OyJnaiLBs2lHX58CSJxZPpfKWE0C9h6sC/t6HdvaywcaIKrLChAx6kqtS6hpwL85p2KcELE6pSGHMG2PpzHQLONwOWPJ7BqDmMeOrHFon1Reo8Kr8217zVWzPPop5RfJ7zUCutGP6KlyLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FO4yrXVG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FO4yrXVG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLcC02gNyz3f3G
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 01:18:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772029109; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L95wrIKVa6v1TwctFgaKbTwBmW2hwLtw32z+bqB7Qik=;
	b=FO4yrXVG53qf3enAzmiVoIY84k8ClmkplmyW2MuxBLh1DMNp4yUwXUK0rGBEeIll2Foob2fjaBhlNgSqZB6j9piQdVCVctN5nL8do8m9u5/wxYp7RV2gI38BiTnwOTZFyXTxXYHUxGymJne2AnYo03Mj41YGYP2UesDucDcqMMs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzmnPPO_1772029102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 22:18:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: do not enable lz4_0padding for plain images
Date: Wed, 25 Feb 2026 22:18:20 +0800
Message-ID: <20260225141821.668836-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2412-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: 8D7BD1989AE
X-Rspamd-Action: no action

This is a new regression introduced in erofs-utils 1.9.

Fixes: 16a77fed8511 ("erofs-utils: lib: unexport z_erofs_compress_{init,exit}")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index aaf5358fc735..b84d1b46f4dc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1678,7 +1678,7 @@ static void erofs_mkfs_default_options(struct erofs_importer_params *params)
 	mkfs_blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
 	params->pclusterblks_max = 1U;
 	params->pclusterblks_def = 1U;
-	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	g_sbi.feature_incompat = 0;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 }
-- 
2.43.5


