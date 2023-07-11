Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4574E546
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 05:26:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=mQSHgHRq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0R9B2HpWz3bNs
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 13:26:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=mQSHgHRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0R932G2Bz30GP
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 13:25:58 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so3853312a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689045955; x=1691637955;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KyOa4f5kTSYX4UYCXZ1y9nIcuLPAJIInZdOaOH3TA8=;
        b=mQSHgHRq/hTyBH7Pjjgj1T6OB3gO0NnfVYl4v0IawSdiaL+h/k3Zz/ULgK/apGooy8
         5y09eHVFTiMb0HuUTtzRzXY33ElO2TZxE4F6OsNO8VD/TaDfue/JWYSwfcVBnwsSa9EZ
         P0l8N+WJFguW8l2JCto3GlKXXg/bQj5IxLQVpchMHlV9hmixCA/gTLk8+wtFskRsAbVL
         VZdDcXo7r2ngKrJu82R03wFhz0at5pBSp7CHu5vO+MiCuxwu7K3XARvHzxl7UMXZPihF
         3yYxLfjnX/ueBCdnBavG4bEuqrW9+hZ8akmK/mOpzvtcW2nr8b3Thxx9vQnTT0bf7cUt
         2C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045955; x=1691637955;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KyOa4f5kTSYX4UYCXZ1y9nIcuLPAJIInZdOaOH3TA8=;
        b=dj36n8GdlZJbF7p1AfouyMEQcAMxDNeuRRMMJ4gDvOdp1MrCj1OUZspaugQbjUKGq+
         3JLFTsq8eI4Ab8Kr235cv8E5AAQuLE+Ybnpi7GIcxsL8GPz8YSca7LZA9NtwIFimGJM/
         4IEdQBXvPdidD7uCun7JOsfUjGtVvzIFWJmhS/kByAx8aiUf0IlSres1CCsPQWNFUOvr
         DqUwq/ydB3OF02LgRIwwoCpEWepgZ0RfeuW2scBe/iUZa9muLUGOWNmygc+TF3kjzfEU
         mA7BFoSVVkH5XO90MMxr00v+hEFExhtyjYt2qpSHab0wpaC0jFx67zqRXnagtKnFKRiF
         228A==
X-Gm-Message-State: ABy/qLaA6AD5kEahVEhZm1hVpYNEv85YNUbsB3QbC9pcLjwNdqQ7TTYf
	7WfmHTLzeTyb3LEefCTWhhxl17Jk79U=
X-Google-Smtp-Source: APBJJlE33TPkJqa4DCiCr5sFpeZqajsGuomOSRLJ0VNxplH9DfaFH6f6jMtg/+tN4hdyTPdX/v5SiA==
X-Received: by 2002:a17:902:7405:b0:1b8:4baa:52ff with SMTP id g5-20020a170902740500b001b84baa52ffmr14184103pll.47.1689045954844;
        Mon, 10 Jul 2023 20:25:54 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ba2-20020a170902720200b001b8af7f632asm621614plb.176.2023.07.10.20.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 20:25:54 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: zmap: fix small compressed files inlining
Date: Tue, 11 Jul 2023 11:25:08 +0800
Message-Id: <20230711032508.6892-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Keep in sync with kernel commit 24331050a3e6 ("erofs: fix small
compressed files inlining") to avoid corruption due to m_llen > m_plen
for uncompressed pclusters.

Fixes: 41790d24329d ("erofs-utils: validate the extent length for uncompressed pclusters")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/zmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/zmap.c b/lib/zmap.c
index 7492e5d..209b5d7 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -597,6 +597,13 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			/*
+			 * For ztailpacking files, in order to inline data more
+			 * effectively, special EOF lclusters are now supported
+			 * which can have three parts at most.
+			 */
+			if (ztailpacking && end > vi->i_size)
+				end = vi->i_size;
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-- 
2.17.1

