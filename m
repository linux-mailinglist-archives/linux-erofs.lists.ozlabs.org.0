Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D3A148A7
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2019 13:01:24 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yKYG2x3vzDqJY
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2019 21:01:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=cgxu519@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWAMaHP4"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yKY81bGjzDqJR
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2019 21:01:12 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id z3so2577897pgp.8
 for <linux-erofs@lists.ozlabs.org>; Mon, 06 May 2019 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=lBhMQf9WfctyA18+FKpwIs/LesJY2H8xeQq9IW9wI0w=;
 b=iWAMaHP4U2dioYF5mGVHCZufaJvfUjtiHdN/f1U4fpRgcRj9pN9keXpVFb7TptS12n
 1+vGUGrsYekiPNnJGsrX6AWGfwRikgxgfyQjZqVLO2jgZ2MA+qCy47bQanuDYdi0Wz9U
 3AGNxB31pZr/Zn4R9Co3AD45CCj6UzdBL09V2pUpY2mVZHkOnaHElFWNsdaPwcidMQ+D
 l/OCfBnyyQLZKXVX6U8EpbabV66BqgvfEWHVXCPyWZGEO3h7tC+WF9M/VvV2Uws+YysM
 f3ShB1nQGt62WeWPS3QJmCgnB+WYYMgy6U28rpui4TeLoBz28tzcmJKrekj/KOXMZ1ZB
 OfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lBhMQf9WfctyA18+FKpwIs/LesJY2H8xeQq9IW9wI0w=;
 b=PsIslOq9P76AccTjoNVVvF2+AaBDcl5kigzDjH59wzn1XdFquwxlwg5KlpUUkXHlNM
 dPQ84AceqxZaNx7T60S7QT7jtTrkOr5aVvcZcVeu6aGFgHp4H7S5dbFfKAg8v89/+NTg
 2KNtjH5KiU3VrHRxzJGeYoO0UZ3rFqyytVAy1Ve22lDtMrfrDM+KrGVNxGLSLWJkgcoA
 HqyOzfyoYBjVrZjbPdfsK8wJsFyzPQewFk0ONc0EbFqlU4Rni+I+Q9zOKfGzI6vhjc5/
 pVZq5h5xburU07SRfC6ecfLO+5OfY9+4JRaqztYEZqtVTiyvakxoCvAyuIwFXVtPWyaF
 C0Cg==
X-Gm-Message-State: APjAAAVgQfigpI3RJRvS3yK9jgikreVqQDpWqkU31LeGPB9DZHkjSup4
 iWlsmK3MPSFkBqRTgMdOeNI=
X-Google-Smtp-Source: APXvYqxQPly9DEyQH3VnDfF31DRjiJDOhUdkvaZytZKSORXy9HRsC5AkzfHjnho+hpTHgG/ftB1TRw==
X-Received: by 2002:a62:6fc6:: with SMTP id
 k189mr32067137pfc.154.1557140469155; 
 Mon, 06 May 2019 04:01:09 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
 by smtp.gmail.com with ESMTPSA id h20sm22016616pfj.40.2019.05.06.04.01.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2019 04:01:07 -0700 (PDT)
From: Chengguang Xu <cgxu519@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] staging: erofs: set sb->s_root to NULL when failing from
 __getname()
Date: Mon,  6 May 2019 19:01:02 +0800
Message-Id: <1557140462-22578-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org, Chengguang Xu <cgxu519@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Set sb->s_root to NULL when failing from __getname(),
so that we can avoid double dput and unnecessary operations
in generic_shutdown_super().

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 drivers/staging/erofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 15c784fba879..c8981662a49b 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -459,6 +459,7 @@ static int erofs_read_super(struct super_block *sb,
 	 */
 err_devname:
 	dput(sb->s_root);
+	sb->s_root = NULL;
 err_iget:
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	iput(sbi->managed_cache);
-- 
2.20.1

