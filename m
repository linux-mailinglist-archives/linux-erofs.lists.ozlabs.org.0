Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDB5AA80E
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 08:32:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJp4D0NHMz2ysx
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 16:32:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QqoFhQ+U;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QqoFhQ+U;
	dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJp465HHFz2xJ7
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 16:32:21 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id s206so1157901pgs.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kLnHKzUhQUtEqhe241FKh09xdL2v/zozWI6ZKV+2obU=;
        b=QqoFhQ+UqZRtcqRxsbr1JyRO39dkDQ5TR+O4BcwYGTZIufanaahHtNQyNF6SPx9kdc
         hOUA2Pmmpf5m14QuDz3ZYcreqEeocku4sbuWdIVMWyZ9bbWFNBja10d+YLlr2ApnghVq
         E+KE2EAKlldsSPpA0WNSSR+wYuZZhLVdvkzCO4xjjmXmI0s4eXqtpnA79k38BGPyHvru
         fOZ/9Of3HGoRrw4FaMLS0Z/2nQ/3UWKZgG+7ymoMf0l1XM83bUJ8kozbSei8mZziLUun
         hpKVvO26bgiAAGGmHn5pjqn5N3fd45U8y0A0Buqrc/efd4ibaxovwtLdYiyDC69Trt62
         r5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kLnHKzUhQUtEqhe241FKh09xdL2v/zozWI6ZKV+2obU=;
        b=o1gu5n6OcHjIVCLrQzfHss5PzUIwb2CrTYdPTrwlEfv+P2aM+U3sCAMTMA/EFsJY/n
         qpTTVtyTRYYeQxqrIqjfOcRydD3iLy/tQtR+FdXpR+Dbwoz+8F/y7pISwXPCkmcThdcd
         yizF07SOaIfjOeDV+NuFZkAD5EbavebYTnUud2IK0cFJ6czwcwwBcudJS7j+3Mcud0Kq
         1OorOXEdtk7oovgmZMlY8Jr83rgL7UoAKVoh5dkHUtDSHEzJCFUkXhdzguTn/eBS2fOh
         LnEMH8qJrEH24gWNCk4mS3kPxg6v7hzlY6QImZrDsn5dpOurd6G6msg4mwebxjU9RscR
         OONQ==
X-Gm-Message-State: ACgBeo3bkWTPYkdAUuSsFFOG0WSnAJgrLS1QkMKwdIgrBCiX2sKqHfad
	5HTCRYojKcjITB0mUaFkyzvtr357RJI=
X-Google-Smtp-Source: AA6agR75raVgus7hK607KKw892NdHOvA5Fn41T8aDP2nbQPifHOsmsJrZNstB8b8rZgF6US1bqFmJw==
X-Received: by 2002:a63:d607:0:b0:427:bc0c:55c8 with SMTP id q7-20020a63d607000000b00427bc0c55c8mr29376102pgg.402.1662100338852;
        Thu, 01 Sep 2022 23:32:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c82-20020a621c55000000b005381f50d1e8sm769851pfc.115.2022.09.01.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:32:18 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: support uncompressed pcluster with more than 1 block
Date: Fri,  2 Sep 2022 14:31:34 +0800
Message-Id: <20220902063134.7639-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The length of uncompressed pcluster may exceed one block in some new
scenarios such as non 4K-sized lcluster (which will be supported later).
So, let's support the decompression for this firstly.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 56 +++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..fe6abb79e560 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,41 +320,55 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct page **pagepool)
 {
+	const unsigned int nrpages_in = rq->inputsize >> PAGE_SHIFT;
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
 					     PAGE_SIZE - rq->pageofs_out);
-	const unsigned int lefthalf = rq->outputsize - righthalf;
+	const unsigned int lefthalf = min_t(unsigned int,
+					    rq->outputsize - righthalf,
+					    PAGE_SIZE - righthalf);
 	unsigned char *src, *dst;
+	unsigned int i;
 
-	if (nrpages_out > 2) {
+	if (nrpages_in == 1 && nrpages_out > 2) {
 		DBG_BUGON(1);
 		return -EIO;
 	}
 
-	if (rq->out[0] == *rq->in) {
-		DBG_BUGON(nrpages_out != 1);
-		return 0;
-	}
+	i = 0;
+	do {
+		src = kmap_atomic(rq->in[i]) + rq->pageofs_in;
+
+		if (rq->out[i]) {
+			if (rq->out[i] == rq->in[i]) {
+				DBG_BUGON(nrpages_in == 1 && nrpages_out != 1);
+			} else {
+				dst = kmap_atomic(rq->out[i]);
+				memcpy(dst + rq->pageofs_out, src, righthalf);
+				kunmap_atomic(dst);
+			}
+		}
 
-	src = kmap_atomic(*rq->in) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
-		kunmap_atomic(dst);
-	}
+		if (i + 1 == nrpages_out) {
+			kunmap_atomic(src);
+			break;
+		}
 
-	if (nrpages_out == 2) {
-		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
+		if (rq->out[i + 1]) {
+			if (rq->out[i + 1] == rq->in[i]) {
+				memmove(src, src + righthalf, lefthalf);
+			} else {
+				dst = kmap_atomic(rq->out[i + 1]);
+				memcpy(dst, src + righthalf, lefthalf);
+				kunmap_atomic(dst);
+			}
 		} else {
-			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
-			kunmap_atomic(dst);
+			DBG_BUGON(nrpages_in == 1 && nrpages_out == 2);
 		}
-	}
-	kunmap_atomic(src);
+		kunmap_atomic(src);
+	} while (++i < nrpages_in);
+
 	return 0;
 }
 
-- 
2.17.1

