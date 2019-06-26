Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FE55F82
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 05:31:04 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YT8560B7zDqYd
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 13:31:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvDQGUVt"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YT816GBvzDqKq
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 13:30:57 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id d126so535028pfd.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
 b=BvDQGUVtDtNQ7wVRM4ZcJUkLAAGKMIKZ0UDtl2Oh+1gZu1ofLLAx+tszz7+XgiyBi0
 0TYiU7s8/ypL/n+Ujtg8347fmHKFXF4CMa5LUdBN3DZq8XBOs34RJWe0H7p7nrB5/qaK
 9Xnq1WiqUHrRCZe8TNKBvYAGok5miHwxEoFvT4KZxkYRzbgSHTef7an/9WqazjeExLz3
 9uYc7E4INcSqiwzXCEfysccdK3IT+RGtD1wC/P2Qf65k4YRZzOEeSDToSpQ8lE0YJPED
 gw5sjcUAyMq0BXzlgiDtbRNkk0wFV+Y5NaWZlKfjIHSBiGWhgDEP3BQiL+BjI8VXa1pI
 TatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
 b=TTd8AvFlGmJf2OOhqz3pj97gwZhIrADUjU3aSmCE3TQPEZD9bIlQQTDcT2hApJnGzT
 mOIXgNv5f39kjAy7MSydSXi1+ElZYC6s+jhzg1DvNqGP0/eqQQxXIQRLjPefTjP5AG3e
 UeKI/MuzAjO5ffgti9oHP+kVuyKZqwVlJPSvFGjwbD648+baBu9VrUlmG8bBQ7QpDMDL
 Y46yJUP1WO/zI8c/bwkgBlxdvS8nAXES4lnT9EkMvc1jehcFuOQzQhfDTXe+RdM6U8Ve
 ME5WfT1hTP3C7uJQt2dvHMp5Ajth1by3EVB1W4QnCTibrzlrtHbuVgewLrMvPVFtfr/c
 /WJg==
X-Gm-Message-State: APjAAAVRs6Bgjq3eggKx+iyQzMdIO2B0xrmaiQ2PkHd16NOgw3kyNqy8
 RZlhD1IYE/NJs0dbxglpiWI=
X-Google-Smtp-Source: APXvYqzgXOaBd0m6wSY+5AEmeAN7rUcjZ0f2dRq9xOhDTJHdBtUUM+yHvKK/xbj+X4pwJYOReCeAKQ==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr536783pgl.49.1561519853560;
 Tue, 25 Jun 2019 20:30:53 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id t2sm16053325pgo.61.2019.06.25.20.30.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 20:30:52 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND] staging: erofs: return the error value if
 fill_inline_data() fails
Date: Wed, 26 Jun 2019 11:30:38 +0800
Message-Id: <20190626033038.9456-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

We should consider the error returned by fill_inline_data() when filling
last page in fill_inode(). If not getting inode will be successful even
though last page is bad. That is illogical. Also change -EAGAIN to 0 in
fill_inline_data() to stand for successful filling.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index d6e1e16..1433f25 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 		inode->i_link = lnk;
 		set_inode_fast_symlink(inode);
 	}
-	return -EAGAIN;
+	return 0;
 }
 
 static int fill_inode(struct inode *inode, int isdir)
@@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 		/* fill last page if inline data is available */
-		fill_inline_data(inode, data, ofs);
+		err = fill_inline_data(inode, data, ofs);
 	}
 
 out_unlock:
-- 
1.9.1

