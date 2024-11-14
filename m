Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 739909C86A6
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 10:58:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpwZz6Jlrz2ywC
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 20:58:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731578314;
	cv=none; b=THT7vCJ20BhGJIuU7/fFLSPpvhD+XNArXHhHjZvJfsw5MdPIxPXzi4ARe6LPEwWTyCLwJotrRZA5UWRc8/aa/tsxCyU6GwVxuWMdyIXHle7M3UkLNUAcUI2lIvMr3vgfhQhFgYCOhxYKOYoiJkS76kJz4x0xX8FW9m/UIe5/Nwm5BZNByEfdd2NTwJtUPVOFpnGDhcfueLd3MrqIaqNyBjc7e/qNSKbMVKhDXGFfdzlSCJ2+8emh+l6CiaS5FXM19RQP1TDUIqafIheupIAgZi4Sb5SD9oefB1asML3oO1DeDNOpLqKz9fsB5LH1/3lMnQg5mtOU8HGzK6lusAfiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731578314; c=relaxed/relaxed;
	bh=Cfoxrf7A2stl6riO4W8iN9G+2yj/ESltvt7CchpB2oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bP2bIo4t6xc/FF1LyxJCtat05gXied+Q8qW4FQfN8ilFC7+IcQ2f01rTx/OHaOIugHjxmFgVZPiBUf4IQewmdfr8UO2S4/Nl7xOm0Ko1OnUcQ7vXBypFNOAgGVE0W4x2/ByjNgl/ZjfXdZTqAzTHP1Ex6VfCZfoeBullu6UmHoVPYJpYe0pIKrcLGrIGYDIwLpPp3LyTAfLZwSJDm5SO2KU5z+5kI2v0ysZ3xX4dMDnhDtPxKjkkObjkhIkWc7T6EmsGpUxBUR43CbIsUTeCuih24s495DiFRuDVmno7qExEx22ZQ1F5D1LndRewhunChNBpLybWwaLc5yIElhb/xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hQ/FPPzD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hQ/FPPzD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpwZw1xHWz2xFr
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 20:58:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731578304; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Cfoxrf7A2stl6riO4W8iN9G+2yj/ESltvt7CchpB2oM=;
	b=hQ/FPPzDbuBMqPX4Xs0UBsZlHE/ca5YOYa9fDWQrB3Mz4Eku+uM6/mG4pxZOUdEMmlITliG/KmLZ67N8jQ7tSA2GRDY23pGXz80IGp5x9AW4HAhYZoSqQski4LwODhUtWB1CQx2HfZ6zY+i/WOJDvlcb2z7vAV1icab2zuEHnL0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJONkQz_1731578295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 17:58:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: get rid of `buf->kmap_type`
Date: Thu, 14 Nov 2024 17:58:13 +0800
Message-ID: <20241114095813.839866-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 927e5010ff5b ("erofs: use kmap_local_page() only for
erofs_bread()"), `buf->kmap_type` actually has no use at all.

Let's get rid of `buf->kmap_type` now.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 18 +++++-------------
 fs/erofs/internal.h |  1 -
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f741c3847ff2..d53979174aff 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -10,10 +10,10 @@
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
 {
-	if (buf->kmap_type == EROFS_KMAP)
-		kunmap_local(buf->base);
+	if (!buf->base)
+		return;
+	kunmap_local(buf->base);
 	buf->base = NULL;
-	buf->kmap_type = EROFS_NO_KMAP;
 }
 
 void erofs_put_metabuf(struct erofs_buf *buf)
@@ -45,15 +45,8 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 			return folio;
 	}
 	buf->page = folio_file_page(folio, index);
-
-	if (buf->kmap_type == EROFS_NO_KMAP) {
-		if (type == EROFS_KMAP)
-			buf->base = kmap_local_page(buf->page);
-		buf->kmap_type = type;
-	} else if (buf->kmap_type != type) {
-		DBG_BUGON(1);
-		return ERR_PTR(-EFAULT);
-	}
+	if (!buf->base && type == EROFS_KMAP)
+		buf->base = kmap_local_page(buf->page);
 	if (type == EROFS_NO_KMAP)
 		return NULL;
 	return buf->base + (offset & ~PAGE_MASK);
@@ -352,7 +345,6 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		struct erofs_buf buf = {
 			.page = kmap_to_page(ptr),
 			.base = ptr,
-			.kmap_type = EROFS_KMAP,
 		};
 
 		DBG_BUGON(iomap->type != IOMAP_INLINE);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9844ee8a07e5..01bbbd32b6b9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -212,7 +212,6 @@ struct erofs_buf {
 	struct file *file;
 	struct page *page;
 	void *base;
-	enum erofs_kmap_type kmap_type;
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-- 
2.43.5

