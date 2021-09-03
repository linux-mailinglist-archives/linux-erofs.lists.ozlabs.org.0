Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D96334000AD
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jpt5rflz2yQC
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:41:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TMB2G713;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=TMB2G713; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1Jpd6dfNz2xtj
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:40:57 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d17so3318157plr.12
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AspVnwiGPtBaOxjnJDL8GyhbzUYqzReZsIbgWMyrEfw=;
 b=TMB2G713Dra8s1q93HRzmW7vv5une3XHyDfRny0K6OSa6vnwLWTv2U0IjrpEvZvxWW
 j5aqnwLHeMd+uD4jkh/rTtUE5Bky38EHxuNtimI71eDLmZdjSqHmG0+S0tyQU+6LOiyh
 S4SUe5bKK7LgLoEvFDkw/Qqje6QtyyQMsWQCOYDB+11SFBrpLbxKsYxYnH0LeFPYiV30
 VP79+KNgoIzCUiP0710nDrEgSKoapkHhS6qKANPjKPaYidE1+byCAYIE/WJNQGXYhAIY
 q3Qpe0E3micuzDzB/Ha5JZAi45N1mko2fgxJPTe5BOXQFWFujwVnccSchJPJFplBBrKr
 EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AspVnwiGPtBaOxjnJDL8GyhbzUYqzReZsIbgWMyrEfw=;
 b=iOwAzJJ5ENqqD1KFEakv1I9BhfKo43mHnf30VrcZLN4oFwpDNpxHy+abZW2nYvYPgW
 BxX0CYIkktDnd7JCHI9+z7sJ9tET9H7BrLCjy8Rqrav/XYdU4QvP172O6/phbVaEGDrd
 Fpre9KuPvYD8ghej5qQ3/NuHs7liB31e/y5WV/ly6vLFdIgBp7hekeaddSCSa2d7IdLl
 4CQXtVShVHtc+j1JFXeOnwsL8Crxd/DHO11TScJ/42WTYNZm/VQiIpFxIylHWlLbXK3p
 2T4zUXPuy1bvdrnrLkufmX/jMrwNnHH5L+YoLeeGorz4D7L/A7T5eNLLQDu6A7VeaToP
 EffQ==
X-Gm-Message-State: AOAM531vfRTa1zY/WwGxZG9xzcyvObq1sFMScGUImkge6oIivVVqup4J
 0iRUGLmKKMKaL7ORCqjEzsLW43cNHe9GXHXQ
X-Google-Smtp-Source: ABdhPJxiAvzsHCiYLXogp6DfMIxWUd95vyfr/Mz58TwneKupBl8EPmEISw4j837RVU99igoV5sakhQ==
X-Received: by 2002:a17:902:d4c9:b0:12f:6886:35db with SMTP id
 o9-20020a170902d4c900b0012f688635dbmr3293622plg.31.1630676455589; 
 Fri, 03 Sep 2021 06:40:55 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:55 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 4/6] erofs-utils: remove unnecessary codes
Date: Fri,  3 Sep 2021 21:40:33 +0800
Message-Id: <20210903134035.12507-5-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903134035.12507-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fuse/main.c | 5 +----
 lib/inode.c | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index fca4d7f..8137421 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -109,16 +109,13 @@ static struct options {
 	bool odebug;
 } fusecfg;
 
-#define OPTION(t, p)                           \
-    { t, offsetof(struct options, p), 1 }
+#define OPTION(t, p) { t, offsetof(struct options, p), 1 }
 static const struct fuse_opt option_spec[] = {
 	OPTION("--dbglevel=%u", debug_lvl),
 	OPTION("--help", show_help),
 	FUSE_OPT_END
 };
 
-#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
-
 static void usage(void)
 {
 	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
diff --git a/lib/inode.c b/lib/inode.c
index 97ee2c9..61dc802 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -677,11 +677,7 @@ out:
 		 * Don't leave DATA buffers which were written in the global
 		 * buffer list. It will make balloc() slowly.
 		 */
-#if 0
-		bh->op = &erofs_drop_directly_bhops;
-#else
 		erofs_bdrop(bh, false);
-#endif
 		inode->bh_data = NULL;
 	}
 	return 0;
-- 
2.25.1

