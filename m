Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57C727EC2
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Jun 2023 13:30:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcMTc5KzVz3dyK
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Jun 2023 21:30:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QcMTK1zFkz3dwq
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Jun 2023 21:30:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkeE.J9_1686223823;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkeE.J9_1686223823)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 19:30:24 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 3/5] erofs: make the size of read data stored in buffer_ofs
Date: Thu,  8 Jun 2023 19:30:18 +0800
Message-Id: <20230608113020.66626-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
References: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
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

Since now xattr_iter structures have been unified, make the size of the
read data stored in buffer_ofs.  Don't bother reusing buffer_size for
this use, which may be confusing.

This is in preparation for the following further cleanup.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index e9bc81846722..4ae9b7cdd3ac 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -315,7 +315,7 @@ static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 {
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
-	it->buffer_size = value_sz;
+	it->buffer_ofs = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
@@ -348,7 +348,7 @@ static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
@@ -371,7 +371,7 @@ static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
-- 
2.19.1.6.gb485710b

