Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F5C8B0175
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 07:59:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=zmdHQExK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPSxl0mRmz3cFN
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 15:59:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=zmdHQExK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPSxf07yBz3bnL
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 15:59:48 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so57682055ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Apr 2024 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713938386; x=1714543186; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqs2qAWLZp5Wa/fhiq/q0lXQfaEzhfUwEe92b8Q9vfU=;
        b=zmdHQExKGUhfnFL+NlCL6zQp+8esywplouz/hts0rflMDBc4HJcshatN0tKFfpCJPp
         j8bkfaqooIGRtbhdUWWDt6M0yKqNiCX5RQn2N/5HWnr326T7jnIE9ymmuJPkkfBvzmlX
         g7itPRCRBN5Z214NXDNNIpnsATtymI0wHKzSkc0XbQDwXkUZnkpNNLFH4dHuS+O9Sqb1
         UAiwdBAi0ejVt5buM8dOp4AHENIrvDZUis5URi+st9pyuQe7RrpLKIxZza+VUFX2MMku
         tm/Ct5vZ2ChN1ABdN5/myZDLabmRv4/2AQ5U5OnOfJI2DKYe8uK3vc9y2iJ+0Rb8seQ8
         9xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713938386; x=1714543186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqs2qAWLZp5Wa/fhiq/q0lXQfaEzhfUwEe92b8Q9vfU=;
        b=cGkhq/van621/xjE9C5wv8NuygK8tjB5RioiOIOE2vwHTnPZ/nV31B1y/QKYpad/om
         1oHjuk6l1dfTQ/NNLF8IV+ynbOi+VW5/o1PRSqvs8J72mWiak7VChuIMTXIsNLoa32/p
         jZsg9LMOF9P0PVOuwUYm9nzVBv0ZAdIrfMscQp4Y8UKqAjsKRWG2unOEAlNomM2AFneB
         O8aBsTm7BvgZdvaEFlrTWtDTMUMK3Y5CkKFRVeXqhgmt1Juz8teurXeh3HhCclA1ojdZ
         WwiwiYZ/IK/UqEoQ8ipM1wMu1xVdtFfRPOuFyS6lP9feKJE8xXlkBFeLRz09jY5/etjv
         64Yw==
X-Gm-Message-State: AOJu0YyTCcD27DSYcKhUM0pV3hxj1hHEV2HIGBZbGAzjZPSeLcsLxDVG
	5P1YgBjp4r9le5m9PPNTpCPLyUsvSKyIi9GAFpO4jFzQr3xNXsD5mnlD8Kaj/NU=
X-Google-Smtp-Source: AGHT+IGi45T/OTHnoOGJnAF9jhd01Yhd9XFF012k174kQtt0xVbllACXP+TnOai4c6Rq9CvG+5tBtg==
X-Received: by 2002:a17:903:2311:b0:1e3:e0ca:d8a3 with SMTP id d17-20020a170903231100b001e3e0cad8a3mr1949099plh.6.1713938385960;
        Tue, 23 Apr 2024 22:59:45 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b001e2a3014541sm11250292pln.190.2024.04.23.22.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:59:45 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: add missing block counting
Date: Wed, 24 Apr 2024 14:59:23 +0900
Message-ID: <20240424055923.107209-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add missing block counting when the data to be inlined is not inlined.

---
v2:
- move from erofs_write_tail_end() to erofs_prepare_tail_block()

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/inode.c b/lib/inode.c
index cf22bbe..9aba69d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -670,6 +670,7 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	} else {
 		inode->lazy_tailblock = true;
 	}
+	inode->u.i_blocks += 1;
 	return 0;
 }
 
-- 
2.44.0

