Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6568FD4B
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 03:48:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC1X24Qjcz3cff
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 13:48:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC1Wy5wDXz3bV1
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 13:48:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbE3e2D_1675910906;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbE3e2D_1675910906)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 10:48:26 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	huyue2@coolpad.com
Subject: [PATCH v3 1/2] erofs: update print symbols for various flags in trace
Date: Thu,  9 Feb 2023 10:48:24 +0800
Message-Id: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As new flags introduced, the corresponding print symbols for trace are
not added accordingly.  Add these missing print symbols for these flags.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2
---
 include/trace/events/erofs.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index e095d36db939..f0e43e40a4a1 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -19,12 +19,18 @@ struct erofs_map_blocks;
 		{ 1,		"DIR" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",	\
-	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
+	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
+	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
+	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
+	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
 
 #define show_mflags(flags) __print_flags(flags, "",	\
-	{ EROFS_MAP_MAPPED,	"M" },			\
-	{ EROFS_MAP_META,	"I" },			\
-	{ EROFS_MAP_ENCODED,	"E" })
+	{ EROFS_MAP_MAPPED,		"M" },		\
+	{ EROFS_MAP_META,		"I" },		\
+	{ EROFS_MAP_ENCODED,		"E" },		\
+	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
+	{ EROFS_MAP_FRAGMENT,		"R" },		\
+	{ EROFS_MAP_PARTIAL_REF,	"P" })
 
 TRACE_EVENT(erofs_lookup,
 
-- 
2.19.1.6.gb485710b

