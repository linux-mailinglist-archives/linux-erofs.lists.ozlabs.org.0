Return-Path: <linux-erofs+bounces-92-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED7A68742
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 09:51:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHjB73x2Tz2xqG;
	Wed, 19 Mar 2025 19:51:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742374303;
	cv=none; b=FfbPrIezMJmzLdoF01YxKWQsV0GZzJeUWgAtMAyueeEfAyYxufbA0/19RTkZiR4L1XyCt+x6R/kBkjDBcTuaIsuYVXj4ZMJA/rDXj/enqcnyvncgXZ8SNxXOgb8mlWC1vl62jPBeZghoBfh4km67k7pV+nuNDsNeM8/jOD6TJHrqiMf5IYc4vc0MUBkWk8HUYMBUvnPpe56xn4BWV9ZBuBK3jcCHjADdurDEALShym67Anywh+Ytg07TbETQL4iu6MELv9b1kjtH2v8d3fcE61DsJuAmwjSHO9R7xnqXD6KBkBNelOQEgx9yOxvNs/3Vd6v+bEBgo9d/uVpIZsXZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742374303; c=relaxed/relaxed;
	bh=kDgPRHGhOjEJ2nJvu5o/zZXNhwOUwu+3KFzmJNBgHPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czjJWHoMXrVcCsxPy1aDTsTS8TmLXhAcNRVUMuHYvJYVExNEgmv7SexMWJxTbqBv+itTkq6szYQ4KssodZT4ip34YPvD+CO6bM8Sb+H89W9mWdT/KiFqU0trswP0mia4/Up/aXzNK+eIxOkPIv4mJR1//LUOsVSsiTpE24CHzWtfQgr6TN9wkhZOMbk8P+WKTi3SGrKU/RZaprcNRlKOBs175iGJAvTwyi9iv08j7W7ZHF1DwBIk/iae0cyJphCxA+KoN21dFcnamyxwAupe34HFpK83woJnxXgGZ4rOgEDRyJu8xH/g+EhFiH5OzD0/2oZ4axchaw0ATB8yG2r3hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eYRcYmmH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eYRcYmmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHjB53DG8z2xjK
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 19:51:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742374296; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kDgPRHGhOjEJ2nJvu5o/zZXNhwOUwu+3KFzmJNBgHPw=;
	b=eYRcYmmHK590sjJdMBT3NEFAMJqdZbxqT6wEe8Of5Ic7vbNf/4t7RAaZ5wGGyEjmQIepgtfq4o+usE1BikBKc1h9QfANG1C2K3i05j6mGmn48zhF+cJ05eTVFYt6OCOFhq2LieMGdzL0xks78w8murut1bD67e5QnnpJfzf3y2s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS1h3h7_1742374287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 16:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 16:51:25 +0800
Message-ID: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Previously, iomap_readpage_iter() returning 0 would break out of the
loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
relies on.

However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
buffered read") changes this behavior without calling
iomap_iter_advance(), which causes EROFS to get stuck in
iomap_readpage_iter().

It seems iomap_iter_advance() cannot be called in
iomap_read_inline_data() because of the iomap_write_begin() path, so
handle this in iomap_readpage_iter() instead.

Reported-and-tested-by: Bo Liu <liubo03@inspur.com>
Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
Cc: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20250319025953.3559299-1-hsiangkao@linux.alibaba.com
change since v1:
 - iomap_iter_advance() directly instead of `goto done`
   as suggested by Christoph.

 fs/iomap/buffered-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..814b7f679486 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -372,9 +372,14 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	sector_t sector;
+	int ret;
 
-	if (iomap->type == IOMAP_INLINE)
-		return iomap_read_inline_data(iter, folio);
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, &length);
+	}
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-- 
2.43.5


