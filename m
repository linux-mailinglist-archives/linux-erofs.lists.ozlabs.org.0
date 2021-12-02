Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8B466A2A
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 20:09:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4lrP1vB0z300S
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Dec 2021 06:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jQHwwBxl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=jQHwwBxl; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4lrF6g1sz2yHS
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Dec 2021 06:09:31 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id x5so520903pfr.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Dec 2021 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R0e0qp/q+R3YOwq+ArK3ammVhpoxjG3aQYMi/M+cSCY=;
 b=jQHwwBxlF52jzdApTc5QpO4xm6j+juZ9cfwOV+eS70cdK08EFMfHeOsnGzfcVSrGU4
 LfQTELk+r5CetMvB/mco/2U0EuKBin3S1ki3Lwz8vwY/JBRzxlOIZTM8F/rSMFcqeejQ
 8O5L4covUwVUnH9Qq0GyOJXcD0JXYkVa7pmO9FW2Jn2QDn5JLLl3WillUy9JW9aO/sAS
 PIX9Pk4PRkTGB3agP/jHVCEpD3CMkBKn/y4eAEZkC6f9aOK2hsWJNfSscwgOrdhS9xAt
 kZU/it5cF/Ehbh19A9lqT+URuDslYHrYraFoOiKDaPFErvbqOgUFCOdlqd5swnEU9P9L
 vbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R0e0qp/q+R3YOwq+ArK3ammVhpoxjG3aQYMi/M+cSCY=;
 b=QzrLT/wdik1vBundbTA/VZGo+7UUtcJLyIMHwT0LSle+j+X4lfclzKDUrMGBP7zQtI
 +e4XLtvHoe6qfbdTVSJPIRdkuMO/cXz6vKiWs0sQozl7xYbrrKqWU3nfT1yFLEKguxjj
 58s56Y6pKtSlfSCDiG+kplyBcIBDeXFyVphkVsJPxHuG37QdJkKwvBxOdB4Mv2NnSVFP
 km6loKOOOzeSf1C8SMiz8yG9Gbn7JVCT35vUZEFOHtaavBjCxvGesYeb9O+QiMYaq6+n
 alOo63XRpkrWsMx7+0tXxVjpcR582YzY27Ts1h8r/kHMeX2MT7MZ/59fOKA59C/4iz0k
 PR6A==
X-Gm-Message-State: AOAM532fVudP3QrDI0c30XBSjT7EzNjiXrul94BN0SBYdGOLJlHzLoPi
 voFJA0U1Cp3OROFJJmwt4gNuVpc+v7I=
X-Google-Smtp-Source: ABdhPJweWyOCeOVmAY0y0tlyqWPxAGHpzMjfd5hX/XX8q3ZCsjvMNq/4fMQSHAohynn5q49F8SPwcg==
X-Received: by 2002:a63:5743:: with SMTP id h3mr868045pgm.166.1638472168405;
 Thu, 02 Dec 2021 11:09:28 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:8054:8fb7:742a:f086])
 by smtp.gmail.com with ESMTPSA id on5sm293534pjb.23.2021.12.02.11.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 11:09:27 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: loosen hash_64 compile restriction
Date: Thu,  2 Dec 2021 11:09:23 -0800
Message-Id: <20211202190923.975767-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
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
Cc: jaegeuk@google.com, Daeho Jeong <daehojeong@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Daeho Jeong <daehojeong@google.com>

We've got the below "unused function" warning for 32bit compilation. So,
fixed it.

error: unused function 'hash_64' [-Werror,-Wunused-function]

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 include/erofs/hashtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
index 90eb84e..d425f0c 100644
--- a/include/erofs/hashtable.h
+++ b/include/erofs/hashtable.h
@@ -251,7 +251,7 @@ static inline u32 hash_32(u32 val, unsigned int bits)
 	return __hash_32(val) >> (32 - bits);
 }
 
-static __always_inline u32 hash_64(u64 val, unsigned int bits)
+static inline u32 hash_64(u64 val, unsigned int bits)
 {
 #if BITS_PER_LONG == 64
 	/* 64x64-bit multiply is efficient on all 64-bit processors */
-- 
2.34.0.384.gca35af8252-goog

