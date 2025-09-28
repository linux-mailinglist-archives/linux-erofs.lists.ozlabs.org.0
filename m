Return-Path: <linux-erofs+bounces-1123-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E2BA6903
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 08:32:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZDym32lvz3cYP;
	Sun, 28 Sep 2025 16:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759041168;
	cv=none; b=PsQnhAyHhfIPj+Aa8XV2mRmAqHQ+IEpNGgizSL+Q0IcAl44v4QSj0m1Kxw8ij/xRWGMrF3nOJavsp1pFiTe/ewYfLDaUUNRhHx/rABh+RZ2NhttsmkpKO1+p88VluirhHfs+jF6VEodvHA1Erax5v0xiiOl+8EFQs5YNYfbVkkysQC2EH8Ga0UIBFDfPhIkm3Yr1QsCaujVK8qh+ZF3Hwzyf+Uokb+nygIR6Ijh7Qt4R4kP83EubWcpNHhy+7njbKEkxl4hYMvdAqgZ6bn/MIPJSibqkf97A7Me9vULeaArFC94P4RbWrXTOWylT8FhASrhxksnd6YMYAVj+F5hyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759041168; c=relaxed/relaxed;
	bh=PhhqHkw6muA41Uc9iKImTHqBVin8l0RVkI7IlxVVEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzpobZV6VMtERKzpPpgea/FUS13ky4lAiKAJ2irVqHs5fZiOFTUAPgf7/w83kxxtNs+9vYnNbTk4/zeeiaI/UADil6Is5Ct3ghXl6Lf60TMlVoomnFqCMwVon5t7Zdx8jo+5AZ3BLfvfLPF4Tab1T7n4QsB23/xuw6AkzDwEVSFp1Fc27j4hMr91KAz3CU2D0IWfnU3iQhbQimoXU/+0QAJLwv/8dcmYJ5OzReouuLnoGj4ZQ+gF9d6uXaGQp7nt26VSHfIRcMlXrsEn8jTr7GNylP0FGdOBFQrJRpLRt61So3ZTHeutS8h/whXfm8sScWAz3pn7TPSBqZmJ3Xweyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KZLXCWaE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KZLXCWaE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZDyk1gLMz3cQx
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 16:32:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759041159; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PhhqHkw6muA41Uc9iKImTHqBVin8l0RVkI7IlxVVEAA=;
	b=KZLXCWaEqX1H9Lb+WaLeNlmm2bXff7ZouRncNUXPP6vOE+zcf7W6M7UWSkmNseSsXlXy6wexuHaxWoBKzgw+uN1C8AqRlsmvbE0AuhFqSOndBa2gjNwd1dB1XHvUvRGcCiKPfAAnvpA2bZ08rrtadeFPqpAON5QCnr7zdjxt0cE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Woy6mJ2_1759041153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 14:32:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: mkfs: fix incremental builds with 48-bit layout
Date: Sun, 28 Sep 2025 14:32:30 +0800
Message-ID: <20250928063232.2613721-1-hsiangkao@linux.alibaba.com>
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

Fix erofs_lookupnid() because the root inode can be relocated
in the 48-bit layout.

Fixes: d41a717721a2 ("erofs-utils: mkfs: support 48-bit block addressing for unencoded inodes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7b80530..0b5e77a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -414,7 +414,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	if (__erofs_unlikely(IS_ROOT(inode))) {
 		if (inode->in_metabox)
 			DBG_BUGON(!erofs_sb_has_48bit(sbi));
-		else if (inode->nid > 0xffff)
+		else if (!erofs_sb_has_48bit(sbi) && inode->nid > 0xffff)
 			return sbi->root_nid;
 	}
 	return inode->nid;
-- 
2.43.5


