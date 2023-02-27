Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 981FD6A3D64
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 09:46:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQDcK3Xstz3c6f
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 19:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=K0762jnE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=K0762jnE;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQDcC4QdKz2yMX
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 19:46:02 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so5101529plf.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFpin/ECaOJex7YpZnFv6bGio0mg33EAQtvXgREUayQ=;
        b=K0762jnEJeB99RHRGn9nhBNoRCkFPx0Ljg3EZyQXsyQFII/I1EkFO5qgAOccMNyeD6
         UJiRPUyOF88EKQ64ReXpDogSAEzm1FhfT5k1GGBx9mn7HhitR+o37RAqUeuqWlQoOikt
         +7R+89Z+KoE/Ogow5wLHeo3vcvkfdxI5BB0JPnxpfd3IN7NCfNdGBGKkxhDyiFFlEQIl
         SVPrbPfz1t9hPC+p/lRJSXw2i2wdFlh8CDDiZrPYsE9aVljQ5XZOY3TgKeJeik8HLUzL
         pTiOS4BhrdtYCU67A7KUe4ppA7u80fNvJeQueGLVph63Z76f/+cezeihw8RdEVY9krcM
         XIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFpin/ECaOJex7YpZnFv6bGio0mg33EAQtvXgREUayQ=;
        b=nbrfkDssgTOY96WsCviW7eZ+4kR7cZn6dwmMy9luhh35VYv+6qSEiNxcVsjsEI+0sT
         no+PZTXdOdnSi/CpABnTES2vjTPdJ/+4OkrxzaLvMNTL4mfx0MpJHIoCM1iMK2vENrpc
         9v5RhsRySDDqrrKr7POGYQ6+NXyn/hiUj0EqWOAV8h1OjXXxGLSy7jm/24lCDX8PrZOx
         MBbmQEY5FG2XAEBKENcZIyRs6tE+Vo/33t772w0itw75BObKBf5YT6qOXyX8Uw/WGqIX
         MC5NbY0t9/soXfHENGgCm6Us5LGdB8Pl5VKmEMt6yPfZvgNCgYn76HW/jy9tlcr2ihfv
         9yGw==
X-Gm-Message-State: AO0yUKX2yTaRERuqtyzIcxEqa+oDI6ANZFj8TlbtPa0VxYsO+IWbhVrb
	MJxl8Gxcw8DzAXlRfWkWNQc=
X-Google-Smtp-Source: AK7set8rUqbwDb6YN70TZCYUV86Ojz9rmvp/fH3/kyj5o5+FHv+eATzeub1Rvw+C1JsZIKHgA9XKnA==
X-Received: by 2002:a17:903:22c8:b0:192:4f85:b91d with SMTP id y8-20020a17090322c800b001924f85b91dmr27141271plg.46.1677487558137;
        Mon, 27 Feb 2023 00:45:58 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ba8300b0019aa8fd9485sm4013688pls.145.2023.02.27.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 00:45:57 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: don't warn ztailpacking feature anymore
Date: Mon, 27 Feb 2023 16:44:57 +0800
Message-Id: <20230227084457.3510-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The ztailpacking feature has been merged for a year, it has been mostly
stable now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..733c22bcc3eb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -417,8 +417,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	/* handle multiple devices */
 	ret = erofs_scan_devices(sb, dsb);
 
-	if (erofs_sb_has_ztailpacking(sbi))
-		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
 	if (erofs_sb_has_fragments(sbi))
-- 
2.17.1

