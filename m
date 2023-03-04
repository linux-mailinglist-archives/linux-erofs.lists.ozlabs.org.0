Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4446AAC42
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 20:58:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PTbHm68lHz3bhL
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Mar 2023 06:58:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PTbHd6Sy8z2ynD
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Mar 2023 06:58:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vd47ETb_1677959896;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd47ETb_1677959896)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 03:58:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/5] erofs-utils: avoid using a static srcpath
Date: Sun,  5 Mar 2023 03:58:10 +0800
Message-Id: <20230304195812.120063-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
References: <20230304195732.119053-1-hsiangkao@linux.alibaba.com>
 <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

To avoid unnecessary memory overhead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  2 +-
 lib/inode.c              | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 08a3877..d4ae3b8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -180,7 +180,7 @@ struct erofs_inode {
 		};
 	} u;
 
-	char i_srcpath[PATH_MAX + 1];
+	char *i_srcpath;
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
diff --git a/lib/inode.c b/lib/inode.c
index 8364451..bcb0986 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -119,6 +119,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	if (inode->eof_tailraw)
 		free(inode->eof_tailraw);
 	list_del(&inode->i_hash);
+	if (inode->i_srcpath)
+		free(inode->i_srcpath);
 	free(inode);
 	return 0;
 }
@@ -905,8 +907,9 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		return -EINVAL;
 	}
 
-	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
-	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
+	inode->i_srcpath = strdup(path);
+	if (!inode->i_srcpath)
+		return -ENOMEM;
 
 	inode->dev = st->st_dev;
 	inode->i_ino[1] = st->st_ino;
@@ -977,10 +980,9 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 
 	ret = erofs_fill_inode(inode, &st, path);
 	if (ret) {
-		free(inode);
+		erofs_iput(inode);
 		return ERR_PTR(ret);
 	}
-
 	return inode;
 }
 
-- 
2.24.4

