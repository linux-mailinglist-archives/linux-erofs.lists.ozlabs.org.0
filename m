Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DBD52345
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 08:08:56 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xwhj3ttSzDqRm
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 16:08:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d3lWj6IX"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XwhZ3ksXzDq9m
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 16:08:45 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id i2so8237378plt.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2019 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=d3lWj6IXIcDAT/yguocBrXBlq+VB/KlfA3Sj0FX0n/yUBGMa0oknMgTfd6XSqQud8I
 x/nMBnh93u1fkEs60DyEWWLxxxMHZDH68cY/YA/h62rhKibiwQp9661IYSy6xJfO5wzW
 n2QNTZt6kbJSwetA27czk9Ms14zJfdOfjOv+XU1eLpEwgBLoltGLUlCS3pzZotnYJjTk
 Dkv8STuoxdzTDl4wdBrKE5xsLStYkfKq0XUULaNAzr2Oxhi9x5Ah7rwneuveVQeGBjdz
 91te0zcJQ/qYubIGzM4S2t6+ZUFdFvli9Xjzelsfjr740k7mnrz5tagnrTYrQBdBYfXS
 +Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=GiMGFArtRY6bLDCHUEpIYUHtqbRFdehOt5ebCy6kBwYcdwPKWkNuxvT7xpn5K5Sv/k
 H/MbdryFa7mYvWl9KkvKUITs4g/XgSrnKXr6LTywgKV1yZ027E98UW6QcsQuDliq5kTt
 XrlRweTHhOB8oraHvirvSWOdgpJ718/MNesF/U+p37p2V8zGZ8aDVBAdbd20DAA6W34u
 jGysTsRpi8hvcwS683YtAt+Y+DsBW8wwGzBbM9wG3IVb4zOiVfN/8r9LhmnxXGhxP98W
 i6s9vLo7aQ7sccQTthC/wp1JAJUIEqH58cRhgXqfiWbYV4ymYci/a974ETtExNRRkj3h
 r7eA==
X-Gm-Message-State: APjAAAW5ZHDMi52nah5xi3r6/Y9F3ZVSF1795SpuIcMUUEFOmtHYlVEk
 BPnS3kHBu1arJ8tHV313NbY=
X-Google-Smtp-Source: APXvYqw4U34avIeQF6ED3/uEETBhMiPtCd0spEiyBFv23LHWUOVgzLeE+N0xYy0zvFW4w3zy0j+N0g==
X-Received: by 2002:a17:902:7583:: with SMTP id
 j3mr34594854pll.196.1561442922451; 
 Mon, 24 Jun 2019 23:08:42 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id 201sm18173359pfz.24.2019.06.24.23.08.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 23:08:41 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
Date: Tue, 25 Jun 2019 14:08:25 +0800
Message-Id: <20190625060825.7912-1-zbestahu@gmail.com>
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

