Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA257F92
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2019 11:46:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZFRJ3jgqzDqdl
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2019 19:46:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s7enxB+I"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZFRC6BQSzDqdG
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2019 19:46:46 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id m30so947474pff.8
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2019 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=uMmVaqGs6Qzw1v02Xne45iZzGkIbUBWZpJMKSMkhWCo=;
 b=s7enxB+IExQARnhO0Qax0ABS2Hi6if5hn8MT8/E9KB4L+I8bWQEYmgRCgrbAoBA5PZ
 8/ENKEDKnCFRMDJPKphqSHG+Wfb1srI7LDWUfcv6SyGcIXuW8r2byhT6R6LW9/QW1XbK
 S0VmYxJGA0bCxTFxrItDMEye/uFBR95uyHbq+8RdjXlNQXxAchyFRzfFp/oE7VylKZ8c
 tFAk/jv0V6dgRI+BVy7G2ud84jqP71+C82mrfD2usIBsg18ed01xUNkA6hPsjB4vdynO
 kDiQAFpPoFdGLnJnIbB+Ggy8V7qb0Zemn76gL1DZ8OyLIGB4rJoFFGGqAQkga9fz1wuB
 WQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=uMmVaqGs6Qzw1v02Xne45iZzGkIbUBWZpJMKSMkhWCo=;
 b=DFyVk8n6GzkSYbO1YdAJ8h/OC9o5k0x5EkOhhCtcREFH6H48vvDGxCDt5ZelN25kAR
 pv24DQL5AEyxUmOpMPFhZMxFTkleXeLRNF7Q/1A+SI6lfGunZrh81Wu7crtjtXCZTabm
 EG26ua/9QcFNG34PRttjBRt2fu7TS+U6qGNo29mk2Xw1pgPN/8RdlP59cQpMQGdFEQId
 ujvyu2oRqxolMMW4TEx/ma1QXvW0hDeVm0dK8NTiufTceY+2mS+DnRwxH7ahL0BL+N3R
 BLP0LMj6p3vph4tpsRUSVFDxD86//RVVmOyZ3aHLibprbuuxckIg+ivK556Fkc4x/DWh
 ZSNQ==
X-Gm-Message-State: APjAAAUpNZ4ljYZt8cjW8E931EGYu1TJvaDHSIrK0OUzZFk+GIKjHPly
 mlDep1FfwySgp1T5WQatAvg=
X-Google-Smtp-Source: APXvYqzV988AIws0jlsYMBuVHSS5AnNS0myfaZDDR3n7w9cPoWvRFgrEcd3t71Hz1fqgEMUY3UzZ0w==
X-Received: by 2002:a63:f746:: with SMTP id f6mr2945161pgk.56.1561628803496;
 Thu, 27 Jun 2019 02:46:43 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id 64sm4653324pfe.128.2019.06.27.02.46.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 02:46:42 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND v2] staging: erofs: return the error value if
 fill_inline_data() fails
Date: Thu, 27 Jun 2019 17:46:15 +0800
Message-Id: <20190627094615.2224-1-zbestahu@gmail.com>
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
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
no change

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

