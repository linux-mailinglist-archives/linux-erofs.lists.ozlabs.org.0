Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94640854D
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 09:25:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7J0L1NQrz2yKJ
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 17:25:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=I0LVTvJN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=I0LVTvJN; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7J0F3zDpz2xfw
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 17:24:59 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id g14so7965238pfm.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rne45CFHVF3Ed+57mqPI4S8t0BZnsiIJa5Mce5cnMFs=;
 b=I0LVTvJN3u3LWC1FrrPIH1QhzeKn39Yh9Z96gRmixJ15fAXrUJMXNtI+W/YWdVtxeY
 9VDd2Kfd3QsQcwl1OAkNh+YARxq3iINnSVB3LK/DRiEnmMWgMPTGQMe1GM7wm2XPRqsE
 scpbov5JJEzBge1BaTGNUEkbhGxAo99oa5h0z8/drxKk7Le+uE09iL9JhzABQre+oMdF
 w/L4axgqjsQ7bqsgTuQQQpWDcjrwVkWQwSedgzDnJsuy97Dydbui5aM6zQuY/jG5TsSu
 0nnf2JmMW5NbXCzr603ZVH7j4uOg2N/XRIQyS1DUIBl8ze8V58s8EcBJLF3+g/Rwi41Z
 vstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rne45CFHVF3Ed+57mqPI4S8t0BZnsiIJa5Mce5cnMFs=;
 b=wwwUjNnRC+BbRBYRzcYqAfvAeQ+6h0IItH1M0Tx7YCo7n5iBm5vgmFe9qYMaxv9vP6
 MCF03USO9e89o06VGBTogMWoj90dZvdKgYrogJ7Xycnt23/J7lNngunH0Po/pdDcDRNT
 vfI4SwCvFFNzD2+dJEX2wFERqyvg1bnzD1SQsB8xOuJixjmSpILd6kEU7ipuSNCmehz8
 9XZcqL5WY0jnTxF5OkI/k+y3Pf0K3Z0bSuMSflEqKPvvA/O/TlOqIaEAmzBpCopylK3O
 W5sQw77BgLFs8mJtqOx6ReKzlHnu6NYz7MgGfQqAqKatycnYI7IJAmIHceqFE7D0ZtmI
 P5aA==
X-Gm-Message-State: AOAM530FXQ/rv3WMEYgkeuCFbmLWhkNCNMuvST/vi39CKZu15VNchaQ+
 SIN7AqitqYhqr1phG/c/FYs=
X-Google-Smtp-Source: ABdhPJz3kPSM1iVUOv123Y56zIId76DGu9yYy2/Q5GwwNmIPqpUoV376MCwV7pvmNJQoe5h9wCF0tw==
X-Received: by 2002:a62:e302:0:b0:3f2:628b:3103 with SMTP id
 g2-20020a62e302000000b003f2628b3103mr9843177pfh.39.1631517896240; 
 Mon, 13 Sep 2021 00:24:56 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id u12sm5687365pjx.31.2021.09.13.00.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 00:24:55 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix compacted_{4b_initial,
 2b} when compacted_4b_initial > totalidx
Date: Mon, 13 Sep 2021 15:24:05 +0800
Message-Id: <20210913072405.1128-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhangwen@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
compacted_4b_initial > totalidx, kernel should be aligned with it
accordingly.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9fb98d8..4f941b6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if (compacted_4b_initial > totalidx) {
+		compacted_4b_initial = 0;
+		compacted_2b = 0;
+	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
-- 
1.9.1

