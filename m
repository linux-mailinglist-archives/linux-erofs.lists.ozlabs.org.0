Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C72710580
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 07:53:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRcfx2q2Wz3f7D
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 15:53:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=dkzqX7I+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=dkzqX7I+;
	dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRcfr2CJHz3cM1
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 15:53:23 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d293746e0so2021969b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684993999; x=1687585999;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7P2pViE0Pdm1oz/lthOVONUXxJhbAwJFigoZZnYI7I=;
        b=dkzqX7I+LHjgODgV0ywVKF5SLiBAzr+fGfCFf4pam8H9IH8uK2DHL9sYz1mJQS+T0j
         QGPRv+8atks+Kg3RkZzzt2nYCvFvKiycZ+lBKTZKBJc5LTFDvnHfJw/l+5PVDXEUzzE/
         BxFMkUbVzc1Vi9KvP5BU2ypMquo3bkBJHMh6tNCJyVQAIzez4AeuyUq/xKQMkTPpLyv5
         c6R27f2W1KANiiXX1d547hMrtCug7n26Pu25Wa0MtlQTwNC0Y7gfvKNlc7+iqX4uRNHM
         dNzlmlAuakASNyGw/L4BvGTGwzfDL8qBKcvQeMux0JDr6i1AbbgGi/18DhmFzz9SDLtp
         Kt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684993999; x=1687585999;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7P2pViE0Pdm1oz/lthOVONUXxJhbAwJFigoZZnYI7I=;
        b=RMXnNrRyp/dW+jxgDooPyHtG7jk56D6xCrv4DQfIZCL0beXCs+Qhkon7HSduQm98K6
         v3vn8VXoQXPAlSkaPwQWupa8W8MXAQEdKZh9WL6RyhV7+t0c4Wnx2l3pQVPhqbDoMXi5
         Lbt6He/kiS6CwXeUZxfiCyVm5KGi9vktZcCdQir1Lx5CYu6RSypAgYYo9fzMkkAJv9Qt
         ExidcujPf1O+G55ZWe37SNCPSlzSiedz38USMAdj+Zb/0Qbv3i4HCGHy6WfLPlaOHqSK
         JJFGf7icn/XZT3Wf2zcIqz5cD/0cDtr7Ev9JxqhNToNnWLUG5+/mIB8dGBFj/JdWAYPv
         /wkw==
X-Gm-Message-State: AC+VfDw5fwFbbFcUxBSNPNk6K5pyv1dXRXOFzrqCZgNc9j4Re+IuH94D
	FgVO/uxyp1Nd3f5qpm++bKbZujItYqo=
X-Google-Smtp-Source: ACHHUZ4/7hCeo6+NoomrhmCHRq3yUsBAuo2crzdqr8m6FlZpndwMWY0HzBfzd6xDatii84yEQvl5mw==
X-Received: by 2002:a05:6a00:13a8:b0:64b:205:dbf3 with SMTP id t40-20020a056a0013a800b0064b0205dbf3mr7081362pfg.34.1684993999543;
        Wed, 24 May 2023 22:53:19 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78001000000b006437c0edf9csm415895pfi.16.2023.05.24.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 22:53:18 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: don't calculate new start when expanding read length
Date: Thu, 25 May 2023 13:51:47 +0800
Message-Id: <20230525055147.13220-1-zbestahu@gmail.com>
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

We only expand the trailing edge and not the leading edge.  So no need
to obtain new start again.  Let's use the existing ->headoffset instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 874fee35af32..bab8dcb8e848 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
-	erofs_off_t cur, end;
+	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
 	if (backmost) {
 		if (rac)
-			end = f->headoffset + readahead_length(rac) - 1;
+			end = headoffset + readahead_length(rac) - 1;
 		else
-			end = f->headoffset + PAGE_SIZE - 1;
+			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
-		/* expend ra for the trailing edge if readahead */
+		/* expand ra for the trailing edge if readahead */
 		if (rac) {
-			loff_t newstart = readahead_pos(rac);
-
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
-			readahead_expand(rac, newstart, cur - newstart);
+			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
 		}
 		end = round_up(end, PAGE_SIZE);
-- 
2.17.1

