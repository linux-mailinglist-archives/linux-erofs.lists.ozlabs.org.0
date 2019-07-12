Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6616679B
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2019 09:17:33 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45lPQ16VSnzDqR2
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2019 17:17:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nishkadg.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDiDxcyp"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45lPJv6lB3zDqt3
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2019 17:13:03 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id z75so4121770pgz.5
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2019 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cmo1tqBeA/Sh2ClKCCO0JqdGpQ8IAK8NK0uVuzIyLd0=;
 b=DDiDxcyprjE4Ta3ztfW9tsjVQv/DEicG6Tlr0nncKQgg7hJxObowvlEhKvRearNs5h
 gTwMEe7djLb+a7fCtQZuARPC+zJS+vDRTSioHGz7CITml5bJ6BXzuC2DKoJkTfFEq406
 K6ATKZAsyYneolthA4B2I5zh25q7Q5uzNpom3Ad7TmotH5xwkT3AAAce2HJT3hsD5hsP
 2AYAmRpxBYfuCixamSHDd+ejE9KMqSLTCDy3eyFNyUNQEgmjL6OoUvbQYvU4Lc3UIEjd
 vWp7TiwC2beD+iLJRQpvA3tTkL0P/5jkxlkiSv38l1o1pzuNKzuTfTdWxxwr5hyNTZ4K
 QPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cmo1tqBeA/Sh2ClKCCO0JqdGpQ8IAK8NK0uVuzIyLd0=;
 b=V8XSarSt8gJlaNytkkqDgZ1e6eQdn4/Dw9QKXj9Kond47+cDiROO3ozb4otQlEZWuP
 6ncZmfg0IJOcDXWonedTazwuGo4IHfy2+gXPryd7kh3lsVwd5SDx2bUrBP2YPHeTKilA
 LvBV+PZgExVV8oJ+EvJ5KI493qIj6u3Z5QxqU2xtH77fVLvzBGJtdlR/2aRraZBPU6rR
 t10bdOQvZa+Q5/xjH90GP8cZXr7dsRXprIJXse4NdxzZPJxnZxrLYsACqLDKLUYyfkqy
 zoMJuCyyYSpPTesoO35DVxziBHn1g9k32wJf73UGlCq5reaIcemW5MtbSj45v5I76iS2
 qRdA==
X-Gm-Message-State: APjAAAXc+Q4Py02tuYbxMb1YT4S2IBRcCiyRqGst0jpJWMC3dYFti7uz
 oDChYnDiytYRuj9j+JI/bjM=
X-Google-Smtp-Source: APXvYqyyxt02F7w2fO44SgdWkmlW43gvemD8er2ox2KKleaFdRacxH9sTUY3sUMYU/OElvDtowYPRA==
X-Received: by 2002:a17:90a:de02:: with SMTP id
 m2mr9851109pjv.18.1562915581568; 
 Fri, 12 Jul 2019 00:13:01 -0700 (PDT)
Received: from localhost.localdomain ([110.227.64.207])
 by smtp.gmail.com with ESMTPSA id u69sm12391982pgu.77.2019.07.12.00.12.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 00:13:01 -0700 (PDT)
From: Nishka Dasgupta <nishkadg.linux@gmail.com>
To: gaoxiang25@huawei.com, yuchao0@huawei.com, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: erofs: Remove function erofs_kill_sb()
Date: Fri, 12 Jul 2019 12:42:47 +0530
Message-Id: <20190712071247.2357-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove function erofs_kill_sb as all it does is call kill_block_super.
Modify references to the former to point to the latter.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/erofs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 54494412eba4..3e2a65ba1945 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -554,16 +554,11 @@ static struct dentry *erofs_mount(
 		&priv, erofs_fill_super);
 }
 
-static void erofs_kill_sb(struct super_block *sb)
-{
-	kill_block_super(sb);
-}
-
 static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.mount          = erofs_mount,
-	.kill_sb        = erofs_kill_sb,
+	.kill_sb        = kill_block_super,
 	.fs_flags       = FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("erofs");
-- 
2.19.1

