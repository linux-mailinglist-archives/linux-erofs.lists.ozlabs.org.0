Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9A37F1DB
	for <lists+linux-erofs@lfdr.de>; Thu, 13 May 2021 06:13:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgdYx0Cb8z2ywx
	for <lists+linux-erofs@lfdr.de>; Thu, 13 May 2021 14:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QrPKcx0p;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QrPKcx0p; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgdYt0ZsKz2y8F
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 May 2021 14:13:21 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C64D0613A9;
 Thu, 13 May 2021 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620879198;
 bh=dwsrV8f/vPgjLFREw37D7qiFei3l3e/9xrCbtYUVMZc=;
 h=From:To:Cc:Subject:Date:From;
 b=QrPKcx0p9QQ/0hUGErkQ4MnsMFiTQFRbcF//1AiItNQscE3T0M/qF3mn0FCFCVQWb
 3zjgtJb0/IeLwDujde/jN9n0eZgOe1sIOEfmv7elNvFQoqsjfKM61jU+VsZBbpuFuG
 B515cKX9Jh7hxJ3mp1zQGCUJl2KpvlRsMuKWHhF7qJyf+suzGMVl6h16z9O5u2lYfc
 k9LthZtHuT7NhPKb/XXHQtgBMYYNJRc0Di11PJqm7qxRVl0TVuKnnwNzS6dQRxvI7m
 iqVQELVIf/fegduLTn0Nw36aw+Zv3ZE5o+DGIFGbLhDaKKd821kf+7H/eITDK/+zvN
 E0RZzi3YirVdw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH] erofs-utils: fix distcheck target
Date: Thu, 13 May 2021 12:13:11 +0800
Message-Id: <20210513041311.22480-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix the broken distcheck target [1], and it needs to be
resolved independently first.

[1] https://lore.kernel.org/r/20210121163715.10660-5-sehuww@mail.scut.edu.cn
Reported-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/Makefile.am | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index f21dc35eda51..b12e2c18cc33 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,6 +2,24 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
+noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
+      $(top_srcdir)/include/erofs/cache.h \
+      $(top_srcdir)/include/erofs/compress.h \
+      $(top_srcdir)/include/erofs/config.h \
+      $(top_srcdir)/include/erofs/decompress.h \
+      $(top_srcdir)/include/erofs/defs.h \
+      $(top_srcdir)/include/erofs/err.h \
+      $(top_srcdir)/include/erofs/exclude.h \
+      $(top_srcdir)/include/erofs/hashtable.h \
+      $(top_srcdir)/include/erofs/inode.h \
+      $(top_srcdir)/include/erofs/internal.h \
+      $(top_srcdir)/include/erofs/io.h \
+      $(top_srcdir)/include/erofs/list.h \
+      $(top_srcdir)/include/erofs/print.h \
+      $(top_srcdir)/include/erofs/trace.h \
+      $(top_srcdir)/include/erofs/xattr.h
+
+noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-- 
2.20.1

