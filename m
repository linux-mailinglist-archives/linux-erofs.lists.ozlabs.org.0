Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E997D7BAEE3
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Oct 2023 00:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1696545633;
	bh=iMRjjnyl2cSU7bykBpLE8QmKkrI84XLl899KpkmHQJw=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=A2bBEA0JP2yMaeVUiCdkYAXX6Tz1aJVSKJvjDef71ZVnooI6P9g/ULhMlP9kFwrcp
	 zfz9KH8hMF5HR2jGMR6t1fT3SB64VZxztzO3WywdWGTVXxGGkqfIrIJKY9MLWS9bTZ
	 ocg97ASHQY/ce9ztPh8e+XxlBrP7mZ+DNJDhfYDGY0W3Awm3kNCz1TGEeCiQKjaHhm
	 3Rm3J1Brp+c4afwHm6vN4yFGAGoFafFUvn6YUsjOSqz48Inj+JZKfYCfeu6psD5bd3
	 4m4V7g5rCsCf9rwc/XbhnxSptZC2tgRiokVAuEWFrfpdkSvjfds15zbd/RpUcUq315
	 ky2NjusvxOCqA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S1mjY1zXGz3cPC
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Oct 2023 09:40:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=r1BWk9kh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3uzsfzqckc3yxbupufyaiiafy.wigfchor-ylizmfcmnm.itfuvm.ila@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S1mjQ1q65z3c2H
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Oct 2023 09:40:24 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a507986ed6so22330257b3.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Oct 2023 15:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545620; x=1697150420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMRjjnyl2cSU7bykBpLE8QmKkrI84XLl899KpkmHQJw=;
        b=ExNjmujp6DBDK0SCc2mJebkd1Dt/EsJMq64fvrvxbY4AZJ6nlwylAFBARVm8GI7+yU
         BT2zPKJe4bTZ0TVHE4iA0h5v3cjsISTdkpCJLVnl0P+wo0NGvoV5f43r7UfEMcK+FOrr
         3lg/IlIwcmWMM1iLypWQ9ll7ZAUYUEWpiWtazXpA1QlH3p7KGjWyBwGdG3TqxMQTrmOn
         nNUljM2hMi2M7rP7ZM5wvqrS7ZO3QWXN13/4lRuD5uTW1Reb3VcygKlPwvrEODuT7EIE
         LROef8RJamJ/Azwmmlb5TeaMlKTcUV9g+zBKpKdaWUmRb3fFHe4sNgsCY8ELLF6iyYRd
         tnxA==
X-Gm-Message-State: AOJu0YxTbeCbBukpSqzphEionfgWMOanU7yDYVXy9Ekw9iM6C26MY7Aa
	pWEtvSJHcrO3HezHnlAZpBzcFd4GbWwTzE4Z5XqHiWay6whvIW4pLw2ykdpBk5xmewqR+c9cyx4
	10sJl3c+LvS0+pkH4Co2SXt7Ii8Sz3StafJ/yyzjtMrRfRpUofD6eD5auwqx+o8e4vCjynpES
X-Google-Smtp-Source: AGHT+IHqnykiaEaAbqwVjjgdRkCPt01sDGJ9SVXZOT1xY+GljkCW60zIC7wLQpALlPmrPKgIREut8x6P+y2z
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a81:b704:0:b0:59b:ea96:8875 with SMTP id
 v4-20020a81b704000000b0059bea968875mr110052ywh.2.1696545619727; Thu, 05 Oct
 2023 15:40:19 -0700 (PDT)
Date: Thu,  5 Oct 2023 15:40:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231005224008.817830-1-dhavale@google.com>
Subject: [PATCH v1] erofs-utils: Fix cross compile with autoconf
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

AC_RUN_IFELSE expects the action if cross compiling. If not provided
cross compilation fails with error "configure: error: cannot run test
program while cross compiling".
Use 4096 as the buest guess PAGESIZE if cross compiling as it is still
the most common page size.

Reported-in: https://lore.kernel.org/all/0101018aec71b531-0a354b1a-0b70-47a1-8efc-fea8c439304c-000000@us-west-2.amazonses.com/
Fixes: 8ee2e591dfd6 ("erofs-utils: support detecting maximum block size")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 13ee616..a546310 100644
--- a/configure.ac
+++ b/configure.ac
@@ -284,8 +284,8 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
     return 0;
 ]])],
                              [erofs_cv_max_block_size=`cat conftest.out`],
-                             [],
-                             []))
+                             [erofs_cv_max_block_size=4096],
+                             [erofs_cv_max_block_size=4096]))
 ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
 
 # Configure debug mode
-- 
2.42.0.609.gbb76f46606-goog

