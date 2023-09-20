Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E717A8D73
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 22:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1695240222;
	bh=t6K/84xLDF3EMRdQr7xNfy7OwgVBXNRp/r+q++QAGKc=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dh2hdUi3YxPnVK/0+1CeFkMREDJbPDGWnv/ijcIUOfeW//7cHAeiaPER8dKFcajtp
	 /8MUuSq+Jnk9W0+IfNr3BjMJ6OwcITdqDZdgs783kRs8DWOLTdSyJmBqBRXhse9Igb
	 FvOBQB8JbQ/wq4rEr5BxgMVvy/mr46/5PXyur1DunIJ6HpFjub/KCqXlmyi2EwgZ5F
	 avV7moOJ9kTYGwiWFuY+wOCASRaKB3Dq4exibgnkHwWOt4it3DPGx1sitBG4WWBwA1
	 MrbKz4UM4J8GsEYJzbSL9FFTqCtebBW+pwSeXub5G3Iv8hIZrToOWZKfpi9+9qyEwa
	 uXzcpNzpl7NeA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrTxV5BSzz3c76
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 06:03:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=srs0=qdox=fe=aol.com=hsiangkao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrTxL5xV3z3bw9
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 06:03:34 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id AF10CCE1AE0;
	Wed, 20 Sep 2023 20:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1ECC433C7;
	Wed, 20 Sep 2023 20:03:25 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix build error when `-Waddress-of-temporary` is on
Date: Thu, 21 Sep 2023 04:03:13 +0800
Message-Id: <20230920200314.9193-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.30.2
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <xiang@kernel.org>

Actually, it's false positive and only used for build assertion.

Reported-by: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs_fs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index bdc946ac0c78..eba6c26d0253 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -440,10 +440,12 @@ struct z_erofs_lcluster_index {
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
-	const __le64 fmh __maybe_unused =
-		*(__le64 *)&(struct z_erofs_map_header) {
-			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
-		};
+	const union {
+		struct z_erofs_map_header h;
+		__le64 v;
+	} fmh __maybe_unused = {
+		.h.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT,
+	};
 
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
@@ -463,8 +465,8 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
 		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
 	/* exclude old compiler versions like gcc 7.5.0 */
-	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
-		     fmh != cpu_to_le64(1ULL << 63) : 0);
+	BUILD_BUG_ON(__builtin_constant_p(fmh.v) ?
+		     fmh.v != cpu_to_le64(1ULL << 63) : 0);
 }
 
 #endif
-- 
2.30.2

