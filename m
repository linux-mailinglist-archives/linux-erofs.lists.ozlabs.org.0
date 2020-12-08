Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC82D2850
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:00:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqwdw1kC3zDqYd
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:00:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cN9z0tuj; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cN9z0tuj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqwdp5wcTzDqXS
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:59:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=OnbVOCo3bXOU9/kWOo4VVhQfQzo7GWaQzsbv1nJLpY0=;
 b=cN9z0tuj/VHEVGV2xCMZZBLE1B/MJiwD/YJ+tgUCx5KBCCmJxOkPCyh1mLZMy2nuPbfwPx
 CCwpso0HYAW+A3SZnVd9cSgmvpZif4vcUbDb0XkXsmuYDC8JrN8bAerEXpKbydpWE/nuZH
 YfIFwz5SXoldzQ/k65EzNWohKjzsI7U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=OnbVOCo3bXOU9/kWOo4VVhQfQzo7GWaQzsbv1nJLpY0=;
 b=cN9z0tuj/VHEVGV2xCMZZBLE1B/MJiwD/YJ+tgUCx5KBCCmJxOkPCyh1mLZMy2nuPbfwPx
 CCwpso0HYAW+A3SZnVd9cSgmvpZif4vcUbDb0XkXsmuYDC8JrN8bAerEXpKbydpWE/nuZH
 YfIFwz5SXoldzQ/k65EzNWohKjzsI7U=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-SlPhtRxUORCsYHGIvg9Aew-1; Tue, 08 Dec 2020 04:59:54 -0500
X-MC-Unique: SlPhtRxUORCsYHGIvg9Aew-1
Received: by mail-pg1-f197.google.com with SMTP id a27so11515937pga.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 01:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OnbVOCo3bXOU9/kWOo4VVhQfQzo7GWaQzsbv1nJLpY0=;
 b=jlmLOv5s7eNV/KAgs7aI+dllEgBpgx4vEP5ItYefb7pxrVI92d3iIjIulrvcZgw1hV
 d9XLeOMbGvjNhe8GV477pEXjeXN4vtU4+BJul0jFb6baSyAKHmDNxVChL1aYaPbrpFsp
 Lwl4zgiftWHtVjC2bcVS4KCje+cKourZWkF2IHieeWLcJ/qdppJdX9RLt01rKUE3gckV
 meDXqkpvhI52djr/37xeSeJrQImhgIu07wrOZaOxn1ITbKX1nItoIpTM4ljibg0ADO1f
 J1tcLCevMvb47EFce5jSATSWU2BIQCc0thzm/AO26swbVK8LPSYkrNfCyU9tcuUmkdkV
 1pCA==
X-Gm-Message-State: AOAM533GXYw9dXkAn8AosrGJg06Cc99okeTArCI2yzMVmXR5b77Yn/nA
 +2YmH6yiFVMzWHuEXrVDXIjFN1TkHA7iCVH2ypXz0fNzgq0xk8KMTlMdG9UIA9AT6gIi+rhpBmf
 MyE8oDhBA8u/4mhBLxYajdvLbr6nbX0L0Q8F2wglJvvBtieJkCEcAPSJQCPExt1W7wjthxGPiEp
 HjUA==
X-Received: by 2002:a62:2b4e:0:b029:197:96c2:bfef with SMTP id
 r75-20020a622b4e0000b029019796c2bfefmr19807454pfr.46.1607421593487; 
 Tue, 08 Dec 2020 01:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyOM02KFHrCbMiE5pqTFonEcc7mLe5Ma4LE3EHzuAQSxiV3ib9dsPfNmT9CWKZRK/3VHhbOg==
X-Received: by 2002:a62:2b4e:0:b029:197:96c2:bfef with SMTP id
 r75-20020a622b4e0000b029019796c2bfefmr19807435pfr.46.1607421593111; 
 Tue, 08 Dec 2020 01:59:53 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z7sm11529018pfq.193.2020.12.08.01.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:59:52 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 2/3] erofs: insert to managed cache after adding to pcl
Date: Tue,  8 Dec 2020 17:58:33 +0800
Message-Id: <20201208095834.3133565-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201208095834.3133565-1-hsiangkao@redhat.com>
References: <20201208095834.3133565-1-hsiangkao@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, it could be some concern to call add_to_page_cache_lru()
with page->mapping == Z_EROFS_MAPPING_STAGING (!= NULL).

In contrast, page->private is used instead now, so partially revert
commit 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
with some adaption for simplicity.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cfb0d11f893b..37fee144f0e7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1065,29 +1065,21 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	put_page(page);
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
-	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* turn into temporary page if fails */
-		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
-		tocache = false;
-	}
-
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
-		if (tocache) {
-			/* since it added to managed cache successfully */
-			unlock_page(page);
-			put_page(page);
-		} else {
-			list_add(&page->lru, pagepool);
-		}
+		list_add(&page->lru, pagepool);
 		cond_resched();
 		goto repeat;
 	}
 
-	if (tocache) {
-		attach_page_private(page, pcl);
-		/* drop a ref added by allocpage (then we have 2 refs here) */
-		put_page(page);
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		/* turn into temporary page if fails (1 ref) */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		goto out;
 	}
+	attach_page_private(page, pcl);
+	/* drop a refcount added by allocpage (then we have 2 refs here) */
+	put_page(page);
+
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.18.4

