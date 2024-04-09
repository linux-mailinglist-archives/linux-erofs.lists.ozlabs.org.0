Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EA89D7D8
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 13:30:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cTkWWcxY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDP0J0gjXz3dVJ
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 21:30:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cTkWWcxY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDP075YRXz3dH8
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 21:30:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712662226; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C0zysPX1OGYstO665h3gZ/2br098P35fTMAWwjzjT0Y=;
	b=cTkWWcxYEfjYP3k2PLcgvgn9wmfxicnbz7PcDvwRladugTUZ/tg6U+pdUNw4PvQPvH194Oyv7e9gZbSwyU3jvj+yMZir0XplqAOTY2JnsPSU9aJ5FhhqXfOKMcZ69o2gDvPU7/CJiaNMQIvMr2erK23hgK/5SLB++90/BQU+co4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4EQnaa_1712662224;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W4EQnaa_1712662224)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 19:30:25 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: derive fsid from on-disk UUID for .statfs() if possible
Date: Tue,  9 Apr 2024 19:30:22 +0800
Message-Id: <20240409113022.74720-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>, huyue2@coolpad.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use the superblock's UUID to generate the fsid when it's non-null.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: update the conversion of UUID to fsid, which looks
	cleaner.
v1: https://lore.kernel.org/all/20240409081135.6102-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..58e41dc201fc 100644
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
+		buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
 	return 0;
 }
 
-- 
2.37.1

