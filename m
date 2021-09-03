Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFC4000AE
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jpw6Vvsz2yQ0
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GutCrn4Y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531;
 helo=mail-pg1-x531.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=GutCrn4Y; dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1Jph4qT4z2yHW
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:41:00 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id n18so5545847pgm.12
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0jVjLapaSGz84ZaT85l90TijT8XaIoKV01N3fasMi4M=;
 b=GutCrn4Y4nGMN2dPDug7jTeN4xJqBjiGOriplSJJnx+cy8/cFQqaW/WFhRlUeKY2wA
 iDoqWx6Zh5OzSTOo/DgWQAL1oXSHEm2Bhijj/sEWuNDQ9b503BC6ndJnGy1GjXL5NPhS
 pdXrk+EYbPaFTXO3oUjyxs4E5egJ4Pe9Pr7j5YQVJgrc4lyZHpLBfU4CSpEmYvb/m6gf
 JhCfyna0bb3dIcE9AQ6TwWFgFutx7e2b+7j2VOxLoPZ9/tWLBeNRMT12qADlvc4buYr4
 pA9WENEfbS2ELG8bsjz0Z7esxtJ8fp2uhMQ+tpp0nheLtFuj226mCV2VOPT+icWF7Kec
 +TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0jVjLapaSGz84ZaT85l90TijT8XaIoKV01N3fasMi4M=;
 b=Yf0NMXwSMBlBNsGYYgguk15lgfMaqe7BPAubWa7cRbg1Y5OaqzwJ/mj+M4btMQRTUn
 fld7IDrDgn31duVlIZ8IMATwzGgXX226KxplwgmvSSVkXU3sQTq652wBUL7r/LlltUdu
 hohlHbVd/0fwT3udGuFWlcdjdILKPy2C0Du/2MohQmO8fU4sLLzWEMM8ym/EzNflJFBP
 s9kQkY4VfXwkczRtfTEdrtpogweQM8V2Y8sf7mNz6zCja9g9H+Ea+cjFU6uV40Oz8jEF
 rhXSgN8eVThRkSpU4mK6TJOdLVoRt5KAOlNtVuM/5nOFvOhAcYxA2/KQoIjiknO3SSah
 OI0A==
X-Gm-Message-State: AOAM532lOFuaoA9RA6KU8wygXyia7QPPfRPLeo/ZZkUSR7pdwJP0AcCf
 ZoxslIf2HcQa8g4kL8k4IzWCbokoAHHqepiR
X-Google-Smtp-Source: ABdhPJwGAWx6kDGMPG39Yl+IX3OgFQpQ0dMfRBEXZ0QI32VkE95VyvM6yomkiIC8FDZiGgRQz255JQ==
X-Received: by 2002:a63:5942:: with SMTP id j2mr3717933pgm.78.1630676457888;
 Fri, 03 Sep 2021 06:40:57 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:57 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 5/6] erofs-utils: fix print style
Date: Fri,  3 Sep 2021 21:40:34 +0800
Message-Id: <20210903134035.12507-6-jnhuang95@gmail.com>
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

Fix warning "quoted string split across lines".

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 3 +--
 lib/io.c    | 3 +--
 lib/zmap.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 61dc802..6024e8c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -741,8 +741,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
 
-	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
-		  "capabilities = 0x%" PRIx64 "\n",
+	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64 "\n",
 		  fspath, mode, uid, gid, inode->capabilities);
 
 	if (decorated)
diff --git a/lib/io.c b/lib/io.c
index b053137..620cb9c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -242,8 +242,7 @@ int dev_read(void *buf, u64 offset, size_t len)
 	}
 	if (offset >= erofs_devsz || len > erofs_devsz ||
 	    offset > erofs_devsz - len) {
-		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
-			  "the end of device(%" PRIu64 ").",
+		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
 			  offset, len, erofs_devsz);
 		return -EINVAL;
 	}
diff --git a/lib/zmap.c b/lib/zmap.c
index fdc84af..ce79601 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -57,8 +57,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(
-"big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
-- 
2.25.1

