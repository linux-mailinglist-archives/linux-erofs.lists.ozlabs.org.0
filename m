Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E50970BC8
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 04:28:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X29k70JMTz2yMk
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 12:28:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725848906;
	cv=none; b=f15rFw0rCMg6Mp7LTvPnjg5GhNOkOOf1RRem08T2GOasWYJur+IEwbDrgYXeML5v2Kt2X47hB2PvMXKM4mewBphevB/c67skWZYaQAjTVM1u4oKTo+lvkpkXOvuj5ujwJBa4pnzGxvu0AqvKbJZrJyDQ2CYbA8Nvzdfxnq8ULLKCWoq3YwML1w2mAVcnhqASQchMeI1HAyG74+k9qXCVLPNCqGhc2RkLlXnVAZfvGjXCCXCxY56KN3AS5eRSueNf90hQ+ptBSHAeDALgDVXygwezAxpRGdGyfqTj6SQT9krdE8iO/AoQQ4HjvOKKuKNni53DuGdo9U94vlExUa2caw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725848906; c=relaxed/relaxed;
	bh=m889utn8QsE6CPyNbFisRS2RlR4XYhZBEbtQrDwaS0s=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type; b=N9A3ZUj3J1D+1wnEx8IHGoVtzCfqcib9Pprvyrai+9e7nEKZk2ci0zj8Qo7SFgyKy9eK2GoGuyRYELUYF1U+vJGFIUhDHkbHJOrVqqq23TKPdTZgN8J3ZT3w3Nnjf19WTyUbc+em5sSH0Uta7oAxqFGoWPOYu1MjVVjC4OSHKQgpQyzwbZpTPphsbSUHkN621lB39XUO+73dnce5ff9o6aiXRKeO63uMyv7tWvREQSsHjmlexySPWQoiz9lwJ7xcT6gvtFH0kUHcq5fLDSAlJcXPhj8pxGfIULgkWWdxbKkbNVT9DBURJbmz/LwV0yaMLmKePTSnJ6jWo/7K05+Xfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=awpoWFwp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=awpoWFwp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X29k120Lkz2xs1
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 12:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725848898; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=m889utn8QsE6CPyNbFisRS2RlR4XYhZBEbtQrDwaS0s=;
	b=awpoWFwpvQvyJKOm2SsjDyNXRLMgNAbyJ+as1Gr+/l7ta0Gowz34o3bocqT+zwBXqT7NXiN7rS1BHT8EPTabAfgT+xWoRtdjL4uHKP3cdSD3a4A55l74f2D39swtKUXV8nABFOXLQ0/18o1ItpZwmRBtOkko6motS7iK4X8s2aM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEVwP4i_1725848893)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 10:28:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix incorrect symlink detection in fast symlink
Date: Mon,  9 Sep 2024 10:28:11 +0800
Message-ID: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, Colin Walters <walters@verbum.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fast symlink can be used if the on-disk symlink data is stored
in the same block as the on-disk inode, so we don’t need to trigger
another I/O for symlink data.  However, correctly fs correction could be
reported _incorrectly_ if inode xattrs are too large.

In fact, these should be valid images although they cannot be handled as
fast symlinks.

Many thanks to Colin for reporting this!

Reported-by: Colin Walters <walters@verbum.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..79a29841ae1c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -178,12 +178,13 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow(m_pofs + vi->xattr_isize, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -192,16 +193,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
 	memcpy(lnk, kaddr + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
-- 
2.43.5

