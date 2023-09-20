Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1A7A8C32
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 21:02:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrSb052dsz3cD3
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 05:02:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrSZs0sJnz2yGv
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 05:02:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsVvKLJ_1695236542;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsVvKLJ_1695236542)
          by smtp.aliyun-inc.com;
          Thu, 21 Sep 2023 03:02:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RESEND] erofs-utils: mkfs: limit total shared xattrs of a single inode
Date: Thu, 21 Sep 2023 03:02:20 +0800
Message-Id: <20230920190220.1837650-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230920185920.1833079-1-hsiangkao@linux.alibaba.com>
References: <20230920185920.1833079-1-hsiangkao@linux.alibaba.com>
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

Don't output more than 255 shared xattrs for a single inode due to the
EROFS on-disk format limitation.

Fixes: 116ac0a254fc ("erofs-utils: introduce shared xattr support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 790547c..1ed796b 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -665,6 +665,7 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	int ret;
 	struct inode_xattr_node *node;
 	struct list_head *ixattrs = &inode->i_xattrs;
+	unsigned int h_shared_count;
 
 	if (list_empty(ixattrs)) {
 		inode->xattr_isize = 0;
@@ -672,11 +673,13 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	}
 
 	/* get xattr ibody size */
+	h_shared_count = 0;
 	ret = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry(node, ixattrs, list) {
 		struct xattr_item *item = node->item;
 
-		if (item->shared_xattr_id >= 0) {
+		if (item->shared_xattr_id >= 0 && h_shared_count < UCHAR_MAX) {
+			++h_shared_count;
 			ret += sizeof(__le32);
 			continue;
 		}
@@ -980,7 +983,8 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 		list_del(&node->list);
 
 		/* move inline xattrs to the onstack list */
-		if (item->shared_xattr_id < 0) {
+		if (item->shared_xattr_id < 0 ||
+		    header->h_shared_count >= UCHAR_MAX) {
 			list_add(&node->list, &ilst);
 			continue;
 		}
-- 
2.39.3

