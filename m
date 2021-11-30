Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EA630462C62
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 06:56:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3BKs6HDVz305B
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 16:56:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638251777;
	bh=NkTxf0qyCwgZdM9uhvZ0VK+Mg/AINvrSaCHxTDbCqjA=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gizsx6fnCIEjycey7Cv1JoHQoFHFCB/DCUiiw5RixTlHyWFrsczpPlojbhL3w67Fk
	 xEpomCYs4U9nhrTiZg2FfALzqmgi+IY4ozHjme26AjcDcPgteJuDHJTb89GHUDo84i
	 uVtnxR+JW3TunwxhsgCsDBYTWHZcsz7O3FSEFIsBFsTcHmncO8e04SelNk2UzPf6CH
	 KnomhCr9pJbDusVOeL9WQcONHeVejOr2VtKNxiRc+VsoBsMvDnUoLIQMJtTu8Drehy
	 DPrgcEJIk4lncBcnXvXgtMM5a6IX1RvQCUHxqhzWn6OAg0cnAK5SOyc053I+oobQay
	 wmIpwekiqGsAw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::f49; helo=mail-qv1-xf49.google.com;
 envelope-from=39rylyqskcxsq81e7b5cm9e7ff7c5.3fdc9elo-5if6jc9jkj.fqc12j.fi7@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=DjISNX12; dkim-atps=neutral
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com
 [IPv6:2607:f8b0:4864:20::f49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3BKl6pVPz304y
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 16:56:10 +1100 (AEDT)
Received: by mail-qv1-xf49.google.com with SMTP id
 kc26-20020a056214411a00b003cabea18f69so26634274qvb.19
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=NkTxf0qyCwgZdM9uhvZ0VK+Mg/AINvrSaCHxTDbCqjA=;
 b=0SnEGLkqFgcBi+01x7zvWgYj39EJljpEvfl7Bs6mu7A+sxGoziqwVq9oSIhygSzKfd
 PQTVFnqlE/n7dETbpB1EpsCkqtopgBaA16Wbt5HWZgO+wKU4S5I8T2eAVBt6eGbboGYG
 2fgBRY2YB9flNc+8mhbhkAcK0SDtLoYPDM40KdhJ0Tanc6gMU7aT/hK9b1nEW046afSG
 4WuQVGgfWGBK1Gb/2oA5txdbmMQ6nlkcDPce21HOI0ObLodU2uto/4LnbyZ8BgRhxH8d
 wpo2leCykaiLb5SPI4g9NuSX7fm25xrFvxBHIBoh39yXnjPR7y3bYCE0GiM4SHNpU/Dy
 a4Yg==
X-Gm-Message-State: AOAM531wdeEmjXxiyIy9LMdkUK4oo4HGc+VoVBJuMP56JK1Jy+IMRHko
 NvTYJTKcV1kkib9XAQOM+zNNNQ+KwapVmxbhgNJlCcYlcYRVzisD3EdymxLqzChBYtXZfjJaTv5
 pPkWrP6EnZCX6w4CUl9QfSLtYLyz0w7DEbjxA7+jC5XGkr3weR52tko42ND1FgXoUIkfPSk8bls
 odvEtBals=
X-Google-Smtp-Source: ABdhPJw6RjY0BdKeyrK07YzEMFQe34qgowR9qePx4NO414s0wEKwPeQ8OtDtk4kB3wNyr8R4i2pOKY825bCMpn9qpw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:5855:: with SMTP id
 h21mr45915419qth.8.1638251766381; Mon, 29 Nov 2021 21:56:06 -0800 (PST)
Date: Mon, 29 Nov 2021 21:56:03 -0800
In-Reply-To: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
Message-Id: <20211130055604.2876828-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 1/2] erofs-utils: Add android build target to build erofs
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

