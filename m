Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88033970C31
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 05:19:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2Brv2FbJz2yMF
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 13:19:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725851963;
	cv=none; b=U7m0bLDHWSmRETlwYIcl/e3+zaZdinuDhyp9ppE0HKxAQZF1VzZ7W76tgm2gW1AzWfa9YItN31a4L9HcqNU/7oaYzYNAPNHnZkAQgnQIPPe+TVp2IG4E2t6z06ICEp8bNDBX5jwm40BLCBLyJyZJqM/Wmja++IIN1zRdq6Wd34w7JTX9cEvZ5B8tWYmqbIhYkd2b3R4VnDoW6mpFEdhC/LhzRRzT4bLKBcS6xDVc+CREr6RXVzDbVZRe2F6SqaqFyeISEnW6UTy3R7GQH8IeAESnILJcfiflXUb1Y3b3aiiAMLMPbGXzpaeOAIRkN0VYSpQCUcJtt7lCDi227lSl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725851963; c=relaxed/relaxed;
	bh=f1xp5p0CJfo1Mj+ACRPp8EkDOPZ2/JavyzqzS5tmiWE=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type; b=Sw04ZnlJ/jI+C1GNzhPXd50tQjITQRtcRyb511w/rPTq7x7qZo2Xe7AKbW1N5PiY+Zu45S9Idc0fYbyaNVumJa3FVhsuwtf3PZJDJAxjZfogT6dQeTKA0/yjUqMYcIO/jeDZgfS1rzEqdTbDVmCE7Z8Ayomqm3Y0ZFtsfx2n0SGowRStymb34zNMgKxzjGJCQgrHieTyyjQwoA+mnyzJuuCKhAZdCfh7KknohoBvi1QIrP+/8oqUJ15rrmLmc48PfKSafb9RtR+Gzn0KTP9QHo3gRNNPsJDJcenw84b+zwh5z001lEJAIgif+x0phbiLBu2M4KG+vqB6loDhPyD+CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QvCZNBGz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QvCZNBGz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2Brp5YVjz2y7J
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 13:19:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725851956; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=f1xp5p0CJfo1Mj+ACRPp8EkDOPZ2/JavyzqzS5tmiWE=;
	b=QvCZNBGz4DZ6yXooswbnt+eEZuPRHRRUb8cJmU9HhNSvDbvVsYzjY2P8Cex14idFEMoFfSvdcEiLf/O1MW7lr+orv3wWu7tCpLqbOjXbKRKUhXBrYKhhdIdQPvdt5N3gqmDqK9N+zpubL8VsZt/bfcq/2CNkqMEG9Z9LN18b3HM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEWAiPT_1725851952)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 11:19:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Date: Mon,  9 Sep 2024 11:19:11 +0800
Message-ID: <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
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
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - sent out a wrong version (`m_pofs += vi->xattr_isize` was missed).

 fs/erofs/inode.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..f2cab9e4f3bc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow(m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
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

