Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E94527CF
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 03:42:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtVhX4mQWz2xh0
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 13:42:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtVhR3L6yz2xCy
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 13:42:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uwnk90a_1637030514; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uwnk90a_1637030514) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 10:42:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 4.19.y 1/2] erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()
Date: Tue, 16 Nov 2021 10:41:52 +0800
Message-Id: <20211116024153.245131-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <1636983460149191@kroah.com>
References: <1636983460149191@kroah.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

commit 7dea3de7d384f4c8156e8bd93112ba6db1eb276c upstream.

No any behavior to variable occupied in z_erofs_attach_page() which
is only caller to z_erofs_pagevec_enqueue().

Link: https://lore.kernel.org/r/20210419102623.2015-1-zbestahu@gmail.com
Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ Gao Xiang: handle 4.19 codebase conflicts manually. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Gao Xiang: Same to 5.4.y and 5.10.y, apply this trivial cleanup as well.

 drivers/staging/erofs/unzip_pagevec.h | 5 +----
 drivers/staging/erofs/unzip_vle.c     | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index 23856ba2742d..64724dd1e04e 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -117,10 +117,8 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
 static inline bool
 z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
 			     struct page *page,
-			     enum z_erofs_page_type type,
-			     bool *occupied)
+			     enum z_erofs_page_type type)
 {
-	*occupied = false;
 	if (unlikely(ctor->next == NULL && type))
 		if (ctor->index + 1 == ctor->nr)
 			return false;
@@ -135,7 +133,6 @@ z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
 	/* should remind that collector->next never equal to 1, 2 */
 	if (type == (uintptr_t)ctor->next) {
 		ctor->next = page;
-		*occupied = true;
 	}
 
 	ctor->pages[ctor->index++] =
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 0f1558c6747e..48c21a4d5dc8 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -234,7 +234,6 @@ static int z_erofs_vle_work_add_page(
 	enum z_erofs_page_type type)
 {
 	int ret;
-	bool occupied;
 
 	/* give priority for the compressed data storage */
 	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY &&
@@ -242,8 +241,7 @@ static int z_erofs_vle_work_add_page(
 		try_to_reuse_as_compressed_page(builder, page))
 		return 0;
 
-	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector,
-		page, type, &occupied);
+	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector, page, type);
 	builder->work->vcnt += (unsigned)ret;
 
 	return ret ? 0 : -EAGAIN;
-- 
2.24.4

