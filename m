Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D46808B009B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 06:34:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AVdBskLN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPR3d3jLKz3cLL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 14:34:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AVdBskLN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPR3W28Mvz2ykn
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 14:34:47 +1000 (AEST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3c74abe247bso2118661b6e.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Apr 2024 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713933283; x=1714538083; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WanqcPdj0b+2wTBEDuxwVutyNWhiV6rbLHSYnXBdLNY=;
        b=AVdBskLNc0O4bisSfxHnfJr1uSLayLqVeHuYzt7qymRgJ6fbLSzpXjiJZOB+l+l2JY
         fPy7mj1mRLd0q5J+plBs/2PXCOIrDyanV6eKtUdwSWo/I1j3KoXaMDAwceNTRtSsvagl
         STtn0cSWyxymQUfhn8sYAUrP6vKNIAiOdPAO8qiNBai/n5u/QupqxyeJV4HihJ9d/oWp
         lYuUhz8cWyBnFGViOB70Pv2tdKe603/fDzrDqJBFj/C8nVSwXdvGNyFn14+SBOukMpfO
         XlP/4a4btPR6RnseMHv5QDpRJ6WPtc4YWEBoe09qrGENlLxq6GoTBgpDQmlC9loBJE4C
         15sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933283; x=1714538083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WanqcPdj0b+2wTBEDuxwVutyNWhiV6rbLHSYnXBdLNY=;
        b=ugbDIhZbJNTWthBxtjNENJFWLjSDdmsLG4XPinZpINBfepYKP4nObX8tuwxM4ZZa/+
         nw8nmauWzW8ueCITL2kVPGKZBGk9dyszf/XJgvdKDQEqQ/6ajhEX+NIPhjMkUGXkDW0r
         c6IbBnk7qXxserR5NSsaeYU/seoVAB8e2ni18bZSBK1yvkN09kn/YXhBwlq+ZS878pHw
         L1i6knTjfc8derNT3iw9Zmjn4my7Ybn3V1A9SUmWhcWFw2xmHRSF3QG5CZTJOXFqLvFV
         UAaf2emWrgjtzQwdm41tq2MGPZGw/5t/uq4lBxQSS2DFRilw8DK7O5me2G4TpD5ytc3k
         TdVA==
X-Gm-Message-State: AOJu0Yw9lYH7ssJTqi9lIGw0dkvFwB1JHo10ERJhlOqCoTFifYciDMMx
	dagfRWKPVb88F7kVaM4CxFqRvHh+OwEag48O9dv5QogGRJ6UtXZRr+yq6pCLHf8=
X-Google-Smtp-Source: AGHT+IG495kMC3zMakxf7K/eu3imdsvQFZhxn1UgM/0PJc27yQAOjPnPQCUtB96cvYgHjfjYvqU2aw==
X-Received: by 2002:a05:6808:686:b0:3c8:3771:6cdc with SMTP id k6-20020a056808068600b003c837716cdcmr1192167oig.45.1713933282921;
        Tue, 23 Apr 2024 21:34:42 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id b186-20020a62cfc3000000b006ecf56cb55fsm11204836pfg.96.2024.04.23.21.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 21:34:42 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: add missing block counting
Date: Wed, 24 Apr 2024 13:34:13 +0900
Message-ID: <20240424043413.90179-1-asai@sijam.com>
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

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/inode.c b/lib/inode.c
index cf22bbe..727dcee 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -840,6 +840,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
+		inode->u.i_blocks += 1;
 
 		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos));
 	}
-- 
2.44.0

