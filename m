Return-Path: <linux-erofs+bounces-1090-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7FB987BC
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Sep 2025 09:18:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWp8t5vYVz2yxN;
	Wed, 24 Sep 2025 17:18:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758698286;
	cv=none; b=gIFYf5x/UChnRikp1zHG3ON//pQntzKDFBWOG35lNRTLxXSxhG1HX/pM5AjY7dPURNfrM3NCDH+EPgd0v7mWWI2c5bIeqrYqNzIMIMQjHDfmUc3M2/+DpAxCB3nGA6645MFG0YRRgW56wa8apTCHysGuJzgsq70TGQzdRyS/zED2rewkqgrz7NjXXPj3UKqxl4xOMI+24/+bgwj36x4tn9/n9/eMzNJmx0GA9d23/hSTuUEMhev5qSPDagWldPpIZSflfyqmSw2PuVp+VQ+DbJ/1QwsvfbtRQrorFPQPgbalgZ1XNmSbkRR7BCPNu76XvpEjWHSkz1MkT7Rta5Z51A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758698286; c=relaxed/relaxed;
	bh=+iyT1NI1nCtgN5MlG9V3F/29GRvDnMoKfTHJp1YD778=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWSB/KKKH9wHT9zn7/u3GVl3xn8kdtVo//5eoVeepXw3ZzsROheHmNi7hMq8Om/SWCItcbjsnEzO+lHwZ2Ncf9/wxiRxO38vHE/K6p10XCD4oHHfia6XIlLsPHCI+gDxq5QFCWPM8N0MbKueDAyQESXMgxY57aurbqDErC8YR5XEyns6KRXY1jkxaK9JRA7V8sr/GElGhkHdAK2w0RLVJNLciaGjYLSmH/bLQ0JjoVz6ILWHR6AGjD5/M2LoJu6NtwA7xV2SLg82DwbCUSkLIMHLr1D4mIuIH8No1/vYWuaumS2LODwCbn/ykrYLJkQ00MV25QQkaQLmMPa2QmpVeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SxFr3heA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SxFr3heA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWp8r5xQNz2xck
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Sep 2025 17:18:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758698279; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+iyT1NI1nCtgN5MlG9V3F/29GRvDnMoKfTHJp1YD778=;
	b=SxFr3heAxwy50ZtpDf/PWEeHZLMjI6tW8HJybHF66vJAS7zO093BuqPamY0mtctNZbTO8lHDci7/j+GfcgFVL6xOPJ4Bk1zDRDjiqVryfCT5smCVqwm1vTa3ji2N5d9GAyULcPYxKHzaRTfwB4pBN0aw/bqQaX2ir8rSsUEl88o=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Woic6Pa_1758698271 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 15:17:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: dump: avoid SIGSEGV when time cannot be represented
Date: Wed, 24 Sep 2025 15:17:46 +0800
Message-ID: <20250924071746.1859784-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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

Just show the raw time in seconds since the UNIX epoch instead.

Reproducible image (base64-encoded gzipped blob):
H4sICACa02gAA3JlcHJvAGNgGAWjYBSMVPDo4dcHvU4WITpANg+DCgM7VPwFM0INE5L6OzNL
tafaus7ZdHvpkTy+2l3o5rGjCxAAIGsOODIzlDD8/v//P0gEQsKACphkZAG5QgUqFgpka0LZ
4QyMDKpQdgJQPAzKTgWKR0LZWUjsfE4oIydVLzk/JyUtMyfVAEQYgggjEGGMbD/QYoa3jYwM
KUCaA+y6//8ZkeSLK6uyE3NyUovQGaz/YfZgSJHKwBd+YPc5MjHYQvkg94HiK6KjuRHE14OK
GyCFnyGQbQhlGwPDJhjKtgDGnp6eHiJIkPwvxYIwHylpoPmfiQq+RWcwk69dUJcG7hllDHUG
I7oIKEPDRcTe7jqNqesp5bYzYs0ydGCACy4gwJC6xEWZyWxQH2FVgyifQKW3OlL5xMLAAi8/
9EtyC/SBGnQzcxPTU9NT84yMjM0MTAwMTI30wQURhMQo9/7Ayz8OcPnEhWQ+K46yko2RjaEi
saSkyLCCgQFIwvlGEBKpxA3elv8GrIcJXP4xMWgoQ8wARSLY2zgqOkYoZgLTIJYGM3aVo2AU
jIJRMLAAABdVKPsAEAAA

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 58d489c..f685799 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -379,6 +379,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	char access_mode_str[] = "rwxrwxrwx";
 	char timebuf[128] = {0};
 	unsigned int extent_count = 0;
+	struct tm *tm;
 	struct erofs_map_blocks map = {
 		.buf = __EROFS_BUF_INITIALIZER,
 		.m_la = 0,
@@ -411,8 +412,11 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		path[sizeof(path) - 1] = '\0';
 	}
 
-	strftime(timebuf, sizeof(timebuf),
-		 "%Y-%m-%d %H:%M:%S", localtime((time_t *)&inode.i_mtime));
+	tm = localtime((time_t *)&inode.i_mtime);
+	if (!tm)
+		sprintf(timebuf, "%lld", (s64)inode.i_mtime | 0LL);
+	else
+		strftime(timebuf, sizeof(timebuf), "%Y-%m-%d %H:%M:%S", tm);
 	access_mode = inode.i_mode & 0777;
 	for (i = 8; i >= 0; i--)
 		if (((access_mode >> i) & 1) == 0)
-- 
2.43.0


