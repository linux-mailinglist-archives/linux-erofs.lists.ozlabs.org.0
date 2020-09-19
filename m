Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A420D270B6D
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 09:28:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Btj3w5r7XzDqss
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 17:28:28 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=jFzAnjlC; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dvjSciYg; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Btj3n5L8qzDqm6
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 17:28:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=2bEftFKQeg7t1a3m+CntScYxnb1LsdZSJyYIcNndeZc=;
 b=jFzAnjlCofsY8QshtKW0UVNo2bWXK9Afiq7z+XQ2pB0hD7EWqy8DunQp0q1YUUCYlzi3Bw
 YjmNXknh8oM8FKvxXEMitDHKPt5/l3KfAac7pFTLnGZAMsMOx6GxMFfsJ6oPX/xlL0selz
 bmSSs2I0RQ/tObcd6xaxO53lQ+7IfkY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=2bEftFKQeg7t1a3m+CntScYxnb1LsdZSJyYIcNndeZc=;
 b=dvjSciYgl1d/l4bqLNUIK678X62eWf1bwxFF9YFC4V+8IckLjLHpgUoCYPWaZNt3Y0V8F1
 fLiC2Al+9M6aKdMhXESiSb8UeHAIBja82wjQVVFloZhuTd6k8JQx4tpxt6kdRVfezrS23e
 kv1NcNyOriAc3Yf7vpf4mqe0bwcX0mg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-RQlR7urJO7eJJsWL0ZNdqA-1; Sat, 19 Sep 2020 03:28:14 -0400
X-MC-Unique: RQlR7urJO7eJJsWL0ZNdqA-1
Received: by mail-pg1-f199.google.com with SMTP id z4so4739242pgv.13
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 00:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2bEftFKQeg7t1a3m+CntScYxnb1LsdZSJyYIcNndeZc=;
 b=A8PG8QyJ+174XPqRe80L7oWFeDNnGT6lyjQPBCOqx+I5fDYCAe4dkqe+Ut2poE3rgK
 OeWFflE8u7n2bQafrzQ5oDZaEzaOM8dzXRILwIS2HTErTVFrQdlSN8ififW7lKTpux46
 0ifCuGscjRSKo0e47X5I3hN525xPARTB3FAIKDhc9bU8WfBM5KrSIR54Km2BuvjFpP6d
 rugTsdDM0NKZUzxK0qbW6UYWOXKULZm1eWKhk+2pj8Kz76ygTZpJdpP4QrrxC7dF2l3t
 xEHTh5E4WHd10/fd0TtEyND72/2MMpXVwpzIbYGFPdYirb4jKWecnOBjchf7uoJfUP10
 Ah8g==
X-Gm-Message-State: AOAM532Ytnq8JCiFXPEFcnoQV/ralwHv/g0ecocqCE8ydvKxaiuAlHMU
 L8eyTtYC1nEQa9Y+bhlmBSNGfhVkxMPKBv5u1ByTGI3nLXYTzc2huNPqdSJuI8/R2NuOeJAjMpV
 MEqOoMzOEIYrrN8sNoZWveVzo
X-Received: by 2002:a05:6a00:1695:b029:142:2501:34e4 with SMTP id
 k21-20020a056a001695b0290142250134e4mr18419834pfc.61.1600500493153; 
 Sat, 19 Sep 2020 00:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnwDQjBN6SIpBsTZ/BuU2boz5JzVyUzKod6irPW+vMbploZ5tevrUsGCQUeZu55MR50+cEPg==
X-Received: by 2002:a05:6a00:1695:b029:142:2501:34e4 with SMTP id
 k21-20020a056a001695b0290142250134e4mr18419820pfc.61.1600500492812; 
 Sat, 19 Sep 2020 00:28:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 00:28:12 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/3] erofs: avoid unnecessary variable `err'
Date: Sat, 19 Sep 2020 15:27:28 +0800
Message-Id: <20200919072730.24989-1-hsiangkao@redhat.com>
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

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
no change since v1.

 fs/erofs/zdata.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ac6cb73df192..e43684b23fdd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1190,7 +1190,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		do {
 			struct page *page;
-			int err;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
 							  MNGD_MAPPING(sbi),
@@ -1216,8 +1215,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 				++nr_bios;
 			}
 
-			err = bio_add_page(bio, page, PAGE_SIZE, 0);
-			if (err < PAGE_SIZE)
+			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
 			last_index = cur;
-- 
2.18.1

