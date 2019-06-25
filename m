Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318ED525C3
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 10:00:13 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xz964qb0zDqPK
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 18:00:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K7HDPZHq"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Xz8z5wgCzDqPv
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 18:00:03 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id w24so524179plp.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
 b=K7HDPZHqJMl/qgVzFFBX8LoUL/9QHN2I5dKIx9pHezuWhcTrqxsE1suEa0Es4x7Sc9
 1fa3oczrMsqU3cC8rPu87pyipKOskY+AAVRXcuhU8A3XiVsSUMtrCB5z2DFCZHE1eIFW
 elwGbBpJzlnLdJJzbrQp8s6hiGNDvCw5QmmH6x/nvZtgj/hctthwZTdS9Pzwh7VYY71S
 zgOoLr82w+r0DLwYbSlOUbvzw30piXd7hPDswkekIRX3FrUhmnSJxwzG+ZSJe6SHDTKm
 I5t2/WVEz4ZSV5veszUtyOksdGApSH2gkcaXtsH17lE3GESohKWvTsc9sMIJjW0DBCZi
 fCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
 b=pbNfauO0OnBRHepR4ZfYH/ySZqBu1waQCENE10/hPtniKo8zYCZNaJPb8F1c5wCSCk
 r9Ljg8hLyfXxIYvJ+1iGTekc/4/TlgKu4IIHHLhTyRtX/Xx9D9icqBpYQPmsFZRlQ0Fs
 heJTG3W2p67QagoT55g6KvZwXEMqxokU6KSsD742eJd7l0kmERSCPpOHVSiwccuEJ2tl
 nuvgekglNXAQes2FW5WSOyXlw/EdbSazlAqJSW/9puezMm4CfEyVHCOd0bnVZ+3+M5q2
 K13PU3tG48PaEqAo6WyNpa/fmSrRkENPnR+FF0rHNqZF0Q6ObFVC9a13wf64z6ekzOIn
 3nJw==
X-Gm-Message-State: APjAAAXmwiX4x+pGmDtGda4coUSDiK4XpzNUuCaUIvUuQDStYa67sJIi
 NwmVJRPWyaih7NyzM/Lqvcc=
X-Google-Smtp-Source: APXvYqx625PQO3wT/eSIJXdxOzKFGOxGxQijAQMVM3oID26XD2G5VK1Mqy6RrjNhPssD/ITx3FkiyA==
X-Received: by 2002:a17:902:9f93:: with SMTP id
 g19mr136995697plq.223.1561449600041; 
 Tue, 25 Jun 2019 01:00:00 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id l1sm13048669pgi.91.2019.06.25.00.59.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 00:59:59 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: return the error value if fill_inline_data()
 fails
Date: Tue, 25 Jun 2019 15:59:43 +0800
Message-Id: <20190625075943.2420-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
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

