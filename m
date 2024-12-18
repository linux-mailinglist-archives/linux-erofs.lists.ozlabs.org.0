Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF569F5F6D
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 08:39:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YClvC3f9Wz30hV
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 18:39:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734507589;
	cv=none; b=jHYbZHfRDGnADI7q2G46GpJ1gxotyHIpGfcDnAoZwygqeMrcbJFVCY5YUghcdv1F+H0k/+0HcA80G20iR+di3T6lMM3/wKovBp39Yup5k0xxV4dUjOdY/qHFa4aiFjKqrqW/6mOD2/woUVuH3zP8yDOT1DnBvfRTl+WZTwGfzyn2s8G+mVAvDNoJRftKvzOy6cA7d3gT2onv1QHUJcn9A7kUsLRJRDAY6O0K9MS1gfW+s7oSndeTwchjhNBimO6oQrBdwufQv/ri9aIG9vs09wFsfB0wYGT4344vmjrbBraThl5qKJ/N+Tuf5ba4Ipdfhr6Pm6ooGyf5H+wSWZ41hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734507589; c=relaxed/relaxed;
	bh=vdSVyoMB0y9/Ui3J906Gv8Qnits7tU5YvWYi4N8ibKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6HgTIU4l6K5Nch9D6HftrnUuGx7Caa4p6bemJpY/vFv0sS/mkDgWe0ImjqnX5a759I/t/FWZRbPmcbxhysyROGZx12483eJitS5xqwiXVXGS0SyBOSz0kVD0sTMqDMDLCww3Ncxku4KEs0VsexrY5mGrudkXpFl5PTTyS9CmmnXw2dzqARlnX/dUtsMgRC+0HMrgBZ6qHDp4qkTyhOIFVEO+mge5l6iROcKt9vuUw13pQzyy7EdE8UhNcKujlkbEK4fgYXvervS0KwZ3X7hzfKVQYo4bZfFTRsRLhL9j18Db3jSrM1jlLMhdVERr363I+iUvOYgalRSvy+wERY+sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NoiicC6d; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NoiicC6d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YClv8328zz3064
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 18:39:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507584; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=vdSVyoMB0y9/Ui3J906Gv8Qnits7tU5YvWYi4N8ibKY=;
	b=NoiicC6dsE41OGU6qH4fmq4T7TylmyjNv1XbkqbJ1rapT8MatDw2Pg+X6WktlCH5bQzvjRFqHyn+ki3u8JyWH2rVoQ81JXfExEHPuqvHC5Nb0SqKSvm5n9aryTE61jjoPxqNq/u/azHXZ+GxlqJQfZPpgBT/gZvnavM82FcTDOs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlkMIl_1734507581 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:39:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 5.4.y 2/2] erofs: fix incorrect symlink detection in fast symlink
Date: Wed, 18 Dec 2024 15:39:38 +0800
Message-ID: <20241218073938.459812-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
References: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_SBL_A,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, allison.karlitskaya@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 9ed50b8231e37b1ae863f5dec8153b98d9f389b4 upstream.

Fast symlink can be used if the on-disk symlink data is stored
in the same block as the on-disk inode, so we don’t need to trigger
another I/O for symlink data.  However, currently fs correction could be
reported _incorrectly_ if inode xattrs are too large.

In fact, these should be valid images although they cannot be handled as
fast symlinks.

Many thanks to Colin for reporting this!

Reported-by: Colin Walters <walters@verbum.org>
Reported-by: https://honggfuzz.dev/
Link: https://lore.kernel.org/r/bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
[ Note that it's a runtime misbehavior instead of a security issue. ]
Link: https://lore.kernel.org/r/20240909031911.1174718-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: fix 5.4.y build warning due to `check_add_overflow`. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ba981076d6f2..af90d3d70a08 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -198,11 +198,14 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow((loff_t)m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -211,17 +214,6 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross page boundary as well */
-	if (m_pofs + inode->i_size > PAGE_SIZE) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
 	memcpy(lnk, data + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
-- 
2.43.5

