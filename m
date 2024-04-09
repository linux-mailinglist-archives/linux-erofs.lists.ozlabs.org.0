Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8889D3DE
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 10:12:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xDIV6c/2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDJb218bfz3dH8
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 18:11:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xDIV6c/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDJZv2Q50z3bWH
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 18:11:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712650302; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=89xpcFLgtVH4lcATuVDEdqCce7EFZbuNNRadjDj3dIM=;
	b=xDIV6c/2dIzZiiUtmuiD+MtiGGB4nS7unVkR3CuUwuSUnOmX6ltza6jBDp53FifK5QI6Vapu9AByB8l1bX16Gvc8EvfOQZLQICkMOz40FowB0Bkoj1CxdvFS+1qIoI7JGU2VymrS91urce+f9bg3K7mZBV6H7LbWTAu6Otdkqys=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4DtF.b_1712650297;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W4DtF.b_1712650297)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 16:11:38 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if possible
Date: Tue,  9 Apr 2024 16:11:35 +0800
Message-Id: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use the superblock's UUID to generate the fsid when it's non-null.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..83bd8ee3b5ba 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = 0;
-
-	if (!erofs_is_fscache_mode(sb))
-		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = sbi->total_blocks;
 	buf->f_bfree = buf->f_bavail = 0;
-
 	buf->f_files = ULLONG_MAX;
 	buf->f_ffree = ULLONG_MAX - sbi->inos;
-
 	buf->f_namelen = EROFS_NAME_LEN;
 
-	buf->f_fsid    = u64_to_fsid(id);
+	if (uuid_is_null(&sb->s_uuid))
+		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
+				huge_encode_dev(sb->s_bdev->bd_dev));
+	else
+		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);
 	return 0;
 }
 
-- 
2.37.1

