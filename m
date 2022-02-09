Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F164AE63B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 01:53:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JthFj43z0z2xsW
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 11:53:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1644368009;
	bh=YTi4ygwd/IHF5gwYfvQJFuWkgL1zRPBDEDK4gtoCIA4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jjNgL9yzzJLSpfxh+l2dSuZKZPDgkP4xDJIwbn+ZjVQZe4aesJ1mlJ2oxi++IHgyF
	 GxZ+lXBnmhLPM9f30uf9C6FnvozXPpRmFllhCFz6bXkhAae6LqKp6V68DysKN/tvAm
	 UojtS4z3OT/Ca4P89R2iMgtvoOifU2q0f288xF9Wce/J56pGYZV/BtQDNVCqtjSS0S
	 pejdMOnCMyL9XK2+JIuHweb6A5lDACCL5HESYM7/uiUeyDDZ9nho1LCHpyxpFNKakk
	 bPHSwrC20EoipzchE5Cd9vObG3y5c15Uuq7N6TtHJHM91LKji6olEZKYmmCgFdJ5WQ
	 EH7v83y/+I5Jg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--pcc.bounces.google.com (client-ip=2607:f8b0:4864:20::b49;
 helo=mail-yb1-xb49.google.com;
 envelope-from=3ghadygmkc8u0nnrzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--pcc.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=cZpEVSwK; dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JthFf4w4Vz2xKT
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 11:53:25 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id
 v10-20020a05690204ca00b0061dd584eb83so1278946ybs.21
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 16:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YTi4ygwd/IHF5gwYfvQJFuWkgL1zRPBDEDK4gtoCIA4=;
 b=H5hO9ktsrb8Z2XHKBTCW3JXhKqO6Q0+uT1AA2Mrj6emO7PbhvqP6nDXp4eaOce8DYD
 MgECQ3vvUWj/pNaDn4Kkqb1Wdt0EZP6mFoiFF1WMTk9Aa95iaouHMEVZJ8IakNcxTobW
 jmW4ZQrAE/7q6GSpIUcIfI45Tr7am2QkcStneEGJSubLIPryCWLBjuicbQNsrpnACHCp
 QgK2b+qJEmEjvSXltL/NllSIkQ8NcIife6TkKqslqJZ/cZf8Ww/a6alyzW099XZ/MAMo
 3YMP15qsJjm59DoVkFuwi4CpHaZJE/IUmN/CYXWBLISwbwdZVHOodT1sEhVG95jEfaZJ
 f/TA==
X-Gm-Message-State: AOAM533z1y+v621nJ1CkUczIVFrFz32Y7vP3VSh57frt+U4ID1Fg6jJy
 c00NhSM3Gbhto17v13eeMu57JG4=
X-Google-Smtp-Source: ABdhPJyngX0D+EOjXdSbUoLSxh9JDIcc+PdzQR+tKUeoxtf2//VGMCBCzwS6bEqS7mYrtmedVSTIsoA=
X-Received: from pcc-desktop.svl.corp.google.com
 ([2620:15c:2ce:200:ddfa:541c:9dba:6ba0])
 (user=pcc job=sendgmr) by 2002:a25:4a05:: with SMTP id
 x5mr2150yba.297.1644368002058; 
 Tue, 08 Feb 2022 16:53:22 -0800 (PST)
Date: Tue,  8 Feb 2022 16:53:06 -0800
Message-Id: <20220209005307.1288161-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] erofs-utils: Print configuration only at INFO debug level
To: xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
From: Peter Collingbourne via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Peter Collingbourne <pcc@google.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The information printed by erofs_show_config is not useful for ordinary
users of the program, and it certainly doesn't count as a warning,
so let's only print it at the INFO debug level or greater.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 lib/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/config.c b/lib/config.c
index 363dcc5..08deb6f 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -34,7 +34,7 @@ void erofs_show_config(void)
 {
 	const struct erofs_configure *c = &cfg;
 
-	if (c->c_dbg_lvl < EROFS_WARN)
+	if (c->c_dbg_lvl < EROFS_INFO)
 		return;
 	erofs_dump("\tc_version:           [%8s]\n", c->c_version);
 	erofs_dump("\tc_dbg_lvl:           [%8d]\n", c->c_dbg_lvl);
-- 
2.35.0.263.gb82422642f-goog

