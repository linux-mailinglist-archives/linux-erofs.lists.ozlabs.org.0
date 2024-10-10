Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34B998175
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 11:04:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPP3B71W3z3brr
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 20:04:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728551093;
	cv=none; b=iyXwVsGWiDhEAXNpkupRS+x+8APAH6bNhwIooJMumDmalq/zH1ogteEPWx8whm3qbs4X7iq+pPgN1uxkfI/WR3TARAaGY9r4FCA5W/DcZZso15mc9X9cJM3BuW43YT0/0d4S1esAammQsawoYUBPCTGPKro7NFib4Hyg98kV35WD2cIZge07OgWH1ToON90c4TqPtvP+rRrroY+oUXKBJ758gGlQLzZ+xjPAUmdxcs85UENKvluvCS6ccxkckWqdWW2kqViT5OjZs33VVJvIS8kGgHV3v2s3ECZuHIrY7nj7kA60Gv4AXmdrObEcQx5YX9MECbchfg30inVlX8AaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728551093; c=relaxed/relaxed;
	bh=OhN43jmqgscvViJHTKkxcG9hhjOllYEZaG+SvYfOIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjFkP1c3PZEixvqIZ5tuKuBaHR6jvvLY9Efx+QmCj8Vw118kohRUhaqBfAssN9p2d8JRDo4SPZVCfxmcNV1IpN4y1SAWv1OoybU1ZiQTMS8S7LXEfAWrGbmtTadX9KypLLx5kVqabR7d/OhRa/Tn/7lv6UsRTxaG0nx4wbK/X0nudbRK+Azg1SZGhVqzywQN/QHNIaiZimQaBzoxKIgBk9tU1dr10/jrJ5F/+DOFHaI4IQcAXg1yKrlnX5xJGq9ldbGCnwi00Ck9BYcghOBAWTsz/qwXnLJST2wC6GjhIncxFYJFY35oC4LFb8UoNAscMQG4uf0MqdUrATGh0LCD1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qRU1PK28; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qRU1PK28;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPP362N7Sz3bp0
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 20:04:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728551080; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OhN43jmqgscvViJHTKkxcG9hhjOllYEZaG+SvYfOIwg=;
	b=qRU1PK281FXbweUxUF7mhjswJBJhRv+EoWsalMEsiPEXu+0akLb20QIuShQO1cYxqXBQd8+ZMyv/UnGqAZbe0cGTSrhouabdxpRaxeRH13u8wtTpu+fNq6ryYDqyTgrhBLapcb0aVgtOiR8Wv6xlfCtX+MZoay/Lsn8n7O4ChVY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGlkDys_1728551062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:04:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: get rid of z_erofs_try_to_claim_pcluster()
Date: Thu, 10 Oct 2024 17:04:19 +0800
Message-ID: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just fold it into the caller for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8936790618c6..a569ff9dfd04 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -710,24 +710,6 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
-static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
-{
-	struct z_erofs_pcluster *pcl = f->pcl;
-	z_erofs_next_pcluster_t *owned_head = &f->owned_head;
-
-	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
-	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
-		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
-		*owned_head = &pcl->next;
-		/* so we can attach this pcluster to our submission chain. */
-		f->mode = Z_EROFS_PCLUSTER_FOLLOWED;
-		return;
-	}
-
-	/* type 2, it belongs to an ongoing chain */
-	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
-}
-
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -803,7 +785,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	int ret;
 
 	DBG_BUGON(fe->pcl);
-
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
@@ -823,7 +804,15 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
-		z_erofs_try_to_claim_pcluster(fe);
+		/* check if this pcluster hasn't been linked into any chain. */
+		if (cmpxchg(&fe->pcl->next, Z_EROFS_PCLUSTER_NIL,
+			    fe->owned_head) == Z_EROFS_PCLUSTER_NIL) {
+			/* .. so it can be attached to our submission chain */
+			fe->owned_head = &fe->pcl->next;
+			fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
+		} else {	/* otherwise, it belongs to an inflight chain */
+			fe->mode = Z_EROFS_PCLUSTER_INFLIGHT;
+		}
 	} else if (ret) {
 		return ret;
 	}
-- 
2.43.5

