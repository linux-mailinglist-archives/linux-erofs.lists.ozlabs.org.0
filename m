Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C828FD066
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 16:06:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjNkX0ha;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvTlL1q56z3bvP
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 00:06:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjNkX0ha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvTlC5h68z30Tx
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 00:05:59 +1000 (AEST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-62c5fd61d2bso68764537b3.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jun 2024 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717596357; x=1718201157; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNb4Eq0aj+Fb5y0tHoNWhdaAVXL77vi/3nFgdVxWYLw=;
        b=OjNkX0harxd8VEBJxphTh3WiQFyAmrdV57Qh6QagiuC0Z7J4y0xyB4iK3UL+SYYPTD
         Jreo0Gr7XMGYRPLXKYDmmsOxNdeWNTNcWSe/Pfor1JrwR/qx0plu8qa15tuIPciGOakD
         1LsWD4c6fNm0+nP7cnc2GsN6vAkShg6mIlSQf1Pzt2VEyY+55XfbvXJ6sBmK/qYjLxAl
         q63ovBg3me+ucrc89cSnha+8M7G9kcfp/O6MdsCYFOIAnNN9WVA5JKxFJgo++nfSUe1B
         L8DnZHIzFvvE3Hfl7zy9PKGy9CU6TNEqWLXw3NinIkq/pgjP+BIacwMV1igRFmak+W3t
         jCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596357; x=1718201157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNb4Eq0aj+Fb5y0tHoNWhdaAVXL77vi/3nFgdVxWYLw=;
        b=kbfYa/4AahgMv/dqfPSsENThrBv32WRvRMJ4XZOrvnpVbRAZhWzC3EQoxAi1P6Fncz
         hzLvDb9aVNRVBskUULXmiZmpk2msGH3TRo3Fw9WmvyD7LQrobi8aul19L6mB49CdCQ6A
         Ta8q6Cov5sYwWji1w+4PoSxTRP9Nh3uum/eI2mRA9P7CKOkxFHnXNRPXPbpj8530HK5w
         ULoE2sKXoTEfSHVZouFFR63EHuvp6AagC6EOcdAZgmrKDNOSGq8ELOMbRuVbuUfcbezG
         L4nWgsHwmyJXwSL/BYOwgpaQCjZrzaH77p6/DbSHBCCvIecFT76SeWKzcCXwaGJFWxUY
         gZ5A==
X-Gm-Message-State: AOJu0YwsSoPDtMSyXft/onMh1qUpR1x1+sbVhy+yqeeNk+D4ax+Hkjwa
	NY4QEDfYguREObmnnUO34McqxBGLPPZdE1g7m+T8LI1gU/GJq90a
X-Google-Smtp-Source: AGHT+IHGIBKTjSky3iE0f5oIrBg0+lS+HOsqYKY7qnaUpo4nAElWK4/XrS/wglhSmrC1N3jlTPAlWA==
X-Received: by 2002:a81:9282:0:b0:61a:d86d:fad with SMTP id 00721157ae682-62cbb5c4be1mr25110497b3.51.1717596356955;
        Wed, 05 Jun 2024 07:05:56 -0700 (PDT)
Received: from localhost.members.linode.com ([2600:3c02::f03c:94ff:fefe:15fc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c76603491sm22195157b3.62.2024.06.05.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 07:05:56 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
Date: Wed,  5 Jun 2024 14:05:54 +0000
Message-ID: <20240605140554.1883-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, wjq.sec@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Here the size should be `length - skip`, otherwise it could cause
the destination buffer overflow.

Reported-by: jianqiang wang <wjq.sec@gmail.com>
Fixes: 65cb73057b65 ("fs/erofs: add lz4 decompression support")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f4b21d7917..95b609d8ea 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -313,7 +313,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			memset(buffer + end - offset, 0, length);
+			memset(buffer + end - offset, 0, length - skip);
 			end = map.m_la;
 			continue;
 		}
-- 
2.34.1

