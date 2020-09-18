Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0251A26FF5C
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 15:59:19 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtFnJ3Dr1zDqtd
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 23:59:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ejl6Idm1; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejl6Idm1; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtFhj4kbrzDqbC
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 23:55:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Fob8e2a9nGW8sR1cLDiz2AvMl4FxYk2sgoIACLAIhco=;
 b=ejl6Idm1odkieYl3Rl4NY+qrrFOAKxtXvxuG/yj4PtBXlMXYvj95mWe9YO4Bx66msposfy
 Tgea1CmE0A5boT6FKhPyzLlXaVWVXgRD+weahfxte5Pntt4yzajHHCL18ng2jKHqSdeBeZ
 l4RijinrUPTzkaJfuruUzr0av+d9Xc4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Fob8e2a9nGW8sR1cLDiz2AvMl4FxYk2sgoIACLAIhco=;
 b=ejl6Idm1odkieYl3Rl4NY+qrrFOAKxtXvxuG/yj4PtBXlMXYvj95mWe9YO4Bx66msposfy
 Tgea1CmE0A5boT6FKhPyzLlXaVWVXgRD+weahfxte5Pntt4yzajHHCL18ng2jKHqSdeBeZ
 l4RijinrUPTzkaJfuruUzr0av+d9Xc4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-iM37etyYO9itxF76dJt9wA-1; Fri, 18 Sep 2020 09:55:10 -0400
X-MC-Unique: iM37etyYO9itxF76dJt9wA-1
Received: by mail-pg1-f200.google.com with SMTP id r22so3523424pgk.14
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 06:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Fob8e2a9nGW8sR1cLDiz2AvMl4FxYk2sgoIACLAIhco=;
 b=KSoMHmjKc/dKLGXC16uyoZ3Hfi+tL5oO1BdlCDLJuj83EsVJNOSvPxkpKNLaMXtZ/o
 aezb1Yr078lqwmx6rYub+7cU62vNFlQvrpIusNbDtokTEv32Sgyhq4Znqtij7hsTqzfs
 rK6Mec6sU6Ee8E7FunndJsfubQahVOhVpAdBY9PV/+hMOpGDRsx0zzGZYrm2nyP77Wat
 NleVhnh014qqVcdzo8lDN/ovqjsZai0cgq5hpvp+9QyAnmRd5pWN6iIQF8AtPIXseQbe
 eGsw6tCqriWCpc6Q7aTbidPSGXwKwF7/iYQjVXZnFmHVMPm21/c62Mk8nCWlnoMAp3vt
 i5qg==
X-Gm-Message-State: AOAM532Oc5S9IgCM6Lua+/ZkITV/5ylURGEPgFYzFRyv5HAveeGeqB9l
 369MCCY6DPpLAiLpcho7TLcmeViXvxTFiS992Gjtw7xOuYivmjs8UADgYUwhFrew8M+L7Jj4MMU
 k2/vkbvWg3tvYfDzvWp6nWsPo
X-Received: by 2002:a17:902:9006:b029:d2:341:6520 with SMTP id
 a6-20020a1709029006b02900d203416520mr5516703plp.37.1600437308859; 
 Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytckQsFmDdTGAEynQGk/nocBz8UclubNVkwkGFO1F2FUPlpGYRyvYg1rCXDtWbmXiv3T63Ww==
X-Received: by 2002:a17:902:9006:b029:d2:341:6520 with SMTP id
 a6-20020a1709029006b02900d203416520mr5516683plp.37.1600437308626; 
 Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] erofs: avoid unnecessary variable `err'
Date: Fri, 18 Sep 2020 21:54:33 +0800
Message-Id: <20200918135436.17689-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
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

variable `err' in z_erofs_submit_queue() isn't useful
here, remove it instead.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f9..df6fa691097f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1193,7 +1193,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		do {
 			struct page *page;
-			int err;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
 							  MNGD_MAPPING(sbi),
@@ -1219,8 +1218,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 				++nr_bios;
 			}
 
-			err = bio_add_page(bio, page, PAGE_SIZE, 0);
-			if (err < PAGE_SIZE)
+			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
 			last_index = cur;
-- 
2.18.1

