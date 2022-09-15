Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769335B9B23
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 14:42:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSxgR00cFz3bqn
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 22:42:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=et8SUZfo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=et8SUZfo;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSxgG6Hxkz2xJD
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 22:42:34 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id l10so18211511plb.10
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=et8SUZfoNeMLnBl0MYEBpYeDFeu37dGfFrRRjQ3AaSxd8mtSowHWfpGGv23g3PclEl
         rgBoVJGjypKu0gzrIGPI32O/YAaVP3IBo2CqI3GwpG50VYJCT/VLn/PefDTSP4ScGOeV
         8gw76ga6vh3F0wTgV/EJQOyXCnDggxUUWVUSahI18DNxw3/pIw+4CYWKjOJdgx/RcVFw
         njw6xSqeSSHJlZIjWtf+8vvHJiTjTyOwuj4vJOpIU8M+1LOlig0Mc60vsGYkEYADlGgJ
         BIzUJSej46PeT0PMCaFJFwlU4nASJaiHY5B42BznFYhPOAqMqaQK1C5O2MQk/8bS78i6
         RbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=ww8LTWXQDcV/KbX7+7M2EKXKAS5Hw0zHy0x0LtVUptBegOUasr01ZmSPZqRJoa3osg
         GgIrp5A/cEDBAOXC/k8SQA4H8GITjwkSfqU7PXbBGeVouYB0qgrz1J1cyupC6V6sqkY5
         JXz2F6Km/wJQgJ26hM0MuMyP9/ipbsVvzlTh4s4QJgsJ3BakAHyJQjkpV7Bh4+ycz+H5
         GNbw+huTsBc+bTQvJQo/p2MnWUPOfrakhyWbeHwc/WaphEitLpX5ZLyJvb9LSd2XiIb2
         tmIDHTOi6R6tRT4otIt74ost81LLKs/ngyakX5gGVvsZxESsAsVUnh2yTO0EbU8gvaSW
         2r0w==
X-Gm-Message-State: ACrzQf3ja5ahUQFbxLU1xoErmd1HapohVfk785kcjBr1775naQF5VUEJ
	QoiHhlNMpfayofEBWaBCpIYxUqpcjtfieg==
X-Google-Smtp-Source: AMsMyM6L9o52U6lZPoVzHgkmu9KCrPUsx4XZmvaJZ+/KCAxjWxbWhbI2BTZHjNqBttWAXeWa68I2HQ==
X-Received: by 2002:a17:90a:db8b:b0:203:1de7:eaaf with SMTP id h11-20020a17090adb8b00b002031de7eaafmr8232679pjv.168.1663245752797;
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V4 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date: Thu, 15 Sep 2022 20:42:08 +0800
Message-Id: <20220915124213.25767-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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

