Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E734462AD5
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 04:02:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J36T124xQz3c6S
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 14:02:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638241333;
	bh=9NCi5pLHFkEAT0Hb+wWzpZFXCJ8TuJWqT2KCb/zV4wc=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S7CPR9f3XudRGP0cEYeKT7r5fW0pXQvMqVDq0F/6OkhRpZRuidgXShgzV4pYOvK9B
	 f9E/PQOh2RkQ6/cXLA8tqiUMLYuO972gkO17EOqU3EknMrUBjoAnzW/HJ8QUgh0FMB
	 3sjBz9+O+SNUs8g0Pou42odQOh8m0K6qgQuBge4YhNdFOGzFXBhcQw4A++2cCmBEly
	 idHFXXNcyyH02WPQNi6qjM/X55C40/5v7SIgNW5SKNE29Z398hT7KBr2x58i7mk0jJ
	 Refe54fwd8lezbWr0hkrYYdK0t/2cn1NxP+aQmNYrhC1inYyH3DYdw59Yv+O7Q3PfK
	 pH5AKUpTfLSRQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3kpslyqskc_s2kdqjnhoylqjrrjoh.frpolqx0-hurivolvwv.r2odev.ruj@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=LO2Y9z6f; dkim-atps=neutral
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J36Ss73sPz3bNB
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 14:02:04 +1100 (AEDT)
Received: by mail-vk1-xa49.google.com with SMTP id
 k19-20020a05612212f300b002f9b9e6a997so10405966vkp.19
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 19:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=9NCi5pLHFkEAT0Hb+wWzpZFXCJ8TuJWqT2KCb/zV4wc=;
 b=2e9PdhTSGcPGy3wIMs255DyyxzN8NsIC+K0RkrQ7Fzam32cMJ7C+9KHW9wtWs632zh
 T2+11VNCu9ZRo5cLwvVhSRb1Og8K0lPsE2DO2S43fM2DK0nmEHKpkfYfTxI+eTpuSefc
 9p9Ufq2x4fd03rNP/+xftI3TqOjMhCRYpYPw/7up7nSav6jXJcqNomu89c5ss8oIW5uy
 udhwet1LKi/+7CsrFYpBb/f+CFMCZnMYbgZUgUui1VY4emXlAVXBaW2o8BaLW8MznVNV
 GWQvxpWiuHFAqJsQUQO1xTru7DQSRqpNeL7tnGbkILvCl7GLzdofDtii6Wi5qB7i0d20
 nW6A==
X-Gm-Message-State: AOAM531dRr+CYW/ArdOB4NShAH0PFx07m1X6qEEa/TjIb9/UOjasPNXA
 CBa+jcKlKza5iVk94jU0Ae4QalLflDgjxsxmDp5IR1ECHnUq/uFy0A5qBZN5cR0Yq3Tc7jXUcze
 ZAUYWCrKfPRqixJ2T1xu8bQC2OS1WnLjo3C/xVdA/7CKIKHhEgh8eXWar5L5EfjwfMBHew0vhe8
 eNJdIIOjY=
X-Google-Smtp-Source: ABdhPJypLGKL9Cmoxc7RwN6psTprDDIPmxkteHniRjI+ZuDG5Pa6agxunyfL+b6hnPlKCztR9ldGUnhL4GS2HYpe+g==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6122:201e:: with SMTP id
 l30mr42548600vkd.10.1638241322076; Mon, 29 Nov 2021 19:02:02 -0800 (PST)
Date: Mon, 29 Nov 2021 19:01:54 -0800
In-Reply-To: <20211130030155.2804358-1-zhangkelvin@google.com>
Message-Id: <20211130030155.2804358-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211130030155.2804358-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 1/2] Add android build target to build erofs as library
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 Android.bp           | 38 ++++++++++++++++++++++++++++++++++++--
 include/erofs/defs.h |  5 +++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Android.bp b/Android.bp
index fc84e6e..7973555 100644
--- a/Android.bp
+++ b/Android.bp
@@ -52,7 +52,7 @@ genrule {
 }
 
 cc_defaults {
-    name: "erofs-utils_defaults",
+    name: "erofs-utils_export_defaults",
 
     cflags: [
         "-Wall",
@@ -60,7 +60,7 @@ cc_defaults {
         "-Wno-ignored-qualifiers",
         "-Wno-pointer-arith",
         "-Wno-unused-parameter",
-        "-include erofs-utils-version.h",
+        "-Wno-unused-function",
         "-DHAVE_FALLOCATE",
         "-DHAVE_LINUX_TYPES_H",
         "-DHAVE_LIBSELINUX",
@@ -69,6 +69,15 @@ cc_defaults {
         "-DLZ4HC_ENABLED",
         "-DWITH_ANDROID",
     ],
+}
+
+cc_defaults {
+    name: "erofs-utils_defaults",
+    defaults: ["erofs-utils_export_defaults"],
+
+    cflags: [
+        "-include erofs-utils-version.h",
+    ],
     local_include_dirs: [
         "include",
     ],
@@ -86,6 +95,22 @@ cc_defaults {
     ],
 }
 
+cc_library {
+    host_supported: true,
+    name: "liberofs",
+    defaults: ["erofs-utils_defaults"],
+    srcs: [
+        "lib/*.c",
+    ],
+    export_include_dirs: ["include"],
+
+    target: {
+        darwin: {
+            enabled: false,
+        },
+    },
+}
+
 cc_defaults {
     name: "mkfs-erofs_defaults",
 
@@ -95,6 +120,9 @@ cc_defaults {
         "lib/*.c",
         "mkfs/*.c",
     ],
+    static_libs: [
+        "liberofs",
+    ],
 
     target: {
         darwin: {
@@ -122,6 +150,9 @@ cc_binary_host {
         "lib/*.c",
         "dump/*.c",
     ],
+    static_libs: [
+        "liberofs",
+    ],
     target: {
         darwin: {
             enabled: false,
@@ -136,6 +167,9 @@ cc_binary_host {
         "lib/*.c",
         "fsck/*.c",
     ],
+    static_libs: [
+        "liberofs",
+    ],
     target: {
         darwin: {
             enabled: false,
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 6398cbb..1ba920d 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -82,11 +82,16 @@ typedef int64_t         s64;
 #endif
 #endif
 
+#ifdef __cplusplus
+#define BUILD_BUG_ON(condition) static_assert(!(condition))
+#else
+
 #ifndef __OPTIMIZE__
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
 #else
 #define BUILD_BUG_ON(condition) assert(!(condition))
 #endif
+#endif
 
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

