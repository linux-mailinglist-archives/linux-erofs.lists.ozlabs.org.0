Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1BD9F5F6C
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 08:39:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YClvB13FSz30V2
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 18:39:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734507588;
	cv=none; b=D7ueW15g3NVXtXQZiFyMfUYi/5G3QFiLYJ8HfBKFxCVDidOKSNn1bubQbb8L0XbxIGMTuH2tGyOeYZf7x6+em3W/pYKi5NRZL3nqPc9u0tS+R3EUBclCzcj8kdkmpECVsliiAqOButIKgLpKSd6pJI/3c0XY13HC8B0OG5wLmo9tNdvi8gBXBa22gft+KH3PYw+Gjx4cNyNQFa3AB2aOw4hu6YhHS02CPvyrPSALZvm2P6V9mYtGlgkvhZnbtm0H5Ua03zeqfpc1l+NLdgv+FByG3JknE8YrYIB/bsMtXN3nkzAKzyQc0NMTC6AL45eONEUzXQPSBW8dPKez6V1QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734507588; c=relaxed/relaxed;
	bh=4/fbYoMW4Mgk8ctWCbpE50BBypITO2RQ4q5chnEAJ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGXz4Rr9aV/9kLN6FI6KY5notnuHla9k5fIp6gDCWpPpjhLFRWjQbff8y8iKWraWNPS/dzuzvnm0UDFi5Ugx9dBSVX6kaH+gayLkrny1RTKxlsXElFBrUAm+DAZ1+XM4RhI/QHyzyNiArUPnQoAlvT7tCUqoKoIB0Olp3f0JHUZofyzAu/gaqm29aagVcWtH9q51bSFd6nZ7V+7nVZ2fJPiC8qIgEPOOCSKQVYJ5LC7PdeY8AbnGSUgaLPbA8B6cuEkPZfTsSRZXpV8p3+RI0ScVSPfe/Bgo64AU8yNM66qfWw9tzQ+41lmk3YiLxJn2KGCdVAZi8ZFe6P7OqYQofg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sNlVyEwJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sNlVyEwJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YClv66BgCz305C
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 18:39:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507582; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4/fbYoMW4Mgk8ctWCbpE50BBypITO2RQ4q5chnEAJ4E=;
	b=sNlVyEwJ0vpEQtc1gj8xgiVKKHTdUIGG2s3Uiz+l0gGFxiGh4QyVsvgfYMyI85vuyqfWUR+fb6X62kVPWrF68g4iPM2ik3+QzEOUxqzXf29E59c5kKzKw6Iag49f7fhDU8xDqMlg4ZFZqQncNCKStysWQZFAYZu/gCqXaN38BL0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlkMIV_1734507580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:39:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 5.4.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 15:39:37 +0800
Message-ID: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, allison.karlitskaya@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 1dd73601a1cba37a0ed5f89a8662c90191df5873 upstream.

As syzbot reported [1], the root cause is that i_size field is a
signed type, and negative i_size is also less than EROFS_BLKSIZ.
As a consequence, it's handled as fast symlink unexpectedly.

Let's fall back to the generic path to deal with such unusual i_size.

[1] https://lore.kernel.org/r/000000000000ac8efa05e7feaa1f@google.com

Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Link: https://lore.kernel.org/r/20220909023948.28925-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0dbeaf68e1d6..ba981076d6f2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -202,7 +202,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE) {
+	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
-- 
2.43.5

