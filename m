Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627B6AD19
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 18:48:06 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p5tW6Gq3zDqcl
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 02:48:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="utexAQn4"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p5tN71nZzDqbx
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 02:47:53 +1000 (AEST)
Received: by mail-qt1-x842.google.com with SMTP id z4so20296552qtc.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=q0NqtvmYr3QBS5nmSx2KYKqSfKQXLB/8EIDh7naBj98=;
 b=utexAQn4HQZwG3SUUpmbEFlYkvK1IOuANj/Zc7xChzgYe/BKh3eDOIax43Dn2cfhwk
 +aIYCGi5CKtsXpQIaxu1hYXnqhoIVwGBucDM4EfbQXqz2zewYhO71vtq9S3E5ADOKfkQ
 VyWGmJEfhr0rTpU18WOJJHAFk8MOlAfSqii/cS6oIN9a2CDwFzJeZDG4h8f3idFaKn5q
 RtClP4wErXHp2hzZzuTdhbCiLs8mAKjYV71Z4p1JBZ8dNrQzEMgc6iJ26rgvC5lVTwpz
 yp5exTISYOIgMXbxO/8N8mqC6er9l07ftY8q6MhdThupwr9SMwKB5dVFGRx4BESBtJ4R
 wDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=q0NqtvmYr3QBS5nmSx2KYKqSfKQXLB/8EIDh7naBj98=;
 b=PgeKGuS+KL8fho1LyXtnCZRFHRpjMP3R4zqimCygRSl5CQHPQT+b+TCxj1bddJXtPt
 mGZ446H/I84iaDwNe+DhAmwvo2ezcavvA6Jfv8F/KkqV99PLA1SmJOK2hANRQuPzAFZG
 E8y7r/pKubbixHqsKPC1MwHyFIoef+zesGUPZascWC7s9od50mnTxwyznPNrtuf74v1E
 5Ueq/PzHDmaleVtZ6qd74AotPiqXCIRYaHuNXMRnRNxkB6vbc+RfPbcNTjRU1au79c4m
 n/qAk8vsdyLLLrnGhJ5Ck8N2UeDtmt63oEv8tC56ja2I/tusfoPH9ZvMfAHn8Z/Wje1w
 XLrw==
X-Gm-Message-State: APjAAAVyQkC30FlgSN7DsRECi1LoXzansAPLjKCfRZU16e3b2CtLrE/k
 D1IaIbjWyKXdhifQmzpQ3FMVVKaXSThMQQ==
X-Google-Smtp-Source: APXvYqyJ5vDUm1pRGTGVuykBQkTnEo3d0FkPfbmU89w9S4TAyp3kfdJsa0cpbX8O3j8rEfOGcJJUAg==
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr25319608qvf.200.1563295670388; 
 Tue, 16 Jul 2019 09:47:50 -0700 (PDT)
Received: from maquinola.fibertel.com.ar ([181.31.154.224])
 by smtp.gmail.com with ESMTPSA id i5sm8813414qtp.20.2019.07.16.09.47.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 16 Jul 2019 09:47:50 -0700 (PDT)
From: Karen Palacio <karen.palacio.1994@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yucha0@huawei.com
Subject: [PATCH] staging: erofs: fix typo
Date: Tue, 16 Jul 2019 13:47:43 -0300
Message-Id: <1563295663-312-1-git-send-email-karen.palacio.1994@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Karen Palacio <karen.palacio.1994@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
---
 drivers/staging/erofs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index d04b798..0dcefac 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -88,7 +88,7 @@ config EROFS_FS_IO_MAX_RETRIES
 	  If unsure, leave the default value (5 retries, 6 IOs at most).
 
 config EROFS_FS_ZIP
-	bool "EROFS Data Compresssion Support"
+	bool "EROFS Data Compression Support"
 	depends on EROFS_FS
 	select LZ4_DECOMPRESS
 	help
-- 
2.7.4

