Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349DD56703
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 12:40:15 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YfgJ2pYGzDqXW
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 20:40:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jE10eCHU"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Yfg65LcSzDqTT
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 20:40:01 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id cl9so1212118plb.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MQ9/uWGOCU6xhcJrjFrAp9D/DzotiwWryJhU2sg3dXk=;
 b=jE10eCHUEAtvgZ94+vzcssYMO6mjwEBNyQyS+979T7V9H88qMRlbM80AALrr4PL7wH
 rN819o1exHNmFlXu6lKk5huqMmX25BQjPANXDQP3CqO115DTSItqtIIM+GlhUvJeJM4r
 Gh6hFKstZvm6Uq50/GjK9JmC/elmcYbePclzDX+j5AvGfUDAjt/8yL2eXwAx9St6tqQr
 gfqWMtfSZEyYrgrjqG/Mru4BLY/83hPufoyrajO724AHU9zgMjmLkdqHYvumvHTCWNKd
 vZZJwRPGkChzW6iHZvaqkeEqI88Ge6P5ak0ReP7ZL+iyU4Rt3SUsoqLxhC8HsenwNKu3
 m3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MQ9/uWGOCU6xhcJrjFrAp9D/DzotiwWryJhU2sg3dXk=;
 b=kj2JFCxrK6CnN0euRBRuDMIzoqa4mvMgYusNRUtZLFhchwSZYXIIhg64HAHanOaYxB
 aHBkqAmz6Stth59RQGHIitKHhR9dMyW4gK/q+exmkUfxKpSa3YVsrBdV9/QlTwFfpT1h
 Cy1EpR/yhAfhYfulM1iBTc9HCFStpA8fSle5snXPOynlZsMMMgCr0GP/NnEoKJsrdCTk
 IuXACctEOu0zbiyaeQaTKnp+9Dp+lG0ipDytFAhUYx2WLtJ2wbOL3NbD8ZyC8gMoM/+Z
 1vPAy79/Z0yCKCcg7HjeO3eGPMNpG2UbduhEJEASCHthZ7ixMw8Jf+4rEEFZJpiECPVh
 D3Yw==
X-Gm-Message-State: APjAAAUxdbfR/YqeWARJNI/UhbwRsF5e/QpkoAcF991KbIF6MgpLqk/C
 03+jPfgll3tGoLj+F7iaOzw=
X-Google-Smtp-Source: APXvYqwu8/FNRhg68Nb2ZF2ohaD+QcYRJVvaXt1TRS6mrgnz8RwmTp+ic/QQpLHJzCrhlbheGAJdFA==
X-Received: by 2002:a17:902:246:: with SMTP id
 64mr4519837plc.311.1561545598410; 
 Wed, 26 Jun 2019 03:39:58 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id x7sm18584969pfa.125.2019.06.26.03.39.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:39:57 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
Date: Wed, 26 Jun 2019 18:39:36 +0800
Message-Id: <20190626103936.9064-1-zbestahu@gmail.com>
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

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1

