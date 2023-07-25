Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C7760D94
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 10:50:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R99jK3Dptz3bnx
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 18:50:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R99jB1Z5tz30fZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 18:50:35 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id E746510093943;
	Tue, 25 Jul 2023 16:50:31 +0800 (CST)
Received: from lee-WorkStation.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9350B37C926;
	Tue, 25 Jul 2023 16:50:27 +0800 (CST)
From: Li Yiyan <lyy0627@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix compilation error due to const static init
Date: Tue, 25 Jul 2023 16:50:20 +0800
Message-Id: <20230725085020.904884-1-lyy0627@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
Cc: Li Yiyan <lyy0627@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

gcc-7 and earlier versions fail to  infer the initial
value of a const global variable from another
const global variable. Therefore, compiling with gcc-7
and below will result in failure. In fact, for global
const variables, using macros is a better choice.

Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
---
 lib/kite_deflate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index f5bb2fd..91019e3 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -47,6 +47,11 @@ unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
 #define kMatchMinLen		3
 #define kMatchMaxLen32		kNumLenSymbols32 + kMatchMinLen - 1
 
+#define kTableDirectLevels      16
+#define kBitLensRepNumber_3_6   kTableDirectLevels
+#define kBitLens0Number_3_10    (kBitLensRepNumber_3_6 + 1)
+#define kBitLens0Number_11_138  (kBitLens0Number_3_10 + 1)
+
 static u32 kstaticHuff_mainCodes[kFixedLenTableSize];
 static const u8 kstaticHuff_litLenLevels[kFixedLenTableSize] = {
 	[0   ... 143] = 8, [144 ... 255] = 9,
@@ -75,11 +80,6 @@ const u8 kCodeLengthAlphabetOrder[kLensTableSize] =
 
 const u8 kLevelExtraBits[3] = {2, 3, 7};
 
-const unsigned int kTableDirectLevels = 16;
-const unsigned int kBitLensRepNumber_3_6 = kTableDirectLevels;
-const unsigned int kBitLens0Number_3_10 = kBitLensRepNumber_3_6 + 1;
-const unsigned int kBitLens0Number_11_138 = kBitLens0Number_3_10 + 1;
-
 #define kStored			0
 #define kFixedHuffman		1
 #define kDynamicHuffman		2
-- 
2.34.1

