Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E65BA8C9
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 11:00:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTSh26G7qz3byL
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 19:00:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vFU4rf8G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vFU4rf8G;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTSgw2jqDz2xH9
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 18:59:56 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id ge9so8902768pjb.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=vFU4rf8Go70F6Q5X1St4eoonyTDWg0bIGM7mlqkuUZSogR+IJq4axzKODFz8sKnu+n
         YXiBN0DBk244rf8gX4Pe+VpbkyIgpV5XBYq6grMrBPmXNl7XOL6g42xvhAltH35m8y3B
         PEze6Qe5vtcJiwsiQ6i0Fwkbc5xrFbMhe51gR3C/M9DiX5e28ek/y5voCR2eiqRCT7Ce
         iy4NsthMJdE38uXD0cSiy17Z+pQWTjcYUK90Wo/KID82AjnQt6nJOgtVLo20QXsl8H8B
         006JBPs9LcPf9RPdCnxagYlGfECHalGz3iZumnvCzQIeX4R3JXpezCdP6mPqHmSmPLV8
         9F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=AlZ260khjaiRGo0FNvXwuNB9mKGEE3B1p4nHMLLnv+sgcJRx0CSq7+sIQwj3+7jkz7
         WCX04ToxwG8G+jEHmT+MBwVBGhOfnb8iXohFKZrcb6A/FBIhNNZM0MSeUPik5q00xzj5
         7k8hz1b8TrUrH/9wyBJlP9BEgvuwWdyd8HALXRViUrzQAXxdPVi+VDuCVeUxmgU9HxR6
         41zvqawh42xRk9TkclaRuGfjHxtY7VJZJq2HUYJnVw0GJPvn8zFZfAZs4KbNgks5MRAS
         IyjTy5hGWak3wKFgACTBTYJ67INLA7YJrrGPx62zC8zvhXUya7TfrEH2x2qEM+0PKk7l
         9Bvg==
X-Gm-Message-State: ACrzQf3LLt8FSjPO/4D8cLGr6icEgN+iY4d3tyXpO1JA/SoRUNOw6Dl1
	6sZYKNBz8wFrcbJ7bExLa0PxH62ezm/MYQ==
X-Google-Smtp-Source: AMsMyM6hd0dG/05ihh0iero8Ff6OfWyMy5mKWwGelHEQgvTGQO/e5EafWIcjvBuL0O1Y2ErsLvgxlA==
X-Received: by 2002:a17:902:d70e:b0:178:2d9d:ba7b with SMTP id w14-20020a170902d70e00b001782d9dba7bmr3776799ply.90.1663318794120;
        Fri, 16 Sep 2022 01:59:54 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:59:53 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V5 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date: Fri, 16 Sep 2022 16:59:35 +0800
Message-Id: <20220916085940.89392-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
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

