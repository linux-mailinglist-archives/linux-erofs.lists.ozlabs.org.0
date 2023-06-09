Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB616729409
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 11:02:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qcw8G3mNsz3f1K
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 19:02:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcw8971JGz3f0L
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 19:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkhRsJ1_1686301345;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkhRsJ1_1686301345)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 17:02:26 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: twist calculation of shared_xattr_id
Date: Fri,  9 Jun 2023 17:02:25 +0800
Message-Id: <20230609090225.91890-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

The on-disk format specifies that share xattr can be addressed by:

  xattr offset = xattr_blkaddr * block_size + 4 * shared_xattr_id

That is, the shared_xattr_id is calculated from the xattr offset
(starting from xattr_blkaddr) divided by 4.  Make this semantics
explicitly by calculating the divisor from 'sizeof(__le32)'.

It has no logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index dbe0519..1cd04cf 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -643,8 +643,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 			.e_value_size = cpu_to_le16(item->len[1])
 		};
 
-		item->shared_xattr_id = (off + p) /
-			sizeof(struct erofs_xattr_entry);
+		item->shared_xattr_id = (off + p) / sizeof(__le32);
 
 		memcpy(buf + p, &entry, sizeof(entry));
 		p += sizeof(struct erofs_xattr_entry);
-- 
2.19.1.6.gb485710b

