Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B920A3FC5A9
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 12:33:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzNnP66BRz2yJw
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 20:33:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=pXOGWJD/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f;
 helo=mail-pf1-x42f.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pXOGWJD/; dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzNnK1Fb7z2xv0
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 20:33:08 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id 2so14572958pfo.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KY7cMjg+mzN0KnlEN3YeG65WmdAqZbIaUV7izU0+6iA=;
 b=pXOGWJD/kF4bFfzqbJTMhhqOLUZCXwq5his6RVcYXxe6Ug2dEZbmgeW1EP48CEntsg
 6vt6JEW9W9bR9pa6ZviNOt4p9sVybqUjN9uljkT/0ornDslUS1pJJsi7zEJ2hg7TuHn1
 u6IbKftygKlL22GzKKzQoY/UGL40FKl4AYdzakYJ5slhuDl65LH6Vuo8KxfmhujlBPmM
 LQvoRZcuIS6VaH2VQq/OVGC6UkE9ZOiXDlf5UmVghXWWFN1uz75PAe388s7pU3As7o3y
 Xf7pxcRWOWbK2uID2M1KFA4Vv4xE/QTQAlEVan9hUBInAine95l6xjDqKL8xtYdLsGeJ
 kxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KY7cMjg+mzN0KnlEN3YeG65WmdAqZbIaUV7izU0+6iA=;
 b=i/9qQRhLs02GJN7/xsFV7465+3YlISr1IjCD2alHNx3vDWegsZG3emzvcEeuIr5jen
 nG4PnWhMQChASRX/8epnR6Fs94PgGqCHnrYciJ39zPS+3TjN5RksSnVT0DzCc7texdGQ
 +CCkbAvnn37U5HxPvw2bGcTi3NqsZt9Zg/FIXNudUTrP1/P/lMPBX3s98Xr/npMdhy6h
 Zl8WJ/GyOh1C4WovdKAXXBkP0rVeqoUbSsFo/Dae33xJGU/wAzH24NzVc/2kT/22mT/o
 w6cQziP/AQHLvOaNHj9/Mf8ppH/7MtKrcLH4t7s5lLiYziFm0hrr+7Kas3Up7KLW7b3E
 silA==
X-Gm-Message-State: AOAM531qoul2Fj87YcofK3xbSmQJb6AnSZuxDhQIF3Y/EQEKiNh59oOS
 YxFxrZ7mQaey/Ffrb7w13hM=
X-Google-Smtp-Source: ABdhPJxj5IwugF/48Cxv7in/gjqkyeaxFTK3PbcrGKLmNvMJkH2iPhE3TvqKrf22P/bQLjYCRwaKig==
X-Received: by 2002:a05:6a00:1349:b0:3fd:9054:e243 with SMTP id
 k9-20020a056a00134900b003fd9054e243mr12357785pfu.38.1630405984922; 
 Tue, 31 Aug 2021 03:33:04 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id m11sm2417535pjl.14.2021.08.31.03.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 03:33:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove the pagepool parameter from
 z_erofs_shifted_transform()
Date: Tue, 31 Aug 2021 18:32:04 +0800
Message-Id: <20210831103204.881-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

We don't use the pagepool for plain format, remove it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..8f50a36 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -360,8 +360,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
-				     struct list_head *pagepool)
+static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -403,6 +402,6 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return z_erofs_shifted_transform(rq, pagepool);
+		return z_erofs_shifted_transform(rq);
 	return z_erofs_decompress_generic(rq, pagepool);
 }
-- 
1.9.1

