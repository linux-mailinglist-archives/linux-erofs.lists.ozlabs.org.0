Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0B16F234
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 22:52:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rt2L1Fc4zDqMr
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 08:52:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Rsy704CKzDqKW
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 08:48:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=vPF9NaaY8PsSDRBa2cHAONSZtTpSsENUkr5OW69v4N4=; b=N6jgfr4UcsghgCPr+wiUMm9OJE
 LmlbXShTyE3uuQXuWB9sLoUN7crlB7IXyqceex8cavHasV9uKxSqJ9BLozlF43ard08jSqCJoQ6lE
 6lcj8LqkXj8AbvKOHxgdFFAU7ZZ8uKqCzV5A6h1xLTEVucuakXjIKVPlTcrkPAQWplkFYaJuMNsmS
 7zMj/itFsGgD+YgTAHaT/j3sKKdE9XSys6eTPbk0+rFu0f1565yF8M3nkiVjD9PNpZnWjvOfF2JVM
 YW7B3gv0z1vY9f3DS7UHwhGWynkOcPcnAJ1xBXblbZKY4VGUtYRhrkR7/BgkgiZ/GNrK+psbM4g79
 OVsKPQCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6i4H-0007q7-Cb; Tue, 25 Feb 2020 21:48:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 14/25] mm: Document why we don't set PageReadahead
Date: Tue, 25 Feb 2020 13:48:27 -0800
Message-Id: <20200225214838.30017-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the page is already in cache, we don't set PageReadahead on it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8ee9036fd681..0afb55a49909 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -195,9 +195,12 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 
 		if (page && !xa_is_value(page)) {
 			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.  This page may be the one we would
+			 * have intended to mark as Readahead, but we don't
+			 * have a stable reference to this page, and it's
+			 * not worth getting one just for that.
 			 */
 			read_pages(&rac, &page_pool, true);
 			continue;
-- 
2.25.0

