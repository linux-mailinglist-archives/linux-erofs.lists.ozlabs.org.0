Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173E639FDF
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 03:59:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NL9Cz2gj4z3fQF
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 13:59:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NL91k4L8jz3f8t
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 13:50:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVnULt1_1669603813;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVnULt1_1669603813)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 10:50:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: enable large folios for fscache mode
Date: Mon, 28 Nov 2022 10:50:11 +0800
Message-Id: <20221128025011.36352-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
References: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
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

Enable large folios for fscache mode.  Enable this feature for
non-compressed format for now, until the compression part supports large
folios later.

One thing worth noting is that, the feature is not enabled for the meta
data routine since meta inodes don't need large folios for now, nor do
they support readahead yet.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e457b8a59ee7..85932086d23f 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,8 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-	if (!erofs_is_fscache_mode(inode->i_sb))
-		mapping_set_large_folios(inode->i_mapping);
+	mapping_set_large_folios(inode->i_mapping);
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (erofs_is_fscache_mode(inode->i_sb))
 		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-- 
2.19.1.6.gb485710b

