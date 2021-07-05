Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E313BC2B7
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jul 2021 20:33:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJZ895PY3z305q
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 04:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U/dHkhRI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U/dHkhRI; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJZ874VX3z2ysp
 for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jul 2021 04:33:43 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 788186196A;
 Mon,  5 Jul 2021 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625510020;
 bh=0U7hZgPxK+V3aSy8+i4BDfGVZnwS/5p/8xyX8R0PyAo=;
 h=From:To:Cc:Subject:Date:From;
 b=U/dHkhRIP114pjZGL3oE1D02XBCEVFMcbo+7KjzI7fQpT2yzKzNjdfXLriB/ZwA12
 wy5FsGzVC3l2WAYiLsDDj4PYKORS3MBFOgSeFtYOwZO1zA4LneE+nMbNxKW/JLqfgj
 zNvZoZRHX9GgfDdYRSnM0phBOul84xb4Irbn6ftfAZ1UsGxy9YOhZM7WtuLtaN0jn9
 tKY0j9L0LpnlI0H9Ki/9kVAVd2rCV+Qh7xJeWbPF5lmVQgSQ/T9okejqsGih0Jfiqe
 FtDdk3dcyAZf4bFjUQoCNKKOwPIedvJMNN+xB9v3Ai05mbBHA9O4EcF+5gaP3Auz22
 sK2vZxwjisiaQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: better comment z_erofs_readahead()
Date: Tue,  6 Jul 2021 02:32:52 +0800
Message-Id: <20210705183253.14833-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <xiang@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add some words about the traversal order and its pagepool usage.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/zdata.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cb4d0889eca9..054b9839e9db 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1424,6 +1424,16 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
+	/*
+	 * All pages are locked in the forward order in advance, so directly
+	 * traverse pages in the reverse order since:
+	 *  1) more effective to get each extent start offset, calculate partial
+	 *     decompressed length w/o knowing the full extent length (which is
+	 *     more metadata costly). If traversing in the normal order, it's
+	 *     mandatory to get full extent length one-by-one.
+	 *  2) submission chain can be then in the forward order since
+	 *     pclusters are all inserted at head.
+	 */
 	while ((page = readahead_page(rac))) {
 		prefetchw(&page->flags);
 
@@ -1460,7 +1470,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
-	/* clean up the remaining free pages */
+	/* drain the on-stack pagepool with unused non-LRU temporary pages */
 	put_pages_list(&pagepool);
 }
 
-- 
2.20.1

