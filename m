Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D7A35705
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 07:24:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvMTM6zQVz3c8G
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:24:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739514262;
	cv=none; b=S1DqyGYlFfgo/0d03pA5CMiI+YqCp+CpcElssk8jL3KwXMv5t3IhPaIPMmsK4YDTcqDvJ9F6Y4AKRXgefgE+GSLTkwgd2Dbko/lDsjywyMMjmHMZAGVIvjQXrAI6g27WWYKN1hBaXNn7bMrmCJNQDd3RsDvNzOyvQDSWMqniSXiERI59Fja8UxtheKzQT65U53wqFPw38UaT4rNum2JiLFnUUGFrxCJpahIxIieNu0bIuRD3UxCdRx9cfOXBrR1w08BSezZMrqu2zztBvYrTgEscU+jPGtkDLzEBnvnPKu4RpYp4fbNQ1kL80rltQFuiTtuKStEeVnuo5mazEwyLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739514262; c=relaxed/relaxed;
	bh=9xBoth4sMuo0AhLnK66JweoD2gXiNlNMCBMXPQYRoOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apNiIGWFcrVPd8FZqOR19BaDpBgTxjvdSc8cd2a8BXjYkIGAwEI9SMXHPsNVuUkmX+Y07LSGBfVOYArKDZViehndfmNu0jEPW6nhLX8o1WH6qhVU77ZBtdyQt1n82ax/KVBtlDh1kzh3QhqdsUQ8f9skaF/QAW/kS9R0H2JFaYgElinSoU7ZYcaJAYMfir9lk+hIbIXEnvS8CNcD0pQIFS5Cmk3RLXBrAVv8oHjeMQyrCTS2MAeBRE+KCyD5H06a6PGU/A+e9lgiVNn6Jz6e5OJ6Hx0GJu+tey/rIO13I6xGSPD4O21JZ6QesgNOKhEHLPbXTu+q1aSy1IvMBzFgqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RJD7xH0e; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RJD7xH0e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvMTH6hXfz3093
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 17:24:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739514256; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9xBoth4sMuo0AhLnK66JweoD2gXiNlNMCBMXPQYRoOY=;
	b=RJD7xH0ehFSLEroUE8k1ou6Cfwg8iqVzJvRL298q8//NjpFOkyfD0SYoTVNjAcXKn252MMJiga3AktyJTJieSEb5+UyHirQPK8qirVXTQsoXbJOEJD5+l2OD5qH7+jtkeeOlIXXA6U21zH6BQOQIvyNODaAE7Dnj/X3WE0AX9h0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPPo5lF_1739514254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 14:24:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: lib: shorten EROFS_FRAGMENT_INMEM_SZ_MAX
Date: Fri, 14 Feb 2025 14:24:07 +0800
Message-ID: <20250214062407.3281416-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250214062407.3281416-1-hsiangkao@linux.alibaba.com>
References: <20250214062407.3281416-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

EROFS_CONFIG_COMPR_MAX_SZ (currently 4MiB) is so large that could
cause OOM kill for small machines.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index 3e97f14..758fb87 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -31,7 +31,7 @@ struct erofs_fragment_dedupe_item {
 	u8			data[];
 };
 
-#define EROFS_FRAGMENT_INMEM_SZ_MAX	EROFS_CONFIG_COMPR_MAX_SZ
+#define EROFS_FRAGMENT_INMEM_SZ_MAX	(128 * 1024)
 #define EROFS_TOF_HASHLEN		16
 
 #define FRAGMENT_HASHSIZE		65536
-- 
2.43.5

