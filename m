Return-Path: <linux-erofs+bounces-936-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D052B3A6B5
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Aug 2025 18:43:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCRzn29Xkz2yDH;
	Fri, 29 Aug 2025 02:43:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756399413;
	cv=none; b=g4A5eWUgoktyy5udH4uD3uu4ohgK4uqR4f9nh810Nny3CJkG6boiDciLv+ujZ32GjOjo9lKqv7+SO3HxEDtwn0gs5yH9bvPft6GHTvR29EqTxwAlc4Rfot67Mh8GAc2IAtssS0SH+V8dXIHoCgGEyv4UlxYzfF5z/f6zWQsHG1vkiBarcPji6qCvrIcVJX6/4Gg3uUPCFAAm7wJBIBleK8Ub0nXWhhIUAcKS+PS12tkvWl0VMdcTxWyLXSfrfVylAILCTAraRf6SZelXAgGwBgf7jEFywH4ey2FNRMbDi8rNFdP0K9a8guQDdsdEX3VMU6uFBBactzNWR6MXiC7uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756399413; c=relaxed/relaxed;
	bh=QqLPQn2O8cySqGVuaV5MWns+mO2yhRWMC8DCOswEVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxm/wbF5cP/YNLWhRuO28tq115A/9qlGc1DMBwsbLEaWbTOrF3bjVPVdXpmWu5m8Vjn43kIo/96qvjN/awlOZCJ1lKCo/Kc4NZja3rrShDacRRAiL4acmIV6195Uzr1WV5FMo710thKoui14uCuQf/j1WEYSebmjUnE6bPWoXMHFotiPw5VK2Z0A8FeVarL1qHQQcJrD6Q+7QD+BU41rQ3g++6BOMjsTOJOta/MeeTQHoFqbvBveokwAmkqYkR3v1cnQnxlVAxZijW9F59AdaJD4Q7QLM7mZo1sDyrt8qB/2Pm16LrhC7+T1EUSp0TSD6LtBLIMczuJMovjfji4ZuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DKAuLPzC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DKAuLPzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCRzl1yM8z2xnx
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Aug 2025 02:43:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756399405; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QqLPQn2O8cySqGVuaV5MWns+mO2yhRWMC8DCOswEVPY=;
	b=DKAuLPzCtYxturxN0VpBezBnYtqNlTAsI/CwI6azBlUc2N3tm5DYhAo850tgOd9U4c5blo27hxISoDVfqCLZ/5D6aSAO7ld0puqe8HsXYpA9ibloT9DDo7lHPLUH9UNVlS1TwX1qgVrIljaMw7965H3Iil4J5cLE2J18BZDi50E=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmnvG2L_1756399400 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Aug 2025 00:43:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: oci: use aufs mode for tar conversion
Date: Fri, 29 Aug 2025 00:43:19 +0800
Message-ID: <20250828164319.302040-1-hsiangkao@linux.alibaba.com>
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

Since standard OCI images use aufs metadata instead.

Fixes: bf7e2b01a93f ("erofs-utils: mkfs: add OCI registry support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/oci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 0fb8c1f..c8feb98 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -781,6 +781,9 @@ static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *
 	int ret;
 
 	stream = (struct erofs_oci_stream) {
+		.tarfile = {
+			.aufs = true,
+		},
 		.digest = digest,
 		.blobfd = erofs_tmpfile(),
 	};
@@ -830,9 +833,7 @@ static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *
 		goto out;
 	}
 
-	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
 	init_list_head(&stream.tarfile.global.xattrs);
-
 	ret = erofs_iostream_open(&stream.tarfile.ios, stream.blobfd,
 				  EROFS_IOS_DECODER_GZIP);
 	if (ret) {
-- 
2.43.5


