Return-Path: <linux-erofs+bounces-292-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5B3AADA8A
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 10:52:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zspth52Swz2y8W;
	Wed,  7 May 2025 18:52:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746607964;
	cv=none; b=iL3Y87dRQLYXNpAGUyAONeFFTprzMDTkxVWB6VzYqtKCukAndshssLasPEWAeqLs/u7uKWL0z1KMT7bdDOHo5WFs2nptOGgqXXm2XTqd7yUHgTafnWVvie171gLW54KvcR0lZyn8MfOHxC5QCztAdMzyfIpIGEo1VmE1VJpIuTjhWCp+dfmK5DOzcxGcmPgEOF7Tk7owBQpJpICbePFO09ODrj0Pu7Q/E74RygSpQo7O5XQRDlyg+UXDAZOnXcptjvhDbMKN5+5r1uu7zwgGopsQCropo2KS8lhWy2kzpOObAK68HS4TdT5FCIaCYxPTxlknlXoEgss7du8USRoyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746607964; c=relaxed/relaxed;
	bh=+CnyOV07IRl0v8m6jeMov4kf/jJ2ETLfejuO0UiutE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0r2oG3I15SwBtlORiWkgMDNXpgFe3CF6pA4+DFAbIcFEgXKnBbJdEfEX+7mM9RCMlXcQYUejVJ2gwU0ZrhfaS5eb8F2rkp3CAHtla7VpHM/E0yMkrOw+ZKCLz3f1K4FjRnftpyhH2m/oZN3Sws3Jk6Wuh7/EJiJJxIGeAEvodhquA0HF781y9KenqMBwu29WQtVT9fPvCUphVNldNR8JWiWnh6eGmgnteLzgWl94EQYXLCrBbV2w40jRwgLB1OfFMb0hXB0vUK3w+4+wy8Io6IoT68f5yrSyNcPfOs8uSpQUBN+W0Bhm5R2eHwNubkanNweUaNBSFTaZPT8dznglg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rSrR/8Ka; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rSrR/8Ka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zsptg5nWQz2xtt
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 18:52:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746607960; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+CnyOV07IRl0v8m6jeMov4kf/jJ2ETLfejuO0UiutE4=;
	b=rSrR/8KakOfuJazpbkkTQEM0JBw3e3WKvmcm+H4LVCL3TUOLJjC5nZJWMCHjfIg6DQmI218R0OdaasQRuyUIVf8pTrNUfm9vPOiZxT8n/qwRppb6gnfKGnDdKRmoGTWt1HrYyfAEQOQw55f/PcSCI2y7b02gP8V8vdcLYiQ7/K0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZoa95v_1746607957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 16:52:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix `z_erofs_fixup_insize` defined but not used
Date: Wed,  7 May 2025 16:52:36 +0800
Message-ID: <20250507085236.1947828-1-hsiangkao@linux.alibaba.com>
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

Fixes: b08e804b1dd1 ("erofs-utils: lib: wrap up zeropadding calculation")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3f553a8..1f9daea 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,9 +9,9 @@
 #include "erofs/err.h"
 #include "erofs/print.h"
 
-static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsize)
+static inline u32 z_erofs_fixup_insize(const u8 *padbuf, u32 padbufsize)
 {
-	unsigned int inputmargin;
+	u32 inputmargin;
 
 	for (inputmargin = 0; inputmargin < padbufsize &&
 	     !padbuf[inputmargin]; ++inputmargin);
-- 
2.43.5


