Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2156559B1
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Dec 2022 10:39:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NfJt44xzWz3bdn
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Dec 2022 20:39:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qsBal0eq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qsBal0eq;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NfJsw5b27z2ynD
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Dec 2022 20:39:31 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id gt4so6925975pjb.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 24 Dec 2022 01:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdoA2pELSiKAaJVeHVwg0Uzmu0qpsY9PIP5dxhNe9Bo=;
        b=qsBal0eq32coAd2womwjekJgCmlbj2Wl3bVKFQb0mjtsuwq7V6D03B95fA107sBn+5
         joiTLBUHkRRDwbJib1XwKDltHV5vI7QBIoPp16E7Ni2SotppF2EC+oXIorNgrzH6hKKb
         0nzKRoa1dC7ho5NPyjfi3+SPguET71s/fs3ifzWCX+2piwViJuCsqwSlECBP0nSGlSuL
         KCE8GRpZRsuIpQa/nAhjO8an7zHdigwjwOo4ZzP/wu67gjrMgpZjvzH+OeGxQYohvEAt
         G1Px9qNMMYJo4g8vltdtEhbvQ032eY12gCiwuegoyJC0akaXqIeQ8ENS0VMI0cY6OdcT
         hhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdoA2pELSiKAaJVeHVwg0Uzmu0qpsY9PIP5dxhNe9Bo=;
        b=gTqH2iiRWi7hkJfLe0bTA99Wi1mvXYWywELOQKBR4iHTQPcc9fNFGx6wpzZA8UpfAl
         Qu1FPRNP69d5CPfY5LPAKWCBU625HlpXPPy7cdHsmDUk700WVyEP4BFuBqtiWC2jPp6c
         +7OB5krVBApuqZFQNFbv21c18OuVLxzZ/F4f1bg9W6PMq+4giDSPBMK6HO1awxNYF1oB
         +/cA8AkBwVKVS0p01WKHTTD7aklv/fp3TV3nFcBM4apwTwFwt8/vNCeOzor2Uu9yJ/1i
         pG8G2sR8/ySn9NsjpO5Qz4x60osiczTbI8ENPmMQVo5gXt0TmeeCskCgMd/0gRBwKIZ9
         b5ag==
X-Gm-Message-State: AFqh2kpW7J5v70rE/W9Wmk3tba7TtpoOXLidvr85jj1glyjc8dj+oJoN
	rU2QPHITuMKWYvLDoXHukNOyKQ45yaLLyw==
X-Google-Smtp-Source: AMrXdXtMBe3l8Bi/w5qk0Om8BHRTUnaCUOoZ5wf7YL2ldfvZsXyTEBGyiR7I3ebPKLhFyG8h+y8SkQ==
X-Received: by 2002:a17:902:f30a:b0:192:5d9b:5881 with SMTP id c10-20020a170902f30a00b001925d9b5881mr4657257ple.31.1671874767412;
        Sat, 24 Dec 2022 01:39:27 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902694500b00186cf82717fsm2671084plt.165.2022.12.24.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 01:39:27 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: change to use erofs_pread to read fragment
Date: Sat, 24 Dec 2022 17:38:51 +0800
Message-Id: <20221224093851.10095-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Packed inode may be uncompressed as well due to no space.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index 76a6677..fce3da2 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -287,9 +287,9 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				return ret;
 			}
 
-			ret = z_erofs_read_data(&packed_inode,
-					buffer + end - offset, length - skip,
-					inode->fragmentoff + skip);
+			ret = erofs_pread(&packed_inode, buffer + end - offset,
+					  length - skip,
+					  inode->fragmentoff + skip);
 			if (ret < 0)
 				break;
 			continue;
-- 
2.17.1

