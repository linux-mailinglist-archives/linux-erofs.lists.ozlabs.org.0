Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EE6E05A1
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Apr 2023 05:58:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pxm5N6Wvzz3fCj
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Apr 2023 13:58:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681358296;
	bh=YJGRTZkA5BN2qD8Z6WUNMxuaviulFYl0QBBAj8i8gIc=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=GFKMYcwEo/XjpgCNe/ayp2Y7TWLo4AORaBbEiENLUWFXNMMJt8sP4iKm2gcm1usoI
	 RUh28RXWHaGB2oTXT3NwNTJwiQAtKnq0CndQvAInJXSGn3lBOAbz9NhM24wtC0qWdL
	 3gf8m4JQcfWCXAgWc86WE49teXy/ukTdW0cpCjEAiHFXLLp0c6m0w2V2XR0zSqC/rh
	 nZGZ/SwYMpjsVA3j/wPZEtdo2vBKh9cDt/cLej6fz2UmODP34WPS5zgW8vCFZexSGU
	 bfGpTMDb3E0edl/K6lUfcvU/QBv44LzMmpssenu8WF51H3Ty/qMy4j83fRisi6Gy6Q
	 zgKeCi73yX10w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XGmPAZ2R;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pxm5F4Gxlz3cKj
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Apr 2023 13:58:07 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso16915119pjs.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 20:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681358278; x=1683950278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJGRTZkA5BN2qD8Z6WUNMxuaviulFYl0QBBAj8i8gIc=;
        b=XGMW8HTeagCMhDH7haKuOor0PC0E6KLjA6NxoBQR0p4fFrmXNyzFVc50D4Zst7KbFj
         NZTLYr9TYh0uPkZ/WzQs2cCUzZu2bLOmuRD7SZZ5bbjoNobOirrwnK0NpUFdEat2xRdc
         x/RHsXmDFb/MdxUNO75pKKl97eM3h6d7acDT0NY41ENtf0KFBrLa2A1Q8cTcvaMsPtvE
         txhnk1A5HuG2ayX+xOrtA0tYtk5gTwAGeKKk6V/QqWUo+1dZ3Pgc5Iqn5lF9sHNJ+Msc
         BTbXkuYEecKezrTUWK9h4AraB+RJ2OCQ326bBlHgP59xW6X7KHsrnJlgmG9ozNe0zt14
         DD1g==
X-Gm-Message-State: AAQBX9eAHqUUzSj3WBzXdVCmCfcdBOVF0mFSrPt7Ejatcgviu9F8AiqP
	FYpaD0WJBu29J4bygiP4XrhIg09nkeYH9ZnARiA=
X-Google-Smtp-Source: AKy350buz1nbJi9w0aYjLrjuzCx8iZBAN4QoVrVRzzuA4RbJ5fv2Cy9WVoKWXwscYMK+1b1xY8oNGg==
X-Received: by 2002:a17:902:e842:b0:1a6:7570:5370 with SMTP id t2-20020a170902e84200b001a675705370mr837413plg.10.1681358277944;
        Wed, 12 Apr 2023 20:57:57 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902b08300b001a2806ae2f7sm359069plr.83.2023.04.12.20.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 20:57:57 -0700 (PDT)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: explicit cast blkaddr to u64 before shift operation
Date: Thu, 13 Apr 2023 11:57:34 +0800
Message-Id: <20230413035734.15457-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We should explicitly cast @blkaddr from u32 to u64 before the shift
operation to return the larger type.

Fixes: b1c2d99b18ff ("erofs: avoid hardcoded blocksize for subpage block support")
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index aa7f9e4f86fb..6fe9a779fa91 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -35,7 +35,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
 		  enum erofs_kmap_type type)
 {
 	struct inode *inode = buf->inode;
-	erofs_off_t offset = blkaddr << inode->i_blkbits;
+	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
-- 
2.20.1

