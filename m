Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3686B0F0
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 23:17:21 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pCsB5qJ8zDqd2
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 07:17:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SrAwgVOn"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pCs75rzvzDqZ1
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 07:17:13 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id t8so15811277qkt.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GWxxxOtfc0hkJsoN956op0nPQ4cc3G9CQfKbpsVdrj0=;
 b=SrAwgVOnyiPAaNHxRm3kITb/9/eY2aKXVp3n+Tq/WXDPTV8JkDdwlVp7G/kIeACNfY
 WhI5Xz8iLcCYypsRAdoBEuTLxIuPkgx/SV7XFlm/QkQA+DCGu0t/WgJU+1FxKVEpSHv8
 EKrT5/bwn16A8L9IBq6Mh13dPmEa/mXKcw7iRdzyvUetvfv4/ibECfvDm8p51exwA1WN
 bhO7buH/icq5mR3xluqVeCA8Z1K8TyGXpRGJmjy2HRWjlNHNbodmTJYl7BuTVR9L9o/f
 4IWixdvzb1HKrb1TsLm3SyUQ4Yw6k2KjbDpXKP+E1w4MQ9UKS3mL/TL/GqC9wUmYMnP6
 GaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GWxxxOtfc0hkJsoN956op0nPQ4cc3G9CQfKbpsVdrj0=;
 b=ASyN70NqzOE2Ix/1VfygpIwKdQuDNwmgCQ/tKOHv0SapQuj3CePofBH4JWKABD9y7i
 EAo015T61lUX1WD+2j6Knl8h0EmXV9mMQq9SIbmYZ57WW6I3XQuL5GFNiYsCeqaEAqUN
 TjAdUh6ojvClRjV8giw6Tc41aGTyt+Gk7OYv96p5oizG8mBVx6d9xWIZ1rWGD5zDgHTi
 H0aCeA/aXy3Gyhl8YH1vPw0cndgahj9j5okWCCD0KSu0+8h+jWPKuhvH45Ce3xbaOgqb
 XczhvcmnVxsBoD0duzeE2eOr24mH9dWn5UQNdtzxrkOo05A2cyzikG9TxNdDusT0PZc8
 VRrA==
X-Gm-Message-State: APjAAAWeGXHNU5JeZlFPdwiTzGunI/rY+jiBEnVjlraQooN4l0L/98GL
 8z5PIDhDlXfLSa7zZzYTTabjewNEGGxUYg==
X-Google-Smtp-Source: APXvYqxAHzQC7Z90lpdgYOSIs5u9EwVm0pWq+yLNiyr32VCtVGa5BvinBHIJMCdkAzPv0wvD8nFRBA==
X-Received: by 2002:a37:646:: with SMTP id 67mr22333367qkg.287.1563311830055; 
 Tue, 16 Jul 2019 14:17:10 -0700 (PDT)
Received: from maquinola.fibertel.com.ar ([181.31.154.224])
 by smtp.gmail.com with ESMTPSA id t76sm11023311qke.79.2019.07.16.14.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 16 Jul 2019 14:17:08 -0700 (PDT)
From: Karen Palacio <karen.palacio.1994@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yucha0@huawei.com
Subject: [PATCH] v2: staging: erofs: fix typo
Date: Tue, 16 Jul 2019 18:16:23 -0300
Message-Id: <1563311783-12754-1-git-send-email-karen.palacio.1994@gmail.com>
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

Fix typo in Kconfig
Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index d04b798..0dcefac 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -88,7 +88,7 @@ config EROFS_FS_IO_MAX_RETRIES
          If unsure, leave the default value (5 retries, 6 IOs at most).

 config EROFS_FS_ZIP
-       bool "EROFS Data Compresssion Support"
+       bool "EROFS Data Compression Support"
        depends on EROFS_FS
        select LZ4_DECOMPRESS
        help
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

