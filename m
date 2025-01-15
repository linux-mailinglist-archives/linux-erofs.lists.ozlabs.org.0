Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC0A11E77
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PW14MPz3byh
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934446;
	cv=none; b=chDs7p5Y8X+c3nnF3JyLcPQmA9CqIFqy5g773Af4gcwKKQjjIVrqXwRxiS1OQHz5YPSTnTv/KnoorEH04iACxc5Vnf+US7qvV1nqCus490+UJn06HSX52pqOxT82OCTtFK9EEsrye4+EmMuvi1qS604Ia8y//elkWYKmVa1HGcK3YASBE3eNgnsdt4mzkQz0KM1Ch6a7sf471D5m7YVULvKePG2O0NPhX3RFgsmK9qGeClHKfqm+2zfJ/dvnQ2wNxBgPVFhF2jSeW0F4l6u5OfvdmXrLS7VFR4punPVpjdrMBMlGIWih4VmxGnjWIbC+Ec1nQ4/UBXvLOwmGWXvtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934446; c=relaxed/relaxed;
	bh=easVSrQ5eMjG5N5DCivClgnlxU07C0jtlUyU9+xSgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOgzLetl8a0OaLKx3JoTAqSpksqrSKxCGQWJAmdK+6Jdyumn9ko2e+9USDT+FX5O64toAg7ASIK37dRZH1H4KqCyPvbmV4MATau9pCz/Ikl59myZDR3nixK70EeNMUGbnmOJFg4EvVu3Blkndr3h7DJiA2m4dOFQ7V3lfFB3zAD7AlRklJACiFsr44B36cXpaVySL08DMWky4TF0k3w3X7aOQwwtgOKAb6C4GZx82gMfyZA6TO3jBMuuCg5/w3zv3MK0vcoi9a0JDpUGTE5JQz3R0Z+lT19qmR870QhrD89fsEgOzeVNnYuxsZsfJpnoDAI06pDCnaorMNAstSOxmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2i2h1J9W; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2i2h1J9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PV075yz3fV0
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=easVSrQ5eMjG5N5DCivClgnlxU07C0jtlUyU9+xSgOg=; b=2i2h1J9Wdt8M088Q+u5JEaevWW
	cig673kf18t+fTojaEjdQziAxcx+drGWauAClKDHT/UuGsaAC5jUPljm6lj3FiI/ZT2R+fnfrFosl
	T/5m9TTME/hTxgWyO2chfKfuxJJk9ibiNysBmGHOlUY9yFzH+A9P3g0yHcWmORuBvaVpV2gXZGa/H
	8qHYA9jBGMk5O7uN7N2ZELltAQ+wZQeN01nT+lGegyy9gNmRjAC3Sd3BsGsIBpfeg5mvQVojnpVRs
	jZ5PmkdpTl2fBcXol1sj7Hb2I5UxZph9NH5rpTLu/MJjIf4WjiDW09ksJ1wFvJXTJMv0O7ArCMqEq
	Hbdh76Ag==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzf-0000000BOiV-15i5;
	Wed, 15 Jan 2025 09:47:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7/8] erofs: use lockref_init for pcl->lockref
Date: Wed, 15 Jan 2025 10:46:43 +0100
Message-ID: <20250115094702.504610-8-hch@lst.de>
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
 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 19ef4ff2a134..254f6ad2c336 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -747,8 +747,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	spin_lock_init(&pcl->lockref.lock);
-	pcl->lockref.count = 1;		/* one ref for this request */
+	lockref_init(&pcl->lockref, 1); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.45.2

