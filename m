Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B09C3B75
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 10:57:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4j72tz0z2yfm
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 20:57:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731319049;
	cv=none; b=AumNu3F/2LKEuaE4a/sZb0hKQIO14anCU/rxQqSYJ0tEi6SgotdU/f3B1RW6kNFGwBcbU4D/dSUlC6s9svSoJtcE3gUrjS2TJIWEbCBXO/AlVhlZM9REO4YKjZmVpjMkV71jj14DkWBZxeKl2B4lj3HQwpHzmHZPvQ2+T4Th1rZW5B5G6sAI+h3TRUeOK/Rkeat8Edd0F1n8GUykSnTrxmm6WifpxNNv8RBicJwDGjMRghEZNThWNM1nM05m0ueitKCv2SjwuA0U4UU7fL6Hmm5QOOrSEYpqQJf12/Sc73dkgwhKNZp+FOQe/1TO25vyVcO7jPzTxWxof3gZEi8H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731319049; c=relaxed/relaxed;
	bh=YmA0VIaoJBVV4lX/XMXIFFsO4eIrTIesAIsCdbSQagE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=far2cc9O+CNIeymUrox+bNGQyna8hjMWPSzj+ei+trxK1aZhC3ljrLeYPNrIio/UuWYoII2SHi5v71aENdBBsE0nRIApfMDVS8wSYxkHt2d61Ro2+5mjjFLKOe5uLVIr2/pfQkkc8vk40oFW05N+fmVaf9x8MZv0Mz9wVGjuJYL9Yn2pNxmkI6mqcCU7qZ/G4vpAgwuILTGCBx8F8G8xYGrUdYT2UwaXZ6dOs7Awhzj/eHrW9muthC2iWmjiKlbYQaufjb4VmHASQBO4Kij+YQfWRpfXFNgt2xyJSZBARQdxwTNLr0EUdm767iXkeifSUAsxH8bYboKuJ2InIicPog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mae6BOj/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mae6BOj/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4j22j2Bz2yF7
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 20:57:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731319040; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YmA0VIaoJBVV4lX/XMXIFFsO4eIrTIesAIsCdbSQagE=;
	b=Mae6BOj/FXCKV4dbMzbnQe/jEJ+XHn3wxarhno8fp1BIbCqJwIjr4iFzrQ2JKnoPGogpu5j4CbUYtLDFMjyi4zALaMv+2slNehP6fqSDAV+xSsU3uiLfLgIaiol1qVAq02uypFLJZGjnPk2XdP1hIKOmg5Y1snIJbhVbdTCS8fc=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WJ90UiV_1731319037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 17:57:18 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: rearrange struct erofs_configure
Date: Mon, 11 Nov 2024 17:57:15 +0800
Message-ID: <20241111095715.3814956-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Move the fields controlled by the NDEBUG macro to the end
to maintain a consistent layout for preceding variables.

It addresses cases where a third-party application does not define
NDEBUG while erofs-utils does.  Ideally, third-party applications
should use the same macros as erofs-utils to get a unique
`struct erofs_configure`. However, since NDEBUG enables unnecessary
assertions, restructuring the layout resolves such inconsistencies.

Fixes: ad6c80dc168d ("erofs-utils: lib: add erofs_get_configure()")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Revise commit message.
v1: https://lore.kernel.org/all/20241111093504.3784696-1-hongzhen@linux.alibaba.com/
---
 include/erofs/config.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index ae366c150232..cff4ceadb7bc 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -46,10 +46,6 @@ struct erofs_configure {
 	int c_dbg_lvl;
 	bool c_dry_run;
 	bool c_legacy_compress;
-#ifndef NDEBUG
-	bool c_random_pclusterblks;
-	bool c_random_algorithms;
-#endif
 	char c_timeinherit;
 	char c_chunkbits;
 	bool c_inline_data;
@@ -94,6 +90,10 @@ struct erofs_configure {
 	char *fs_config_file;
 	char *block_list_file;
 #endif
+#ifndef NDEBUG
+	bool c_random_pclusterblks;
+	bool c_random_algorithms;
+#endif
 };
 
 extern struct erofs_configure cfg;
-- 
2.43.5

