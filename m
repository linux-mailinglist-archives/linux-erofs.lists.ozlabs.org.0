Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B440B5AA68B
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkR03pp2z301Y
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wdHIrpiS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wdHIrpiS;
	dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkQw64Dhz305M
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:24 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id bh13so887057pgb.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=29yigyMnPFGfDuD40Y83IOfvtDsC8VAK42q+yJUeUxw=;
        b=wdHIrpiSaBhjfQbqOd+Abr+Z7iAWnqTitm0NuSsGbPvaDveHA3TOCmzxpCEaxURIvn
         c4v4b8cLleHbAaCx7Pp/bxts1GEAxe61h0wmVCp0UPzqOM/w+wQyPhrW0zLkYq9qOBhf
         Yok1Z6ryVNgeKydsYzrzE2f1+QcKwwUjY0epN8bEV51Gn2fpLpHQ5fimRpaiotKtRmmS
         FaM2mEHm+hrTaNF9ek8tH40G1HIcPI1MV66GhzrFLYX1/3JVfh0AvFmLGjG/Nj71ugoc
         m4u9opqkr/kAkUKl65Ljw2aEOhQShGIYtP46EA3cAzRgwQx/ME02xiOMWu6+NuZVKe1l
         UEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=29yigyMnPFGfDuD40Y83IOfvtDsC8VAK42q+yJUeUxw=;
        b=pSOVu/3IA4iJuyqxKR0K/uudv0A4HkUq5Ch2hXHSHuizDa1pKGq8NEK0kOu0EPTRU4
         7KWchtpOPvCLyirx1MeYlGLc8A14QE57OJZwX6ydi+VTr5heexJAGc2TfZqiDWHPdseL
         yytYRnxye65UnLKpdNOrKhRKJJyDWpvU9GCfvHR6BURaE4Y+4X1tVCEoDBwcrbVIPiGL
         kLqv9Z370qZekf74hSmpK8FOO72fKp/US/ar+/cbFR4jP6n7XjydtGHW/C5weFB24pR7
         221HGaf0IV9tJS+oih59+WsbA3A5S3HqutZN+a/a3dtFJEd2F5M5emoRlhWv1q66X1eH
         xabw==
X-Gm-Message-State: ACgBeo22ClSV3PTutWSQqf1gplltD+BtWNDHNHV4F17BvsUSu+3tIo0e
	y3OdmeOee0WMS3KfQXxfBpdQrXqlFqpnPA==
X-Google-Smtp-Source: AA6agR6fClfcvJYshTe0TrLdO6pfsgDgdl3xFTGMsK3VFTkr/Loa612tx9QqfoxFg/OHj7mTD7JQeA==
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id bo15-20020a056a000e8f00b00536c98e8307mr34362687pfb.73.1662090504153;
        Thu, 01 Sep 2022 20:48:24 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:23 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 4/5] erofs: remove duplicated unregister_cookie
Date: Fri,  2 Sep 2022 11:47:47 +0800
Message-Id: <20220902034748.60868-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In erofs umount scenario, erofs_fscache_unregister_cookie() is called
twice in kill_sb() and put_super().

It works for original semantics, cause 'ctx' will be set to NULL in
put_super() and will not be unregister again in kill_sb().
However, in shared domain scenario, we use refcount to maintain the
lifecycle of cookie. Unregister the cookie twice will cause it to be
released early.

For the above reasons, this patch removes duplicate unregister_cookie
and move fscache_unregister_* before shotdown_super() to prevent busy
inode(ctx->inode) when umount.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index a3ff87e45f2c..05dc83b25da3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -920,19 +920,20 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_litter_super(sb);
 		return;
 	}
-	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
-	else
-		kill_block_super(sb);
-
 	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
 
+	if (erofs_is_fscache_mode(sb)) {
+		erofs_fscache_unregister_cookie(&sbi->s_fscache);
+		erofs_fscache_unregister_fs(sb);
+		generic_shutdown_super(sb);
+	} else {
+		kill_block_super(sb);
+	}
+
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
-	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
 	kfree(sbi->opt.domain_id);
 	kfree(sbi);
@@ -952,7 +953,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 struct file_system_type erofs_fs_type = {
-- 
2.20.1

