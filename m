Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C619F5AACE0
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 12:54:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJvtc4S1kz309f
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 20:54:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=kbfzT2ZC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=kbfzT2ZC;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJvtW5BBtz306K
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 20:54:27 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id f24so1517946plr.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Sep 2022 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AuN/fB7WFgyGdRo1r9YkRNBbxG011D/UvehVb1XsFR8=;
        b=kbfzT2ZCnk1BzCZUOZaSAPZHcn9bDeZoIcCQhUlUv1pniGRGW5nNiT5GTdes8JMaV3
         Y95kFlCTrSr2u/ho8LKBpM7nw0xPrCdk5y+RnYRy4rVkIvtbQBJe18GV3ATAHVdkwr6g
         jSlOLST7OCNNH/NBnvg2ORdfU6UIClzGfrTGx0ck4MdCrOdafFpH5+xU1lxMWQDU5H5b
         OZgJCmeJ4kGZJg7H4rvp49s+pALBQsNpqQWYlWdSYYyp6YhHMq6twrHzRoJROmbqq3KU
         iKyDIr8yonTBNEgRk4efSFsvao3qAC2QRKQTyK1/UMwBaOQJAAYjeuDvjBaLxNRXe0mX
         eJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AuN/fB7WFgyGdRo1r9YkRNBbxG011D/UvehVb1XsFR8=;
        b=VPCU8zrEJaG+Tbvruu5xH6MXeh86wq86vWZpsy3DqFyN2e9uwVr0V9p98FIFwSPvnm
         esxYgxMUFvI0uYf0Ag63NF0hLUu2MxCAPVP2i/SuU27BXwxm4ittzOKXGKR4+fbSFxVN
         gfHADtGd/VbF72HRzhSQBSihlc5v9r/FKe9VgGJ5M6EY3xauZM0r//yzCCe7RFD85g9r
         i08exuY+2I4Sf4rEjwulN2HfazWkkMBFHBi+1xLw4b1j7klE+R4ZGgbKUZmMfrWBUsB9
         lbOVUqyZ/7AyQ9vJRbAsaUYJagEh3wTJyZb+Jo96/Tx9hPXmv3eqPrQdG2P6Yk0Nsnrz
         2CEg==
X-Gm-Message-State: ACgBeo1KuPA9JEGyN4r4w0jehYl0tgEQgcAcjOlpGLHtrlUf4Utva0mP
	MJU5dovgJqWcprf3+pBeeo3q9HSx61KdTg==
X-Google-Smtp-Source: AA6agR6QGCXjeNASveGGnc4rOolzyZrMO6wMXa37BzI3m3bNUn3hb0Yu28Yt2LmUN5gFf7V7aMdZ9A==
X-Received: by 2002:a17:90b:4aca:b0:1fe:686:fbf3 with SMTP id mh10-20020a17090b4aca00b001fe0686fbf3mr4194388pjb.174.1662116066994;
        Fri, 02 Sep 2022 03:54:26 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:26 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V2 4/5] erofs: remove duplicated unregister_cookie
Date: Fri,  2 Sep 2022 18:53:04 +0800
Message-Id: <20220902105305.79687-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
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
index 69de1731f454..667a78f0ee70 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
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
@@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 struct file_system_type erofs_fs_type = {
-- 
2.20.1

