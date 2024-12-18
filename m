Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5B9F5F65
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 08:36:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YClqb1F1tz30Ty
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 18:36:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734507401;
	cv=none; b=AjazfS5j1C4AfzvOemLJ9CK8upVIZ4gYVj0g5wpWWuaqyZyk0gr47QwQlItJ5VYtAutSKbRpj8JmtwQTZl2FDokHCZuS8UBiG/gEE9PohKDCVJwUKp8q989hNRZHxiNcRkMxbUmx4jsAmSS5811OsMCxY7MbPu4dQ/Df3nfICCVB+9Cw5shtXRdX3RiF5UgwzoH2DSg0FEEAepcCVZQ0hEGhQVsTWEtiTZqtrVSJpRxNv9DcPkVuJsN8xTef4Ov0O27V7OUA15CCjEi68Z5mmC+zKob+TLQwYkvKodq8Ze9E2F7B7Z2J+8d73A+dSoovw9Vb2EOuRiZBDigrJ0nwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734507401; c=relaxed/relaxed;
	bh=p0vvWWrMMbw7/s7hWg0TDba/m+Ylu1H14UrtBMjU/Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EA1MTuerRD52BTvpSDSz2vqnU0DLfczMbAv4zY+aHeZsR6tA3HWtG7cmVjp6Im8mKvZKfp64bzXtNFaNYhlnPTryxWrQ9zhHXZcK1d9RM2bE0HoPDc7FADnQyTSRd/ib/97ebeMEjqriF48TllvKxSwkTXmWN0/u5Ij4Ty7e2bZQR5LEA0orXsLc0P7xf8yz+Z03iQsPNjyBk15JliE7Enq2i39zROaxwoISpiM7mzvAmhpgBk/bWlodfGZa912GycckooyXow26tIzD74G5jXiruW9PL52U3NYOf5GkRZNARfvvPNRPt4URsfGGgKuGaYI0wQIbyF2gU6bEMDbZMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H9eVFcPR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H9eVFcPR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YClqX3jPbz2yD4
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 18:36:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507396; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=p0vvWWrMMbw7/s7hWg0TDba/m+Ylu1H14UrtBMjU/Ow=;
	b=H9eVFcPRKslO2Dlqo03lpRg6niO6nQ0Lk6N82ZdJgfNWv/MVLQerTiTTzmwBT4GDOygw76DPBU8d7kQ0gWr+ilOuJTmEy5ZBkaDRJAzT7my7VmLyRdRq9zoqlyIMesEXTX3nX4tBWaXXnoo3EjX9U6yU58h7aOCf8D0J+cq5uDw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlonKC_1734507394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:36:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 5.10.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 15:36:25 +0800
Message-ID: <20241218073626.454638-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, allison.karlitskaya@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 1dd73601a1cba37a0ed5f89a8662c90191df5873 upstream.

As syzbot reported [1], the root cause is that i_size field is a
signed type, and negative i_size is also less than EROFS_BLKSIZ.
As a consequence, it's handled as fast symlink unexpectedly.

Let's fall back to the generic path to deal with such unusual i_size.

[1] https://lore.kernel.org/r/000000000000ac8efa05e7feaa1f@google.com

Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Link: https://lore.kernel.org/r/20220909023948.28925-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0a94a52a119f..93a4ed665d93 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -202,7 +202,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE) {
+	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
-- 
2.43.5

