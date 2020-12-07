Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A07792D08D6
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Dec 2020 02:25:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cq5G76Fl3zDqcW
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Dec 2020 12:25:03 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=NE/YLJ6N; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NE/YLJ6N; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cq5G00G5mzDqZP
 for <linux-erofs@lists.ozlabs.org>; Mon,  7 Dec 2020 12:24:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607304293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=sPZMkWPyWVaaTUTdVItsmybqSHRLMaGJkADfcXrdhD0=;
 b=NE/YLJ6Nb8ORKyLXqUlTAKKLwG7xMPl3aVAo4+374a1RPqBme6xtC94aAXYxs02rrVosxn
 V9O9tJ6zXd00X2Px8pHNcwHKrWFfu7UDG59xp85i4jV6lKUkGXI6jyoLsMaf2K0Mep8h2g
 gQplrjyInVfYChzayDrxag7T3dqfANg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607304293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=sPZMkWPyWVaaTUTdVItsmybqSHRLMaGJkADfcXrdhD0=;
 b=NE/YLJ6Nb8ORKyLXqUlTAKKLwG7xMPl3aVAo4+374a1RPqBme6xtC94aAXYxs02rrVosxn
 V9O9tJ6zXd00X2Px8pHNcwHKrWFfu7UDG59xp85i4jV6lKUkGXI6jyoLsMaf2K0Mep8h2g
 gQplrjyInVfYChzayDrxag7T3dqfANg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-vJ5ul1MLOVqdPAjW9pEGJg-1; Sun, 06 Dec 2020 20:24:52 -0500
X-MC-Unique: vJ5ul1MLOVqdPAjW9pEGJg-1
Received: by mail-pj1-f69.google.com with SMTP id p20so6697781pjz.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 06 Dec 2020 17:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sPZMkWPyWVaaTUTdVItsmybqSHRLMaGJkADfcXrdhD0=;
 b=Rr4dKsFcsiH/JvqhuNq5dogNi/YSK3j66X/1TaCAbFsqN6lCnAURU/uidjyN5Roslq
 sp27WQQiYKXf1o3if35pzBmvwQiukFfPzeuNSQ1UQ2C9Gi98IxKW9fAIf5wHBJaSrboA
 LHF59lZu31rP3QXqratIgqW1etgEpZIcZEjqiZ9M51ylwbof9YdXuGdIicmzSRJOre7H
 LEeyChE3Hv6+ZcjbyZeFUMCvGIJOqOaolSdraBhCsGf8+s3+vdvQ9wF6Nz07+4jP/OnK
 8iFd40ShhcMSDjJxgtvLvI+sUxc3dIYJxNFVxMuFol6UASzgrGTTzHckTggzerfxSWpM
 kV9Q==
X-Gm-Message-State: AOAM530Ai83ZBm47IqkjK/8GRl4JFxdrckZ4L4NySLkhi+Kz5zflAlxp
 xfPBtO6d0pj7cFdIuhGhhDcrZBpGq1kZr2TtbDSOCQ+Sseo0dwMmEVlOHpwG+AWZM4f7AuYqMOp
 0KA0kRJj8rhuSC5nb/i19duFMOt4Y7IVjydYcPpX9jXyFly0ZRLh5n5hzkjBJ3G1Z40kYNcnKRe
 dp6w==
X-Received: by 2002:aa7:8ac1:0:b029:19d:beff:4e0f with SMTP id
 b1-20020aa78ac10000b029019dbeff4e0fmr12861636pfd.0.1607304290561; 
 Sun, 06 Dec 2020 17:24:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy76aU9QSvKxeU7JwVnF91LA80bFL4tQFJSdIYpiOIleO/vCRSKgFZj3awZ33K3hPz8OuLQzQ==
X-Received: by 2002:aa7:8ac1:0:b029:19d:beff:4e0f with SMTP id
 b1-20020aa78ac10000b029019dbeff4e0fmr12861617pfd.0.1607304290238; 
 Sun, 06 Dec 2020 17:24:50 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z13sm8600202pjt.45.2020.12.06.17.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Dec 2020 17:24:49 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs: simplify try_to_claim_pcluster()
Date: Mon,  7 Dec 2020 09:23:46 +0800
Message-Id: <20201207012346.2713857-3-hsiangkao@redhat.com>
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

simplify try_to_claim_pcluster() by directly using cmpxchg() here
(the retry loop caused more overhead.) Also, move the chain loop
detection in and rename it to z_erofs_try_to_claim_pcluster().

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 51 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index edd7325570e1..b1b6cd03046f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -298,34 +298,33 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
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
@@ -370,10 +369,8 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
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

