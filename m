Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56643597B89
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 04:35:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7TWz3fK6z3c1Q
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 12:35:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HVLAYGNi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HVLAYGNi;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7TWr3KJnz3035
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 12:35:34 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id jm11so368603plb.13
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 19:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=itGC5H5B+cLaUwPihp7VmzghbjptZCVG9Pjg8B0Ua/4=;
        b=HVLAYGNicHQVo7etS7uuyK4m/a2YZgeGk2vGzGmVQnWXd0pEKVXTdxz/hmaFTrm/dc
         4S0f4qVeUP33t+ZpBePtRFSs3g1IxSRXkJQ7cRnfcZAIfQpcZU2Z+6PE4LhZika3WxRP
         DJNAGaMliae7UxA+1q/0DeEs8jqkjQVLXOXmTh6qATbIiDByRasn7FWyz6Ocvq6WFoot
         Yo6bpRMmO7TVQG8bGSVPKYb0LFWezIe7bD/ddM13KjS9Du5oBtlpncScPZHxd5fMMnpb
         ZJFAScAfpAJTMx4LEXbQsZZGEeWHnog6Xnnmb6+fotruFlsIqR1g+UPaTFFwGgJp/rx4
         DpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=itGC5H5B+cLaUwPihp7VmzghbjptZCVG9Pjg8B0Ua/4=;
        b=8OCv99vpj7w1aNzDDN990XIi/l7mJT//yOwTZ9CWiuDI/ybfSiKcDIS+cC5+pPtg7j
         BCRgizJbcUPh3qJUdrolcpuFANXvhyXoCM2fQpDq4MO1zTBAxCHwj7aH7aZXi02FxSGt
         pbsh+pBSNV68jbuH/uapTz92WlM27UlvHitpiuVSxCh0q8OH1K9Ee7JDMzVjrTcjYMfp
         LGTieZ5I3fuXbqExLxVzOiiaycHKC+bB52n+OdTQrUqXPHN1fhHtW+cef4AGT4ndalbk
         wmaG8Sqa5nxYf0WSUXneCN0wvo7pz3ZXls6ceXGS6UNqsg9rDFY6TP1VnJ8XB7V5gnm4
         l6lQ==
X-Gm-Message-State: ACgBeo2uIqefzuMqoR3e5fTV2xpmiTjr7t0Rp3+U/HJQB3jHnr/9+V/n
	GSP1Qi83fJ4gnQ/LrhOHIkkkaDzevjo=
X-Google-Smtp-Source: AA6agR659RtBgP5Y8Kih4GkHrWNwbOcc7VuCWqnjHKUf3KUghAZ27K8yTBd1aDYxcuC+lt53rHtpVw==
X-Received: by 2002:a17:902:7689:b0:170:8b17:37f4 with SMTP id m9-20020a170902768900b001708b1737f4mr837412pll.42.1660790130907;
        Wed, 17 Aug 2022 19:35:30 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b0016f0d6213a5sm151588plh.2.2022.08.17.19.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 19:35:30 -0700 (PDT)
From: zbestahu@gmail.com
X-Google-Original-From: huyue2@coolpad.com
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: clear 'h_idata_size' when drop inline pcluster
Date: Thu, 18 Aug 2022 10:35:09 +0800
Message-Id: <20220818023509.8698-1-huyue2@coolpad.com>
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

The value of 'h_idata_size' should be zero if no inline pcluster.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/compress.c b/lib/compress.c
index ee3b856..2453d0a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -565,6 +565,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 
 	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
 				  ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
+	h->h_idata_size = 0;
 	if (!inode->eof_tailraw)
 		return;
 	DBG_BUGON(inode->compressed_idata != true);
-- 
2.17.1

