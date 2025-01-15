Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D7A11E75
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PS2ptCz3fS5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934442;
	cv=none; b=f1u6c44/Nrcm4upxynP9FkHObKq+nbLxscAsSRQw7SeTywGZwDnVs+KSwKBvsAlR9cUA0YVa1ni6yIHzgA0lwKWJCHc/SV/V4d7FN2JrtkhWnpu1pc+cNf6/dvBPAk/Yn/3w0GyM7RrR8moELz5E4geBp2+VXJjXWq3wz33pbGnKGTXw5a9PHP1CLcizXfVVjDpTNEt29STFJ6Ls5gQeD8Mql7gioi+xnENM61G+em3I6qrvgWgxkknbzkOY0qqvvEq9cWrhlvLkPUyD0B9vzj6TN/FKMgnYxvHa/o+SNcvk+JYmMNjk9WzcDowtXeseaXItsQ0IN+4w3oHEx4MfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934442; c=relaxed/relaxed;
	bh=JfHT3r6a2waLQ1axcUyumnw0jeW+jo8FKvycKmaGzeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDb+LRg+h3Iya+XvSfJUfud5+yDiNcnfpL181mdwE+PfSMMn7wEwjI/cV8yKqMF+T0IUwxXnw7HK48hBlOyKA55+LfUpvRCX52P3Q0tf8MQDi0Phm71Hrr2uhdUMooIKNd9d6YMallp/HWCUo0YRxFbSdRPs6ETjdsD3YKPkgrmEJoNL6w41fNidsgEiiORo/k7HMo1QE1fv69nF3q4A9dGVJ5NGCS5I4TJr/XfuMwqnzQAJGUnpVLFgQIQFovrwyr53asbRjfxrFd6Rzg7+MZIaqy68MeMCMIbbchWmnzpVad37eo5DSuV7zZiuwjKj2QxH0lQq0xiTmQrTunCzyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bR2RAmVo; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bR2RAmVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PP1n2cz3c7q
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JfHT3r6a2waLQ1axcUyumnw0jeW+jo8FKvycKmaGzeY=; b=bR2RAmVoqBnTJJ2YjwFXzYJR3U
	wNZZV35kNGFHfNZacudPz7xszFWix1gdKTjZTPxLSeK97IE17UGtRGRAbDyvop3kJN1fEiKG72+Lu
	+l1bvKMfgmmQrz/ePRwV8qALTqndGRaXYkZaHSx3pw0iIS/ndhjU+BcpJbzbGylHRTMCW5h++FlyM
	GiAmCzdjcI7EbJiPk1juaqXkUHqh9nlnl1aM/xl1RmCrxxyayMfp5IlIpODjH2ZM8cRsdBda/LF6x
	+kCJ8v3jSLdDzzeAwwnFSYNuElC7/JQ91uitQkor/sC0XC+gtjoHpcSrnKFmFyxxfSJwwZ91tJ3Uo
	HzPkhZvA==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzza-0000000BOgI-1TUG;
	Wed, 15 Jan 2025 09:47:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/8] lockref: add a lockref_init helper
Date: Wed, 15 Jan 2025 10:46:41 +0100
Message-ID: <20250115094702.504610-6-hch@lst.de>
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

Add a helper to initialize the lockdep, that is initialize the spinlock
and set a value.  Having to open code them isn't a big deal, but having
an initializer feels right for a proper primitive.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index f821f46e9fb4..c39f119659ba 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -34,6 +34,17 @@ struct lockref {
 	};
 };
 
+/**
+ * lockref_init - Initialize a lockref
+ * @lockref: pointer to lockref structure
+ * @count: initial count
+ */
+static inline void lockref_init(struct lockref *lockref, unsigned int count)
+{
+	spin_lock_init(&lockref->lock);
+	lockref->count = count;
+}
+
 void lockref_get(struct lockref *lockref);
 int lockref_put_return(struct lockref *lockref);
 bool lockref_get_not_zero(struct lockref *lockref);
-- 
2.45.2

