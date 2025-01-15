Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB75A11E73
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PR6t8Zz3fK3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934442;
	cv=none; b=GyoYthcBtOdDC3R+QGSohJAgdrq0BUuQy0pckrCLqp8mjOX+OCLOc9/ix5++8osNWSgnJ/qJapULMUR4Ls9nU+zheK6Z1SAtAi0xWT0CKollatcCmKswey7AuQi0Frahxlh0Zuvd39eGeBVdxFYwPywkWWUHmgeY1AXMo6OJeygQou7CxnJV9VtMmhMM1cuRbNi+0djXzXWGeR9R4VzwRvJA8BW+lDjiWTCNuZMzuw4vpqb1l0OP9SmDiXwhve7L+UFNpWzOiaiAKqKoJvwMRCnbzjUgZN0X94SJJkHtU4t/1DtjoWXNi7N1yIO37Tjz36IeklTdS5zkAi3ZxtR4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934442; c=relaxed/relaxed;
	bh=ohLiAdYSUOhMrwWdrrwT+bNxgt2i6mB7od5qyPwAJhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEVjMkK5Ncyl93Sf4Cf9Ii5JXt3+914ROasa6m770izY2lObirBiizlGKGVQ9AyMLFxqHP0OJrdEonT6AG7uk35XAS2prlejBSmOx2SGk6yjgiDzO882FVhlSvycbFOKmuyeyz+e5I0K3EQeVeWr+indXtegKMn+4YONBHA4pEqi7oPQfIyyZp27oCW0gKkMnd1YbPAzgMKOXzSI+seuzHVJDvv/Rsu5//MRya+MTwpoAHUFLwrK4FBM/FcC9FQcPAU0f/LZklr6zrGHGkSY1QlnEtAi/M4+NpxXzlZmlxBZAmRKM+CWlS3RuQenNGMSnTnbRaZhuUIqBA+zZo7YyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4iDLRR/G; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4iDLRR/G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PL6HpMz30h5
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ohLiAdYSUOhMrwWdrrwT+bNxgt2i6mB7od5qyPwAJhc=; b=4iDLRR/GW8kspoqoiyDTuPao8Y
	WIozGp4pjDbQ2H8yjOVwxYmknSOFPaJ6ob/dBmRjS+k4aJQN1oK2txhY6VdW6M/RMF3WaxJQKbBii
	QQYfCRR6Wb+w1z48a6o+zs8H7qyzlKg5uo/Zy0Z0FRzKH5ZcMHnRDfGL0qQbGLA9MMdc9q68b6jlP
	vrcMY1G+9FtoFApiVT/H0yS0jqe4FeLLN4u7HANOflLA/4WWISoK18iZltCo4B0f9Jb2YpxSiTzyA
	zn9IAV1dhLtlogt3nrNBCpTqzClssInH/vQWcUccM3Ph9cv0JnPWx1G0bwYIAkwmp3rVMjBqonbz9
	6OdXLL3g==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzX-0000000BOfO-3ZBc;
	Wed, 15 Jan 2025 09:47:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/8] lockref: drop superfluous externs
Date: Wed, 15 Jan 2025 10:46:40 +0100
Message-ID: <20250115094702.504610-5-hch@lst.de>
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

Drop the superfluous externs from the remaining prototypes in lockref.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 3d770e1bdbad..f821f46e9fb4 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -34,12 +34,12 @@ struct lockref {
 	};
 };
 
-extern void lockref_get(struct lockref *);
-extern int lockref_put_return(struct lockref *);
+void lockref_get(struct lockref *lockref);
+int lockref_put_return(struct lockref *lockref);
 bool lockref_get_not_zero(struct lockref *lockref);
 bool lockref_put_or_lock(struct lockref *lockref);
 
-extern void lockref_mark_dead(struct lockref *);
+void lockref_mark_dead(struct lockref *lockref);
 bool lockref_get_not_dead(struct lockref *lockref);
 
 /* Must be called under spinlock for reliable results */
-- 
2.45.2

