Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6FB3FCBD8
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 18:51:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzYBD1Cgtz2yJQ
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 02:51:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=eOHU/sez;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eOHU/sez; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzYB22HxQz2yK7
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 02:51:38 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id u6so14821125pfi.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q0/mcmtboeI2e6pFDHSBwyPINbN8HQeVavBH9wBztbY=;
 b=eOHU/sezPHDw+3ASkw1Tj6CoFuAVCDrV4swH2XnRyVkATBKb3mTaiSsv9II3/7Kuri
 PahvVYgeZy1IQa/JTnXo+zx3r1gYI47E3/HGbahjB6Ui4Iz9zGWMRg6W6CXjaMMwTsUk
 jl+zimIIiXar3B9ATd4y1TAIHFVyXWD2VCjsHcVQWqIInCaEJotVeApV866GRtonkrs+
 3//IRsvCIkZSfqKip27mskygafQUJLB4oKkd3xHmgDZ8HDadERiWHvl7wU8Gu3e2h4dZ
 2JtCxyhkm2oX3Qctqu+Qdpjo45w1mY/bUPZOm7CcjioMBaV4Wcynppp2EvAsSI/iDRs3
 GcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q0/mcmtboeI2e6pFDHSBwyPINbN8HQeVavBH9wBztbY=;
 b=IeHHSDsFUoSO9auJAFhjEpZNgAf20qM6QRkTR3zEatVtj2+RGS6JUYcTRPixe8aKUl
 yw8WhfJ2sy5O5iSIBI7eBeIW5NtwXgV9pBaRZ68SvHlMcqL1c73zhp6WPNO+pqRGBqo4
 EY6SxkNe9cxVm9rCVdTp6WPczASDuBaFY/NvM91WpIZfcrZL9OFFj+IF89L7wvl7xwVK
 lwfsox6rqugDZwWvtBrdrhKKp24WJYONgYKOZfRy+4+e8Ynr7chFbRbajNB+KWRYJ632
 fFeg2Usm00fAEpKz1x25Paxjy7MxRKCTe1HiJ4Z0yRom8LK3Le3NlmDRfbmgD87+Cy2/
 Iahg==
X-Gm-Message-State: AOAM531cJjPT40XcXUXFHR8i1ZZeWaeZyJb2duAmv235kNBY7RtTnK7K
 zwOklSF0afKiEa+3lVYw1rHU1z+OO0bjtg==
X-Google-Smtp-Source: ABdhPJxUE6y5Y7X8aVYfbGvowo9PTMlnLVROXZFPUaXc3k3NfQLc0+bmw7oi7/bBM/FViFbDaCChxg==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr27691853pgs.450.1630428695662; 
 Tue, 31 Aug 2021 09:51:35 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id u6sm20697487pgr.3.2021.08.31.09.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:51:35 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: fix print style
Date: Wed,  1 Sep 2021 00:51:16 +0800
Message-Id: <20210831165116.16575-6-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831165116.16575-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
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
index f001016..76f5fb3 100644
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
index 88da515..e4306ce 100644
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

