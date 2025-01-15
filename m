Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CFA11E74
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PR3tXgz3cVk
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934441;
	cv=none; b=XJGIMaKUV7EHSekFHPNjbGFcjbUNo4TqNhOYGPNs1RehAEcMfjd0UQS6KDxZukwUPVCXz+kEiYygWWNUIgLqq3mrFVeia/KD6xywilqShTKpTUSCd+0122SHoDZhEqnw88gRqIWlmBGokvjWEQS9aNWH30rjeKJlcKS37LR60LrBDDT9i77JBp3HqNypBDbDMWUJtOkzy4Rs4CBcI5XNxOCMnofrvGY+6bhPiRlqTIvHM0e++kM6EadLAiKO+TJsdUfp4z3QIIW1jZB+mVuqF4K4EHv8XtK7NQLWfJEwAB7ryjXDvVPPPxf+VIpBGrg3agSy/IEGRkO/B3kXBxUt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934441; c=relaxed/relaxed;
	bh=hPOnhSQ0mVQSxdqd9+OXmMe6Ci3iABOIejHsGxfpgNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar3qEvX6oK5fMOt8wSgAaNiWqbNWoA4fUB1boXCbqZ17U9Phu+dRVKJYM0zJrmbMj/fcFnnrqP4JNIBoXa3T3TL53P25GteVsdsvFzuXa+E1nURvDTH0R68052SnexbtqXCT7gclny3smsfYTwfdiyukk3EBx9VSF8o7V6kglUlU7grhtA8MgJMsc40U4mnf9/cfVJJl1gfRWAEaAEK5rreeBBmpAVwP4Ws+IwTG57GwmJrBHhMq9Kg3kjjIKHm8v8ishwoEih2ykSOqJ2gYa5a2+1MZSG/FfP1PUuprImvW62M7yDS+gzFOPqFC7mF2i/a9h7GSJ6qq7DoJFEONyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PJ36knz30gn
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hPOnhSQ0mVQSxdqd9+OXmMe6Ci3iABOIejHsGxfpgNc=; b=h8dpluIRfwDN/s/F80wti5ojXn
	5K6j6iAa+Y1Ss0dCC8pdGnHsR8V8WqiIOUb/KDp2Qod3fGSjLTa8xPYuEPrDdxRJQ3DKHBjd7Dh1g
	OvI1poxJMckuc++FXPSjpY3tdBh1iYBeD2kav7hWUyspMp8ib/zxMfCf17Xjn6rTl89Hr7Ok9ZL+o
	RHZkq5gKn48IjS6N23bDigYEZjCQFyPn4Iibj6UQuvT0jaEmo/9QITCWt/8jZqGe8foa8FB13z7Xj
	Lxz3opalR6o8vDFRp3hRsfX5pNWVV13yKwXiQMVGve6izyO96gJCCJC1MePDG3EvqgTfKc/epzBly
	cZFUYf/g==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzV-0000000BOec-1gaW;
	Wed, 15 Jan 2025 09:47:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/8] lockref: use bool for false/true returns
Date: Wed, 15 Jan 2025 10:46:39 +0100
Message-ID: <20250115094702.504610-4-hch@lst.de>
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

Replace int used as bool with the actual bool type for return values that
can only be true or false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h |  6 +++---
 lib/lockref.c           | 30 ++++++++++++++----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index e5aa0347f274..3d770e1bdbad 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -36,11 +36,11 @@ struct lockref {
 
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
-extern int lockref_get_not_zero(struct lockref *);
-extern int lockref_put_or_lock(struct lockref *);
+bool lockref_get_not_zero(struct lockref *lockref);
+bool lockref_put_or_lock(struct lockref *lockref);
 
 extern void lockref_mark_dead(struct lockref *);
-extern int lockref_get_not_dead(struct lockref *);
+bool lockref_get_not_dead(struct lockref *lockref);
 
 /* Must be called under spinlock for reliable results */
 static inline bool __lockref_is_dead(const struct lockref *l)
diff --git a/lib/lockref.c b/lib/lockref.c
index b1b042a9a6c8..5d8e3ef3860e 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -58,23 +58,22 @@ EXPORT_SYMBOL(lockref_get);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if count was zero
  */
-int lockref_get_not_zero(struct lockref *lockref)
+bool lockref_get_not_zero(struct lockref *lockref)
 {
-	int retval;
+	bool retval = false;
 
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count <= 0)
-			return 0;
+			return false;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
-	retval = 0;
 	if (lockref->count > 0) {
 		lockref->count++;
-		retval = 1;
+		retval = true;
 	}
 	spin_unlock(&lockref->lock);
 	return retval;
@@ -106,22 +105,22 @@ EXPORT_SYMBOL(lockref_put_return);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if count <= 1 and lock taken
  */
-int lockref_put_or_lock(struct lockref *lockref)
+bool lockref_put_or_lock(struct lockref *lockref)
 {
 	CMPXCHG_LOOP(
 		new.count--;
 		if (old.count <= 1)
 			break;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
 	if (lockref->count <= 1)
-		return 0;
+		return false;
 	lockref->count--;
 	spin_unlock(&lockref->lock);
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(lockref_put_or_lock);
 
@@ -141,23 +140,22 @@ EXPORT_SYMBOL(lockref_mark_dead);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if lockref was dead
  */
-int lockref_get_not_dead(struct lockref *lockref)
+bool lockref_get_not_dead(struct lockref *lockref)
 {
-	int retval;
+	bool retval = false;
 
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count < 0)
-			return 0;
+			return false;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
-	retval = 0;
 	if (lockref->count >= 0) {
 		lockref->count++;
-		retval = 1;
+		retval = true;
 	}
 	spin_unlock(&lockref->lock);
 	return retval;
-- 
2.45.2

