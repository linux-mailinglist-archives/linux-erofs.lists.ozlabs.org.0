Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E4195817C
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 10:56:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp3H65wwyz2yDt
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 18:56:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ISGkbLPy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp3H25v3qz2y33
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 18:56:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724144184; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8uaDmpfMNQCpCM0aUgKOkD6ZL9TOLlGfVf7ZQ6Vh07k=;
	b=ISGkbLPyGc5u/y0tVu9wtnq0blNtu59cP+pzMGb49LUOgnaVGggRRdGW9tysl5c9NWL8yl/U0PrYslt5op7UNYhl0H7PTwVFJ6iboyWOKLsexyWaOJkZvWnV7YvJbtb/uhdWerJHIz+0UDasWgcWi4CZbPqvgtnQtCmnExpojco=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDHzSAl_1724144181)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 16:56:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RESEND] erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails
Date: Tue, 20 Aug 2024 16:56:19 +0800
Message-ID: <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <000000000000f7b96e062018c6e3@google.com>
References: <000000000000f7b96e062018c6e3@google.com>
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
Cc: syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If z_erofs_gbuf_growsize() partially fails on a global buffer due to
memory allocation failure or fault injection (as reported by syzbot [1]),
new pages need to be freed by comparing to the existing pages to avoid
memory leaks.

However, the old gbuf->pages[] array may not be large enough, which can
lead to null-ptr-deref or out-of-bound access.

Fix this by checking against gbuf->nrpages in advance.

[1] https://lore.kernel.org/r/000000000000f7b96e062018c6e3@google.com

Reported-by: syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com
Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: <stable@vger.kernel.org> # 6.10+
Cc: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
RESEND:
 Add missing link and reported-by.

 fs/erofs/zutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 9b53883e5caf..37afe2024840 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -111,7 +111,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 out:
 	if (i < z_erofs_gbuf_count && tmp_pages) {
 		for (j = 0; j < nrpages; ++j)
-			if (tmp_pages[j] && tmp_pages[j] != gbuf->pages[j])
+			if (tmp_pages[j] && (j >= gbuf->nrpages ||
+					     tmp_pages[j] != gbuf->pages[j]))
 				__free_page(tmp_pages[j]);
 		kfree(tmp_pages);
 	}
-- 
2.43.5

