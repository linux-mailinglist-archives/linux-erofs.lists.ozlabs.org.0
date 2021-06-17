Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2303AAED6
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 10:32:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5FfN4B2sz302m
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 18:32:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=c3rKWTXa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d;
 helo=mail-pf1-x42d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c3rKWTXa; dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5FfJ6201z2yxL
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 18:32:07 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id u18so4396526pfk.11
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=glZyjdypy92mNPNqQNw06jJZZ/iEMRko6EpLAEVWzuM=;
 b=c3rKWTXaS35HCZSUJbSsFKn7DQFvHU9f2IfdYbaU8E1NOH0cFY3379vOcfSS4MhuAF
 SN1ui31RGo7ZSkLDQCTdMc6+oY3et7pgCt//98/ITiLzZc4FIm9ROfRIddlNAzHigmSV
 sX7cXLZSYz5edt9agw8oqQg/wfhynyZefAlg0HuTg9rEOcAa3C/arH2EVTVFkxfrDt9/
 +dCr473i38SHVEXaBY6gC4PKh8EZOLc8/61TPJ6FMazGki5rbBVnyBlD5gaFtUiX4GkA
 ibx2lDwYbDlP8V28isoFafUVLh+GfEKZ3C40VUociMP0Ba46wFWrfIC6POahwSb1nsRR
 s9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=glZyjdypy92mNPNqQNw06jJZZ/iEMRko6EpLAEVWzuM=;
 b=QbdRW9uIMrJeactBJvAyQPBTEU99saSqr5/x+dgFyva0m6kuSUDQLpr26LuDsTFUDY
 GWyJ5lbFCLp/erp+rsWWRRU5Ng3hQZs38eP31aSlEDk+wR2XtLX8ywfGLUd0ZY6YG/lV
 s4w0UgZsh8nmdzMoEmKrn8Xv2fDkSZIw+o48JHRiC3KGzrFJxZPeq82gnBy2zl6ZwAxs
 HU1/crp1Y97Mef3kAH02Pjg8xoAFkJm5Cua4HqSuY9OuvsDBH6cPjrMPFGcYHI+X7Vqe
 7yaZOsJNQMjOddmsX4jvSh1nZpLLHixqNsLoUBB1wQZycgawi1/7UWMxTRqTbbWEQw6q
 O8LQ==
X-Gm-Message-State: AOAM533whMYwgY+qcCiLT9tqk68VwNgVTQbH1vRMugAmD0qH/vJVQP1V
 Jn+DvKejDJefuoci0oyC3+ICcXmWSNCuEQ==
X-Google-Smtp-Source: ABdhPJx5cFE93cUrcO3Wc2CB+vXXiEyTJfti9O0J3PY03owO5pNtmI9Da8Mlx2V5v82TWI93OIVPDA==
X-Received: by 2002:aa7:949c:0:b029:2fa:c881:dd0 with SMTP id
 z28-20020aa7949c0000b02902fac8810dd0mr4142956pfk.9.1623918724531; 
 Thu, 17 Jun 2021 01:32:04 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id v1sm4165641pjg.19.2021.06.17.01.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 01:32:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: do not check ->idata_size for compressed files
 in erofs_prepare_inode_buffer()
Date: Thu, 17 Jun 2021 16:29:54 +0800
Message-Id: <20210617082954.1001-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

erofs_write_compressed_file() will always set inode->idata_size = 0
if succeed, that means no tail-end data for compressed files. So, no
need to call erofs_prepare_tail_block() which is used to handle
tail-end data for that case. Just skip it.

Also, correct 'a inode' -> 'an inode'.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 lib/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index b6108db..b5f66de 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -111,7 +111,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	return d;
 }
 
-/* allocate main data for a inode */
+/* allocate main data for an inode */
 static int __allocate_inode_bh_data(struct erofs_inode *inode,
 				    unsigned long nblocks)
 {
@@ -572,11 +572,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		int ret;
 
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-noinline:
 		/* expend an extra block for tail-end data */
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
+noinline:
 		bh = erofs_balloc(INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-- 
1.9.1

