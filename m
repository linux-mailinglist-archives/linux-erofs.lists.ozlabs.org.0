Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914A5993F10
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 08:57:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN6KH0W23z2yPq
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 17:57:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728370657;
	cv=none; b=Mcylw4mydS2CXTVtigHAWw1+hvjW6jaEFKki+nM4/N2jrs9nBuYttwjtngTaJYrB3nchWQp2L04WNZKO/Qyk45+bf9gO0TC0h7d54C89akmOnkuAlIyR7YgLtU29aWl5+eCBFoOf7shcD0nsVP9B4Riy8KJVmQZMahFkXPExYXX2gr4t7Iv4upNHA6buanXncto4l4pRPsMoxF+WpengekiuUjCsxicSuWy7Yo/4wBgMuFLDLcmi8kEYWERv2LJNLuAwdfEzDWU5bf0w2aXZgjjUAv4SEPa3awdaJ9bMgoVciGZPCBMiv4Pu085rxuwYmUyTptDlRL1XAIvWpPl98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728370657; c=relaxed/relaxed;
	bh=Qzw3uPLvC2c1Ig93+/usRmDOA6a9YuiU/S67IDUtqwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzR1bbZuIwiG0EcvIY1az75tuKhnW3fge5nBGtMn5pL5+Ns+Jdgi1Hee5ois2fYkPafaT0TIcXZYN2+L3CZr3QC+BA4SuYE8XoR0YOxT1rpL0hjMtnmPhvGukaKA8WLfZI4fTpICeo+FiOzNIIV13gdhfUtQiHGE5O2ObdqNc+0XWLvYELp+0KKgCTSZckeddgkAmzwKDvgSTDHo87UVwACG9nygqv8jMS4NQFGPxcdzzFb1pO1uc8eDArJl0tBhDQRSFLt0cAy9qboqTKSteP1gXMMghg5j2cN/22G6t/1iww8Tsmey4pmjCAev7gn2hp8o8k0N7mmrRQfciMxtYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CvT5fEKQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CvT5fEKQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN6KC04dnz2xfK
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 17:57:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728370647; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qzw3uPLvC2c1Ig93+/usRmDOA6a9YuiU/S67IDUtqwU=;
	b=CvT5fEKQA2Kf0eVZBnFfzUG+bd4GqOzH/8noS52OEsV5i6oc5nbJo/+mcHrGKivrUZW7l6c5c6abAmfBJyZMftIc6ZUhBezcV/rPIaUSRVyNtOTakMjeyZx5mao4ohVAngxMN0KBZHblLFKJvsv3Kb7IozkpRbR0sbMbHO6a8jg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGbLQYt_1728370629)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:57:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y 1/5] erofs: get rid of erofs_inode_datablocks()
Date: Tue,  8 Oct 2024 14:57:04 +0800
Message-ID: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.

erofs_inode_datablocks() has the only one caller, let's just get
rid of it entirely.  No logic changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Obsoleted EROFS_BLKSIZ impedes efforts to backport
 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")

To avoid further bugfix conflicts due to random EROFS_BLKSIZs
around the whole codebase, just backport the dependencies for 6.1.y.

 fs/erofs/internal.h |  6 ------
 fs/erofs/namei.c    | 18 +++++-------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 79a7a5815ea6..30d464230ae0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -347,12 +347,6 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
-static inline unsigned long erofs_inode_datablocks(struct inode *inode)
-{
-	/* since i_size cannot be changed */
-	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-}
-
 static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
 					  unsigned int bits)
 {
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index e8ccaa761bd6..642431350bea 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  */
 #include "xattr.h"
-
 #include <trace/events/erofs.h>
 
 struct erofs_qstr {
@@ -87,19 +86,13 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 	return ERR_PTR(-ENOENT);
 }
 
-static void *find_target_block_classic(struct erofs_buf *target,
-				       struct inode *dir,
-				       struct erofs_qstr *name,
-				       int *_ndirents)
+static void *erofs_find_target_block(struct erofs_buf *target,
+		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
 {
-	unsigned int startprfx, endprfx;
-	int head, back;
+	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
+	unsigned int startprfx = 0, endprfx = 0;
 	void *candidate = ERR_PTR(-ENOENT);
 
-	startprfx = endprfx = 0;
-	head = 0;
-	back = erofs_inode_datablocks(dir) - 1;
-
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
@@ -180,8 +173,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	qn.end = name->name + name->len;
 
 	ndirents = 0;
-
-	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
+	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 
-- 
2.43.5

