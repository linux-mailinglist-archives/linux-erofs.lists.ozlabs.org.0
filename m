Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A7363F8A
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 12:26:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP2zl0m1Mz2xYc
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 20:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=uUoDcp6h;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=uUoDcp6h; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP2zj2H8Zz2xYc
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 20:26:40 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id
 y22-20020a17090a8b16b0290150ae1a6d2bso1335725pjn.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SsoScbFAcL8FkdE1UMldI0OlgZNvmlvhjr8KfKtHYxc=;
 b=uUoDcp6hF+0v+R0ZBgrJ7v5vFkvGh7/VVrhSd86/pHSkdM5wKbx8eQBWVYLcZjsAL5
 8zf55yayHfyaBhzKaI6aFTTQ+5xq5nxLvaO3S1oRwu6dsfMCJ70Zc5pxML6UFpv9lBVm
 zxDwVeO+8oY1E3JTMIsn7GhMP3TAB03O0AVekBG/skpEyPLRK0liOqjo1UonCn+Kmrqw
 tF/tTMolIgh2obz7DkXO34+7VXDEIHcE90atb0BXald4I9Knl5djn6h9ZzBircvxs3Ns
 m8AmNgJB/4/5XGyTsObDTZ7XZE1kJT6iaTjCVBA4jzXvyoqYpIc3LdZWAxF4zY8SkB1w
 jHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SsoScbFAcL8FkdE1UMldI0OlgZNvmlvhjr8KfKtHYxc=;
 b=lQD0wvC48Lqy5rlC+FwnLnpegtq2ZfTCk9fA8tSPQjaKxzQWftzp8IAf8I7WqOuzz8
 jYX9sbzDK7sMAvqLnx7MTbzIZwkOqU3T9pps2DDlzLXepBtpi6DTzTK6bycuzCJCkaji
 yCfIgkMt41r6MAFGE75bE2Qky/zJBJnlBpLEP+Gam2iZuTXIXhJzRWIYWUkjbpz1jhOm
 xCYlxv2ltlyqNiQ1wfuV1jrVVQkwNv64uDkriJRkMKR4k3hJWFY8rzhGwnc6OkkOJXnS
 g4aTBB8k+yhimhSUvCVlFUWfei0dTlmh08WdkwLyqLW8K7AjnG+cM4dQhxo6pg4spU82
 iXkQ==
X-Gm-Message-State: AOAM533jsH1JaNoHT+J8kBBvyyd5iD9ag+wOShqio72m2sEQc+yqIciW
 sfHmwsXhO6UVR8aGtPMrpz8=
X-Google-Smtp-Source: ABdhPJwgPQ550Z+Hyob0M75sEMzQ/vZLHdvZddWMMNCk4umzDWS51pOfGBFC9adQM/njCkn/WTcMYA==
X-Received: by 2002:a17:90a:d707:: with SMTP id
 y7mr24966563pju.50.1618827995421; 
 Mon, 19 Apr 2021 03:26:35 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id o8sm15164516pjh.20.2021.04.19.03.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Apr 2021 03:26:34 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()
Date: Mon, 19 Apr 2021 18:26:23 +0800
Message-Id: <20210419102623.2015-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

No any behavior to variable occupied in z_erofs_attach_page() which
is only caller to z_erofs_pagevec_enqueue().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zdata.c | 4 +---
 fs/erofs/zpvec.h | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3851e1a..e9231da 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -298,7 +298,6 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 			       enum z_erofs_page_type type)
 {
 	int ret;
-	bool occupied;
 
 	/* give priority for inplaceio */
 	if (clt->mode >= COLLECT_PRIMARY &&
@@ -306,8 +305,7 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
-	ret = z_erofs_pagevec_enqueue(&clt->vector,
-				      page, type, &occupied);
+	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
 	clt->cl->vcnt += (unsigned int)ret;
 
 	return ret ? 0 : -EAGAIN;
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
index 1d67cbd..95a6207 100644
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -107,10 +107,8 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
 
 static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 					   struct page *page,
-					   enum z_erofs_page_type type,
-					   bool *occupied)
+					   enum z_erofs_page_type type)
 {
-	*occupied = false;
 	if (!ctor->next && type)
 		if (ctor->index + 1 == ctor->nr)
 			return false;
@@ -125,7 +123,6 @@ static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 	/* should remind that collector->next never equal to 1, 2 */
 	if (type == (uintptr_t)ctor->next) {
 		ctor->next = page;
-		*occupied = true;
 	}
 	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
 	return true;
-- 
1.9.1

