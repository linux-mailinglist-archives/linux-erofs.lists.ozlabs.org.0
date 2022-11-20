Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6A631273
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Nov 2022 05:07:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NFH676zjJz3cMf
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Nov 2022 15:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IhxjNrLG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=o451686892@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IhxjNrLG;
	dkim-atps=neutral
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NFH5y6qX0z3bY8
	for <linux-erofs@lists.ozlabs.org>; Sun, 20 Nov 2022 15:07:02 +1100 (AEDT)
Received: by mail-qk1-x72d.google.com with SMTP id g10so6108500qkl.6
        for <linux-erofs@lists.ozlabs.org>; Sat, 19 Nov 2022 20:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfvoeMa3zQOpX5IdaoZl8AlnTg4fuOHPaV3vjj1xOms=;
        b=IhxjNrLGM+iZRK70WFs+RWeSxvoHz1eBL7usBIlkeyrNafJkynpdEi30SF/EfOpbrL
         tb2lmqRw0ftPzfEnBj831uM9PKCmcgt6AYJWndx8G39rMW4Qz/XqHGts07dcV8kkSzgF
         pPganelZuCf3nAgSbNMKJo+byDtXgfbIIlemAR4J1+SgoK1IZkkqK7aBmh8hAMf9rd2Z
         9y2S01v+WdxSo5bKPvfW0zmrDeKpkcBBeKCDYe8HlLh6dxB65WFwcnCRDgq1tAjXcTeY
         dlAbujRYbra/DXOPj5muwk/eCvQswzaBNgPK0ByXmnW+MAjsCBHS9DE7HedphHzIGPwv
         iUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfvoeMa3zQOpX5IdaoZl8AlnTg4fuOHPaV3vjj1xOms=;
        b=mbwgDorByspxF2eoI3aAh+LQNnHiBnGSRYuHS8l2ipYlJJz9ZEnfsiv9GLDqHzIv3o
         gRq7BdnDoNWngnLHrTra+g0mgxNVt81vJAQXue8w8o15XW0bve1Pvie7bSSusghbQNrX
         EFbc81KizASGevelQfdwQ0Q4znOlNUr2kUH2623bKzdCBEJsm9jOYdLKjwzOwHQNf1v3
         pfTZqSAFaKCx+a8hSW1VzWr804ZvvLSLkHG9ebu3hWqvV2CkqHm1daU3jTcRT334dSdI
         MYsP/8blLWbbfPuHjbMA8MYlvayMlXvLG5AuPzfGvkiwQ8mc6XHUHj39t9g4FdeWneNv
         iTKA==
X-Gm-Message-State: ANoB5plHLctQHHygAZ0H/GIH7VrN5W5NnpN0goK6ijMitHtP5Psv4VyM
	9+67BqSin8KInglOizOM1CpxSJwnSd6UKofz
X-Google-Smtp-Source: AA0mqf5GxLFvw82o7t2PIKWVijuMDiT5+i5n+17VjXIHDlZz1zFENaUUZculm2BAFlvZBEZzmeGdyg==
X-Received: by 2002:a05:620a:f83:b0:6fa:376c:b746 with SMTP id b3-20020a05620a0f8300b006fa376cb746mr11635839qkn.422.1668917217380;
        Sat, 19 Nov 2022 20:06:57 -0800 (PST)
Received: from ownia.localdomain ([2400:9ce0:1ad1:58a4:5bdc:d39e:761e:bd4c])
        by smtp.gmail.com with ESMTPSA id n30-20020ac81e1e000000b003a50b9f099esm4775428qtl.12.2022.11.19.20.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 20:06:57 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: remove duplicate file type
Date: Sun, 20 Nov 2022 04:06:48 +0000
Message-Id: <20221120040648.706871-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.37.2
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
Cc: Weizhao Ouyang <o451686892@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove duplicate ".txt" file type distribution.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 dump/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index f2a09b6..93dce8b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -37,7 +37,7 @@ static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
 static char *file_types[] = {
 	".txt", ".so", ".xml", ".apk",
 	".odex", ".vdex", ".oat", ".rc",
-	".otf", ".txt", "others",
+	".otf", "others",
 };
 #define OTHERFILETYPE	ARRAY_SIZE(file_types)
 /* (1 << FILE_MAX_SIZE_BITS)KB */
-- 
2.37.2

