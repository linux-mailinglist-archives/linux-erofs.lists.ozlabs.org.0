Return-Path: <linux-erofs+bounces-472-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39470AE07FA
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jun 2025 15:56:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNMbb6bV1z2xck;
	Thu, 19 Jun 2025 23:56:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750341403;
	cv=none; b=iwTiEGk3ODaLAe8lcbAlEs+kZmi4g6ALe+EhrBZ2MXf/xLOehFOuhQUUQjt0jgnyuzcEEDRrt/ZcnnDHmSGRnb0SMX2tOvfixCfprP3G87dRnZLNOC5Tf08+K87J+i69bsb/M1w5t8Raq0KdchrU9OnIH8Dyc6okCipcJC7CIFu9RjCNdxnl7zS1I+FqSXXHrqh25BM01jpQcXYZgeuuLQxM1x3gC9n20vZTeycpnnphU2ZovrRhlUHNnFthixTVfDOMkzfFK4ixW2JhWNVzx0KaeMJapSv0154RvDV1KtkjfpRXHb28gBIzLoY1MVQaBJz2w37jg5UdHAcFBSP6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750341403; c=relaxed/relaxed;
	bh=Ju2QlI7K+wlon++5OtmDCYMmaXLp770jzBhD2aLcBLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTy4JFumN335BZ9i1wVdxgkjMHznirobtDO7HTAbhpwRb7R+4T+k9ZWMJRAXMIQXjCjNcVGSK6SG6Zojy16esgf0HgGxr1ABhOOJ2cqzwmGpd+QUtmoy3tacxj3WJ6qzcGlWqhUVE0Vtcpi1gAqkLbjah8umMPa5wVJ7+eobdpOicvgbpH4XyppLHz87tAdGED/EXtR23k49Bnm57gA9zA2dINCov2bEzprxQu5lwjs0wns2RtZTkhVlk1I+7puZx9HvN4GYgeIXxiVYS33HCXmpwFs2rceb/5ML8IU2twW46k17/xXgHBcHdldOM8bPN1wDvWZpgSUIx2ttwQIDiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FBhzIP51; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FBhzIP51;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNMbZ0Qblz2xS2
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jun 2025 23:56:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750341395; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ju2QlI7K+wlon++5OtmDCYMmaXLp770jzBhD2aLcBLo=;
	b=FBhzIP51LrLzDPktWbFvxBvhaPcdcZqhVi2QeM5dBv7fUCrCmpE/ZJW/cAbL+0VD/5A0eptFICuHazV0Udt3QBSHGsDMVdCSOjf5HuT8VJvks+lW5g3V3aWZw7tSmytF+dyXs2rYa2B4alVj3PHCuFEAAZqaNYSaaal9pRZ0eEY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeHXhUd_1750341388 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Jun 2025 21:56:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: avoid erroring out if `zmgr` is uninitialized
Date: Thu, 19 Jun 2025 21:56:27 +0800
Message-ID: <20250619135628.3533406-1-hsiangkao@linux.alibaba.com>
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

Uncompressed images don't initialize `zmgr`, but it's simpler to
unconditionally call z_erofs_compress_exit().

Fixes: ce7dd3e61c26 ("erofs-utils: lib: introduce per-FS compression context")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 2bafb0e..8999b2c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2130,10 +2130,9 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 {
 	int i, ret;
 
-	if (!sbi->zmgr) {
-		DBG_BUGON(1);
-		return -EINVAL;
-	}
+	/* If `zmgr` is uninitialized, return directly. */
+	if (!sbi->zmgr)
+		return 0;
 
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		ret = erofs_compressor_exit(&sbi->zmgr->ccfg[i].handle);
-- 
2.43.5


