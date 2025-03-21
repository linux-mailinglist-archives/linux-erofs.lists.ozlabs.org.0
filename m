Return-Path: <linux-erofs+bounces-99-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E3A6B737
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Mar 2025 10:26:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJxs66kf6z30NY;
	Fri, 21 Mar 2025 20:26:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742549178;
	cv=none; b=X1IITp7tp4QZopBxymREJ1xytlkXTKtHA7NofLh5slGF5dnKVPt6WY5RFIG6E5GzV9DV7taUYgLegUKvqxszfByF5pA9yqKvlcPVyKxGbCGnHqCj78SamM9k8Odmx99/GVknbXVIwHV8L9oX9Nn/d7ZYrMg7lgbMIUnDq4HY7OspCWbRaH77FrMrCB/vr5w84gYlUgrUdBdJ9O9uqhZukzFU/EcbPGQ+13fLAIVyaEpJeAJW25kMy2ZBvEXBQ/Gyjl7NIcC0nlrox6j7XxXyq1+kkoJ9lx9qnxjG09jks4727E2KQq8evl25hVllY/YlF0Ll2d403o1Isho5Iy8LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742549178; c=relaxed/relaxed;
	bh=HQuMzy0mtdQyVlz18wKzSgQKM/OIzvHN0fS35O0H07U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZK4/WyP4qXwnCdmu6GMA5NUfrTu+y6ayhbjorEGURNlFbsOuhUz0niEzE9ah/3Nx0fJTKpFsWvruwOUb2GKGx43dG6ocECpfOFcdPHPKjDIRlhcNN19omsVRO1ASFA6YYNW8tAjRLuhYnbWDoP1QFTpoWWYUvPpCLFO2n6MI+hTXCoL55c3xlZTu+m8C4J++FGHngcosBo0Ivd4yOtxGq6oX+4OJ+Gw40w63WjnpMG8IafFeDLu+Z3YOulsv3r5pjC4GZ8RgTjFcpD/x1NpMv33EBbW0KDZXHsii513dx05BsQTXPYoahLLOk50LQIlf+orM/9cXwaEl1Y22zP47Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Yp/RjduK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Yp/RjduK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJxs46JTqz30MR
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Mar 2025 20:26:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742549171; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HQuMzy0mtdQyVlz18wKzSgQKM/OIzvHN0fS35O0H07U=;
	b=Yp/RjduKb9sCxwnN1Mx6GQI5/4+JP4+7InkJq5PDoxTUeJm7Jdngoe9F0mfB3+EEXrR3ndDmuZOpcmgHVilv2NZxvOcfHcWsM8cCiY4nvP0PpVcVrJeTyUoUlnOGSkiwSIdo3ikAE5KyTWiqgIa6AEOmvYEl6DKRhqMPst9mogo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WSHd3YP_1742549164 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 17:26:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: fix heap-buffer-overflow in fragment cache
Date: Fri, 21 Mar 2025 17:25:59 +0800
Message-ID: <20250321092600.3703493-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Allocated sizes are slightly smaller because the bitmap is `unsigned
long *` instead of `unsigned char *`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index d300439..fecebb5 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -44,7 +44,7 @@ struct erofs_packed_inode {
 #if EROFS_MT_ENABLED
 	pthread_mutex_t mutex;
 #endif
-	unsigned int uptodate_size;
+	u64 uptodate_bits;
 };
 
 const char *erofs_frags_packedname = "packed_file";
@@ -402,8 +402,9 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			err = -errno;
 			goto err_out;
 		}
-		epi->uptodate_size = DIV_ROUND_UP(BLK_ROUND_UP(sbi, ei.i_size), 8);
-		epi->uptodate = calloc(1, epi->uptodate_size);
+		epi->uptodate_bits = round_up(BLK_ROUND_UP(sbi, ei.i_size),
+					      sizeof(epi->uptodate) * 8);
+		epi->uptodate = calloc(1, epi->uptodate_bits >> 3);
 		if (!epi->uptodate) {
 			err = -ENOMEM;
 			goto err_out;
@@ -473,7 +474,7 @@ static void *erofs_packedfile_preload(struct erofs_inode *pi,
 	if (err < 0) {
 		err = -errno;
 		if (err == -ENOSPC) {
-			memset(epi->uptodate, 0, epi->uptodate_size);
+			memset(epi->uptodate, 0, epi->uptodate_bits >> 3);
 			(void)!ftruncate(epi->fd, 0);
 		}
 		goto err_out;
@@ -524,7 +525,7 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			erofs_blk_t bnr = erofs_blknr(sbi, pos);
 			bool uptodate;
 
-			if (__erofs_unlikely(bnr > (epi->uptodate_size << 3))) {
+			if (__erofs_unlikely(bnr >= epi->uptodate_bits)) {
 				erofs_err("packed inode EOF exceeded @ %llu",
 					  pos | 0ULL);
 				return -EFSCORRUPTED;
-- 
2.43.5


