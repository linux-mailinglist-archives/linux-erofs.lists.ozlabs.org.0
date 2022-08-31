Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54805A7D61
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 14:32:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MHk8P45MJz3c25
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 22:32:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cxa4WizI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cxa4WizI;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MHk8M3RlWz3c2v
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 22:32:19 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id y29so10194679pfq.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WugVPm8FmMPSaptmZMd5rqlv9lrGBWi6vcJNH+GONqA=;
        b=cxa4WizIxSVztAOwqS3p1vrzdIohGVelZD28GH/iej9ofpHRtLhH1cBA7X33awv5uL
         cFbWTqJtHS0Nf3ytkXuWXvIDZ+W16F2s0SE8uFO9WVsGt50aUgRrJIBTookyKK+4z1MW
         0VEh5Dk0odizW6XMn74eGMUNmoShini6IWqHJLKN6srUVYkbwqxwTmyWY2QiAhFqx6sK
         QyeLRjRDBbnWDoqGWc0Rq9qmFsmAYsOFrpD2C9KiY+Sc/r3L+j2NXv2UVz4WP06MBEVV
         0ZysMKgu4nNPNXs18LTsjU9MH3CrPsS1YZFjizFTKYkAIgl20QxwLTeLRSxnx2ob+Tyb
         lC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WugVPm8FmMPSaptmZMd5rqlv9lrGBWi6vcJNH+GONqA=;
        b=v+xBkVYg7FK6HDHEr6VTflweDM7kfIW6u+QMwnb+EE8ND6yujIIYOVbEzTaWyD0FcK
         TzZkF/ObNnGoJv3d935wT5tfG1UzK8X7TYEAYe71og9Omfwp1qmjheSoylBeuLgmYPER
         bkiYPOQegZKlFLtIZeeVNK7a4N7kbQCuq7R0879JgxRx7U0uS7vM5GBtoWishXEw2eAJ
         6XFfWleh5PHp8nYc3Khk/SYzlTVaIi4D+PuRvqGbQKuSAxB4r4HNgles7Q4XAX7ehd1C
         YeRKCHS9CsVDIhsKLZbVlAT+4lmoYig/X3YOfWoN1fPCIvjSGN0kWKeIdr0/ql+FsYGv
         M3WA==
X-Gm-Message-State: ACgBeo33ffiH4h7TED0fewMUBW16WkZG6baq7STCpwGKTrRRL+6k0Qcb
	CDXUvgFOB6Q1WSWrwz56xi1qGsihf+QD5Q==
X-Google-Smtp-Source: AA6agR48GQvGj6dIP4ogw1z7Eg1rCQiwWE1zxsQ+xnXMrG9ghr/pZ2SUlTyFcCm74OOggxXrTFGE9A==
X-Received: by 2002:a05:6a00:228a:b0:538:47a7:706 with SMTP id f10-20020a056a00228a00b0053847a70706mr13569032pfe.62.1661949136951;
        Wed, 31 Aug 2022 05:32:16 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:16 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH 4/5] erofs: remove duplicated unregister_cookie
Date: Wed, 31 Aug 2022 20:31:24 +0800
Message-Id: <20220831123125.68693-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
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

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 55d2343c18a4..bbc63b7d546c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -929,7 +929,6 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.20.1

