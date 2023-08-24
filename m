Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2807865F4
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 05:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1692848691;
	bh=lY6Vi/2E/8aKoDMoFhdgeDuzJGEBhcHcwJKxLN5aRm4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=c/xcJH6MG3KhS3K/32mw5unyX4JzdoIzcTR6LJpjkF+tLh+jAiPmtv+rYOZwMq2TW
	 /9l9nlEvHU7eJeKjYX5pXFsF03QrCmayzoAQYxfgKJxDAMV9oYxMpIJclfV6ws+lmj
	 +Pz5fht+lJXPAu5xxZ7AzUf0ODySvlkBdvk+6l/YQZ4/YnsalseVCeNurqjJTnDXJo
	 S9NW3ImXAWbu+94gVY5Qp/uHtyiHCGDJtvVCyREpI1Fs7BXhkLXVJ/EgE+ZnucVx7L
	 dhyRrJUc8ydVOzp9+AR7dhyKdyjF9wW4x+1unGMr9BeHEHyCVvUPz65NTnnoA3pHOP
	 x0OzWDZSpOCNw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RWTVW6gv6z3c5K
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 13:44:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gHtaEy0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RWTVP0lWrz2xdl
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 13:44:43 +1000 (AEST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a86b1114ceso349122b6e.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 20:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848681; x=1693453481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY6Vi/2E/8aKoDMoFhdgeDuzJGEBhcHcwJKxLN5aRm4=;
        b=Lu6tFaujtahKK3t2EP5wj6Sx5/XaJLDaZGQ5WuCoCQAvokoZKYWYi1dwd9fEZwRO5s
         wGwtmsG1Po8Ee03oueRZ44XS2FZTL7I083QideQNEGZxL3CB6nLvh/hcM8AcpUfqr/FC
         9nURxZKH6xMi0aQn7eNOoTCxs77k3+csAAdDDhnRpSlxeNONSEdw+vCJpNA9aQEc2JgP
         R0N0rXX5+inMWRK4q1dnmLyfzU4KJTf6r0fqAwQbelL+13BIc2YHN5YI+Zg7FyupAofP
         qIu8yeOE6Z9fYjhQ0jPD3fRVaqeXDR7GduXN/nYQhS4He7zHUOSV6uDbfu+Q1Z8ZKy8z
         Il3w==
X-Gm-Message-State: AOJu0Yzr2JCP/RI85WrQPG1GrE2yT/9gHVErBRgo5c9jmYIxkEl/ihsV
	UAdSIonzhUl/jDk14xfg1UGNzQ==
X-Google-Smtp-Source: AGHT+IGSn8aXVXktFOZZa/BcVGbtb8f6zEZDLrwOYj68DXtiQe8FLStK6m/pgQCqQbi7Z2XDHrDQOQ==
X-Received: by 2002:a05:6808:30a7:b0:3a7:2eb4:ce04 with SMTP id bl39-20020a05680830a700b003a72eb4ce04mr17475307oib.5.1692848680931;
        Wed, 23 Aug 2023 20:44:40 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:40 -0700 (PDT)
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev
Subject: [PATCH v5 06/45] erofs: dynamically allocate the erofs-shrinker
Date: Thu, 24 Aug 2023 11:42:25 +0800
Message-Id: <20230824034304.37411-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, Yue Hu <huyue2@coolpad.com>, Muchun Song <songmuchun@bytedance.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Yue Hu <huyue2@coolpad.com>
CC: Jeffle Xu <jefflexu@linux.alibaba.com>
CC: linux-erofs@lists.ozlabs.org
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..6e1a828e6ca3 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2

