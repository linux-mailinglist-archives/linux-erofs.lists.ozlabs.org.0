Return-Path: <linux-erofs+bounces-403-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF47AD99AD
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jun 2025 04:33:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bK0gF579dz2xd3;
	Sat, 14 Jun 2025 12:33:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749868393;
	cv=none; b=lOQme6bkmhAtJJSFxRxhivgoAylkuq+UKoPT4Jx11qWeNtXnzSWq5G5iHXhlIxbkhll9Nz7ljye83bbQnASdTwijHcpNZVCVPC1p64tPk94y37dWI7LZL/KElUOUldMvdYqLwrC5k39T9UydSPakan12B/kaGNkXf3ASH2ydcJy/fj2cdcP3Wlhu60jV/KDVlf9+5l1GJk4sM+oTe9f9tolsTmZL9qipEj/wGep1naX0tm5vA3mHyB2DIx6Y/f/+/lHZ6zkRhWOLpIBgHA82CHH1B27sE0Aq5E2Ir/14Rs5zZVBKzQLZaA0OlttZnCiTPWBrJvdBC9o1G4nfvL+nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749868393; c=relaxed/relaxed;
	bh=JxWN2c422xihPT0Ntth+3aCS+iQ0KKkagEmtgLyuIFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hc7ICFYUooFtyf8T4TAJkEiEk46pakjwc2NJ7iUIJaN7QYvwOLGKF7AqVGzJ2R7pSBxjh/3B/VU5JY4gSw3VK4mJaj0Npgbb9qbF0gNdkBF8beMbXBcfHwNP4XUSZDDFlGQVPWp8Kc1lJi50YIbHmUCq0n7c3FseT9l9uGK72g/VlNhAYfhRqCvSxtNqz9D05b5vR4jo7nzvqRKmh9OGaALnQNMslrJfay6pE5HOTSxw+QJzRrj7kiuwJOvPTVDEuHFrNojvViHLj7x4V5i6EBpuAFvVxnaGAkfQDw3NaKHfQRqbsBUSA7RHN0HZCSVW/HiFVApp44UYMHct4j1zrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iiqmRxAe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iiqmRxAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bK0gC3m3Gz2xHp
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 12:33:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749868386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JxWN2c422xihPT0Ntth+3aCS+iQ0KKkagEmtgLyuIFI=;
	b=iiqmRxAe+gd7Hq0gsKTTJ+XjVIdgljzy143v+CT3wujCCDMGC8LTsCMPfu0hOaSkxMhztGQ0fbgE8cn5WYfMfY6hZpa4hwoJ+BT2jpmjXmkCBV5Hqj8MxrB0Fua6Zx/KvDs+h200BchIiJxEFJntjH4UCRtaLxU+1CMKxDNnnok=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdm5aE1_1749868380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Jun 2025 10:33:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: mkfs: eliminate redundant FD duplication
Date: Sat, 14 Jun 2025 10:32:57 +0800
Message-ID: <20250614023259.1688845-1-hsiangkao@linux.alibaba.com>
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

Removing unnecessary FD duplication prevents EMFILE errors.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 73554d6..2bafb0e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1720,7 +1720,6 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	ret = erofs_commit_compressed_file(ictx, bh, pstart - ptotal, ptotal);
 
 out:
-	close(ictx->fd);
 	free(ictx);
 	return ret;
 }
@@ -1791,13 +1790,12 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		pthread_mutex_unlock(&g_ictx.mutex);
 #endif
 		ictx = &g_ictx;
-		ictx->fd = fd;
 	} else {
 		ictx = malloc(sizeof(*ictx));
 		if (!ictx)
 			return ERR_PTR(-ENOMEM);
-		ictx->fd = dup(fd);
 	}
+	ictx->fd = fd;
 
 	ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
-- 
2.43.5


