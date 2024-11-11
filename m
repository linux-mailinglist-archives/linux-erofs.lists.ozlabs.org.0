Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE89C3AF4
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 10:35:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4CZ6xH1z2yfj
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 20:35:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731317721;
	cv=none; b=IK/cCwp5mIv5/5P3nLXPyhsaNFJERnP1dy3LZ4kydWIUDl4T4qQjzmoghbg3a3/BLhegNqPE3hRMQDmGEc2Wn44EZI6VUQht7mINW7sIIqAcldcGJn2UecuVjbtuRrDxL2CAWedjlWBl3VJiXIp6ajcc4GgZ2GFfAQNPwXZRakH42OCDxsFGU+j7fLGmkv0pL69rxvYH80G3Xut/zQqeDvfttRvHcdjgy38bwMPXW604bKIfIXzGTGuyXDUBeiw2owXEhbYbkPx70zNtHurG6XTt6Jtk8fDnm9GWl5nPdHJloC+IpmJui0jIeFzJ03w5R2PDcUJMzkRmfzuAtEgAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731317721; c=relaxed/relaxed;
	bh=imF9vXnbhK6tf9A//yaLBZDF5fuZWWgcXpd6NyPBo9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgwiIiQNq3WpUPoOZnHRmE2maBeweVLfZvT4z2XkGmQAbjjikgQ0ShgdsbKprVSS8YZOEussgY7kdfNtNhlg1jtKs7HBONnu3p7b7dYaP1yEkknGSJ7rV9A9JHFDwAUDMziWGAN+zQrznJpsUHEKxH6yhs44JZ76sprdmpO/ra5ErK/m2QwQ5UzolcC1tR0lVpTRqOyxk8fGX+Uh/am4PqYPR28ahr+1xM5XANOkDG2zAUv0FFfreYDOVpbZB6n0VXMiXCqtLIDj1CLZpficXRbHyp2TyHm5QiKQ/pJRqMvW3CJj8ev8pgzdQI5NEwrbFXrNtkXs7kIxgBVwLe+Sqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jw+4gNxN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jw+4gNxN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4CV2Qs5z2yG9
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 20:35:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731317708; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=imF9vXnbhK6tf9A//yaLBZDF5fuZWWgcXpd6NyPBo9A=;
	b=Jw+4gNxN7kbYq++zmjpl5vkhiQiKA2NnevGuNFl3SH4gsi2bMzXAO2JHC4Umia3pdaHpOrI8F21ycERJZi0w0qrghDj31JQHXbwNJ/nYxvb/gBJ0WDxJ+J93Q4ayXOpRngrFOzHgA8iSUqo25KgqYdFUx23+EESiMMJg2+ntnZU=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WJ91TM7_1731317706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 17:35:06 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: rearrange struct erofs_configure
Date: Mon, 11 Nov 2024 17:35:04 +0800
Message-ID: <20241111093504.3784696-1-hongzhen@linux.alibaba.com>
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

Move the content defined by the NDEBUG macro to the end.
The reason for doing this is to maintain a consistent layout
for all preceding variables when a third-party application
defines NDEBUG while erofs-utils does not (by default).

Fixes: ad6c80dc168d ("erofs-utils: lib: add erofs_get_configure()")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
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

