Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECB6CFE3C
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 10:29:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnGml3VLpz3fHD
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 19:29:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnGmY5lLVz3c92
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 19:29:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VezvKme_1680164952;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VezvKme_1680164952)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:13 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/8] erofs: rename init_inode_xattrs with erofs_ prefix
Date: Thu, 30 Mar 2023 16:29:04 +0800
Message-Id: <20230330082910.125374-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 9ccd57581bc7..dc36a0c0919c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,7 +29,7 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
-static int init_inode_xattrs(struct inode *inode)
+static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct xattr_iter it;
@@ -405,7 +405,7 @@ int erofs_getxattr(struct inode *inode, int index,
 	if (!name)
 		return -EINVAL;
 
-	ret = init_inode_xattrs(inode);
+	ret = erofs_init_inode_xattrs(inode);
 	if (ret)
 		return ret;
 
@@ -600,7 +600,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	int ret;
 	struct listxattr_iter it;
 
-	ret = init_inode_xattrs(d_inode(dentry));
+	ret = erofs_init_inode_xattrs(d_inode(dentry));
 	if (ret == -ENOATTR)
 		return 0;
 	if (ret)
-- 
2.19.1.6.gb485710b

