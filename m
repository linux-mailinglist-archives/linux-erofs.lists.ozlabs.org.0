Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E497C2CD
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 04:16:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8K092JLfz2yDw
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 12:16:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726712211;
	cv=none; b=gloXF/jKqgxGdTaGDB2cSecKltha6juz1dai3KfzTkmhPoJ5INVox4o3QWrm3XA2wuPd0Ie+ZtjegxiSZ8LA/yTqJGvpLZNRwcXrFtNxdDERR8OPPJNGA8YADahr8mtcg3ThmvxV3yBA0Tdi1vjL1vsrhToyPiRuqSCiaFFk7R7n4g7XSX5gfKOxD2TE6MNCfuBGffYtx/6WWUucNnSScVM6lgRgspLujC1SIKsp8PeB6IwibCAHeb3SpwEFJVk/0/OW0QaAJ23vYLEqsjWQ3gXVz+iNZ+P/Y0bwoew2BLelhx1XShPF/8eyIXlZlDjNe7RzNI5OziA/B5zjGmyZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726712211; c=relaxed/relaxed;
	bh=Es2F13SeOB4gTXCkHkaK3HzhrLIglwDJ6k9brYaiUHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UezHg7YPZERGYGsHOj/QIrkUcXTQrmAx88d+a3MvUDBaVqXpzWjqUFa73QvCBfHJCN85Y1e0VmxncyK7skxnfFYqYzqP5huXJTxObFTkg5ZBvBYppHDcvjth+72bcWch7ktMKlvRnq3LZXkVqhDsva/0zMuSDioiTjVzMms6x+kWBxHlqItLruTFUHBbKaGZSQLmJg5Lt1AsOZB+G1LGZH81/UMgPsvOAiPE/vb7EiswUzNUBFnJbYpdWdZ9RC+XljvZfxDU0V/foIu+xlv+oZKsAVQ4y01+5QCLfs6NF+AcZAmtX7juqkbhcfJTXiJw4firXJaz7pYjtDBWy2LS6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qgh33LkG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qgh33LkG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X8K016LMSz2xHP
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 12:16:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726712202; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Es2F13SeOB4gTXCkHkaK3HzhrLIglwDJ6k9brYaiUHQ=;
	b=qgh33LkGSy2fgvrWO8n+cS0IONJviZOogVQVLHsHygLt/LroaL+wBEJrrfQ3xhTKOhdP889qhnE3fPMKFWSfTeihBBvkm1hGZwkTJIOeoKfp18UaqS1U03LS8PGLgI6n3Jnc64JYeZhIemOj+lLkwTPbaiivZzKnKSzpRYWtRkg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFFsVrT_1726712196)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 10:16:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix a regression where rebuild mode does not work
Date: Thu, 19 Sep 2024 10:16:35 +0800
Message-ID: <20240919021635.2922387-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It will fail unexpectedly if any sub-image lacks an extra device (blob).

Fixes: 7550a30c332c ("erofs-utils: enable incremental builds")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 5c8b5e4..7e2e184 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1091,7 +1091,8 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	if (datamode != EROFS_REBUILD_DATA_BLOB_INDEX)
 		return 0;
 
-	if (extra_devices != rebuild_src_count) {
+	/* Each blob has either no extra device or only one device for TarFS */
+	if (extra_devices && extra_devices != rebuild_src_count) {
 		erofs_err("extra_devices(%u) is mismatched with source images(%u)",
 			  extra_devices, rebuild_src_count);
 		return -EOPNOTSUPP;
-- 
2.43.5

