Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E018E2E864D
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 06:21:56 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D79HP5cjJzDr6f
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 16:21:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=M8vZN5gT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8vZN5gT; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D79HK54rDzDqC0
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Jan 2021 16:21:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MqIZXJJTMDt5auTDJ8GBTyEquYp6hwq9+ues8Ab+anQ=;
 b=M8vZN5gT7psaEtmLt4IBRauegD490vYTf69rhRrAg4Oc8xSX/thdAg319JOarJMzI3V1KN
 r0cMQQUFzlTXkzYcCQp2vN6jRQJYp4fKV+AYo27/yCZ7DBZmq3mqa039NH00n16RFB9I7z
 4wIdvB0Y77BX/xklx4IHdqa67plHWUQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MqIZXJJTMDt5auTDJ8GBTyEquYp6hwq9+ues8Ab+anQ=;
 b=M8vZN5gT7psaEtmLt4IBRauegD490vYTf69rhRrAg4Oc8xSX/thdAg319JOarJMzI3V1KN
 r0cMQQUFzlTXkzYcCQp2vN6jRQJYp4fKV+AYo27/yCZ7DBZmq3mqa039NH00n16RFB9I7z
 4wIdvB0Y77BX/xklx4IHdqa67plHWUQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-pYpMNcK8NHWLUwFCP5DHYg-1; Sat, 02 Jan 2021 00:21:43 -0500
X-MC-Unique: pYpMNcK8NHWLUwFCP5DHYg-1
Received: by mail-pg1-f197.google.com with SMTP id l22so5409918pgc.15
 for <linux-erofs@lists.ozlabs.org>; Fri, 01 Jan 2021 21:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MqIZXJJTMDt5auTDJ8GBTyEquYp6hwq9+ues8Ab+anQ=;
 b=dFuoTlTVOarJ2mlsSbK5R3SFcdM/sYYQFHps9G8Jj1CgHaQIIhDgOru/hIh4pZnwCm
 ffMwMUBWMtaWfFvc7vXUWINckmqjouM7nELdlMpUFcEo/G5kPoFyTc6cs7bRE+iHMHyQ
 t3LqqJ2dDZOfpVG6aIiU7SiUi0ax0kHBzl72zlNS2VH8QaJ1+z8gA04t6gT/mxcidNBY
 gn7wu1mF/b440vN14mDyDrsjgZIJZkd+rZ+81b7OuWspv4Ka7CUsLR2Q/RceBr3rKn4V
 fB7epDef9uBdYet8ZhG6XqkTsE41qVJUQdSs2pOrFtlicdtNje1Z2JJrlmA9Ka9tI64K
 yizA==
X-Gm-Message-State: AOAM533IXSxJqP+Mvt1xHtskTYlvmNypNz6V4xog9EeJVBYiVfsvArZI
 pIBTCe8m244B4VjAanSqqs5ay+3kknGbknSm6c+NEB3AXOcESDMfJf4wc1KXOKVoIYJ6vm7luyK
 zmDTU7Yb2MrRCHpZYhLKnK7CVeB7Xs4mt3hGqevsYupeJ27OkJcQl2g5KzIQQcq2vYzW4tGNuUJ
 ALwQ==
X-Received: by 2002:a63:fe05:: with SMTP id p5mr40204027pgh.161.1609564902143; 
 Fri, 01 Jan 2021 21:21:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfe9qsVcnGiBr2x1QmyOSQtEye6uK+os6MNd+INQYSbC2/wgGKQIb3r29w9n6IsZirohMW9A==
X-Received: by 2002:a63:fe05:: with SMTP id p5mr40204012pgh.161.1609564901880; 
 Fri, 01 Jan 2021 21:21:41 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h15sm46355933pfo.71.2021.01.01.21.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Jan 2021 21:21:41 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update my email address in README/AUTHORS
Date: Sat,  2 Jan 2021 13:20:55 +0800
Message-Id: <20210102052055.3734591-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

My previous email address was no longer valid. Fix it.

Reported-by: Hu Weiwen <huww98@outlook.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 AUTHORS | 2 +-
 README  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index 121cf6a..3487d44 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -2,7 +2,7 @@ EROFS USERSPACE UTILITIES
 M: Li Guifu <bluce.liguifu@huawei.com>
 M: Miao Xie <miaoxie@huawei.com>
 M: Fang Wei <fangwei1@huawei.com>
-R: Gao Xiang <gaoxiang25@huawei.com>
+R: Gao Xiang <xiang@kernel.org>
 R: Chao Yu <yuchao0@huawei.com>
 S: Maintained
 L: linux-erofs@lists.ozlabs.org
diff --git a/README b/README
index 0001a67..b57550b 100644
--- a/README
+++ b/README
@@ -149,7 +149,7 @@ To:
   Fang Wei                   <fangwei1@huawei.com>
 
 Cc:
-  Gao Xiang                  <gaoxiang25@huawei.com>
+  Gao Xiang                  <xiang@kernel.org>
   Chao Yu                    <yuchao0@huawei.com>
 
 Comments
-- 
2.27.0

