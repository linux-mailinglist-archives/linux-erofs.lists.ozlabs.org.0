Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A376338D38D
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 06:35:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fn9dP4K2lz3brt
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 14:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h9PwNBUl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=h9PwNBUl; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fn9dH31B5z2xxn
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 May 2021 14:35:31 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41F616138C;
 Sat, 22 May 2021 04:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621658129;
 bh=uTmVLaOL5w7Dv2XEpa0JQHyFnvqyJuZIAub/iIITjew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h9PwNBUlq5idl95b6qc767k8tXFVD9GwsHz6Tb2ISV/mwRIq9WrEOpC+dH+j9sgbG
 /Yu7pArurvmpBcOU1IRllC/go/k0TZAaq65R0MfVQdEZHBtynJ8R9pWptYvEqJt617
 qXGt4cPmD8WmFX1BPrGftOIRMvChkNv8/yWKHQZXH0FTbUJegFyENbvlZgq8SLg6Xb
 +RQguanyN2m279tCTxIk/nodBmmetwgDcm1Yn8mxu6fFti6Z/0GZ1D+x1g1w4AtX88
 CcAwrMj/slyuK56FMvLVoW02r2wlkGttnP7ct38WgY/6gmmTsISdMg6xCntWMl4ov0
 VbBkmmzJxWpEA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs-utils: introduce --enable-debug
Date: Sat, 22 May 2021 12:35:01 +0800
Message-Id: <20210522043502.11975-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210522043502.11975-1-xiang@kernel.org>
References: <20210522043502.11975-1-xiang@kernel.org>
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

This adds --enable-debug to explicitly specify debugging mode.

It's disabled by default, which means NDEBUG macro is defined instead.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 configure.ac | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index 28926c303c5c..f626064cc55c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,12 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
  fi
 ])
 
+AC_ARG_ENABLE([debug],
+    [AS_HELP_STRING([--enable-debug],
+                    [enable debugging mode @<:@default=no@:>@])],
+    [enable_debug="$enableval"],
+    [enable_debug="no"])
+
 AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
@@ -150,6 +156,12 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 # Checks for library functions.
 AC_CHECK_FUNCS([backtrace fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
 
+# Configure debug mode
+AS_IF([test "x$enable_debug" != "xno"], [], [
+  dnl Turn off all assert checking.
+  CPPFLAGS="$CPPFLAGS -DNDEBUG"
+])
+
 # Configure libuuid
 AS_IF([test "x$with_uuid" != "xno"], [
   PKG_CHECK_MODULES([libuuid], [uuid])
-- 
2.20.1

