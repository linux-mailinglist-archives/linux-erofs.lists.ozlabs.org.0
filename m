Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E144462B0A
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 04:26:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J370Q1wKYz3bhj
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 14:25:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638242758;
	bh=NkTxf0qyCwgZdM9uhvZ0VK+Mg/AINvrSaCHxTDbCqjA=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hhBU0wCbPbar5hg2sJpmRADcq1Uyg6mLmcyaGCAIsg+XAUL+1P/lAocUyxAfA/iHF
	 oKJQZKx3GN98otF2Mtskt7BaHta0yUmoURH5rtkniWPZjZ+KDWuRPXkb8JssNkPVFo
	 CVYHs4xeVHLbzv/yDGjhcbGRxTf+0s38XdsSEbiYdVMZ9lKDj4UVT+hoYwNvCXoqHT
	 rxs8t+Pq2em6aXRYQ2ncLuhRwCvOI/KhTIxKc+XoaXh80G3FLJiR/X6Ti37TBI9kdz
	 Q33rSzhA1trqeCPSBhPlx/HCL9riEqSlGlqyDymF8jIoOXMB3guo9ag62wTPnhAl3g
	 894+VwuS2A2mQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3vzmlyqskc5otb4hae8fpchaiiaf8.6igfchor-8li9mfcmnm.itf45m.ila@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=KV00HQag; dkim-atps=neutral
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J370L3NMHz2yn9
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 14:25:52 +1100 (AEDT)
Received: by mail-vk1-xa49.google.com with SMTP id
 q3-20020a056122116300b002faa0b9026fso10430335vko.18
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 19:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=NkTxf0qyCwgZdM9uhvZ0VK+Mg/AINvrSaCHxTDbCqjA=;
 b=VMIDx3gjpKmhKBaYTYbnXv4/h3azVXdNXmWxcUmNcWu+ikuiNEe9fgmvy35TqUONXj
 CpD/sHN2CyBLngUJiNY667nF+VPV/fFBCHtq0lwlSQ+oh9+3wPQvm0pBPg42nPrHTBEv
 leQD5YyaWu7UBgNqCHsK1cyvS80FIrHoK/oCcadpI3irgMLvBLJpfQZqdeF4Jkji0nZH
 kAQ+U6md5NX1vUl+G3N2hOlhH6iFy7Gv+LF1N+wFBfTmwl9iz/6YnmIAZOsADzR/ci54
 2iQSW0LfqhItKdpvBmwozBDcm3Oc6L8/ZRJOkrubMFP8eFClmJNvnuAJpxGKcXi4rfYV
 Sq8Q==
X-Gm-Message-State: AOAM532+O20QZ0IpfR7O+dK1qZkYB4NRHo0tCgzsIhVIa30BgMa1XA7/
 SmEl6tyqLh3LMSCh4e56/Z02PCYRZPPjGBsUJuQh49lbVUFpm4gZQUOOkmtdmu5pQpZ4QRN2Bf2
 r/3KXd87JmxcOfjdAmFuaAM6mVrm0ng9l9tEbnZhOiCmLi3QVkLqoibG18jKvXGVnIKxt8O2FuY
 1k/U9MmfU=
X-Google-Smtp-Source: ABdhPJxZD28lgmGGyDqYlhKT3ST1PA/udEzSHPFDGqOqDw2mmTLFDkxejanVsV6zceIVj+NMniXFvZmSl+TTOPZz9Q==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ab0:3d0d:: with SMTP id
 f13mr56717870uax.48.1638242749909; Mon, 29 Nov 2021 19:25:49 -0800 (PST)
Date: Mon, 29 Nov 2021 19:25:45 -0800
In-Reply-To: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
Message-Id: <20211130032546.2825384-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/2] erofs-utils: Add android build target to build erofs
 as library
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

Change-Id: I648ae5707ec94b0b5a13781dc22e2c47d488cb83
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 Android.bp | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

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
-- 
2.34.0.rc2.393.gf8c9666880-goog

