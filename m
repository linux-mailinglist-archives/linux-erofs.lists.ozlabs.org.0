Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D7A11E6E
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PN3pJzz3bg4
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934439;
	cv=none; b=DcdnL8F3wk2e0nYcH5vxmvKWC+wdilC5GM3Ls7+mJ1C2/lNLUc0C1Ej+U5ZsUlT9QiVraE+FOsSk50Z9IXjlYANOE8Uz+dOf0X/Iv5/eZ5MClemDH36mdfA0mHIgRkif8jmuh03lXWo0tb5L6AscgiK3cy8QcDdGHTAb0G4+wAK2nZfIkEqmeNulG8fTM2xbnwPe209w947HG60Fvg6gjTqDXOCuEMv0f0m+xOdzF9few/1jf5U4lpUN3s6USRDHGt/dJGHrkxdZAawyFGdf83jhlXPrN+6xLzK8TJLa/+7xTvA4TX0S7sX7aftfN3oXLrNh1ZSXvu7XBpuKiarxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934439; c=relaxed/relaxed;
	bh=2emN2ZekPl9pUS8HrHL111sEmJvGZ8RKJUw7xW8tiZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSMlpTUACi/AAvWzU4K/lIWZq01ICXN76wooWMWwTFAB5bpaC/aY7KNJeC3N7+pi9gntxKYfdR0dVzKCuT2zokZFzN+hbY5dGjmiJYQFiB7T3li3Xc/G0STUETq7T+iZbpmoHlspqwm51jcA1ochjkpJX/FMhO+XxartZUFsAQZ5KLxSx/iGavS2J0uXaiMBjurRvOzdIUqzhEuB9HSZL4AR8vh9kUv7xeG4nhSWGKpKgKJRQsGgRo4snaZYKtZFIZ9V8BWqjWRGsIAvwkIaSU9EuMua73D2XJW9P0fG9VcuTMMeqJyUh4lr3kfIrNrIhhzPyNscrShPHWn2qhGh0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PD21S8z30Wn
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2emN2ZekPl9pUS8HrHL111sEmJvGZ8RKJUw7xW8tiZU=; b=g+5BuL+cWMKlkPq2h1gfpxLmjj
	rywUnEu6MLP81WJIXN0CxJ3brcQ8Fja26vBn45gYLf5UPcaz+Mkjd8xR7XkSjCIruNVND/0pxuP2d
	h4b+V2eX2CWFv7JUC/c24Zm565irmjyEeDFdYLVnSZZ2iFp2X2D4NjaGSPWms3998+G1D66YrZi9c
	+JLYCK6Upy02luduPiZO2tB9WxIkXVGpUMexecOaZL9Ozn/q4RgIgOBmVaD5aSVvlLbha55jDIYpk
	EKiV5yC5q1AXqGcmt0JUDE28B8UQqw0Qd4/3l82cCnojKvEmz4wbLBsT0kHJORBeUOfh24SodK03M
	+3jlm7uQ==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzQ-0000000BOcl-1dG1;
	Wed, 15 Jan 2025 09:47:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/8] lockref: remove lockref_put_not_zero
Date: Wed, 15 Jan 2025 10:46:37 +0100
Message-ID: <20250115094702.504610-2-hch@lst.de>
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

lockref_put_not_zero is not used anywhere, and unless I'm missing
something didn't end up being used used at all.  Remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h |  1 -
 lib/lockref.c           | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index c3a1f78bc884..e5aa0347f274 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,7 +37,6 @@ struct lockref {
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
 extern int lockref_get_not_zero(struct lockref *);
-extern int lockref_put_not_zero(struct lockref *);
 extern int lockref_put_or_lock(struct lockref *);
 
 extern void lockref_mark_dead(struct lockref *);
diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..a68192c979b3 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -81,34 +81,6 @@ int lockref_get_not_zero(struct lockref *lockref)
 }
 EXPORT_SYMBOL(lockref_get_not_zero);
 
-/**
- * lockref_put_not_zero - Decrements count unless count <= 1 before decrement
- * @lockref: pointer to lockref structure
- * Return: 1 if count updated successfully or 0 if count would become zero
- */
-int lockref_put_not_zero(struct lockref *lockref)
-{
-	int retval;
-
-	CMPXCHG_LOOP(
-		new.count--;
-		if (old.count <= 1)
-			return 0;
-	,
-		return 1;
-	);
-
-	spin_lock(&lockref->lock);
-	retval = 0;
-	if (lockref->count > 1) {
-		lockref->count--;
-		retval = 1;
-	}
-	spin_unlock(&lockref->lock);
-	return retval;
-}
-EXPORT_SYMBOL(lockref_put_not_zero);
-
 /**
  * lockref_put_return - Decrement reference count if possible
  * @lockref: pointer to lockref structure
-- 
2.45.2

