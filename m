Return-Path: <linux-erofs+bounces-1499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC05CC1836
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 09:22:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVqfP47bnz2xqj;
	Tue, 16 Dec 2025 19:22:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765873325;
	cv=none; b=WctLYzbp9G3z9cp6rxEw6WKEaryPv3PY38GyQQ0KWQ99xmORUdq4ghJv3ceQjYVsSWUNJ0thuX8qxjlw9XD+Wc46n5rhfFBIB5DDmQGSV4VccdURF+YMssN5JnPIWFdy1Aw2SSc5H3UL1aAFL+qGFSnc8kz+C8mM9hZv51MGocUpRisB3i37FTcDt2IxPT1SBcURFKVyffB0GjHH6JajeBFIYP7il2dir0Pm7N5tXtqgyTsFiGg5g4v0oeHSwD/zUeEwuWnKcSBfGaPXTvOIyZ5Y0+Asb6DfhT3n9cf2pCP8mXyDkf2ZMS8B67ejtGgFF9RAnMZtBmsHoJBCJ9RRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765873325; c=relaxed/relaxed;
	bh=5TEL7W6YAIclZ7iiU0lGOdRmFx9gyLCGCWTWqp7Bh7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idEksvZcJ0cp+RUCcMNC11tzALBQBIphLf6EocDnUVqwgoevg3V6u9B8Ac+a11rudzeaMBhgE19qEaz6gBXBrZwRIw5eMyq53eVZL2S5EFPrblIHwLVHenRox+bAdXzP4pzKcwYqoecrW6RxRStkP2OWbmDqcbowqIOYidWgmoGHvWb9k4ukzEAtpzPnpg908Gs4ZqdPEWLSK7QGkOhMcJ+j2eL668BwpT3AuadHwhO0XAT/O3hgib+08uUQZdecVlfUBee8TTNh4soBuOjEdcMlCuza+nYr8z53/igjYcMbraVDLJlNva5PXPh4f/GPECaPCoHXBeuBDp4wM/KP/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BtSGMgYj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BtSGMgYj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVqfM5J5hz2xqf
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 19:22:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765873315; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5TEL7W6YAIclZ7iiU0lGOdRmFx9gyLCGCWTWqp7Bh7U=;
	b=BtSGMgYjRUwIZC8vp2sD07XnYu1pRheiJQtAtmtKBL7tARcmCuyktRgrigleFyBp1daDz2a1IknBzq7vKRwamjJzHkQBnvITN5B1P+YaXa/r0lztU6/G1MBhU+859oCgpG+8nmDt26btBaM2M+ElIdCuS8WfAqi5BmxQqbQjBA4=
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0WuyVD66_1765873310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Dec 2025 16:21:53 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] erofs: make z_erofs_crypto[] static
Date: Tue, 16 Dec 2025 16:21:41 +0800
Message-Id: <20251216082141.108624-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Reduce the scope of 'z_erofs_crypto[]' that is not used outside of
'decompressor_crypto.c'.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512102025.4mWeBSsf-lkp@intel.com/
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/decompressor_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
index 97b77ab64432..ab0c0032d199 100644
--- a/fs/erofs/decompressor_crypto.c
+++ b/fs/erofs/decompressor_crypto.c
@@ -61,7 +61,7 @@ struct z_erofs_crypto_engine {
 	struct crypto_acomp *tfm;
 };
 
-struct z_erofs_crypto_engine *z_erofs_crypto[Z_EROFS_COMPRESSION_MAX] = {
+static struct z_erofs_crypto_engine *z_erofs_crypto[Z_EROFS_COMPRESSION_MAX] = {
 	[Z_EROFS_COMPRESSION_LZ4] = (struct z_erofs_crypto_engine[]) {
 		{},
 	},
-- 
2.19.1.6.gb485710b


