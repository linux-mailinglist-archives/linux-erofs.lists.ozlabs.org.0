Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AECA1B254
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 10:06:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfX4N6bYhz30fW
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 20:06:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737709603;
	cv=none; b=aXyXh4damp8jRVvcuhROKI0QujfVtA/5QK2XT9cppSzs4jA39nU+fn1l9KFlGBv14kVSp2KNFYbB0IDq1ATG5I2mjfGKoXGljuCcQUuTxVsf4IAO1OiXAAI2+DiJJx7u43pqjDZGiY0415JEWptelcdzu8rUuZfSbPRKXERhMJsWRjcq5ONXdK2OBw6jEGn/WlDbqcHxiGlcP0BTFt1CidvBlWlYkZhPodbWZ4oJ5OYjpItbNINa8Tds56dfbcbc/VDrOiv0rV2MEWkaFkXkgUesmioAoddDWRLFnDYNvsn06D2sWTX4tp0KwvBUMXJ1jIdH2S0zZvzPjqoLcG8TcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737709603; c=relaxed/relaxed;
	bh=ySCw4Q7at6+V+Ft/b/8LWE6ZewrOTHFZivzn4zpcyXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vm7GEFQQyZXD4W9kkLU5qAC6Wz2fbQQbJJRgMkVxR6xboC9noqinDI9zB1ORAuLMWqZvHmZAg8S50+QXyorql+KceyP+EgVrc6pPvycZJXnPiP7rBivJbKsHEz0xDCNuZYoSSurGnHnkWuJBRRTeV1DtaS0ausf6VEA5FhL99OtUqzUjQgnqZHWdDVs02ksq6muZpb2d8w6VfzDfB6a7tX5CFnd2j4H3UHc2gGr/sHEQk4FeBshh15QBFusTmsOJ6Ay5vhaza8gyuHTIsLedvAQ0psOgOkhcrTTq9JXNAxTnn0fDewXunO6VGG9ZnEIAdHZOJO/JKFadh7/qL2mLuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y81k7CUX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y81k7CUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfX4K1T4Zz30Nc
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 20:06:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737709596; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ySCw4Q7at6+V+Ft/b/8LWE6ZewrOTHFZivzn4zpcyXA=;
	b=Y81k7CUXKdLliuqjF+VfqBZfWymppexf8FdKpYCGNckUuqppeKw3uIPtwxGsJYAZkMLHphMbOkXgQZf65aQeHt9e1Q1eMhauJ2JMEAMDv32OTSDpNi9lvKEJXqUp7nFPZpMxuW0SOmkxxFojGTzvsuZM8XqCJnYk5Tglngjaxps=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOE.K25_1737709593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jan 2025 17:06:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: fsck: don't dump packed inode data if unneeded
Date: Fri, 24 Jan 2025 17:06:28 +0800
Message-ID: <20250124090628.2865088-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124090628.2865088-1-hsiangkao@linux.alibaba.com>
References: <20250124090628.2865088-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It was a vain attempt.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index b1d6214..372fee6 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -518,6 +518,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
+	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
 	int ret = 0;
 	bool compressed;
 	erofs_off_t pos = 0;
@@ -552,7 +553,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		pos += map.m_llen;
 
 		/* should skip decomp? */
-		if (map.m_la >= inode->i_size || !fsckcfg.check_decomp)
+		if (map.m_la >= inode->i_size || !needdecode)
 			continue;
 
 		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
@@ -918,7 +919,7 @@ static int erofsfsck_extract_inode(struct erofs_inode *inode)
 	int ret;
 	char *oldpath;
 
-	if (!fsckcfg.extract_path) {
+	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
 verify:
 		/* verify data chunk layout */
 		return erofs_verify_inode_data(inode, -1);
@@ -939,8 +940,6 @@ verify:
 		ret = erofs_extract_dir(inode);
 		break;
 	case S_IFREG:
-		if (erofs_is_packed_inode(inode))
-			goto verify;
 		ret = erofs_extract_file(inode);
 		break;
 	case S_IFLNK:
-- 
2.43.5

