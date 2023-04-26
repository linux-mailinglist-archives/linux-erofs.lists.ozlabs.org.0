Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B359D6EECE7
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 06:12:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5lnx5vrLz3cGH
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 14:12:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=mazw8iLR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=mazw8iLR;
	dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5lnq20Gbz3bT0
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 14:12:30 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63d4595d60fso40297816b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Apr 2023 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682482345; x=1685074345;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colsF3QIXsTiooOemlNXQSPda56nkWMKGesQwoq3aEs=;
        b=mazw8iLRHJGZBQdTJyeMGzuvsIwR4uLQ33MCJ/K5e343t+/FHOL+GrfZhglheX+uqg
         nbKyPWCtuqGV3Vx00K/tF/QYlYHmaGznzQ3ypUHqvk05C6aPqX8PDCofm1mu8j/tzVnl
         /Im8COJ9vjtanht5dTS7i8++Z0tHPkMx5hR5a00sFWHctVsl/khPGC3KeldHXIJo0r1s
         A8jaIKazTg5TYsMVRUUJvB6Gm26PFcBrjC0bGECphRSqNitASGu0y4FFGkAl3zURjDTt
         FqLcxk5aMko+CQcVb/aQNNUURHqU3DB6TrAo6/U0o14clg0mi7ybbo3KKHNk6fNgNzvK
         xpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482345; x=1685074345;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=colsF3QIXsTiooOemlNXQSPda56nkWMKGesQwoq3aEs=;
        b=amubBTDXtahvnlUKWHitrwU+Jsv/w6ehPJW3yYZwpek0YOAr+zeETedYJcKaDlbkUz
         vea1Jb8diUmoxnIBCjlLe5YEVjFktKKZlwRQjM6PK/unCII7suN63t7xAF+HtMZduq9G
         lw5Jhxg+Les79UcqIqN87zp8cMOb5WNAsAun8+uOo0tlarRkWQJhKfQLnw7sVZoyBxrT
         W++sEwTn1G2RtELYztP2Ac4tXqDEcMLrnbCev2KBZUVxHN+nGf8X9WqAW2iNvP755MOV
         kLJG2m5sWNIoa1+kSRRUoUe8bditIR5EJQPlEmgYl0p+WOXhSWUwhquvCJls9AnhdR1n
         t9hg==
X-Gm-Message-State: AC+VfDzNUzOAPIgSQy1NskNtFHPCVrmPGpOpYJexQd2+nMH5yE7ShvTK
	LisOkMrfSAhueP+HhPbqBzg=
X-Google-Smtp-Source: ACHHUZ4mxs1ocDrhW6pfoAjpak0Xu9bxJMWsH0LzDxJRxFceS67uB7SM33esHXAp4RsbqHJlcrX4IQ==
X-Received: by 2002:a17:903:445:b0:1a9:7bf4:17d8 with SMTP id iw5-20020a170903044500b001a97bf417d8mr1216085plb.18.1682482345344;
        Tue, 25 Apr 2023 21:12:25 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm8983193plz.132.2023.04.25.21.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 21:12:24 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: get rid of name from struct z_erofs_decompressor
Date: Wed, 26 Apr 2023 12:10:26 +0800
Message-Id: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

There are no users of the name and we can get this via ->alg if needed.
Also, move struct z_erofs_decompressor into decompressor.c which is the
only one to use it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     | 6 ------
 fs/erofs/decompressor.c | 9 +++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..d161683bda03 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -20,12 +20,6 @@ struct z_erofs_decompress_req {
 	bool inplace_io, partial_decoding, fillgaps;
 };
 
-struct z_erofs_decompressor {
-	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct page **pagepool);
-	char *name;
-};
-
 /* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
 #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..f416ebd6f0dc 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,23 +363,24 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
+struct z_erofs_decompressor {
+	int (*decompress)(struct z_erofs_decompress_req *rq,
+			  struct page **pagepool);
+};
+
 static struct z_erofs_decompressor decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
 		.decompress = z_erofs_transform_plain,
-		.name = "shifted"
 	},
 	[Z_EROFS_COMPRESSION_INTERLACED] = {
 		.decompress = z_erofs_transform_plain,
-		.name = "interlaced"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
 		.decompress = z_erofs_lz4_decompress,
-		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 	[Z_EROFS_COMPRESSION_LZMA] = {
 		.decompress = z_erofs_lzma_decompress,
-		.name = "lzma"
 	},
 #endif
 };
-- 
2.17.1

