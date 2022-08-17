Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E139596906
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 07:52:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6xxx18QMz3bhK
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 15:52:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=D01Ke3oU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=D01Ke3oU;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6xxs4lGRz2y2F
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 15:52:47 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id p18so11128139plr.8
        for <linux-erofs@lists.ozlabs.org>; Tue, 16 Aug 2022 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=r9uSBZRzY/hyg7x3wIlRysRhk1e378ROz1u5whAvJMw=;
        b=D01Ke3oUmo3DQd2FAhmvr/6caGqSQoCLfHq9dVux0HktZBZD8Lg2xnN1EA7e7bhJhX
         oqzlkXI84XFRlU9JxWx5ZPlBq4aVgiyB2pWRsjl2Du2bK8vTihLmXTYBLngw3BVsreiN
         LfqoNvskAE9QgLYO5sBV+QnHwIpzHaOZeE7MmMZWqlI5KkUUG2xz9Hug5XZIKADHPGtw
         8yBNpxe8HWq6n/Z8ATdLb4IoZslDs8Q72EstRO2rawNM3Upw41r5LgUpn+ZxMacfsdwn
         Wp3OdsRdGQy4mwzqcSM4bB4mYO++++WV5MtstBloed3/j0bOIeoJFMvHcjrpdgRKnnCv
         Vs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r9uSBZRzY/hyg7x3wIlRysRhk1e378ROz1u5whAvJMw=;
        b=Zh0wcemrVIUKjG62xRqejKt6wprcYpyhZ9ypM5qfhOZe45xd7mG/bPhgBEYJDA2yze
         JsGyq7CZ1V++v4o9WiDJIrDlmWhGvPHLtsQD+0+fTGBQMzBtzssd/YZoITyQiJDTEZRF
         rRO0VuzJTTSskv1tEQAedY1bjoNaojneg1YGh07RfcUhWEBd1TcFw86WlHSXb9nzz8rG
         uuCxCKhSz82afDGIL/NfwC8TnHd5hhjiy/9hkVEbHZnrPPCQdFZoabjUA+L6AmUDaRmv
         2cXowzIZUZ4VBSWJf3sqYDdfQK48kop0oCjnFpQeYY46zRloE/WKFI0V4SFJEA6beRgY
         BFmw==
X-Gm-Message-State: ACgBeo13Gmka8G50mCHJlxjeqzpKCTMacmXvM0iyaaU3/s3kHWl2KS+G
	S9Z7K4rJrwtY1wNHRNiRTsQZoCVCjW4=
X-Google-Smtp-Source: AA6agR7JejMjJKTRCO/sdsARGjxrQVAIH78MHzB7YSkAfUZhnQ8EZ56CbUy6FOJN+cIHOjd323Facg==
X-Received: by 2002:a17:90b:3812:b0:1f6:7f5:4c3 with SMTP id mq18-20020a17090b381200b001f607f504c3mr2168301pjb.223.1660715564576;
        Tue, 16 Aug 2022 22:52:44 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 143-20020a621795000000b0052d8b663c37sm9442577pfx.195.2022.08.16.22.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 22:52:44 -0700 (PDT)
From: zbestahu@gmail.com
X-Google-Original-From: huyue2@coolpad.com
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: avoid the potentially wrong m_plen for big pcluster
Date: Wed, 17 Aug 2022 13:52:28 +0800
Message-Id: <20220817055228.32314-1-huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Keep in sync with the kernel commit 0d53d2e882f9 ("erofs: avoid the
potentially wrong m_plen for big pcluster").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/zmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 95745c5..61666c5 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -97,7 +97,7 @@ struct z_erofs_maprecorder {
 	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk, compressedlcs;
+	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
 };
 
@@ -153,7 +153,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = m->delta[0] &
+			m->compressedblks = m->delta[0] &
 				~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
@@ -253,7 +253,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -450,7 +450,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	}
 
 	lcn = m->lcn + 1;
-	if (m->compressedlcs)
+	if (m->compressedblks)
 		goto out;
 
 	err = z_erofs_load_cluster_from_disk(m, lcn, false);
@@ -459,7 +459,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	/*
 	 * If the 1st NONHEAD lcluster has already been handled initially w/o
-	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
 	 * an internal implemenatation error is detected.
 	 *
 	 * The following code can also handle it properly anyway, but let's
@@ -475,12 +475,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedlcs = 1;
+		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
-		if (m->compressedlcs)
+		if (m->compressedblks)
 			break;
 		/* fallthrough */
 	default:
@@ -490,7 +490,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedlcs << lclusterbits;
+	map->m_plen = m->compressedblks << LOG_BLOCK_SIZE;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
-- 
2.17.1

