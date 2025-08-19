Return-Path: <linux-erofs+bounces-830-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC247B2B6DC
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 04:18:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5YCS28W8z3cdT;
	Tue, 19 Aug 2025 12:18:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755569892;
	cv=none; b=WLFbsHB1k2hI93PbHW8QKZQfGjIOWbD7DNVtnl1y82mlnFOXp8uVg+ugj/7P6w6GXWaJAI17pGAiTbAFW3zf5cRDcJPjwV5PB0TOwzusGTt/qlMILlgYOTV3zVgSjw/7VLK/X0K/AzHajQzZo2ZBkTAt44qx1QDwGp+KGuqTyn07PuhQyF1wc3ITF7PqGGt/htutglpJTAmtTkSGVcZRQIVoF91sqY4K0uQpjDxB0fLeNVhr72vKeKont+TKB5e6eH2PeExPnwsjKphl2CFAeKhzAMuaNevwDmWo/ogOQ6/2qQKIe7IRAVxG4LIdyLCptuUiICl8HH1I6L5TjA+JoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755569892; c=relaxed/relaxed;
	bh=ct5boXDIGQLvW8vhSW9KgbqSm84LazLVuA1mUw8ksKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCB50/6kvXflBQ6I/KUUv9l+kCJqzGfBq0cFI8Dfuw4+DHIN8UtUtpO4J7xFOspmC9wpCEC4nD3e32p4RIu48WWNDDKO8AHEo4tR1BqT5Gk7xalWLY1WcHwMGEkZzOnmUED/00XFSIyOGf3N5kUFXvwgyutQtajuc8OK+Lb7SBl+Wa1RemUNq4y9iP+TK6bSlARJPB6W4s2EQH+dW7st4k65Gv3MNMSNwsdQE0DoAbufodNrZr6ig1d4jtYcd44VD0yO7ASvLt8XQ57+gZaYY67Q8FR6AntRCkW9v7Px8ZBQuHHl7VTzf5ka+aSvW45Hw/MrDeUTAxtJSi4k3AHdBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BY4Bk9Hn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BY4Bk9Hn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5YCQ2szDz3cbH
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 12:18:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755569884; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ct5boXDIGQLvW8vhSW9KgbqSm84LazLVuA1mUw8ksKw=;
	b=BY4Bk9HnYIO8fbVSacfQAW8CDUR9KYfiLxfYmOaUPNWINsHX0s4/5nM8crF2YWCOqhax202Mcky3z3Csf9fIQyrrTxN6C08AbCPVE4Ed4OYFYsoQeGqg2vVoVFMltRhGMIpTqlWcJaqf+wHLNt7+nCcG4xR8sweUXEmnHZ8yDPM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm4x7Zv_1755569879 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 10:18:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: enable multi-threaded build by default
Date: Tue, 19 Aug 2025 10:17:58 +0800
Message-ID: <20250819021758.3465553-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Remove the EXPERIMENTAL tag since it has already been adopted
by various distributions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6f2421d..1efb57a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -111,10 +111,10 @@ AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils supports]
 
 AC_MSG_CHECKING([whether to enable multi-threading support])
 AC_ARG_ENABLE([multithreading],
-    AS_HELP_STRING([--enable-multithreading],
-                   [enable multi-threading support (EXPERIMENTAL) @<:@default=no@:>@]),
+    AS_HELP_STRING([--disable-multithreading],
+                   [disable multi-threading support @<:@default=yes@:>@]),
     [enable_multithreading="$enableval"],
-    [enable_multithreading="no"])
+    [enable_multithreading="yes"])
 AC_MSG_RESULT([$enable_multithreading])
 
 AC_ARG_ENABLE([debug],
-- 
2.43.5


