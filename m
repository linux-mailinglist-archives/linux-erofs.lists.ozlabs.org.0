Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236456752
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 13:00:59 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Yg7D1ncRzDqXW
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 21:00:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rBDF2Ibh"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Yg7657NgzDqWy
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 21:00:49 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id e5so1233862pls.13
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=VdhU2ks81jo9UrjXZOm8gn8RMZx/sg7VdDnqoRepyqE=;
 b=rBDF2IbhJqsbejWYMTlxvc33psvRPXREmLlH1kdj1sffS2GEpRGBd/3KU+XhYKueKo
 X+EQyfMddlzhcC9Tl0wzQORvQ1bW66K6b0gsa9wt3R6/H1Axhm8w2kKwnFbpwFlcOdvz
 6tRlrliU4HwUEcR9KZQ09pXc+vpCSgC2wdEePTtVVRRSlKeQQ5s81RkbDssKTwnhZneg
 ct0dmSY17I3QbZ/5SUFm/H3tyoEyMLNhw2PFHI+ZNJscDX4J3xybD9YWMs9gYK+2Op7/
 en73nUmQ3xiIIGmzxayHgcccJ8POvkUb5YkUA2t14LWTKWYmjBgHKbXO17UO+1IBF+8j
 MZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VdhU2ks81jo9UrjXZOm8gn8RMZx/sg7VdDnqoRepyqE=;
 b=mKWXSdfqRN1VdlgUyjSXVSn1xZUXT16HJEiDR3Emnt/fVL5IpGDP8Rxz+osHJlx5if
 dt3HTRKjAy8jodSj4Crh/ArwUqn8NcgDRN7E2R/+ipcdSemKtcdbhgoGeeLX+FjDrmCB
 BZ9CGMA3NUgGhseEv3VTIAcKwNJpKgVtj3eLziWizpcIZ4QB1eSSBh5t1UdesAAaNJKO
 4HxzH9wFBGVHXD3MwhtmU9S+P8hJeelm/CMGXWSu7c/kx5/dJTj7CUl8gm7V8kMkQFFz
 cOceutPjrrQF+Afp4o/dIMxwXCQXmGj/xKduNZoB9oLc4ApDuAhPyPyzyNfkKVFDS2xl
 eLKA==
X-Gm-Message-State: APjAAAXE/jBfVVSlLH0Bi55lAiwQ7yJNa80Sn7fKq1q7enVXKpZcvS8Q
 tjv3NIvpWL62mb68ZJlXQns=
X-Google-Smtp-Source: APXvYqzBd85hjMi95y7wvZswP72zOfwbAYxL/u39AlDoY64MjcDYg9no5lCwuw6Hum4qX/JCV/hAtQ==
X-Received: by 2002:a17:902:542:: with SMTP id 60mr4831596plf.68.1561546846595; 
 Wed, 26 Jun 2019 04:00:46 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id w187sm19008873pfb.4.2019.06.26.04.00.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 04:00:45 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND v2] staging: erofs: remove unsupported ->datamode check
 in fill_inline_data()
Date: Wed, 26 Jun 2019 19:00:32 +0800
Message-Id: <20190626110032.3688-1-zbestahu@gmail.com>
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
v2: add tags.

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

