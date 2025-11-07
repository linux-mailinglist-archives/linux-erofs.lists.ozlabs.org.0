Return-Path: <linux-erofs+bounces-1355-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44195C3F50C
	for <lists+linux-erofs@lfdr.de>; Fri, 07 Nov 2025 11:06:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2vpm4kGbz2yrF;
	Fri,  7 Nov 2025 21:06:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762509984;
	cv=none; b=gWveD4dH4CJhyQZdd5sndO+4QAaY2By6i8Me+b/qm1fmsmLkP9SF3Ndc2XQY5XB7ihKAaAFBhmFJ60rOG+RRRnuJuW1gvfw2OkM6xBrfBzX5ASEFwkuW8g1wzjJAN8SWeXNzY0SaXtyNNPLmJDsX8ItRuhRKXmSYxT0eu+yu6gHEj/UZwkS2n8i9dzsWlbJ+JIe2NHWg1utebzA2SUKjbxMywbKVE6ZMGrgxYEZE5dN7qWKxf9gcHyd/EQRdRChMDBDebZqImXTgLcbalsBRw2chZrkQgpOSljHjCK7Rsal2HAG2jZbq7FSJQmo1Wo+/0OBjMiLYEI/y+AdSi3fyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762509984; c=relaxed/relaxed;
	bh=3E7LBdmduLtIN0rZqdPWrmP4k5VI78REmJ5KoGRBtYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IszDI1ebLmCgCrwMkwX9Jl0Njnv7jzfqqJU+2fMRobZbaPkgvZ67V1rsH3Ja2c+M5trOu7JasEkIF60HdZhGMHqX6jhvAgu7bXCNEtqz6FoWJjSbcA4QwEz/rxim8gmFReC2qZcxkFuvhIBchJehSBW9oopKhxZNSbnMiLUpsxfgVmvPjawM4QsWN39Byep2ijgHlGus+Eht3n/C9CupuUnGqB3aA+p0dqJM5wmzlct6UFYmCxdzTXgvdKLnazWPCPWPg1pJqSfc5rD7RSi0FfxzUg522d2Ln9ZtdN6nxsGrtBBD983eeihbI0R9z9ABN7RVGBwgGpcomFt3qEFZKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yKo97wm4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yKo97wm4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2vpj6Cy8z3054
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Nov 2025 21:06:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762509976; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3E7LBdmduLtIN0rZqdPWrmP4k5VI78REmJ5KoGRBtYM=;
	b=yKo97wm4u8qfb0elW9qllqmGTIh7HjqwwTjlljkOh1knO31DxaXPQxE34gv+9hmX54rg5nq1/gaob1tFm2Wvi955krE+RZUSpqg/ir9nsMlo/laUShur6KeQU47fZv53Ru19tw5BKSH3g0MjX44bkGpQFNi89Xoiv8JKqH/Xd6M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrsiSUb_1762509970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 18:06:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: mkfs: fix unintended multi-threaded disable
Date: Fri,  7 Nov 2025 18:06:07 +0800
Message-ID: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
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

Fixes: c75cfaf6956d ("erofs-utils: mkfs: Turn off deduplication under chunk mode with '-E^dedupe'")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 3b4d230eda21..7a5d4374afe2 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1743,7 +1743,7 @@ static int z_erofs_mt_global_init(struct erofs_importer *im)
 	if (workers < 1)
 		return 0;
 	/* XXX: `dedupe` is actually not a global option here. */
-	if (workers >= 1 && params->dedupe != EROFS_DEDUPE_FORCE_OFF) {
+	if (workers >= 1 && params->dedupe == EROFS_DEDUPE_FORCE_ON) {
 		erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		cfg.c_mt_workers = 0;
 	} else {
-- 
2.43.5


