Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF92D08D5
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Dec 2020 02:25:00 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cq5G15zWXzDqbh
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Dec 2020 12:24:57 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=jAB9XjzI; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jAB9XjzI; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cq5Fx0JTwzDqcW
 for <linux-erofs@lists.ozlabs.org>; Mon,  7 Dec 2020 12:24:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607304290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=J1oN9sljlo2pwicIsZRRyVmn98jc3XH9a9o30D1qed4=;
 b=jAB9XjzIMyLEA5iPIr4rnrflqexWavUIBPdHIwyOLc16b4Lx26d5/Vw3UnqGO6cuO9fd77
 DfmQXi8OwNArVl8bDvOsT4KHVE0wwqaXiYpcsaOKQ14bc+FqM0oJQYV5w55D2T6iES4RRE
 Zgfa5ECiHolI1sMp+W5iJLlzlJI4hfA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607304290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=J1oN9sljlo2pwicIsZRRyVmn98jc3XH9a9o30D1qed4=;
 b=jAB9XjzIMyLEA5iPIr4rnrflqexWavUIBPdHIwyOLc16b4Lx26d5/Vw3UnqGO6cuO9fd77
 DfmQXi8OwNArVl8bDvOsT4KHVE0wwqaXiYpcsaOKQ14bc+FqM0oJQYV5w55D2T6iES4RRE
 Zgfa5ECiHolI1sMp+W5iJLlzlJI4hfA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-CVVdgQIQMbCVRZ7-Io7pNA-1; Sun, 06 Dec 2020 20:24:48 -0500
X-MC-Unique: CVVdgQIQMbCVRZ7-Io7pNA-1
Received: by mail-pj1-f71.google.com with SMTP id p20so6697646pjz.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 06 Dec 2020 17:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J1oN9sljlo2pwicIsZRRyVmn98jc3XH9a9o30D1qed4=;
 b=gLmp18o5mo2xVN6NOGmkzydLfG7nEjQL3NG8lH/V6NvuYgJw9+tzwFwhT8Jsk0Ut/S
 0G3c39/XpdPQxr3vtvKLDc5XGzR+HKTWgYkJwPEpmQxBWgzvlNtLrEIbZdX97g4sXHWQ
 B081OWjqUwOaPlfv3ACYFPnxIxj1OuInoEThigAiD3KxpKDqovjsEZbCJZYT9p0iYtX9
 askSsfpeUzJUeM0e4TyD4/h6htDypxEBt6Vo+p2fZHtHg9FGfpcvwFJAVTK1USXr2OVd
 e7+h0cViqvJN821+nYM/GbkQ5xaEwUM75vP3t4R92y+9uCpl21MKcWBmw3FOZTzrqKOW
 U8Xg==
X-Gm-Message-State: AOAM531nWgPLbMhcRhOMVqGLMJbdDIrMz+ntTptE4WPyUz1UDUYuxVrr
 IE9jnRsBdcidl/p3cWeMSGVGzvWCF7fQmPMNTUpR7TtB/yovN0ATWw2uCLi6pU/awLaSME2kAzr
 Nwp+3FiQMvfg5SCxv3eCgiFxFxBe2EbHbvhO8AhA+qMbn6yArJ1pcwLgQTGcOmVVfow7YoDXgpd
 gpQw==
X-Received: by 2002:a17:902:988c:b029:da:60e0:10ec with SMTP id
 s12-20020a170902988cb02900da60e010ecmr13661222plp.83.1607304286499; 
 Sun, 06 Dec 2020 17:24:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYCeL5bFeJwgvAd8bgm/URwkfycr/f6iQI0ks84hppoFfPEEnwKQQX9XEEQ7rJRDKUvFLgKg==
X-Received: by 2002:a17:902:988c:b029:da:60e0:10ec with SMTP id
 s12-20020a170902988cb02900da60e010ecmr13661200plp.83.1607304286141; 
 Sun, 06 Dec 2020 17:24:46 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z13sm8600202pjt.45.2020.12.06.17.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Dec 2020 17:24:45 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs: insert to managed cache after adding to pcl
Date: Mon,  7 Dec 2020 09:23:45 +0800
Message-Id: <20201207012346.2713857-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201207012346.2713857-1-hsiangkao@redhat.com>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
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

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index afeadf413c2c..edd7325570e1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1071,28 +1071,19 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
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
-		set_page_private(page, (unsigned long)pcl);
-		SetPagePrivate(page);
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		/* turn into temporary page if fails */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		goto out;
 	}
+	set_page_private(page, (unsigned long)pcl);
+	SetPagePrivate(page);
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.18.4

