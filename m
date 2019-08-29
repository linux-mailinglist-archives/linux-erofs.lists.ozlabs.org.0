Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8CA1AEC
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 15:08:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K2x55qymzDr7q
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 23:08:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWnodVrC"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K2wz4xmJzDr63
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 23:08:32 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id b24so2041358pfp.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=j1UY67r1uWWM2jMI80CXLCxfjYlAolrqvseIHICgMCU=;
 b=BWnodVrCF0swc449Dmw8ldMFD2TnZYq8StkgQjfdNr/lQYHJnXC7jZQey7C02bxi+a
 kAFcdxUWis2WTO4uOcIzcih3dNkcfDOHtPgPpfE8+yBcrQdyvf+on0BXpGNAGTCwQx8P
 orZ9mZhUVUt3e5nk67YpsSZHvicralJu/Q9Lg+7qhANf0tTdBdbRcZpD+dIyBSGfFEGF
 HWH6XfC/ILEh9RFOFQVgdbdVyMRil9fiKCOOS8oB9D/5epNgvN/e50qlG6aXzMVYHQJw
 DWbj7/SIVzng3rP/jr244JXT3tXU3GZdLkT6drCTx3dbzdTrpPhPpM/mzI3Sq4xBDf/N
 kVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=j1UY67r1uWWM2jMI80CXLCxfjYlAolrqvseIHICgMCU=;
 b=UVKs5GdrjL8doFmD4jGF55kNcyDnIci1KTLPuyz8db68Uot0FDLeuru+DpDhzZeEk9
 wcqje/r3MAskbOJ8Z7629vnw3MI04QDlXmqKO0J0AlkFi11aR3gcMjBc3iKAyID9uQL6
 88nAuB8zJb36uJ+YUKudnp7xI5T2TXkHO++xIe7CYYPQraF63JyDPrzjNuXDTz0wtlJw
 mVeEadx+vQIh++jO2YBNqZsgooX+FnwQPKKlmZHwQqNzgsJluq2N3yWxdFizi0KTT/+p
 1c52F1A42avK8CNExt5IA/4TqVLVD7R6MuGUkwt1qcfCqW/PocMPApIpVyCGe78s/qoh
 GbYQ==
X-Gm-Message-State: APjAAAW+yrTG/zNHs6qoJyC5X96owS8Tpxv1Sw/kFjOeWp3Ick9CWS1a
 3zrExz4Q8yInlhYl+UqnB7cIJbhZngPGyQ==
X-Google-Smtp-Source: APXvYqwTXhdtGbYjcmybp+U8ZqNsq1OuK1IAinEBhCF1P1yDqg1+tfFqjmzA6pa680VSpaQJw68t+Q==
X-Received: by 2002:a63:9d8a:: with SMTP id i132mr8266283pgd.410.1567084108145; 
 Thu, 29 Aug 2019 06:08:28 -0700 (PDT)
Received: from localhost.localdomain ([157.33.15.68])
 by smtp.gmail.com with ESMTPSA id o4sm9047219pje.28.2019.08.29.06.08.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 06:08:27 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] staging: erofs: using switch-case while checking the inode
 type.
Date: Thu, 29 Aug 2019 18:38:13 +0530
Message-Id: <20190829130813.11721-1-pratikshinde320@gmail.com>
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

while filling the linux inode, using switch-case statement to check
the type of inode.
switch-case statement looks more clean.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 drivers/staging/erofs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 4c3d8bf..2d2d545 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -190,22 +190,28 @@ static int fill_inode(struct inode *inode, int isdir)
 	err = read_inode(inode, data + ofs);
 	if (!err) {
 		/* setup the new inode */
-		if (S_ISREG(inode->i_mode)) {
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
 			inode->i_op = &erofs_generic_iops;
 			inode->i_fop = &generic_ro_fops;
-		} else if (S_ISDIR(inode->i_mode)) {
+			break;
+		case S_IFDIR:
 			inode->i_op = &erofs_dir_iops;
 			inode->i_fop = &erofs_dir_fops;
-		} else if (S_ISLNK(inode->i_mode)) {
+			break;
+		case S_IFLNK:
 			/* by default, page_get_link is used for symlink */
 			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
-		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_op = &erofs_generic_iops;
 			init_special_inode(inode, inode->i_mode, inode->i_rdev);
 			goto out_unlock;
-		} else {
+		default:
 			err = -EIO;
 			goto out_unlock;
 		}
-- 
2.9.3

