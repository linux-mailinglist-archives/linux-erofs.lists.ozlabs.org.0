Return-Path: <linux-erofs+bounces-2786-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK8eCW4VuWmOpgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2786-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:48:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 348822A5EB2
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:48:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZlx6312yz2yjV;
	Tue, 17 Mar 2026 19:48:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773737322;
	cv=none; b=CY5zykB7PwDb7ySJv6cNwOSyGsA3xET1V7zU2r8XsOdRfbo/BXJWNYA0+w/0KuAKEYovQpIv2nei+5PQyH7f/z5AH/LFhJ3V5qj+C93vaPzcSM538WGstENb5EBSd3lM9xC682ri+2oDFb+ZXi1aQMz6J0xD6y3Cg1Jy36h5r7WiBNR1W358qy+RERBr6HpBUTz59wRJjHjWN4Z9dgHd3+tDMesCay+0CyJ3Z1tCo8dLedZ2lqGstkWv+4yX+iayLnXpnDpGROCZfaAEmED1I94vXkieP8yOM10TSAtCElovi1w16GB10jCMLQX7G8HdYxvvzJGyq3YnBocJ64P0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773737322; c=relaxed/relaxed;
	bh=dhnUtezbXuWfRmc2N2oQOE9hFPOsHiWoXNz6C98Pu3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHUCfgMdBMvcdDBOKjG9mTvJolF8ZUeuALX4Y0CeBW/l7RqiDymMZSGAeJRCrFWxKcznjkwF8i4Ubtrsvj8NB1ratOTKfUvkXwBiWrnlpFWrEYhZQasiis3/D+ROJxF/xi+C/iRDKwqy55ATxNnoEuCwO20bolYXx9spqgkxyVo5hiZTDX4wMmHrYtip5EIfaPQWo25nwzMmYS4xWRzuOJoRPD7FKNTYbzwRHSKfwof1/KRmCySyvF/jzjjITi875hRofSaWSzyNYggsLNWA2l3obWyLFlknDJ7SnoocnWejxiEWrMkO1xb5ZHq1deKqUvS5AQX32Slk0avyRWwq5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HeuYen/Q; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HeuYen/Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZlx41dMrz2yjN
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 19:48:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773737314; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dhnUtezbXuWfRmc2N2oQOE9hFPOsHiWoXNz6C98Pu3I=;
	b=HeuYen/QselecWM/OQElhHhdB6aaSe21j7vwpRAAp8l/FAZ6MFJmkB6rOsJHQO2/XHJajNQ3hPErpZH3BHW547AKxGwXfYTSA5KCUfV9J9oAVyj+T5+Y7uUaRhdwcgbrciWrf0Xrw/cdtRxopEmkDJ4SvFk+d+vzNbQDtEfiLm4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.APPFy_1773737312;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.APPFy_1773737312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 16:48:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: avoid infinite loops due to corrupted subpage compact indexes
Date: Tue, 17 Mar 2026 16:48:27 +0800
Message-ID: <20260317084827.3228413-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260317084827.3228413-1-hsiangkao@linux.alibaba.com>
References: <20260317084827.3228413-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2786-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 348822A5EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Source kernel commit: e13d315ae077bb7c3c6027cc292401bc0f4ec683

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 067e3ddd7cda..4a6507726ba8 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -60,10 +60,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 	}
 	return 0;
@@ -246,14 +242,29 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
-	switch (m->inode->datalayout) {
-	case EROFS_INODE_COMPRESSED_FULL:
-		return z_erofs_load_full_lcluster(m, lcn);
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
-	default:
-		return -EINVAL;
+	struct erofs_inode *vi = m->inode;
+	int err;
+
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
+		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	} else {
+		DBG_BUGON(vi->datalayout != EROFS_INODE_COMPRESSED_FULL);
+		err = z_erofs_load_full_lcluster(m, lcn);
 	}
+	if (err)
+		return err;
+
+	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+		erofs_err("unknown type %u @ lcn %u of nid %llu",
+			  m->type, lcn, m->inode->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	} else if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
+		   m->clusterofs >= (1 << vi->z_lclusterbits)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	return 0;
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
-- 
2.43.5


