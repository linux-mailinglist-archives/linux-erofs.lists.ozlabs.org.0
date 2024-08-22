Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8CB95AD72
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 08:28:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqCty3Ykmz2yPG
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 16:28:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C2nddr3b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=jinbaoliu365@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqCtr5kxPz2yHT
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2024 16:28:03 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7bb75419123so301976a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 23:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724308080; x=1724912880; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcegQ5LLDtxve0FpkI1VDAxYi55e9yjJyF3N9IONl9U=;
        b=C2nddr3bOwh2l4bYDG1Uk/+Z1moZ/2r0tjDZ2ghhWo40Xlh/bvvlZkCBh1WIOXR04u
         47UEUXHE3+Jy2zUZbnAQ+dVHCv4xSSMoEdiniKUmAJ9MmApAROPnkL7y7Wav/2GWdvLH
         6zZtL9zlueuj44qIgBKaoRTH/10r0fT8hUSNFV+vpFtNH3egByzauL+V25bOE9/d+g+E
         GcGHSQ8gD/HUOBSmcQrvMaJmCNurWhRWIXEIcco1fLYauW+naNVA2+wBpYNoe/N5Ze3r
         wJmFm8yK2iHBofCFeFqPfzn2eM9PBBB6iBuzISYMDkdsLirgVy9mZQr83zf2qf98FlYv
         NtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308080; x=1724912880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcegQ5LLDtxve0FpkI1VDAxYi55e9yjJyF3N9IONl9U=;
        b=PwHkGNZFXJSEdR0U0k8JeZu3wC9yAD1IH9WgIpFIQ/F1mwGbudAj4QsO1/BZK4yl4+
         AsimY6ohDVV1mgydVBFdM3bYcnETdbmlOqo27SQW4MU9Y5imdPTcz9TRsdbQVW0vcDog
         JBfh5YhF2BfMJOaucvJrYoZClFOjfKiWIadNXvUrRgT9l0WAlMHqXXjhVf6KFQTBwaHW
         3d9DozCmg6hiQwzUuqfVcw6XlhE0mlBpZy47aHKumTCXOsuUF5Twbtn4FHNHE7UPXxK/
         dsZks9722Rno7B82qFbneEnx7/u06lecxbl8t54Cl0yQt1SUAV7gNkMl20FQV/ahfqsD
         Kmgw==
X-Forwarded-Encrypted: i=1; AJvYcCVE8WpO7aiWXjdw4q4/s+nJ9le0R98INVLZq1AL/WTqWhmzOIexSYVf1fpMSiWhyccUCNZhsbEedVWHyw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyq46dbQ4zwyxdEMHA9iUqEVNZC9PnUr21pWPK3uHkdlUBf4ogT
	I+vYt1j4MT+TfO70BA14islnukk+vF9WP1mtEashHRXk5Zm+Mtwd
X-Google-Smtp-Source: AGHT+IHCI5vCN/67al2Tnidlyb6v/FI5ftalotWYxeMsIJ9e48XVWNG8KMJ19aJgFvP2G+Hzr3o9CQ==
X-Received: by 2002:a17:90a:8914:b0:2c9:e0d3:1100 with SMTP id 98e67ed59e1d1-2d616b284edmr913222a91.19.1724308080228;
        Wed, 21 Aug 2024 23:28:00 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0598sm3114486a91.36.2024.08.21.23.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:27:59 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: xiang@kernel.org
Subject: [PATCH] Prevent entering an infinite loop when i is 0
Date: Thu, 22 Aug 2024 14:27:49 +0800
Message-Id: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: liujinbao1 <liujinbao1@xiaomi.com>

When i=0 and err is not equal to 0,
the while(-1) loop will enter into an
infinite loop. This patch avoids this issue.
---
 fs/erofs/decompressor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..1b2b8cc7911c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
 	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
 		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
 		if (err) {
+			if (!i)
+				return err;
 			while (--i)
 				if (z_erofs_decomp[i])
 					z_erofs_decomp[i]->exit();
-- 
2.25.1

