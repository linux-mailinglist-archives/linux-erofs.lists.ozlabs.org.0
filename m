Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83D41C320
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Sep 2021 13:02:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HKD390t4Sz2ymr
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Sep 2021 21:01:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HKD3427bdz2yNG
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Sep 2021 21:01:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0Uq132Go_1632913278; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uq132Go_1632913278) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 29 Sep 2021 19:01:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix truncated uid/gid fields of extended inodes
Date: Wed, 29 Sep 2021 19:01:17 +0800
Message-Id: <20210929110117.123214-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Uid/gid of extended inodes was badly assigned with le16_to_cpu()
by mistake. It could cause truncated values if uid/gid >= 65536.
Fix it now.

Fixes: 6a61ce1450c5 ("erofs-utils: complete extended inode support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 1538673aa0c6..6597a26f7ac4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -466,8 +466,8 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 
 		u.die.i_ino = cpu_to_le32(inode->i_ino[0]);
 
-		u.die.i_uid = cpu_to_le16(inode->i_uid);
-		u.die.i_gid = cpu_to_le16(inode->i_gid);
+		u.die.i_uid = cpu_to_le32(inode->i_uid);
+		u.die.i_gid = cpu_to_le32(inode->i_gid);
 
 		u.die.i_ctime = cpu_to_le64(inode->i_ctime);
 		u.die.i_ctime_nsec = cpu_to_le32(inode->i_ctime_nsec);
-- 
2.24.4

