Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1668FFAE
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:12:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC4jy4qn5z3ch9
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:12:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KoxOwAfB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KoxOwAfB;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC4jt1CW1z3c4B
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:12:17 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so1187210pjb.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 21:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/zmyB5ed7X1QuJ3E3Pi4MYoQa0o5KmmlWf5Y2v7TIw=;
        b=KoxOwAfB2evDlwQdC43RR3+cvwXl+CsNC6c5ASdcFA88hHBZAb2JGL+SUEr6MwRZA1
         gkVsEeNFr6rOHIeNcjL6Jy3Ego+8VfORmEsufcLyu+D9q2bI4JWAr8PxVRj3DW47eTWn
         H2Ju4G8oDpPmZhXBDmDLA1F0+Mtv8OlMt8xyJhl5VK28btX6Wb+kb3lU8FdEDB6G1DKu
         /qN5wTdBUkJT7qezEklgq2kCqkmqu3inMC41/FfVPEP5jD9KRf3jYWAqJiSRtlwWQ4cO
         abq6xWHJqq2U5WEiVoZsS+A3ZGM+DU+xKP3L0O4nGlz+4mXpKfy4UWFksWXYdjcvGfFA
         mU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/zmyB5ed7X1QuJ3E3Pi4MYoQa0o5KmmlWf5Y2v7TIw=;
        b=A0VGVbM7KyCtLaJyepnNJsdnw/5tzj8D9XbpdLbLIEN1uFxYKYe2VcSKsg2/ORoCiG
         xnZiM4NE7WPKRXBdSjJrXfi4a4K7GweekrBI1I2eeYbiYEK0cdxw3PiL88DJWIQRaE+Z
         EasBueV84+4gp4m1hkSz0bEbbnPcbyGSENMyhrbi82ZMu56tLh+E6jyy/CMN3ecf/qLF
         mJRTMKDk0Kwnl5VQ6DdHqmnA7MXp327p6bMLY+/AHZWSHm2GIw3hWUhDkFFUsM0RbFJ7
         EWQqf6UZLI7zKlhJ54Kk5Hv4HYO0MWjbULAANrqEt3hlLCArsMvYJCdBSNjNPnNtu0kY
         1SSg==
X-Gm-Message-State: AO0yUKVvUm866DacIlY8BAb+KFvoahvG7saiv2OhZOl5BfsoMiv28vgN
	x2IrQOUwBR+UP8pZ736lRH0=
X-Google-Smtp-Source: AK7set85mRngGbLrqjwx1O+DEVdLiY/kT/apfyuSlakyXvcI9AVxfkuo2PRWjoBZ/zKfJ3O8qxh68Q==
X-Received: by 2002:a05:6a20:e40d:b0:be:96d4:f863 with SMTP id nh13-20020a056a20e40d00b000be96d4f863mr7500208pzb.18.1675919535038;
        Wed, 08 Feb 2023 21:12:15 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n25-20020aa79059000000b005882b189a44sm356207pfo.104.2023.02.08.21.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 21:12:14 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] Documentation/ABI: sysfs-fs-erofs: update supported features
Date: Thu,  9 Feb 2023 13:11:28 +0800
Message-Id: <20230209051128.10571-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add missing feaures for sysfs-fs-erofs feature doc.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bb4681a01811..284224d1b56f 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -4,7 +4,8 @@ Contact:	"Huang Jianan" <huangjianan@oppo.com>
 Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
-		device_table, compr_head2, sb_chksum.
+		device_table, compr_head2, sb_chksum, ztailpacking,
+		dedupe, fragments.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
-- 
2.17.1

