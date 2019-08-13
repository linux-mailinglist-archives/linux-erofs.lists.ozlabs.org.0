Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAE8C239
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 22:40:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467PjP6cJPzDqV2
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 06:40:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEC8laF3"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467Ph31YDPzDqkh
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 06:38:58 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id ay6so49808681plb.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=hwvRVADKtc6Sj8Y/Ad99QEgzGhBVmriNcJ7rbr0fKVI=;
 b=iEC8laF3x+qgX1ohOCNpcpJIcSnP9mLcGmISbHdt0P8/+KXpP/D41yVUkMYzVDm4J1
 paCWz3rbmRXsWxYvST6YCi4f5Rvnk6HayNapUN7XZA5/U7dIvFz5P83r1VXgiJDvZqeb
 V9xKYAnbKTpMxwxK2dc8cEyyLGW8OKmY2OUsPkgX0AqwY2D0lOdJqzG6H9Ud6NgrP/NZ
 MuFsUUbXKc3YNWkBaJPnajzYRh6BpNAL68MPubolClGDhxEr6jGNzblN0Heyhfbg9wQc
 MpjF7f4CAFdNmNJGOjJ1aAO6hxGqUVMEl58H7/FQWQbpkHSXV/bii/G9btPTaWoDOEp1
 lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hwvRVADKtc6Sj8Y/Ad99QEgzGhBVmriNcJ7rbr0fKVI=;
 b=FPQ3MXmQsQoHGBlyldmTYnLfvuRdcSv60jIi2+lu6QXKohMqs4NMlljol+g2/+Dvp2
 2EBAbdT/RtJKJmJ5nh4wgfGE2FWrNT+vAnIeuB2+aHY93MfPhLYGk1pnGmYuDDcWQT9I
 cBr4fLInyAX6y8as4qh97K85iZLruxTb3DJjueOyaorks086McwK2fiUF9wMR1xd8ALe
 sMBcNok0kAlhD0mUXxpJtA/vrT7ElmfFWRAij+xC/4cqE04koFelYhms7wcnqxdcXMXK
 0EshIxci82YR0ZLFiz5CVwTmJalmPZEyMoq2yGv5tao/3Y2Eq1LBQ7a/yaqqnjtuJji2
 n3qw==
X-Gm-Message-State: APjAAAWBOcwQf6FP1qabXuAcuzxZFxdO4dMPXC1QR3hmMf3pBEaGvwbL
 an1NLN74gnndr/xmiw8ENCUw2yx9iq0=
X-Google-Smtp-Source: APXvYqzyp+JWU8mM9jJ+W9dSqpzHTVp2JgnXsOkgKW1ZAAWSP+MgmKQ+0e2ix7K0XbXXyMfnFiStqQ==
X-Received: by 2002:a17:902:690b:: with SMTP id
 j11mr3937576plk.35.1565728734886; 
 Tue, 13 Aug 2019 13:38:54 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.130])
 by smtp.gmail.com with ESMTPSA id e7sm15095721pfn.72.2019.08.13.13.38.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 13:38:53 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] staging: erofs: removing an extra call to iloc() in
 fill_inode()
Date: Wed, 14 Aug 2019 02:08:40 +0530
Message-Id: <20190813203840.13782-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

in fill_inode() we call iloc() twice.Avoiding the extra call by
storing the result.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 drivers/staging/erofs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 4c3d8bf..d82ba6c 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -167,11 +167,12 @@ static int fill_inode(struct inode *inode, int isdir)
 	int err;
 	erofs_blk_t blkaddr;
 	unsigned int ofs;
+	erofs_off_t inode_loc;
 
 	trace_erofs_fill_inode(inode, isdir);
-
-	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
-	ofs = erofs_blkoff(iloc(sbi, vi->nid));
+	inode_loc = iloc(sbi, vi->nid);
+	blkaddr = erofs_blknr(inode_loc);
+	ofs = erofs_blkoff(inode_loc);
 
 	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
 		__func__, vi->nid, ofs, blkaddr);
-- 
2.9.3

