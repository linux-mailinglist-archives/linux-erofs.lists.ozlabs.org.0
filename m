Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02A7520B0
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 14:00:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1tTy1j28z3c4v
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 22:00:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1tTp6hTrz3bb4
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 22:00:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnHh9xP_1689249616;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnHh9xP_1689249616)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 20:00:17 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v2 1/2] erofs-utils: add ERR_CAST macro
Date: Thu, 13 Jul 2023 20:00:14 +0800
Message-Id: <20230713120015.93308-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230713120015.93308-1-jefflexu@linux.alibaba.com>
References: <20230713120015.93308-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add ERR_CAST macro to prepare for the upcoming tarerofs feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/err.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/erofs/err.h b/include/erofs/err.h
index 08b0bdb..2ae9e21 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -33,6 +33,12 @@ static inline long PTR_ERR(const void *ptr)
 	return (long) ptr;
 }
 
+static inline void * ERR_CAST(const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.8.3.1

