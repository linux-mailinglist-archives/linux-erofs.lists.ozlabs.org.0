Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A663E5235F
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 08:15:12 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xwqy1GzHzDqP4
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 16:15:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GB2C+6Iy"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Xwqr1j9lzDqN6
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 16:15:03 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id z19so5443199pgl.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2019 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=GB2C+6IyBF0AfUIcPBtEa6XzESVQHX4NcOYKxbAq/KgYNkY4qgCGCwqCZ+AKjjKQ2g
 xFiWWFgVw5z4aB2GIElx9yGoWxMqo5L01oFhDGBBlyARXy/2To9lLxBExT6rls6XPFzn
 nT0wGMvwbE3HxyKqtg64uoHj4seArwAmI514GT39qBXb4liGtB15gz7cKcRrTg8V1DC3
 jtjPWq7h5+AihNnbR9uPk7alFIu5bT64+RwvxuBPQ1JdFyGaE62eIJOHHAGtjc2p9lYN
 pEHbgzGZ+CP7U3DLlx2JuSzHeCiLpjtDWbGd5cIiarFOrhV7GGA7n/2BnVn3guWdWNuO
 WeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=Na8uNr1d8oiaeE+eEvP0Wx8o0C3b9i3peUU96VhKGNewrdn0X6VBexHBzN8LvlYV/z
 rglPLfvdN6QJb4/jSI0NYB3vi4z4GzZyY1l73p1Hq1WhPMBXTTV/+o5arO4jX/FpVRln
 iKRMiIRktNdefpCuEshncGsfZtTF55yxganJgiWP1Xdk8E4wd5VvwxgXD/NDwA0qFcJn
 UwU2ExwnVAg3FojuSsNRIM1WBv82ToqaDhb5n5xajnnVbAd9DE2t2tbXPdBBdEyXsHvu
 Kz23NzJPknB7PHGJ27iBKymF/hJe69bgZdrXHDEWu+MBz78UwXPdxHNtgnRJZg4k7tIl
 u5Rg==
X-Gm-Message-State: APjAAAUAX7YEmviTGE2h5SAZb6DyKSvZ2146vhlUgQaKJKwmkQ4VJGTp
 VYmkUDs6T2U1zs8/0pMRVzM=
X-Google-Smtp-Source: APXvYqyybuAVWv+7L6aYrebEN/lOJeqrrXgjO1fvdb5hgKUf60UHInpSkfahk4D+zHtSsonPHgwchA==
X-Received: by 2002:a17:90a:e397:: with SMTP id
 b23mr29396600pjz.140.1561443300090; 
 Mon, 24 Jun 2019 23:15:00 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id p15sm2584748pjf.27.2019.06.24.23.14.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 23:14:59 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
Date: Tue, 25 Jun 2019 14:14:31 +0800
Message-Id: <20190625061431.3964-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1

