Return-Path: <linux-erofs+bounces-3777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R5UlAe4dQmoH0gkAu9opvQ
	(envelope-from <linux-erofs+bounces-3777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 09:25:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311F6D6F98
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 09:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=ThkTRAFr;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3777-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3777-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpd930s1Nz2ySS;
	Mon, 29 Jun 2026 17:25:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782717927;
	cv=none; b=aVeefBa5Jc38Jba7j3etETHRE10vZ/ftbWBOynVPOGPzMb7hKwGjYC1qBwMReKjx4N9OGsxgtNOs7YFHRS7GPxJfbK8HZ/v4xvRz9mvT2ZTeaw0+6hMAwwOiT/5u9MwLNgN8RgBYOttixoQn6fnf+WNR4BLPe3K5jrS7FVVDVC5nLYbJZOlTsQnIAd/dSAhZm/iJDR2rJ1XVHAjmYNigGn6gd3n/Ic2b42FEqaTvRSVux/gjlNEwScmEWqhS6lA85PRc7q6Ygo4ILaRUNTb/dwEhmG7z6Zhp5JMNj0e/L0hU27jzVpp/XSbTYSCs0Yjara6w8PaPQnO+NE7sH646kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782717927; c=relaxed/relaxed;
	bh=qL2Nmfpw2bH8GvU5a1/TMjI57gz3fLSPQ2hJLmLyhKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvH97Dgr52K8wkzZyTN1GA0/hLiLMMjo6KpOQXaJRMpcT4HLT3/+17vTzqj25m8lS9pHbya0WZbYt6WjcN/jT2ndzDZw0GGRcGYpyPiVD41YFAZJZdaJ+9JbHa7/5+Gt2Or8cShibiNFnsKZj8niWN3soF+VkN6iaf9HbsMp/UAv/8uoMlUZex0ksTZIUfzPtKEdpqV9gLPajeI3eTaRNVux0q1X3q1fwdI7gDhd2So4x7Hy+G9uGuSkVz55jgAZmvw4uf7B4hkivg9uSPTILJSxt80U2FLV/yfvJU7MBFmDW3J2HLk3GFghO+ON+DkS8IwoPzFt/0ylif5vAN956w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ThkTRAFr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpd901K9hz2yFc
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 17:25:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782717912; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qL2Nmfpw2bH8GvU5a1/TMjI57gz3fLSPQ2hJLmLyhKM=;
	b=ThkTRAFrb1gv/sKit2adeiJYs67muIPep1ZPdebC4W4TX7mtaSySAyKRuTdTPqTXAxoVSu1E5VM1ij8ex04g/pn0CrBBZbD5ThARMKlFx4J1G0bNrWQCeIjpaolVvLc9Z5go2dfB+jIbJeq04LU2y0V3R6hwGT/j7Ot8kq/geB0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5p-XKO_1782717908;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5p-XKO_1782717908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 15:25:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Tristan <TristanInSec@gmail.com>
Subject: [PATCH] erofs-utils: dump: fix stack-overflow due to directory loops
Date: Mon, 29 Jun 2026 15:25:07 +0800
Message-ID: <20260629072507.2375923-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3777-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0311F6D6F98

This mirrors the solution in commit f3728a162d22 ("erofs-utils: dump:
fix stack-overflow due to directory loops").

Reported-by: Tristan <TristanInSec@gmail.com>
Fixes: 5a9ac8e057cf ("erofs-utils: dump: convert readdir to use erofs_iterate_dir()")
Closes: https://lore.kernel.org/r/CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com/6-dump-erofs-recursion.txt
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 6c7258a5db40..9eebcb8a3e3f 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -17,7 +17,13 @@
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
+struct erofsdump_dirstack {
+       erofs_nid_t dirs[PATH_MAX];
+       int top;
+};
+
 struct erofsdump_cfg {
+	struct erofsdump_dirstack dirstack;
 	unsigned int totalshow;
 	bool show_inode;
 	bool show_extent;
@@ -359,7 +365,6 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 		update_file_size_statistics(occupied_size, false);
 	}
 
-	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(vi.i_mode)) {
 		struct erofs_dir_context nctx = {
 			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
@@ -367,8 +372,18 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 			.dir = &vi,
 			.cb = erofsdump_dirent_iter,
 		};
-
-		return erofs_iterate_dir(&nctx, false);
+		int i, ret;
+
+		/* XXX: support the deeper cases later */
+		if (dumpcfg.dirstack.top >= ARRAY_SIZE(dumpcfg.dirstack.dirs))
+			return -ENAMETOOLONG;
+		for (i = 0; i < dumpcfg.dirstack.top; ++i)
+			if (vi.nid == dumpcfg.dirstack.dirs[i])
+				return -ELOOP;
+		dumpcfg.dirstack.dirs[dumpcfg.dirstack.top++] = nctx.pnid;
+		ret = erofs_iterate_dir(&nctx, false);
+		--dumpcfg.dirstack.top;
+		return ret;
 	}
 	return 0;
 }
-- 
2.43.5


