Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F034B764527
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 06:57:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBJRD6M5zz3c7f
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 14:57:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBJR34CXKz30F5
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 14:57:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoJALV1_1690433833;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoJALV1_1690433833)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 12:57:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/9] erofs-utils: initialize i_nlink to 2 in erofs_init_empty_dir()
Date: Thu, 27 Jul 2023 12:57:05 +0800
Message-Id: <20230727045712.45226-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
References: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Set dir->i_nlink to 2 as "." and ".." are allocated.

tarerofs_init_empty_dir() is removed then.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/inode.c |  2 ++
 lib/tar.c   | 14 ++------------
 mkfs/main.c |  2 +-
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index c4d1476..d54f84f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -235,6 +235,8 @@ int erofs_init_empty_dir(struct erofs_inode *dir)
 		return PTR_ERR(d);
 	d->inode = erofs_igrab(dir->i_parent);
 	d->type = EROFS_FT_DIR;
+
+	dir->i_nlink = 2;
 	return 0;
 }
 
diff --git a/lib/tar.c b/lib/tar.c
index 76ba69d..3c145e5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -138,16 +138,6 @@ static long long tarerofs_parsenum(const char *ptr, int len)
 	return tarerofs_otoi(ptr, len);
 }
 
-int tarerofs_init_empty_dir(struct erofs_inode *inode)
-{
-	int ret = erofs_init_empty_dir(inode);
-
-	if (ret)
-		return ret;
-	inode->i_nlink = 2;
-	return 0;
-}
-
 static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *s)
 {
 	struct erofs_inode *inode;
@@ -163,7 +153,7 @@ static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *
 	inode->i_gid = getgid();
 	inode->i_mtime = inode->sbi->build_time;
 	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
-	tarerofs_init_empty_dir(inode);
+	erofs_init_empty_dir(inode);
 
 	d = erofs_d_alloc(dir, s);
 	if (!IS_ERR(d)) {
@@ -759,7 +749,7 @@ new_inode:
 		inode->i_nlink++;
 		ret = 0;
 	} else if (!inode->i_nlink)
-		ret = tarerofs_init_empty_dir(inode);
+		ret = erofs_init_empty_dir(inode);
 	else
 		ret = 0;
 out:
diff --git a/mkfs/main.c b/mkfs/main.c
index 92a07fd..bc5ed87 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -928,7 +928,7 @@ int main(int argc, char **argv)
 		root_inode->i_parent = root_inode;
 		root_inode->i_mtime = sbi.build_time;
 		root_inode->i_mtime_nsec = sbi.build_time_nsec;
-		tarerofs_init_empty_dir(root_inode);
+		erofs_init_empty_dir(root_inode);
 
 		while (!(err = tarerofs_parse_tar(root_inode, &erofstar)));
 
-- 
2.19.1.6.gb485710b

