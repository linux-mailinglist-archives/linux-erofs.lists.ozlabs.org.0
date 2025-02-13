Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E553A33E0F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 12:29:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YttHM0s0Lz30W7
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 22:29:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739446142;
	cv=none; b=O6R+sTKoFQzQRVHR1q1PsxQPiA3XwFRg+0K802m9y6FSZbV0DZznrkFmcK+STK8svQhJdFx9/2M2eBzHYfvTrfS5i6qKI/FlljnJqf9safa9EGxCbUcK86dD+I6ddfkx66Uyq7ARwhcaowd1TbPusM1ybPxwZFftREvGlSKSjGrclJm0NeLIjQgPeiFsXa3hjwcCE6AuvghLWeSyoG9wNEU5dAkpaWaX8H+XqOIzAVF/jW9YBK01S5EFTx8iIUz79N/c3VvLha6IyH33Mu+o4mJzkGqRDmxih6744GshUhrOYa4GZOS00XP/L3YQq+OrWnBK31vJeBm2zwn4Adttmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739446142; c=relaxed/relaxed;
	bh=kv8BMoJpbxc9jojR7+5+zseML6qOiINst/GRSJcHC18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpHJRcc+Mh5we2K1Oll2MNjJ+yiuxy+1Ygbg0JRDEgzwqK4lNy4uJxiuLxWAe9QyFppLiTKjUljBdm78JyAZuiEhyPk43y1NuHLV6bu4rxkwhhkGsP+z5pCRKboWW7nbkr7yJvGCl4/L1cGlMKjNvoeR0eY/OAERijauvrmoaHXWh3Hze0Inh6e1Ce08sns7sXegf2PW1ZdQR3si6IWv5iRFtsSlEMedbcj8RkQiBw0CbCuPIM9feK98mIc4VP69G0oRDg0VvDyMc8lHU9w3Y74JwLxxhV8BbtCh384MMYvvVpWppKK+cAgMlfmwPI8hwc/08kzVZseU3p2hZs6pTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s57AD7aF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s57AD7aF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YttHJ4cQ3z2yVV
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 22:28:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739446135; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kv8BMoJpbxc9jojR7+5+zseML6qOiINst/GRSJcHC18=;
	b=s57AD7aF9ODeXRrlwxejXOLTOlnW/Zba0/wurhX5hbkYE/P3biXMoLFLoblkotwP3IJCWp27QNGxBy0MPcxMZqHybc6UDcyNH3H59bkcoeWmb1COdCckcMnFQv61RTwpTqsyPyXoU1BXqgVMbYyhnaq+pW3fJ4LzrjmX/WhaD9Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPNMGBb_1739446129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Feb 2025 19:28:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
Date: Thu, 13 Feb 2025 19:28:47 +0800
Message-ID: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

See the original report [1], otherwise len + 1 will be overflowed.

Note that EROFS archive can record arbitary symlink sizes in principle,
so we don't assume a short number like 4096.

[1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - use __builtin_add_overflow as Jonathan suggested.

 fs/erofs/fs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index 7bd2e8fcfc..dcdc883e34 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -59,16 +59,19 @@ struct erofs_dir_stream {
 
 static int erofs_readlink(struct erofs_inode *vi)
 {
-	size_t len = vi->i_size;
+	size_t alloc_size;
 	char *target;
 	int err;
 
-	target = malloc(len + 1);
+	if (__builtin_add_overflow(vi->i_size, 1, &alloc_size))
+		return -EFSCORRUPTED;
+
+	target = malloc(alloc_size);
 	if (!target)
 		return -ENOMEM;
-	target[len] = '\0';
+	target[vi->i_size] = '\0';
 
-	err = erofs_pread(vi, target, len, 0);
+	err = erofs_pread(vi, target, vi->i_size, 0);
 	if (err)
 		goto err_out;
 
-- 
2.43.5

