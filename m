Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3499E4C23
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 03:09:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y3dBB4SrGz2yGl
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 13:09:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733364576;
	cv=none; b=PED6pAE9JNUr0FYdVJiKDkvqG5gUd+KBqmF+Bg9q4dJ1foPQx+JZMbgZxlnPElUPxfwLD4IGgOER30LB41ZxkBxbGXE5dZFasAb4k0Bd/PukKbA8H0/F8GJpm6cr+7susVN6opo02cYWUrH1yFHqxjWwELkumf+8m/4jFMyihhD4XcEZFDAfYbwdGydO8aV9nzxZGczex1ydMhmwmZx4MEbLsWrTw0jDKi6KKHZOnRH3xvhjjhvxkxOQgAXprJt4mBdhEZn2DyfQ3UJPOisgbbrzjnNzGcq7zB/J6g5x0VWX8usoJflEatwmUIZCNi6sjRRp/TVI2Btv0c9zc0jHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733364576; c=relaxed/relaxed;
	bh=FgzQXEhCxcY13CaLPk8BrtLkahZV4/sZGUc/dB6wMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDY41wtxAqL5zCVohN91BMpojIWsgMkgD2yvIae6VOGeEHOpJe/T21T3sq/FGQm73Y6gPW+tboqn8FsxTmhsSChmaMlcCZpdGihn0tm5RqEqFZ2fQEapgk6LsbiltZjtVhgkKUAN4nVEGqaj5BP0rd9j/9vH/hVuTH56FyC93BegJGvm5HKwH5IHH97KipqCaiQMfUiJ1dsxDog09e1FHOMBM0JKUE0sAdk+GEUfiJn7z3bn/N15vYaE3ZzE3gsWBbLQ+F0SwqP/1Wk80kwn1XhUB8b/BILGkO7z7gZHryAeqe+p59Gb6ZJlEB12CMooPEHoHOtBMD8nhy55xB0q3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PSVhYRQy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PSVhYRQy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y3dB50tYdz2xsW
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Dec 2024 13:09:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733364563; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FgzQXEhCxcY13CaLPk8BrtLkahZV4/sZGUc/dB6wMFc=;
	b=PSVhYRQyOQluavS1Z8cSWPqHQvNUuFJZMb07x87jkmA+x++RDzzRAa5IQolO+ZajTbG5F6MSzsBuEN7nXcyYP6T0KnAJ5rGuNdeLgupRKqIcWhElbL5//BVSGkpYYrEtdmOupLIZ6HRSr4l2EFZO8D93dxgN/mfJN6ZkM7sOMes=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKrRRZu_1733364556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 10:09:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: add missing dependencies
Date: Thu,  5 Dec 2024 10:09:15 +0800
Message-ID: <20241205020915.966196-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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

Add the missing ${libdeflate_CFLAGS} and ${libzstd_CFLAGS} to avoid
compilation errors.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 2cb4cab..758363e 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -51,9 +51,11 @@ endif
 
 liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
 if ENABLE_LIBDEFLATE
+liberofs_la_CFLAGS += ${libdeflate_CFLAGS}
 liberofs_la_SOURCES += compressor_libdeflate.c
 endif
 if ENABLE_LIBZSTD
+liberofs_la_CFLAGS += ${libzstd_CFLAGS}
 liberofs_la_SOURCES += compressor_libzstd.c
 endif
 if ENABLE_EROFS_MT
-- 
2.43.5

