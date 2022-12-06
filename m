Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD185643CB6
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 06:37:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NR8Lg64w0z3bX0
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 16:37:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=l3HsB9xf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=l3HsB9xf;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NR8LZ0Xp7z2yN9
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 16:37:08 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d3so12911273plr.10
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Dec 2022 21:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQZFshjqB4wtFOz2UdJmUUSt4cp78Rg6R2ZZnizTKMg=;
        b=l3HsB9xfeGFcIIP515/iK95rBFJKDGwlVkcARHwqen0mD40gKB/Yn7NQZyMWoudwjy
         8MRXlW5s5bDKsqGU9Cak0jPqZQ1Flu0kG88Ie3Dr+ZI4glRiK1WUm47/ROQ3fBT3/bHC
         ZkOVdc+qklLxFuW924h1qsdp+RifGP3HnFdyVA8jJuqcy4YKYM10nFRXI1bg23grsl0t
         YiShF0ICEgoV3CoKI0uxzWjbHUo/H5RdG7V2Pb6WYtAlfiwcP7rFaRQ0wbPU80WkrqW3
         5OQYyLRj36leTdvt//Wj+JsMmrCk8zUsjEioanMIoDiSDsFKZz6ksGO5kTInOYW0YD6+
         oWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQZFshjqB4wtFOz2UdJmUUSt4cp78Rg6R2ZZnizTKMg=;
        b=jO6aMjgnwT7Z3wtKEVZFznNwGGYgly13hgSbo+8krmUG3NmkDNt2AN5pIeKDtFuLJF
         /gaxSsh+IUpx+dNJxarz9cS2SabOCbpA6IfmpAepqiJXujovEPWdjgFnlsevZjn5+Jgt
         z+amYPBwzOPtWd/JZddSsu+8ejl1fTuY1kHopnpPMSJLCrwzhmnL/eFSVR9JQaLodRmL
         rL6hR8J4JmVwq7e6LX7NzcG4j0fv2NJ2uDkxEfSFzwuRyKQYQsMGVcTOKx9v1IrilPqO
         EBRKhzOE4GJesgfTVqo6tXni6Y6ZJdc6OYZnq8q4AISWSBy+G3hxQCfEyerIuKvxakTD
         FThQ==
X-Gm-Message-State: ANoB5pmqxwTmfSX+n9JeJC6dmB40qM6h7VbkICPddClZM/2+U+xEUQjQ
	8wlVhhPo5doSzSOItWkhnjI=
X-Google-Smtp-Source: AA0mqf6xgrbNZcgk5sPZ4G06UTfOQd8rQ6ESvJb75FR6JtpK6sjL9G648ZUupvwyCnMBanTZOI1+pQ==
X-Received: by 2002:a17:902:e311:b0:189:c7f1:c2a1 with SMTP id q17-20020a170902e31100b00189c7f1c2a1mr13885211plc.141.1670305026035;
        Mon, 05 Dec 2022 21:37:06 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b00219feae9486sm357964pjb.7.2022.12.05.21.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 21:37:05 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix missing continue for !shouldalloc in z_erofs_bind_cache()
Date: Tue,  6 Dec 2022 13:36:33 +0800
Message-Id: <20221206053633.4251-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Do cmpxchg_relaxed() is only for successful allocation if I/O is needed.

Fixes: 69b511baa0be ("erofs: clean up cached I/O strategies")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2584a62c9d28..b66c16473273 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -333,19 +333,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			if (shouldalloc) {
-				/*
-				 * try to use cached I/O if page allocation
-				 * succeeds or fallback to in-place I/O instead
-				 * to avoid any direct reclaim.
-				 */
-				newpage = erofs_allocpage(pagepool, gfp);
-				if (!newpage)
-					continue;
-				set_page_private(newpage,
-						 Z_EROFS_PREALLOCATED_PAGE);
-				t = tag_compressed_page_justfound(newpage);
-			}
+			if (!shouldalloc)
+				continue;
+
+			/*
+			 * try to use cached I/O if page allocation
+			 * succeeds or fallback to in-place I/O instead
+			 * to avoid any direct reclaim.
+			 */
+			newpage = erofs_allocpage(pagepool, gfp);
+			if (!newpage)
+				continue;
+			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			t = tag_compressed_page_justfound(newpage);
 		}
 
 		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
-- 
2.17.1

