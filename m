Return-Path: <linux-erofs+bounces-1632-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050DCE64AA
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 10:30:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfrXs0KP2z2x9M;
	Mon, 29 Dec 2025 20:30:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767000605;
	cv=none; b=fiwvPIaK1G8relMH6t+wTeZ/nrTnga/OlwoitT/Es9UntdBJeDDNdLxTaERt+7bvaU3isSWA0gMfgIxW0IyD+aGgzb7+BOt2lUsjuSQRoQ1TBGQJLNKs572XFBKt+93P864iwu0s8bCZa/IFUI8Ixf9S6BBQByV24kuFydbf6O9MSzGKSgUZjliKvOyQ99S3B/N7gvpbu3NNoCT9adlFjH1XTj63WckAZQIe4/LeinYb2y/rtqmbdTxL2uJ1Ujg8BcHFq8ioRwDoH1OZD5gJGj8cNDC5PfoL0ccFtFq+LA3AWBsish4Tb402FU6GfambBBuI5Iyhny+i/kuxitCfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767000605; c=relaxed/relaxed;
	bh=DTcDrCKHuE1wXLhx8R4H8p8WcGuOFBc484to9LdCtVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jl+aR4hZ7MC6eIEbkYluv7WCejrg/HXpnXHUM0glxWtocGX11hDvuLAwaHKVqFQIF7xJ/5ekHuWj67zzt14Q60KjGv8K82KVAMsgkH13rDcD2iwFZgr0frXUhPQ6SQmV7VXKE1hG5cJHM0OBtrK2+AexxucV9hYZGpPNfCCp0Z6NPnhuTRpo60XlTORw+QEQn0gIYKm7vmbS4wbDMxAMASfo1T7ljXca8t+Dne1En0piyYroDlqVnFNq41v+9N03snxxiJbIq2RewhFdrHRjjXoOWHQ84lvEI/yKri0NDImIWmG7ZvCdeMCJO7BzTebnv60ZcQ7bUFRhph9xkARHIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LPetRUs2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LPetRUs2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfrXn5ln6z2xdV
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 20:29:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767000595; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DTcDrCKHuE1wXLhx8R4H8p8WcGuOFBc484to9LdCtVU=;
	b=LPetRUs220O9lq4Z6qd+sMZTYH7DubkBLt5UnKUira1CvTkCYW+mnsTVixrpDyh0PYbXjfFaJhVUaRYbYKgjZY8dS7MdfRax7K8b1viCr1vxc+BAZ5NkmgiKg2yt5PjRSteCDyV1+DPJ8rVAGkAqhsxcF8ToFO6BFMMAsY92UbY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvqzdqv_1767000589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 17:29:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs: fix incorrect early exits for invalid metabox-enabled images
Date: Mon, 29 Dec 2025 17:29:46 +0800
Message-ID: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Crafted EROFS images with metadata compression enabled can trigger
incorrect early returns, leading to folio reference leaks.

However, this does not cause system crashes or other severe issues.

Fixes: 414091322c63 ("erofs: implement metadata compression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..2e4d0ea2ffa1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -330,12 +330,13 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	if (erofs_sb_has_metabox(sbi)) {
+		ret = -EFSCORRUPTED;
 		if (sbi->sb_size <= offsetof(struct erofs_super_block,
 					     metabox_nid))
-			return -EFSCORRUPTED;
+			goto out;
 		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
 		if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
-			return -EFSCORRUPTED;	/* self-loop detection */
+			goto out;		/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
 
-- 
2.43.5


