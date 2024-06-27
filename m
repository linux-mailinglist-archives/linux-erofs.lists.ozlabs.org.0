Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B3919D26
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 04:10:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=czu1xljs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8hqC48xqz3fsS
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 12:10:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=czu1xljs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8hq760s0z3fqg
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 12:10:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719454209; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YNJwujzbNiYU8WvfVJs+BVorwm0PDP5TD49gpzOLYtE=;
	b=czu1xljsKE7sUFBF/Lhz7ruJlFxHlntDvXI2nuxcwkCDeip54y+IDNmbQ14Mn0Pnrr2b51wHhgfRnNBicnT71b4M6nXmLN0Fbml1c3rJ2c+rMa00+k5gf4i2qr4w6UWCVG5Rcd9MgoAi5fNsLg7za62YVDZ/LzL0EnDTtFUtysA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9L3Prf_1719454206;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9L3Prf_1719454206)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:10:07 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: add erofs_get_configure
Date: Thu, 27 Jun 2024 10:10:05 +0800
Message-Id: <20240627021005.3896379-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This introduces the `erofs_get_configure` function to obtain the
global configuration `cfg`. This allows external entities to get
and change the `cfg` value through this function, thereby controlling
the filesystem creation process.

This is a temporary solution for liberofs to configure the
filesystem creation, and it will be deprecated in the future.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/config.h | 1 +
 lib/config.c           | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 3ce8c59..aa6870d 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -99,6 +99,7 @@ extern struct erofs_configure cfg;
 void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
+struct erofs_configure *erofs_get_configure();
 
 void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
diff --git a/lib/config.c b/lib/config.c
index 26f1c35..3f93cdb 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -66,6 +66,12 @@ void erofs_exit_configure(void)
 		free(cfg.c_compr_opts[i].alg);
 }
 
+/* a temporary solution for liberofs to make configuration */
+struct erofs_configure *erofs_get_configure()
+{
+	return &cfg;
+}
+
 static unsigned int fullpath_prefix;	/* root directory prefix length */
 
 void erofs_set_fs_root(const char *rootdir)
-- 
2.39.3

