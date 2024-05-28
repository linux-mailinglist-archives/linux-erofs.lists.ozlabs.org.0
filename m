Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7868D14B4
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2024 08:51:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wxfJobAc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VpNJV4lpdz3vxT
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2024 16:43:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wxfJobAc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VpNJL0NNJz3vdT
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 May 2024 16:43:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716878603; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uiFfD2L8eN9TbUDxK49YGeft8B5GJ4/wivSAAllewF8=;
	b=wxfJobAcQogDFglkQJlhsSlZDPa2Ham1HZ+OeBRgB9ZqDUg2Aws+1BiOA3kzQiDgAgy+ebr20SFznUW7qB2BW3C44ryCYKVWHTIzXJDukxrMfsBBamQNPHJHcle9pOhx80nfA6Du3BX+vcWlW9KJLju6O6LUk99+FJBkOiBL7Fk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7OoPt._1716878594;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7OoPt._1716878594)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 14:43:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix false-positive errors on gcc 4.8.5
Date: Tue, 28 May 2024 14:43:13 +0800
Message-Id: <20240528064313.1352565-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Just old compiler bugs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/data.c      | 2 +-
 lib/dedupe.c    | 2 +-
 lib/fragments.c | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index a87053f..c139e0c 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -420,7 +420,7 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 	ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
 	if (ret)
 		return ERR_PTR(ret);
-	len = le16_to_cpu(*(__le16 *)&data[erofs_blkoff(sbi, *offset)]);
+	len = le16_to_cpu(*(__le16 *)(data + erofs_blkoff(sbi, *offset)));
 	if (!len)
 		return ERR_PTR(-EFSCORRUPTED);
 
diff --git a/lib/dedupe.c b/lib/dedupe.c
index aaaccb5..e475635 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -99,7 +99,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 		struct z_erofs_dedupe_item *e;
 
 		unsigned int extra = 0;
-		u64 xxh64_csum;
+		u64 xxh64_csum = 0;
 
 		if (initial) {
 			/* initial try */
diff --git a/lib/fragments.c b/lib/fragments.c
index d4f6be1..f4c9bd7 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -289,6 +289,8 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 	if (memblock)
 		rc = z_erofs_fragments_dedupe_insert(memblock,
 			inode->fragment_size, inode->fragmentoff, tofcrc);
+	else
+		rc = 0;
 out:
 	if (memblock)
 		munmap(memblock, inode->i_size);
-- 
2.39.3

