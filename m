Return-Path: <linux-erofs+bounces-771-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1AB1B1BF
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 12:10:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx8LY086Jz3069;
	Tue,  5 Aug 2025 20:10:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754388612;
	cv=none; b=WO6x8uqmj0SUNl/D3a9wF2IqvJzllseeNEIPVsbbbEJBsSuuIDnyiLgk8wwX/RuS6VWtXG5KRXUVqNX1MtQb3OxLWCwDpG2vpJEbO5w1GkdDPZIjKj8pUzY6G3h5c9v5RxRmN8VKofUrb+SmqiDPj7vL8h5L0zz+80L4LzxRI4poxuNOIz3M1RBm1zOVuIXPhpqIlR4e5kqA94R/zVN/u4piuu/Kp/y5ueOlcm3zvCA9A9ySdcD1kZd/3z3qlO5JXss37Qxcz2Z43MsYEQfrfRVBFG4r4FS79n29iXIzaEqiu2p3LeoFSvdbFE2CUZ+34kRtC86zSFoixdbMEVrPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754388612; c=relaxed/relaxed;
	bh=DVUoh8oeyCiCVgw+xlCNv00smmzKC1AG5G4L35dQIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oS6K1fSKcDuMx/t3FNxVIDbp4UbaQf5aBujSVFZlICNMLXzsoM5XVZJHbtDgmtPSzNZboWdtU+XW5pfLpIwM0Br0PBX5N7Ip3K3gRE83R3Gt0tBRLhklU+pzLIVK/ypNYfkDfVuQxElM0pv9LDh/ZrAB3iEwImzqoUBRdj2MPN8m1yQ4iEkox1XJms6YyNZxNMWzkrMGhRa0683HYExRo6c2CBk0G+G89YsjxR8Lg7/dbLtaJBo2NScJLK6F9GSmOE9weY+OZ5GXwEP2PpGQzSHnbp7rGbv4gW0Vwmh6noOVuGz6hEXZSCK/3n/oS/ctOivt+r7TMY7jWpCr5orSwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yHnsVzhx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yHnsVzhx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx8LV6glFz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 20:10:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754388603; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DVUoh8oeyCiCVgw+xlCNv00smmzKC1AG5G4L35dQIUA=;
	b=yHnsVzhxB2x27JMvtCzh9haBUXpPGT1jGlTsx5TQ2tud7OTEete9f+nItai15ao+wFow3dBgucmAIHCzo73az607aEvKrhAxv2rJJl92ZGM/jw2minX/Iac18DlJLfXG7ITarN50aLuoZkRH5BX8NqieIa+BzFby8wZLTqsSWmQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl4pLUE_1754388596 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 18:10:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fsck: skip erofs_verify_xattr() if xattr_isize is 0
Date: Tue,  5 Aug 2025 18:09:03 +0800
Message-ID: <20250805100904.3610181-1-hsiangkao@linux.alibaba.com>
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

erofs_dev_read() will fill with zeroes so this issue has no functional
impact, but this behavior will be changed.

Fixes: f44043561491 ("erofs-utils: introduce fsck.erofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 44719b9..93de1cd 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -343,15 +343,12 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	if (inode->xattr_isize == xattr_hdr_size) {
 		erofs_err("xattr_isize %d of nid %llu is not supported yet",
 			  inode->xattr_isize, inode->nid | 0ULL);
-		ret = -EFSCORRUPTED;
-		goto out;
+		return -EOPNOTSUPP;
 	} else if (inode->xattr_isize < xattr_hdr_size) {
-		if (inode->xattr_isize) {
-			erofs_err("bogus xattr ibody @ nid %llu",
-				  inode->nid | 0ULL);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
+		if (!inode->xattr_isize)
+			return 0;
+		erofs_err("bogus xattr ibody @ nid %llu", inode->nid | 0ULL);
+		return -EFSCORRUPTED;
 	}
 
 	addr = erofs_iloc(inode) + inode->inode_isize;
-- 
2.43.5


