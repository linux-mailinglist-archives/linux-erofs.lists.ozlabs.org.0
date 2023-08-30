Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE378E318
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 01:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1693437402;
	bh=zHtntQp4Bt6yhAvu/ACUB2cljoPXt28EJOYaW0l19aY=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=g9Y++ZC+PsiQVbrsbL4YcKrUVPG6LAjAoQIC6EX1vvM4oIavkdwpE1+9G0RDFHm4P
	 saKafvBIrJdderzrGFJ8FJs6tA+dMXlVObw6DGo0hYrRqxpasIEuVXqfHKzq1o5guz
	 BKFsbgqff5F8/X8seFC6G/R8oseGVJSdM+dQmpiKTzA+hlmCW3T4/ZNQYmsETbenFW
	 +t4EfXfEkEu2n5w/9F90vTZwAlwDgsLv+nBTlQ/Kbe6kLi5SltgmgYWAxKflbQTial
	 62qPoIeX6mxFXnmfjIs7FlsH/CUv9dlTBLbG5p570ap7R7jZKvSHaeH5rB4yWSYgjE
	 +Eg51qje57jMw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbgCt38Lnz2yt6
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 09:16:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=599hsoqL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3z83vzackc1g370l0b46ee6b4.2ecb8dkn-4he5ib8iji.epb01i.eh6@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbgCl0h19z2yhM
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 09:16:34 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b9187c0b1so87218276.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 16:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437392; x=1694042192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHtntQp4Bt6yhAvu/ACUB2cljoPXt28EJOYaW0l19aY=;
        b=EWlnys2lazm2Cw9BlWGz8Dehe4GQnvxHtv9HCxQcSBxNeBBrGHdO2l5FLH0hlzYClL
         V/Ls/ORAGOk/2z+8kkVki6xLOfXIyRMDleV/lLghieoPU1Y9zQT/bZWqGwa0f06nNP0T
         +EJFQkGJ5rIV9rymTw81T7DpyM7Xeu5oJKHk2DC+C/oh0df7SJlP/7PGbvq0gQ4Mx7x6
         UHXpdLmtnCmwdIed3DNRW0zxB5z8EyDaCGoFah46xflLFqRuvbvnbKqQCplUAeLd1Wya
         701Gr+veXlcq9fjRAHgU4dqDnT035slcpJaeEW02Dto71JZns/UK0n50u4nBSYvO4cRi
         USJw==
X-Gm-Message-State: AOJu0YxszS44n+WOr37vnRQpc6A333U96xDfZxpqWoOUbfGAkZRstrT9
	L6Jz5kYbkdmWF1yEDpnV6+rzMSvUeaVSF5tBdh1mjOor8p5DOGV3xQJ4c1qeMz3gUrDU5hxbepa
	N9g7WeRw0/naHPMZhg/UH/7POn2RH4/dYgpEy3aIxyYlJkT+Jg80dAfC7KgoGz1ZE5IYcsoCH
X-Google-Smtp-Source: AGHT+IFM0dnL0ixe7wA7F5hqNuSHN7T8AxnCd61y8RN4Tp37cazP+FeKqs0mcEdAda/edA/vAXom43timAaw
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a25:2d0a:0:b0:d79:3b84:9997 with SMTP id
 t10-20020a252d0a000000b00d793b849997mr95613ybt.7.1693437391578; Wed, 30 Aug
 2023 16:16:31 -0700 (PDT)
Date: Wed, 30 Aug 2023 16:16:06 -0700
In-Reply-To: <20230830231606.3783734-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230830231606.3783734-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230830231606.3783734-2-dhavale@google.com>
Subject: [PATCH v1 2/2] erofs-utils: Set mkfs default blocksize based on
 current platform
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

Set mkfs default blocksize to current platform pagesize.
This means mkfs with default options will work on current
platform. If we are building image for a platform for a different
blocksize, we can override default with -b option up to
EROFS_MAX_BLOCK_SIZE.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 37bf658..8c2c2e3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -689,7 +689,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
-	sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
+	sbi.blkszbits = ilog2(getpagesize());
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
-- 
2.42.0.283.g2d96d420d3-goog

