Return-Path: <linux-erofs+bounces-1487-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1001CACACF
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Dec 2025 10:31:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dPxZh4Mc7z2yKp;
	Mon, 08 Dec 2025 20:31:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765186316;
	cv=none; b=QpJFlQHVfHpYhx2bPlbOObh9oSPAyb2wd36sGpM+eQENhWv53uxUGBScWJadZnhppm4gRUnlV/N0Dd93wcN+DmxPUSbRE78uFsH0FXhBcPw6f1oiSOiXptqnwmC7eIeZzZXmgLsyXMsxge7zDEp5ijtXcGV8wuRuQ5SyAKFi7N8CN6R1/so+TaMPAelAR8n7+JLYNqWi6ZUqJrY7br13kjIMWEr7KPZh5hz9S3DhSeeI+pX91+WDcRCebOwT3jAlakixQKOku0n+rJXYioLuqVN9URWrJnZH3ZlKSrUguYWaMERhQq+sE3/1titMAVmqXwf3m53yllRxKLxyb/7bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765186316; c=relaxed/relaxed;
	bh=G9Zj8YF6oErWksGx+Hr3GZX6O0aFLF2DRJ0Uiqt74GU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4vy+0sZMpDVXTGr6++0V1MsiSTrebCyi5KWGfHmpCH29Z7IQr9noOdCbOljwEvmf1rH16xblF/94xOHunGlqe7nLZYh4Jm/d3deuJFvZrlm1L9GhZzpxrwhA6xB4qVWiH6BjZmwbzXh1oMOJmQIJjI1MBY/xc2dk3r2RKKnA7r80zU8uisKRWcF9HymKNJ1Pu3ERphfrBDV11MQ7ArcQp6L6j+rgz54jnnxMltZtZQUAEWTrDjl2Gbg1oj9myx511MmAC4Fng5cZzSVv44d6rVHfx6MIi+gy+vTL5X32Er/yCkAB261sT5eJ5zIfMbUWchpDH4vjk0cofwVKAEjNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LdvZqOVU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LdvZqOVU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dPxZd6bsQz2yK7
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Dec 2025 20:31:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765186307; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=G9Zj8YF6oErWksGx+Hr3GZX6O0aFLF2DRJ0Uiqt74GU=;
	b=LdvZqOVUowe5iQrUaSuniyLnbktxnThaGm4rv/bpJYuCs55QLVfobzAxMxtpdz/lad0cQiQvz7QgLpY0VUl8u5ptXrEybsxhXtIGKTz+mxccTp52YOMnK2Iql5eaqHpoKOsTGiiioQH6i6GNuXZ39m3KYKKw+S3lk+hfq4Dkj28=
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0WuJUYJI_1765186301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 17:31:44 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH v2] erofs: Use %pe format specifier for error pointers
Date: Mon,  8 Dec 2025 17:31:38 +0800
Message-Id: <20251208093138.127880-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

%pe will print a symbolic error name (e.g,. -ENOMEM), opposed to the
raw errno (e.g,. -12) produced by PTR_ERR().

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 461a929e0825..86cc6ebd8450 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1324,8 +1324,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 		if (IS_ERR(reason)) {
-			erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
-				  alg->name, PTR_ERR(reason), pcl->pos,
+			erofs_err(be->sb, "failed to decompress (%s) %pe @ pa %llu size %u => %u",
+				  alg->name, reason, pcl->pos,
 				  pcl->pclustersize, pcl->length);
 			err = PTR_ERR(reason);
 		} else if (unlikely(reason)) {
--
2.43.5

