Return-Path: <linux-erofs+bounces-3783-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LPgKN30vQ2rHTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3783-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB76DFE6F
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=p6dyccXt;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3783-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3783-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73q0MTzz2yZ8;
	Tue, 30 Jun 2026 12:52:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787958;
	cv=none; b=g4vzT7SMtgC+MUiBkSTTrxkNnc3CQyI6f4PDxkI7hZba0vSo2TfM1x+2pWR8NDsTugGvC0/Qa1k7bhNjSE6Xobo+pq8IbGeZQ+oBokb/ctw3Yuz0jnwCBg6LKHi3bjCw539EhP09hoLULqAFHcv2i591iwVB682Whpofy+pw9zHt/7t7qrEGzUcSBj01RmJJHWTKnKT2eoV/IeLCRU4jk5T1rUYR5Vfu7s1y1qLtn5GuBbjj7Vxj5YhLPI59H4qFlIq6etuLalA6zm4rkmCKc+DbJwqB5H6jufaeUEKcDCamAIIzdOu87STexSwpobMPv3XYWk4qjQ02MtoElnbm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787958; c=relaxed/relaxed;
	bh=vpgb6RPjgsg2uUwmuZfiFZi0G049VFqTzA6+jxA6sAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9aod/g0ck5yv771BdBdZwObVLXB0KRZ//i3Qwfn71mckp/ypQcqVitKKSxLRvLigp7guKNNoP7e5tX4A10fj/xK56Sq2NG4Rge7asFiZSwGVw6bSQ4GGoOkebr7/TjArDWLe5EaYDQ9obj1hPTdrzrpo/38Osn3JZZaJJWRDLFAQmw5/EFklJZdICu63+yVOe1RjKVJAnOMGRU1UhQC7choo1SM+f0KYAJRKLZNmoM/yR9IURdG6iU35RUEcl+GoYvNTaU4TtCV4At2Z+thD4KDcvCnKIsHT5lVF9vMfciqamgAD5DdXl9OAfY9lRo4kPkCQqWQLOWcV5Mwa9YzTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p6dyccXt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73m73PCz2yY1
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787952; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vpgb6RPjgsg2uUwmuZfiFZi0G049VFqTzA6+jxA6sAc=;
	b=p6dyccXtZt1dp1cuDRTu5svG48gk2mTYRD9eeAhWfsAY1TIpuMMkxxMg1Hs4F6Clj4sO4lykIrZ5H42KT4EerI7DKe6IfoMhOjFDzYyR4ecY0YxJacd542qah4p3vb+2WxQwBSxhezpIa37XoOeQ5Eh0TjgK24zxagm9g7FtYAo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2p5_1782787949;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2p5_1782787949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/7] erofs-utils: lib: silence `INTEGER_OVERFLOW`
Date: Tue, 30 Jun 2026 10:52:19 +0800
Message-ID: <20260630025224.3955763-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
References: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3783-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEDB76DFE6F

Coverity-id: 647269
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/metabox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index 86a708367dc0..5c2eadacaf7f 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -133,6 +133,10 @@ int erofs_metazone_flush(struct erofs_sb_info *sbi)
 		return PTR_ERR(bh);
 	erofs_mapbh(NULL, bh->block);
 	pos_out = erofs_btell(bh, false);
+	if (__erofs_unlikely(pos_out == EROFS_NULL_ADDR)) {
+		erofs_bdrop(bh, true);
+		return -EFAULT;
+	}
 	meta_blkaddr = pos_out >> sbi->blkszbits;
 	sbi->metazone_startblk = meta_blkaddr;
 
@@ -148,7 +152,7 @@ int erofs_metazone_flush(struct erofs_sb_info *sbi)
 
 	do {
 		count = min_t(erofs_off_t, length, INT_MAX);
-		ret = erofs_io_xcopy(sbi->bmgr->vf, pos_out,
+		ret = erofs_io_xcopy(sbi->bmgr->vf, (off_t)pos_out,
 				     &m2gr->vf, count, false);
 		if (ret < 0)
 			break;
-- 
2.43.5


