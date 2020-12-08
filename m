Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A22D2851
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:00:13 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqwf26hCWzDqXY
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:00:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aBF37uHw; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aBF37uHw; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqwdv1FXxzDqXY
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 21:00:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=rBR2sHYHwldgTu0PFeX3ECPbcilHKiXAcu7mwUOdVL4=;
 b=aBF37uHwQbFSsDvo+zHCuCHT9LxmZWQbt+ggkfOkJ4mwLWNzzBAMm82eBnLvA0mD8hUybt
 ahbQh6EHWdj6oWIqDY3v9YrMkKWrCgtXlDmjy1OYGgrQduXiom7dbkneIT4O6JFwb5hNj3
 56d30rq5O5BD6SEmABi58cIXFRaY7+4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=rBR2sHYHwldgTu0PFeX3ECPbcilHKiXAcu7mwUOdVL4=;
 b=aBF37uHwQbFSsDvo+zHCuCHT9LxmZWQbt+ggkfOkJ4mwLWNzzBAMm82eBnLvA0mD8hUybt
 ahbQh6EHWdj6oWIqDY3v9YrMkKWrCgtXlDmjy1OYGgrQduXiom7dbkneIT4O6JFwb5hNj3
 56d30rq5O5BD6SEmABi58cIXFRaY7+4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Efnu_CXWPQaGo4MKWl50OQ-1; Tue, 08 Dec 2020 04:59:58 -0500
X-MC-Unique: Efnu_CXWPQaGo4MKWl50OQ-1
Received: by mail-pg1-f200.google.com with SMTP id 1so11512223pgq.11
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 01:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rBR2sHYHwldgTu0PFeX3ECPbcilHKiXAcu7mwUOdVL4=;
 b=bv3xwoY+tHMHiSru+oa7WnLvbbNzU0hpTpnkvxMW7bCt20k6NvyG8bWtPiSotamz4M
 XZFaAhc/DlWjm57m5xIm4ef5Rd3dzpjGbSzbL251sN8KJkw8WkR/OiVdibaPnN/fjioI
 vHJUqxaPLF8cLpNjyEg2/8vIp9KPTivwUltZMyPmp7WaE4Wqyr5fiZ4xDW2j6UsllSPX
 UHgnfBkJvXDgOslCWszY+G1ZOYW7U1rQ3B76DKeGxaNQhYWtTVBSK7FXUmVWeuWkQ/8Z
 zz8ly8fTW1WXDbLErMBg1BIIsOYZ+fiEKYIas2Fo3s+VwX5JJzEiAJTxsUpSwO1zo8vr
 DltQ==
X-Gm-Message-State: AOAM533GbxKi2SGr3C+IXVdPGStChYDTThQAgjShf/L8SbWyNZeZxsuh
 jR0X6teLEoU5v6LP70sbdtbG4Jv6b+wPSQfjnzMxS4/VbwlgQko0Sm2l2PjuQJ0OeypRl83jwjx
 OP1EeFR5fDOES8QQsVs9fIP/YmgdvL2nrhNWG5q02TvPJZ1MfmzUACj18H2+ZioEUBcDXeV1kQM
 OfYw==
X-Received: by 2002:a17:90a:a2e:: with SMTP id
 o43mr3484692pjo.59.1607421597476; 
 Tue, 08 Dec 2020 01:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUumzd5COLJTL8qWXa47ZR2o6FPrRYsjhJoPO1IK0VWghEiCF9KhowSLpTE7f5VVk6OdLSJQ==
X-Received: by 2002:a17:90a:a2e:: with SMTP id
 o43mr3484674pjo.59.1607421597228; 
 Tue, 08 Dec 2020 01:59:57 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z7sm11529018pfq.193.2020.12.08.01.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:59:56 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 3/3] erofs: simplify try_to_claim_pcluster()
Date: Tue,  8 Dec 2020 17:58:34 +0800
Message-Id: <20201208095834.3133565-3-hsiangkao@redhat.com>
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

simplify try_to_claim_pcluster() by directly using cmpxchg() here
(the retry loop caused more overhead.) Also, move the chain loop
detection in and rename it to z_erofs_try_to_claim_pcluster().

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 51 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 37fee144f0e7..777790038bc9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -292,34 +292,33 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	return ret ? 0 : -EAGAIN;
 }
 
-static enum z_erofs_collectmode
-try_to_claim_pcluster(struct z_erofs_pcluster *pcl,
-		      z_erofs_next_pcluster_t *owned_head)
+static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
 {
-	/* let's claim these following types of pclusters */
-retry:
-	if (pcl->next == Z_EROFS_PCLUSTER_NIL) {
-		/* type 1, nil pcluster */
-		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
-			    *owned_head) != Z_EROFS_PCLUSTER_NIL)
-			goto retry;
+	struct z_erofs_pcluster *pcl = clt->pcl;
+	z_erofs_next_pcluster_t *owned_head = &clt->owned_head;
 
+	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
+	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
+		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
 		*owned_head = &pcl->next;
-		/* lucky, I am the followee :) */
-		return COLLECT_PRIMARY_FOLLOWED;
-	} else if (pcl->next == Z_EROFS_PCLUSTER_TAIL) {
-		/*
-		 * type 2, link to the end of a existing open chain,
-		 * be careful that its submission itself is governed
-		 * by the original owned chain.
-		 */
-		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-			    *owned_head) != Z_EROFS_PCLUSTER_TAIL)
-			goto retry;
+		/* so we can attach this pcluster to our submission chain. */
+		clt->mode = COLLECT_PRIMARY_FOLLOWED;
+		return;
+	}
+
+	/*
+	 * type 2, link to the end of an existing open chain, be careful
+	 * that its submission is controlled by the original attached chain.
+	 */
+	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
 		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		return COLLECT_PRIMARY_HOOKED;
+		clt->mode = COLLECT_PRIMARY_HOOKED;
+		clt->tailpcl = NULL;
+		return;
 	}
-	return COLLECT_PRIMARY;	/* :( better luck next time */
+	/* type 3, it belongs to a chain, but it isn't the end of the chain */
+	clt->mode = COLLECT_PRIMARY;
 }
 
 static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
@@ -364,10 +363,8 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		clt->tailpcl = pcl;
-	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
-	/* clean tailpcl if the current owned_head is Z_EROFS_PCLUSTER_TAIL */
-	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		clt->tailpcl = NULL;
+
+	z_erofs_try_to_claim_pcluster(clt);
 	clt->cl = cl;
 	return 0;
 }
-- 
2.18.4

