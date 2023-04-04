Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A86D5A31
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxj0ndVz3cjL
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP4Sttz3cG1
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfL3LKP_1680595345;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfL3LKP_1680595345)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:26 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 1/6] erofs-utils: declare prefix_len as u8
Date: Tue,  4 Apr 2023 16:02:18 +0800
Message-Id: <20230404080224.77577-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
References: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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

The on-disk erofs_xattr_entry.e_name_len is declared as u8, which
implies the maximum length of the xattr name.

Let's also declare xattr_prefix.prefix_len as u8 to keep sync with the
on-disk structure.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 1a22284..a292f2c 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -41,7 +41,7 @@ static unsigned int shared_xattrs_count, shared_xattrs_size;
 
 static struct xattr_prefix {
 	const char *prefix;
-	u16 prefix_len;
+	u8 prefix_len;
 } xattr_types[] = {
 	[EROFS_XATTR_INDEX_USER] = {
 		XATTR_USER_PREFIX,
-- 
2.19.1.6.gb485710b

