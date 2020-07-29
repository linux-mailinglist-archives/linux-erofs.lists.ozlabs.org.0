Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C823244D
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jul 2020 20:03:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BH1ck3SsqzDqnF
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jul 2020 04:03:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=JQWwtUen; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQWwtUen; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BH1cZ2rjJzDqmj
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jul 2020 04:03:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596045802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=yPxwBGHvqALkfsrQrrIYpsq7hoQPI6RVBDt+ux1gexE=;
 b=JQWwtUenFdw7jabC0KldUDsdX/rhqjKd+bKpMEWVU70laNIKOqzFxx8gul9zkAIh8+Sdxx
 cGcYhkyxZQ0Ydgg+3bWgj2CtkO0n8oQvE2Fsk7I6p3ioFnJuJawynwS53K94x8lXA6LAWo
 0ibVLLRwALa9wjsAfXEX6VxcCziHp50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596045802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=yPxwBGHvqALkfsrQrrIYpsq7hoQPI6RVBDt+ux1gexE=;
 b=JQWwtUenFdw7jabC0KldUDsdX/rhqjKd+bKpMEWVU70laNIKOqzFxx8gul9zkAIh8+Sdxx
 cGcYhkyxZQ0Ydgg+3bWgj2CtkO0n8oQvE2Fsk7I6p3ioFnJuJawynwS53K94x8lXA6LAWo
 0ibVLLRwALa9wjsAfXEX6VxcCziHp50=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-L6OsTF4BN2O_hKEwUlZEeg-1; Wed, 29 Jul 2020 14:03:18 -0400
X-MC-Unique: L6OsTF4BN2O_hKEwUlZEeg-1
Received: by mail-pl1-f200.google.com with SMTP id w8so14760782plq.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jul 2020 11:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yPxwBGHvqALkfsrQrrIYpsq7hoQPI6RVBDt+ux1gexE=;
 b=dTbhgCoUidbuetqvKHm1k74Cj9YxrUS1LogjNcvfoycJjwzyoSghsFgHdCO1uFR0jm
 FL1tzG/ngvtd+VJcqxCehWCdKulFYYJ12lV2chTwKxjht3HXcq2Diyq97vMR8kM/I1py
 kTdQ2VNxyk/btBW2jjjqHny/hpofeQtpbxMh/5SSvru7DWirlygA3hMHEi3AB9bYLrku
 t8Za8srDx0AiDuHOXpHdeH4huJUU2bHZP97PP5W7hBIDus3PUNl3fHwx2RwW1rP6P42z
 JjEUbOxMdspwblj+W0SJvW0tkcNwmd0wl5Gbj3aIHUDlffxFgpu8TSQd0DqI4d0YD51V
 6itg==
X-Gm-Message-State: AOAM530VO+dRH6QkdjiqI9WZV6743I0qiF+LqeNCqhEACL8Pon38PkYg
 zOKy2DY3kmUX1kNIpxJxOIBOL83TAH6xkEy/h7z9faTermUNIMqCmOVIizpwEzzTO5TgKeKFE/m
 K1wm64lNwFuK3FmEH9ERLzcNN
X-Received: by 2002:a17:902:368:: with SMTP id
 95mr29689639pld.279.1596045797409; 
 Wed, 29 Jul 2020 11:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwohj6P24jrwHX9Quk18oF5SJeQ9c/MjqAOHHevveTR1FFq2T4bSXP++bEI6hqh7pTETbcoGA==
X-Received: by 2002:a17:902:368:: with SMTP id
 95mr29689623pld.279.1596045797161; 
 Wed, 29 Jul 2020 11:03:17 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id np4sm2311140pjb.4.2020.07.29.11.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 11:03:16 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: fold in used-once helper
 erofs_workgroup_unfreeze_final()
Date: Thu, 30 Jul 2020 02:02:35 +0800
Message-Id: <20200729180235.25443-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's expected that erofs_workgroup_unfreeze_final() won't
be used in other places. Let's fold it to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/utils.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 52d0be10f1aa..14485a621862 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -127,12 +127,6 @@ int erofs_workgroup_put(struct erofs_workgroup *grp)
 	return count;
 }
 
-static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
-{
-	erofs_workgroup_unfreeze(grp, 0);
-	__erofs_workgroup_free(grp);
-}
-
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp)
 {
@@ -162,11 +156,9 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 */
 	DBG_BUGON(xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
-	/*
-	 * If managed cache is on, last refcount should indicate
-	 * the related workstation.
-	 */
-	erofs_workgroup_unfreeze_final(grp);
+	/* last refcount should be connected with its managed pslot.  */
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
 	return true;
 }
 
-- 
2.18.1

