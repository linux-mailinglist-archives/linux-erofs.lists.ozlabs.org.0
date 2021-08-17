Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A83623EECF6
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 15:02:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GprmH4KZtz30C4
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 23:02:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YFxAmdYE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YFxAmdYE; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gprm86bzJz2ymS
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Aug 2021 23:02:32 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0214D60F41;
 Tue, 17 Aug 2021 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629205349;
 bh=5PuQjEM1eX3vxqvu9eGKEl7S1kAeLgwY3hmnhFDdcUM=;
 h=From:To:Cc:Subject:Date:From;
 b=YFxAmdYEDBNah0WXoCLCuccIbC9lszdJkqnkvXUYQWsKVNj4S0FpQ55RBuwDpkn5c
 sNzh0f0l2HPkOgq0dZbOb+9wNq/WD0eXcZ4JQtFJeRJmIFXvFfzbRMDpVLdnqT60D7
 YgY77sL6xOFhAihW7OzpcAu2wicD6bq70gYFP2xpUVtn3Y2RBPlpDBZit1i27sqBv5
 QQZ+8FCKR8mHd3xGmocQIxBKytNdwqIgDXsuFPavChjizYoF3jt+LjdBB9IUcSskfj
 1s1aZ9fyk5v9WGcOYvl4F3TfID96s/UKPTs/VqQWQsuZW4J0W8j8BiMEAkHgXJ1Ma/
 C0IS9jWj7aV7g==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix --with-lz4-libdir when lz4_force_static is
 off
Date: Tue, 17 Aug 2021 21:02:05 +0800
Message-Id: <20210817130205.8996-1-xiang@kernel.org>
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

--with-lz4-libdir doesn't work for lz4 1.9.x, hopefully it works for
all cases now.

Fixes: c497d89e5eac ("erofs-utils: enhance static linking for lz4 1.8.x")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 38c371c4910f..35106094d9f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -285,7 +285,7 @@ if test "x${have_lz4}" = "xyes"; then
     LZ4_LIBS="-Wl,-Bstatic -Wl,-whole-archive -Xlinker ${LZ4_LIBS} -Wl,-no-whole-archive -Wl,-Bdynamic"
     test -z "${with_lz4_libdir}" || LZ4_LIBS="-L${with_lz4_libdir} $LZ4_LIBS"
   else
-    test -z "${with_lz4_libdir}" || LZ4_LIBS="-R${with_lz4_libdir} $LZ4_LIBS"
+    test -z "${with_lz4_libdir}" || LZ4_LIBS="-L${with_lz4_libdir} -R${with_lz4_libdir} $LZ4_LIBS"
   fi
   liblz4_LIBS="${LZ4_LIBS}"
 fi
-- 
2.20.1

