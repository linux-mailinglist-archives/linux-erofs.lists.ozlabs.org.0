Return-Path: <linux-erofs+bounces-1607-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8ECDE5DE
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 07:10:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcwFT0vl0z2xcB;
	Fri, 26 Dec 2025 17:10:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766729405;
	cv=none; b=IwnIEUSRGgWJgWAXnkb1NtP8wprzVhTIFHIeVFcbaQrwDYcD2u/5EG4pR3AZQMmzzcCMgZIiFKFfFGppoNKeuWQmL8fnqpzktTMefWHMAiOGZK43+zT3KQlrvgtqfwnbZd1IHRbz+DhQZPI1gLRqYnwwNt6ursPje5G+MedduQynOdlLux4KkvIph04FJ8Uy+SFVDFMSJBNNd7aDWGC4S3Poex2tLhfgRwfdXu9u5Ef3prc9lAcQnoZRbU2ZFznqSciarjgoIsksEgCvd96/3FTCqumgKp2wHjX8i8dLmSLaXPYlcUPZiJm4AeuSS6ZvLKX7EaruZ5XVcAHHYAdphg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766729405; c=relaxed/relaxed;
	bh=50UODVW6LHH7s725vA6IywII8pTnQqfvAH6qf1Im5Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjSgEqBh0J3k5EaBL6SmxwMjU7GGDjlqrtz0hRG/5LS5U2pZhhQGfTsXXgxfgQVLfyh7LMghXSZo6bcI6q5bYjzouybP1ANuz7wv8Hj5VeIAQ8ri/rDd+TlGVmOhCzYEd6o8DorELMVhe5wgv6NPXV2e8bUzlOBHvwYhiz/ZIaAKIflJVeZVPVT0BZtlKtRItNVXNx9dtTXxBePCL3BUwmwY3HYRBC1GPa2bUV+ElWIBfLb5+V7HHrE+M9kFHoMo9YP8NnuO4jPqQjIYZPxckb10CnhQM1ZGL5Qm2CyUM9dtguWvBSYEANXiws7mHGflFAgf3iHqYp3HwDbxiOPS2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LiCYeHro; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LiCYeHro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcwFQ1JqYz2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 17:09:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766729394; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=50UODVW6LHH7s725vA6IywII8pTnQqfvAH6qf1Im5Og=;
	b=LiCYeHroiUvag0PH/B/3CLITIHfB6UKiKaJU9Dj3/2aAACEHJiKKXn63sRj7043vzZAJM6bpf57eOvBhYbtF5mr1lUPJ5anpf3DO41kdb4uxxrElEoSPKbKy8deblT8PmZKB34a3OQk2uugIMN9OOlsQz5ftNinWQTLyetek27M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvgZnn1_1766729386 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 14:09:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: avoid noisy messages for transient -ENOMEM
Date: Fri, 26 Dec 2025 14:09:45 +0800
Message-ID: <20251226060945.786901-1-hsiangkao@linux.alibaba.com>
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

EROFS may allocate temporary pages using GFP_NOWAIT | GFP_NORETRY
when pcl->besteffort is off (e.g., for readahead requests).

If the allocation fails, the original request will fall back to
synchronous read, so the failure is transient.

Such fallback can frequently happen in low memory scenarios, but since
these failures are expected and temporary, avoid printing error
messages like below:

[ 7425.184264] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 148447232 size 28672 => 26788
[ 7426.244267] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 149422080 size 28672 => 15903
[ 7426.245508] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 138440704 size 28672 => 39294
...
[ 7504.258373] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 93581312 size 20480 => 47366

Fixes: 831faabed812 ("erofs: improve decompression error reporting")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..bc2e0d3b97dd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1324,9 +1324,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 		if (IS_ERR(reason)) {
-			erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
-				  alg->name, PTR_ERR(reason), pcl->pos,
-				  pcl->pclustersize, pcl->length);
+			if (pcl->besteffort || reason != ERR_PTR(-ENOMEM))
+				erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
+					  alg->name, PTR_ERR(reason), pcl->pos,
+					  pcl->pclustersize, pcl->length);
 			err = PTR_ERR(reason);
 		} else if (unlikely(reason)) {
 			erofs_err(be->sb, "failed to decompress (%s) %s @ pa %llu size %u => %u",
-- 
2.43.5


