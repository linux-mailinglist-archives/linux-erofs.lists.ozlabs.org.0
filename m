Return-Path: <linux-erofs+bounces-459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC067ADDAF8
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 19:56:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMF1Y1rD4z30GV;
	Wed, 18 Jun 2025 03:56:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750183009;
	cv=none; b=ej9omc/LexZYUgEbwzu5WtBJu+5WHgk3XS/1VF6eyrEmWJ4QbrGUtZskYiDSzs4/sTJp3Em+RFGaJRRe/q8H8r/8TJli6iQAbKz7XMMzE5ouvzwS85pMpyzHS0Y6kUuER48OMpdPhgZww0hpPR2vKwrcdQpjcJRlyBJqTfhdwgL1+i6SRZF7+sd+d6uV5cerhnOnZ0AUlGt807xAarUaHYmgMoEKMCmQGbenIL1kgu3K7v+sv2KPKus7+FVsEA11iismVIXu/ZsoU6+Fnp6pYFxnF/GXUzsKbr7YVvAqITfb6sVwVqwXWLnTbEkODuSeVbkSUR6iKOpod64SpuCGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750183009; c=relaxed/relaxed;
	bh=n6l6piq1gfTfi9oX/XyyNq+wjcRRhBO/CyxzrXQn7U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iK/+0kBm9tywkEdTl4hnbZ1KDyAMqVTFcwaVrM8TS8658RanyjJ14S9T0V7iKrnpxim9P4fvY7WXGI0c6qH8zc5fmU2+BMC1sufuifi9f8lZahlsyZu1Tj0zYym8DZ93Srzw8A6HDygNhCjCFSa546+zouJ6GhdOJ8ykPT3vJUIOqFvlQSem3cV7pVZLFPEL/u2sXB8pKLydmzbbxC+7sNe2vK0QlXb2XZAIRJWwHSt8evZuaqmvs6TY2cnkIrkpHWcdVgKtGK5uCYp1jbvOVS9a5jinImgBfNDeLQ1DXI2YJL73h1fne7ojwx2hWkSCWN5nTVLzO/+6MKNqZs2usA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3667Fc/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3667Fc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMF1V6ht5z2yRD
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 03:56:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750183001; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=n6l6piq1gfTfi9oX/XyyNq+wjcRRhBO/CyxzrXQn7U4=;
	b=n3667Fc/dfFMrrqOFcZVYmVv9G27Z7rBjWdVPtNWSIA/ekhef22CUhN+gK4wSubI4WM6fzIrG8Q6Ept7ZTwnosjwOU9IM6K9rfKtWWoCrcYjr6zMYs3emKEANAiflHBqreBnbT8LdJkQvH2gFxurdpjOUsEqj+qbv4nzHLlb8wM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeARHQu_1750182995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Jun 2025 01:56:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix erofs_pack_file_from_fd()
Date: Wed, 18 Jun 2025 01:56:34 +0800
Message-ID: <20250617175634.2598-1-hsiangkao@linux.alibaba.com>
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

If sendfile() fails, it should fall back to a plain copy.

Coverity-id: 554788
Fixes: 84bae6acdbee ("erofs-utils: lib: keep full data until the fragment is committed")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index d63995e..e65963b 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -242,6 +242,9 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 	char *memblock;
 	bool onheap = false;
 
+	if (__erofs_unlikely(!inode->i_size))
+		return 0;
+
 	offset = lseek(epi->fd, 0, SEEK_CUR);
 	if (offset < 0)
 		return -errno;
@@ -256,7 +259,7 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 			sz = min_t(u64, remaining, UINT_MAX);
 			rc = sendfile(epi->fd, fd, NULL, sz);
 			if (rc < 0)
-				goto out;
+				break;
 			remaining -= rc;
 		} while (remaining);
 #endif
-- 
2.43.5


