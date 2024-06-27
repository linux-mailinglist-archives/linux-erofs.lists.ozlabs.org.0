Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C1919D3C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 04:27:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bs0JEhrl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8jCZ3Vj7z3g1J
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 12:27:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bs0JEhrl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8jCS6hyfz3fyv
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 12:27:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719455263; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mDndEhWWf2R7uatmy3vOtMIedtjyf9ZSKq0tRPzjEB4=;
	b=Bs0JEhrlCxmc5JWiuMgrIYvqleN5f30bbMekl8Hhhpae+TQIxsgo2kvQOgUAdbVGWQr0VICHQi2/3J8CmTf+j55FsSBh6DI0LQJwmQ36n7F/cUA0mG71v11l0+CzIr5yfgHgfVxCKNfDmnRzxiQFfIxdvB1/ffooIRBkF4/H++4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9L2ohi_1719455262;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9L2ohi_1719455262)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:27:43 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: add erofs_get_configure
Date: Thu, 27 Jun 2024 10:27:41 +0800
Message-Id: <20240627022741.3912785-1-hongzhen@linux.alibaba.com>
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

This introduces erofs_get_configure() to get the global
configuration `cfg`.  This allows external entities to change
the global configuration through this helper, thereby controlling
the EROFS mkfs process.

It is just a temporary helper for liberofs and it will be
deprecated in the future.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Update the commit message.
v1: https://lore.kernel.org/all/20240627021005.3896379-1-hongzhen@linux.alibaba.com/
---
 include/erofs/config.h | 3 +++
 lib/config.c           | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 3ce8c59..111f5b0 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -100,6 +100,9 @@ void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
 
+/* a temporary helper for updating global configuration */
+struct erofs_configure *erofs_get_configure();
+
 void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
 
diff --git a/lib/config.c b/lib/config.c
index 26f1c35..44f0606 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -66,6 +66,11 @@ void erofs_exit_configure(void)
 		free(cfg.c_compr_opts[i].alg);
 }
 
+struct erofs_configure *erofs_get_configure()
+{
+	return &cfg;
+}
+
 static unsigned int fullpath_prefix;	/* root directory prefix length */
 
 void erofs_set_fs_root(const char *rootdir)
-- 
2.39.3

