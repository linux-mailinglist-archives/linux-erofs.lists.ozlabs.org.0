Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3BA11E76
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PT5d9pz3bpx
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934444;
	cv=none; b=eDewJprX34IhOQkCqb8pbattZsH8lDAK7JZanQkRxm21ZzRqx1kYM9vOzqkBvadjVQPxNj1CdNXZz3G58p3NXSuttTpS4ED2IE8XlGJwKFrFBxNeiLLGdmQtmaT60OlsFgpBRk0jWRZ2MqvEdDh9P1iDOTQT7tEdRpW55Ly9cPDccIjJ1CMA25Z7KnCYtHooGwXAVW+YJfFO+7umrQS8Xrc1Maoes0/709tj0LRQO1Tgms6MuXi7be3xs+Q6vSq6OSIz3U005e7yIBr+KHNZGVjiua/vMdGXsjqKv46ifzykSCPQ5a+Ua72tldDzLW9rPwxlICQ4Bgytqf+MR/Ktug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934444; c=relaxed/relaxed;
	bh=ExehWvHtv/dE+gm9ctBRtigxAXDYJyzO6NdGxVTaePM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBvldUvplwEhqRq71DZ84ZRpOh51vajACF1pRqOKOEhyqLMVoCemir5eGQAdhj5JKFVr3uCFgmT6AwFBCNLoONmk0+/6/sNDJ03gJ7qdLKTIjJnD1g+lCIOq0l7xB8CUxvyf6HZAF50TTpaok6TokGV1CNlqlkzR3eUuVQwTQPPOJuPR2wMkzAnbahBm5NjJv53pi+FaTsJtZus/0reUWdRKtifC9jQaZq6b27nYfsRUEDXFGXiQNw/zv/CTsuhqLyRJ9EXGjB+P8GnWFML2Alb7RhkOyjB0aeMPaqx5pO81f8cu8ehQHV3y755HEzMOY4w+vkn+dbQ3pDrHD8qtTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TEcVQuCB; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TEcVQuCB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PR5K2Sz3dBZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ExehWvHtv/dE+gm9ctBRtigxAXDYJyzO6NdGxVTaePM=; b=TEcVQuCBrtuxpbbGwt6sZya1tu
	euTd+T6inBKAGmmi2u3vsBYnZAMN42UtOxfDQbtcaQY+y4YlogzvG+ik5Z3fK6g6hWY49bOafbOGk
	vYdwQHhIbCq2HxTzWHQGstbvvu89Yi2f69H3/1xE/Fn9b+KU1Y6SQaOx2LceSGdunyhOdkRsM3AzS
	G7csU4LgFummki3Fw0E7K67xdCtq2vdgxq/ySgQI3gw6PknJIX9ZvLOdLEOHL6gwIQQaVX4S8hhHH
	b36fAJWyXzTQg04kE6Ul4Kyp3COkQxOz8WXCC+hGiLF920+djQ7z6tvkROeYhQcp5aEeqce5gIpzN
	bTUGT7TA==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzc-0000000BOhl-3P8y;
	Wed, 15 Jan 2025 09:47:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/8] dcache: use lockref_init for d_lockref
Date: Wed, 15 Jan 2025 10:46:42 +0100
Message-ID: <20250115094702.504610-7-hch@lst.de>
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
 fs/dcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..1a01d7a6a7a9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	/* Make sure we always see the terminating NUL character */
 	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
 
-	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
-	spin_lock_init(&dentry->d_lock);
+	lockref_init(&dentry->d_lockref, 1);
 	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
-- 
2.45.2

