Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB76C1ED
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 22:12:05 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ppMR0scfzDqLJ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 06:12:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OEE0T7NW"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ppMK4Bm6zDqRf
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 06:11:57 +1000 (AEST)
Received: by mail-qt1-x842.google.com with SMTP id w17so24707480qto.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=aXF9YjNGRVCKlAtbL0tVAMrOAXyOBM/cVbWCJmWIjRY=;
 b=OEE0T7NW8GXKa4IkI0g33CvRjWt+tKuSq6OtlaBYdZPT9X2RVTHISNbkhN10r8j/Gi
 bgLDuzEp9IpLD2UssVXvKcGciz9CJzaKjFNcbRCMjF7+AUls04mOv+SebbSfQT786f5+
 GbNt2cVTkGIQ7PeS40/S1BPUZxhHCAHSHUH65QxribnTd3IHws8mXHhFzK2N44N1BlIu
 z+UN6G1gv9IsI51vmJhAz1oP4yT0boomGFduNUX81TjmGDq+37UlhZVQk1Bwl9zFghnz
 cR4gqdB++f+QCZ/Sn0maocW9e+Xs3z4XRn1J0BjJK4sr3V8BgNseeILo8JkTgtf60i+V
 dOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aXF9YjNGRVCKlAtbL0tVAMrOAXyOBM/cVbWCJmWIjRY=;
 b=nvobj6+63nmL7NxJGrmItXuUy29S+wfIrDwSNHrTQQhj/im1XtVnj/oyDXP9roSHu0
 osNiFV6408nkDlqbYerjmtDXbWxIY3NqrYmvf1AVbJNI2oqhhhqqBj3jC9MpGUhb0n3n
 Kflny7kGXNEK8qeRp3X+iwE8aNz88x3ECnrM6QisP0SSAu3LVlRpPvGGBUAD6KQLkiSl
 xVkNM/dl115+9OSKYZQLWC1enWUh/tLw7iTkoQsgKHYifs5UF4HBae/hjWeISIR4WW25
 YmDVdWMOduMbzTbGYq8kiPvCWeuuoysnzotTm0d9xsLCyK06qXI7Q1kwAry4XYoZh10x
 Lq9A==
X-Gm-Message-State: APjAAAU2+YOxRgm+TrmTQcE/fYQZqDpXMvhStnzPR0TGHOvjVY+tV4Ma
 4QwqJirA8tdWUgaKaJ2wPR9CQTcjrcqWlQ==
X-Google-Smtp-Source: APXvYqzr2Hlv8Z3a/qc8bpgmZo3SR+IklR6PK1qaWMLb29Rj6uz8Mvia4TyysKl0TGyTH02a3wcYnQ==
X-Received: by 2002:ac8:2a99:: with SMTP id b25mr29479379qta.223.1563394312784; 
 Wed, 17 Jul 2019 13:11:52 -0700 (PDT)
Received: from localhost.localdomain (host131.190-229-79.telecom.net.ar.
 [190.229.79.131])
 by smtp.gmail.com with ESMTPSA id a6sm11187296qkd.135.2019.07.17.13.11.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 17 Jul 2019 13:11:51 -0700 (PDT)
From: Karen Palacio <karen.palacio.1994@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yucha0@huawei.com
Subject: [PATCH] v3: staging: erofs: fix typo
Date: Wed, 17 Jul 2019 17:11:19 -0300
Message-Id: <1563394279-6719-1-git-send-email-karen.palacio.1994@gmail.com>
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

