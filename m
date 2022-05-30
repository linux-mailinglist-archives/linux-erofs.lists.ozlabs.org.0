Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D08C537614
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 09:54:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBSNw1MF8z30BK
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 17:54:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oOHy+1wa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=o451686892@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oOHy+1wa;
	dkim-atps=neutral
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBSNq5dLmz302N
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 17:54:34 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id t13so13458647wrg.9
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kcYg8SvftZ4Pv8K6+My0zsHrpG5RiRd2GgL3qZs2gI=;
        b=oOHy+1wa0Y1QWiyS+VCO8OYEDSfeb4P6rKwugYGCN7bpah1DiWveZ7BFpagsJ7/B5p
         OFcsrtoRriPmcS4y0Xfdrn28EYWxIU5YJq872nY+HwsO1qmuE/QtQjFI64s2uIjoTiEj
         0peNA3xx6oibsD+QlQydo71XbCH7+zX6x8zZ72Djnya0nWIeZyRmhSIZtC/AbU2/DAbZ
         05Ycpn6SQdheX229ZnQMYOcTXVVZNOTHXRjJXt6IJVLIh6Fl+CdQFhb92g0QWIJRnvF8
         K3t02JPLJ6733jL3PdmtIoU//SZXX8NcRJOXrPll3iUMbHyRhB3j/DEivj0AZzZURgyx
         feRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kcYg8SvftZ4Pv8K6+My0zsHrpG5RiRd2GgL3qZs2gI=;
        b=4QaFcTBShMWtrqPuSbo74gwnbCGmSwEl33HXIVyoeSc1EfqzSCHomBI0XTiOpUDRnF
         cXUudn5gLyUHNkElyiqVjPg9JFS1WdNHP7A5I69ovwQo3tqk4rSi+lEK3dWlg9r3eKJG
         cpjjkff2GpoczABl9WLxnUkxPqPFVwYG4mLizYrlfw1d9HR9otjavcIuiD09R+Rub7/n
         RiuNisEhD1XqT9Ud1XKq7she0uXeq2BiUoMlqBvhb5AyyCEDHCLgC/u6ZnS9/KYiTVYw
         yVD9p0ErB9ZuW/PJSGePWCA6T+Fw4uZE30Vjxk9lJBZgWa7oAvLW/3WN4aVDS0MxppcD
         gFwA==
X-Gm-Message-State: AOAM531lHHnKGse9c8PVnJfXVTcp9pA9m9lsq1P3T8tAIisL5j6Ieo3i
	/MW6EPnILKo139dJnD5w1yc=
X-Google-Smtp-Source: ABdhPJw6xnN8Iy6RqczuscjkcuqNxwqXuNH9d2cQ78QPMlE0uD4bsefwpWemYj8HuHLpLpqQB6LkUg==
X-Received: by 2002:a05:6000:2cf:b0:20d:c9f:63d0 with SMTP id o15-20020a05600002cf00b0020d0c9f63d0mr46629276wry.45.1653897269034;
        Mon, 30 May 2022 00:54:29 -0700 (PDT)
Received: from ownia.. ([103.105.48.166])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003974860e15esm10578642wms.40.2022.05.30.00.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:54:28 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: fix 'backmost' member of z_erofs_decompress_frontend
Date: Mon, 30 May 2022 15:51:14 +0800
Message-Id: <20220530075114.918874-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Weizhao Ouyang <o451686892@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.

Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 95efc127b2ba..94d2cb970644 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = COLLECT_PRIMARY_FOLLOWED }
+	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
 
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
-- 
2.34.1

