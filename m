Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB6A11E78
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PZ3Xp4z3bnq
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934448;
	cv=none; b=milRlyRFYBPah+T6Zu7tl1vrDvzz4jU0PCcXXraFAbF7YccGwSAJpxp+th9CO2/PfU64Yx2MVwsEnCIkhSgrL+GA2/YEnu2y3zu70uf0Y0lJcQsImTieAr8xUktaYBB4BMHRSUavOeuR4kIPWcYAJL4oxlJwtq1nfb1H9133aXC/rToWEAdRwVbZRGbfg8abQoxTs9RRb1gNDbdmbNu0+VCfsTrl6n1OGgKR3DRreubjJ2sqm52QnoHOIoYZyEyOq1h8xdoqLfNWSfcbakdV6ToGPxtlN9FLgNDqu9gW95oL2HOGDJfP5m/NHT2GW/pdCkNAAZIWMxfJypla2tQ2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934448; c=relaxed/relaxed;
	bh=ZxUBne0G/XLQFQ1URg54UYUl7/jIy/7Nitz9EvG+UdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkR79l16HjXfrnUcbUC29R9CVWn8I+oViW4nVpuINSmSQ4E+AoWAurcLRytxRsWfZJWIIybt4lIBEDxSfUoVTr3f9RmRlxwBJIe8/Z5t2XTSgASMem/3EMqlFgH8gVMYry/pwqsfg1R4v+mmhsOYGwvfxemQoJEXLDZnBH+gPKy8sW3Ml6hRurlKfsaIUZCFxOwB678iKwLHYdp5zEXD9E+yny4aR+uHHu1LCGUot75xqsrbCiOiNdI9HqUAd7Y67ZDLFgmniNhy2U4RYXhjuZZJOcQD/LxtGopu6dTXR5mTtqdETFxrf/qMr4woU/vXvZEoNi+l7GOdBBztwMNstg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4i06VkcB; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4i06VkcB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PX3j0cz3bX1
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZxUBne0G/XLQFQ1URg54UYUl7/jIy/7Nitz9EvG+UdI=; b=4i06VkcBgTv80wC9jlhm43uqnO
	SaUx2axJyzLuuZJGQBiyDXV1vofYcQjlFJnj7cYgeDFqyQaOtE5mVpKa6/qZTddTupg0T1sA/B3YG
	JviSj4bfuy/TLsuAjQqWzp7SOi3Zk4BHMjOg8n67V+ZXWNY9DPskD2bD/phwb8U2LD7s3AXPmluve
	tHoCxb6OG6SMmfrLMJ7fFdxATHVOA3ESfbSqTewWczUs5t/bY2lGj73c90AY3V4PbkLYmMBe84NnL
	ycArGN4LQ16VZXaTzElrFip+NrifMaEI3704kr0Q6o1QnSRxRZcUq416AhTrt5OZ+TqCSxQcIlKmm
	5CxTkYLw==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzh-0000000BOjb-31T0;
	Wed, 15 Jan 2025 09:47:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Date: Wed, 15 Jan 2025 10:46:44 +0100
Message-ID: <20250115094702.504610-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.0
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
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/quota.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 72b48f6f5561..58bc5013ca49 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 		return NULL;
 
 	qd->qd_sbd = sdp;
-	qd->qd_lockref.count = 0;
-	spin_lock_init(&qd->qd_lockref.lock);
+	lockref_init(&qd->qd_lockref, 0);
 	qd->qd_id = qid;
 	qd->qd_slot = -1;
 	INIT_LIST_HEAD(&qd->qd_lru);
-- 
2.45.2

