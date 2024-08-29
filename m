Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DE96444F
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 14:23:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvgSC1rFGz2yy7
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 22:23:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724934232;
	cv=none; b=C5+vE4A+2A6A8g7AG3iXJQQJ54UxnZlZx5BCgKt1EuoedEjyGJ9F8seLqcYbWIE9LFZssIaSeXMM8q2bl1altQcJsV9vpPneDvdos9L4MhT0fagxs8jCeyMRPj+TLA+eLmGqk7D3GSoUVWr0rufZrst71dvG6nW93kOBXuljlfKBJATnyX5fyK5G43VQg+6Eg5AgX4F2hF9P4vpHVNK5XeUDMvBNMBAvgFNS8iwD4C0vATduQo2bRSRlc2+Khd0T7ymHiNL8kQKgknUDJP2XAhVm/yjT1ZwncUHI5Bag34Pfsqn5bb3MH+Z7xZa/SbpYRviRZsqa7nxJpjI3ZLD1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724934232; c=relaxed/relaxed;
	bh=TwpOWs5TRY3li1WZexMIRENKzcNMtUnsc6PFnx6LYbw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=OkwL9VHl8xeLKvbpnEIRk1FFwdf8XSx1d8u4wdZVlBgboBgC7+Aetaeersh6/ClthYXYujJVHViKQGcVDkuKWrVspPIzjoWp4h856ZHP5Yx9TWyT4UeUOkinZ9TTQ4A5t3wTOaQZpTiC3hg4tlBrxJGLwxqQno+mYY1f3uFEs1OMXBe8ZZChyGjFsc0wNf7xjUf5utp6tt+J8S1poklY7hP45X/UfDcnxu9laAzITHa2gVSTQvHDfHEFL3p0WauN9P7th+qDc+sd+arI164FkTaZD30Ba3Fmsr8lFcbeD7WMnKlojdy6/tEJV5MqqDJTlq/I9aHFghz0k7eBybwfrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VVN6yfzS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=jinbaoliu365@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VVN6yfzS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=jinbaoliu365@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvgS756PQz2ytg
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 22:23:50 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso1276329b3a.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724934229; x=1725539029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwpOWs5TRY3li1WZexMIRENKzcNMtUnsc6PFnx6LYbw=;
        b=VVN6yfzSRIFRzqtTbz+eUcW+JsdquyLzOpffnlJjqKKvkcoIW6Hjlsc5cP9OP2AxAb
         M/8LOXTtqkitLqBk6mWv50CoyH80KYMCouUENsWTHilEi1qKTI7GHgNpYo/ZSmPiNtHZ
         4Xg0mQ4/iT+WpoY4mkxy4UOKsr6IMiLks2vfTLyTFyZwlDAYGBp0wi620HKaNlr+VfZ3
         OsMCY5dgY/4ktHH+YmjMCvAYsqEt/RjdBPy9JJq4aq5JeQhxHn78lrL3yZrwgJ9gRJ5C
         f17CQtgGEeOooB3nIezrN8HHip1PbvP9HN7krW+ZLtD0MTeYXFVvVHaHXrpMtt4PRADr
         ua0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934229; x=1725539029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwpOWs5TRY3li1WZexMIRENKzcNMtUnsc6PFnx6LYbw=;
        b=CX5Kk/QPXQm2rgrXCDLQ3VQth991PJ/GdCR+NLXJ5nkSQ3QsUGO+Tkjq8px9IdUYbn
         mI129qyxqLHVEN8bEJCC036AxL6CYDAh+BhKOQt67Bp/ZTgdvmCxGNqRFZI+QjSEWYeB
         YtJHyMgO+1WBFF5+gr+LfR9KIPen0jaP8FmG3RgaM4UY0Ced4ssdrkw4A6KmodPGYEzl
         MZz88uzNp8//9RZsI0cWS7GOeMZ8msvSoczbdnykfZAFBn+vuqw2a4+rW9io4uGleRAe
         uldIclbbujYlU6FIFOW3FOXxFvrJP9D7i+YMy4Bfbfr4KKMBWMb6VN5+THWol9D7XwaG
         wPbw==
X-Gm-Message-State: AOJu0Yw7Xi3wJ7yZb2h1x6As0AXpz8h0SIemfSRMIUHv15hBRoQ/TLI/
	OBs0ajRFyZFUgVa0WCj/Lk6UBJVooyDpwL+YpTWlLxjmvMPLO2ib+BNJQw==
X-Google-Smtp-Source: AGHT+IG198yRuHygyAB1tM094PSpZ1gX96hOLQ8t4QWkcUaq/daYsXOlEmRb6eqNGi3KG87Q5zMWYg==
X-Received: by 2002:a05:6a21:338e:b0:1c4:91f2:936a with SMTP id adf61e73a8af0-1cce15f7d79mr4245384637.5.1724934228690;
        Thu, 29 Aug 2024 05:23:48 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e742e0fsm1093693a12.16.2024.08.29.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:23:48 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: xiang@kernel.org
Subject: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
Date: Thu, 29 Aug 2024 20:23:42 +0800
Message-Id: <20240829122342.309611-1-jinbaoliu365@gmail.com>
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
Cc: mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: liujinbao1 <liujinbao1@xiaomi.com>

When i=0 and err is not equal to 0,
the while(-1) loop will enter into an
infinite loop. This patch avoids this issue

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/erofs/decompressor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..672f097966fa 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -534,18 +534,18 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 
 int __init z_erofs_init_decompressor(void)
 {
-	int i, err;
+	int i, err = 0;
 
 	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
 		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
-		if (err) {
-			while (--i)
+		if (err && i) {
+			while (i--)
 				if (z_erofs_decomp[i])
 					z_erofs_decomp[i]->exit();
-			return err;
+			break;
 		}
 	}
-	return 0;
+	return err;
 }

(1) The use of "break" is to enable a jump out of the for loop, 
otherwise it may not be able to exit the loop.
(2) --i should be changed to i-- because when i is equal to 1,
the "while (--i)" statement would exit the loop prematurely.

and sorry for the delay in the response.

