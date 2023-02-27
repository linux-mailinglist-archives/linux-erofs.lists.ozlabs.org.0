Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE556A3EAC
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 10:53:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQG6L0xChz3bvs
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 20:53:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Tfvx0npU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Tfvx0npU;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQG6C0p71z3083
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 20:53:38 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so9562074pjh.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 01:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+zZX6p/ZFL5s0pNIMTU+Syq1lPmBDiVjj0eWV4QM5A=;
        b=Tfvx0npUsXlB/nCGpWJhgD1N19rZSKgnN1yCemyZNYmuweeqVWIJiBnZcBowAnG/x0
         6MabHDKRcEIgvWUo7qoK2WtrLGCqxfKaul5SIBStjj7EOGvbpUYyQtfTVRdWToDuBabs
         QTOQnqxrMGTUAiDMyJL44zUSfdJiJf0+aQdwV/q9+rNv/TKrWplSH/D14wN+j5AMznpm
         HD+3N3n5rGYyUHDykYi4bMgPwjAPnsVFUJMhBS5TM32r/UcZmFMLNo3PzkNyCQeOJO4L
         l7mM1NFdmJjkrnavqsbq678/YQrgVVkQfy2MwaQq+Z2aQg4IlbDb0BZmNj9/bYyqDVJV
         45vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+zZX6p/ZFL5s0pNIMTU+Syq1lPmBDiVjj0eWV4QM5A=;
        b=SWHxbq4lWmEIKPBUYwzcStziAFwJzoypTPb90ml9W4AM8aoW4Gwx6L8OECMsAKrO9K
         gfp8ipt9jSjwtuXIz56E7uC88uy+k1QK7jkdG4snbzbGD75No3cGxe4eFEgohhdD6X/K
         M9lIxl71VUAY/XqrP/onU/IfGr8TOgqukmfRdEb4RiBAoPW+qNn03IjksuYWxRfqq4B9
         30L2RT6oFFernHh8eWuMJofisxCr+fhFsY1QYjOsqlDMZdGl1qgMmMjrqbsnIWOQSYmx
         d5nzZk8IcZCzstqB2JEo/KSsdBE8ABlmyo93BACgGIWc5C/6CVkYEnBuQkDo7YHl/I65
         B7lw==
X-Gm-Message-State: AO0yUKWVc6rT4HmTT4s/ghUrrz0VFOQ388k6ym8xS7H5fQVz3zKrabBR
	7U5Wu96BTyFFUco+f43HnGmLatnQUII=
X-Google-Smtp-Source: AK7set8CRJXncLj4xPZt0MUD1odWHIYan0L9jPaPlCOLGPDwKcx8fL+TxEYGoyzs8qEtHuMlHtHIQg==
X-Received: by 2002:a17:902:fb8b:b0:19c:a3be:d9f7 with SMTP id lg11-20020a170902fb8b00b0019ca3bed9f7mr15991884plb.11.1677491615804;
        Mon, 27 Feb 2023 01:53:35 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b0019cc28bfc0fsm4183253plb.34.2023.02.27.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:53:35 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: don't warn ztailpacking feature anymore
Date: Mon, 27 Feb 2023 17:53:11 +0800
Message-Id: <20230227095311.13033-1-zbestahu@gmail.com>
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

The ztailpacking feature has been merged for a year, it has been mostly
stable now. Let's drop such warning now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 mkfs/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index d055902..dc5c4b5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -724,8 +724,6 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (cfg.c_ztailpacking)
-		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	if (cfg.c_fragments) {
 		if (!cfg.c_pclusterblks_packed)
 			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
-- 
2.17.1

