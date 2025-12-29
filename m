Return-Path: <linux-erofs+bounces-1631-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D77CE64A7
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 10:30:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfrXr3cFsz2xrL;
	Mon, 29 Dec 2025 20:30:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767000604;
	cv=none; b=fLYVtomKQ1kDYEC3puOogCIzeUQvEkhO1L2aGBT1sT2JdxIbouYOYUp18fgYKeUCxC7BiY46GWoTf781FwGXj74FtdbUoJuQuiok4hhIKPCJx0icqbihufuylXV1C4nmtPb2FAKIcxez+uYXBrlKqVu5CPkkWiRD82/S1dfMw2WUE5fxNohuNXHx0hfalaUuVLkYi4GQgdEzFgs6xazY6CXXjdNWsNnotSs1mdt5bgJiD7pXoNy5t9ebzpp9v7QLgcaOCraxv1/UIgwskuVZ+13WqDilNaVVuLU/NQTqh8tV6w4aiW5iiO3W8Gn5Y+6DON2KKTfkJ/PDM5dM40CPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767000604; c=relaxed/relaxed;
	bh=3rk3kvZ3VXsGykVHI9qGaamUdteLgjuNOIN3NRqV4B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVLrw1OZq/BCnvYGY3RZU3b4hr/TNERv/yaFYFUt7Yo4MVEDKJx4hCEe8XEGNicYtvIUe2uW+z4ySyfI/261nzLday+P4Plt/8yCOI7/Anuxv9HCO2SJFAZo4f46JgCQl0M43SpbGAoKnBLiHTbVaLJHB/ep7xuJGOCvjWgyoDmu2F+4Wgt168+smyfNzTqNZJfiga9zWg7I+s8KwBTRrLaQcj5TnwcO1k1tkTpxxjVcmPDBUwzwUGraQO0bsmJjTdRp2v0HA29SCli870RwNS3SI0tMP6VItgobnLmLcFoECowNfOVqEpFgUFx4quq74rHslodmRR/R+T0bTfDeKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vE87AH6i; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vE87AH6i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfrXp20Vlz2xpg
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 20:30:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767000596; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3rk3kvZ3VXsGykVHI9qGaamUdteLgjuNOIN3NRqV4B4=;
	b=vE87AH6iER/L3EclRusL/pyizRy2IhSZ99IG+ZAVobxX38U1/pse7wLoexN6EgLrnUi6RDzBKfnrSWoK4tt34QYvi62V1UoSC83hmAUpBp0qRw9m0vteR7FXNbEBXdNCf1HtYAccEwsIH+nf/FHyZGvdJZvHtyFMGE4mzzFK7aM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvqzdsd_1767000593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 17:29:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs: fix incorrect early exits in volume label handling
Date: Mon, 29 Dec 2025 17:29:47 +0800
Message-ID: <20251229092949.2316075-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Crafted EROFS images containing valid volume labels can trigger
incorrect early returns, leading to folio reference leaks.

However, this does not cause system crashes or other severe issues.

Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 2e4d0ea2ffa1..0d4f736ae1f1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -347,8 +347,10 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (dsb->volume_name[0]) {
 		sbi->volume_name = kstrndup(dsb->volume_name,
 					    sizeof(dsb->volume_name), GFP_KERNEL);
-		if (!sbi->volume_name)
-			return -ENOMEM;
+		if (!sbi->volume_name) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/* parse on-disk compression configurations */
-- 
2.43.5


