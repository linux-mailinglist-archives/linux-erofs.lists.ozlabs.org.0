Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A377D836
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 04:14:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQWsb2zC3z3cT8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 12:14:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQWsK6rHsz2yW7
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 12:13:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vptqv7P_1692152030;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vptqv7P_1692152030)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 10:13:51 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 03/12] erofs-utils: lib: read i_ino in erofs_read_inode_from_disk()
Date: Wed, 16 Aug 2023 10:13:38 +0800
Message-Id: <20230816021347.126886-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
References: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
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

i_ino[0] is a unique inode serial number in the erofs filesystem where
the inode resides, and also serves as the on-disk inode number, while
i_ino[1] is a unique number identifying the source inode in the source
directory, which is usually derived from st->st_ino.

Read on-disk ino and store it in i_ino[0] given the above background.

Fixes: 5e35b75ad499 ("erofs-utils: introduce fuse implementation")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/namei.c b/lib/namei.c
index 1023a9a..2bb1d4c 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -60,6 +60,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		die = (struct erofs_inode_extended *)buf;
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(die->i_mode);
+		vi->i_ino[0] = le32_to_cpu(die->i_ino);
 
 		switch (vi->i_mode & S_IFMT) {
 		case S_IFREG:
@@ -95,6 +96,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(dic->i_mode);
+		vi->i_ino[0] = le32_to_cpu(dic->i_ino);
 
 		switch (vi->i_mode & S_IFMT) {
 		case S_IFREG:
-- 
2.19.1.6.gb485710b

