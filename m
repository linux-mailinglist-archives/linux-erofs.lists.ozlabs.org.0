Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65C77D946
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 05:50:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQZ075qqHz3cTc
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 13:49:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQYzz5yLjz2yVs
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 13:49:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpuJ30i_1692157782;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpuJ30i_1692157782)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 11:49:43 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/4] erofs-utils: lib: fix potential out-of-bound in xattr_entrylist()
Date: Wed, 16 Aug 2023 11:49:38 +0800
Message-Id: <20230816034941.126866-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
References: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
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

Check the index before accessing array to avoid the potential
out-of-bound access.

Fixes: c47df5aa2d16 ("erofs-utils: fuse: introduce xattr support")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 12f580e..2548750 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1229,11 +1229,14 @@ static int xattr_entrylist(struct xattr_iter *_it,
 {
 	struct listxattr_iter *it =
 		container_of(_it, struct listxattr_iter, it);
+	unsigned int base_index = entry->e_name_index;
 	unsigned int prefix_len;
 	const char *prefix;
 
-	prefix = xattr_types[entry->e_name_index].prefix;
-	prefix_len = xattr_types[entry->e_name_index].prefix_len;
+	if (base_index >= ARRAY_SIZE(xattr_types))
+		return 1;
+	prefix = xattr_types[base_index].prefix;
+	prefix_len = xattr_types[base_index].prefix_len;
 
 	if (!it->buffer) {
 		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
-- 
2.19.1.6.gb485710b

