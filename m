Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC95BBBA6
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 06:35:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MVZjd4rDhz305d
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 14:35:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=eVaRVfx5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=eVaRVfx5;
	dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MVZjV40XGz2xbC
	for <linux-erofs@lists.ozlabs.org>; Sun, 18 Sep 2022 14:35:08 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id v4so23909456pgi.10
        for <linux-erofs@lists.ozlabs.org>; Sat, 17 Sep 2022 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=eVaRVfx5a2MVEdsHGLTKj56DVEcrAKgua7VGnhGuCRo54sfJnqUIYr+XO+BbkdT1Zb
         91p7t3DNLn1Y10DnRA1xNP7ubPYrptiSSv2pIPQF69SV6FIJgoaI8Edoz6Ve2lI6NGO9
         I/3cXdD8eXFSUYB1836GY6jTk7pDfHZzDePuSyAF07ooCWihJS40cNU+8pY9OP1loa05
         4xK1oEcStoUp7wLXga4FUZZoX4zPkuGym5UVGGI/0YGuwaLJXhOP1nwB7FvQdY5GFOCW
         FdfyQ+JLR2Aj5TNnYdI3QtZcfxS/5ZRWv0lkwl/b1ZQKnvdGNU6XsZZ6dVIkwEPRJdUj
         +Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=Ti1e5E4DWU0Q50aVpX6H6RO/cUbI9VPoxIwm8yOO6CvWAA4l5duv6mL24FdlhBBO4p
         84Rzk0U560OvTxyn8f+UzvJRKxtk/iOXVbRVKK0KoA3bB9h4QI+pitlOeCogJpxR8zgb
         sg22dj8CNy0kABIBTrHv56JRnM+adxuHJQkn+l92vwJExeLxkp+gdhlkWSq43Rxvn1xJ
         x8aCUbVYW/yfzowq1uZLAI/Qk4ETPgU0OJ35PUKkXZOHL8fPVvarDr7bDW7dUR5I228q
         Fmvwt1fs7ScsNZV4+zRxNgRLe2zDrKK3bGLzPmweg4kUn2lvUI+VKcyB+CM84JzScZIz
         LVNg==
X-Gm-Message-State: ACrzQf0JVKmdP7lX4gq2iAq4nC4m5WcpoQyA3WOLOS1BEgnpJYCBew+c
	BFzMsBb32gE9Zwddm3jUdMruGI/nHR90W2GE
X-Google-Smtp-Source: AMsMyM76iQB6B2cNhDHRqLO41Da7t2u4Ij4woRMn+qQFywM/+pG/hclaTdhS/4IoVJYsYMH7aOEmsw==
X-Received: by 2002:a63:42c7:0:b0:438:e0dc:cc09 with SMTP id p190-20020a6342c7000000b00438e0dccc09mr10797694pga.128.1663475706078;
        Sat, 17 Sep 2022 21:35:06 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:05 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V6 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date: Sun, 18 Sep 2022 12:34:51 +0800
Message-Id: <20220918043456.147-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use kill_anon_super() instead of generic_shutdown_super() since the
mount() in erofs fscache mode uses get_tree_nodev() and associated
anon bdev needs to be freed.

Fixes: 9c0cc9c729657 ("erofs: add 'fsid' mount option")
Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..9716d355a63e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
 	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
+		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-- 
2.20.1

