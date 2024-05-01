Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1E8B8441
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 04:16:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fWeX5qHX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTgg63VwDz3cSM
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 12:16:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fWeX5qHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTgfv5Sk5z2xbC
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 12:16:38 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ee0642f718so351698b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1714529794; x=1715134594; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5haz21yR4hpgCaVy10GDfzhYcReI5QYdpnKMGaUSa20=;
        b=fWeX5qHX0YvXqyCHNfsIFcsla8pi640Ib6NSUM4Jg3EpXqHUul44y2QwoDVS5G+ao4
         QnDrOPPxd6/KCgo06u2pnhVOmelZAWGWc4IlLQVqnqmLf9BdhrBYX4n4+auVovvzRSnU
         wA+0226/8pMuTDID+48g748+c4qjwQGbczxdG4x4Z/HY0ILDOmkdO+f088njhiuUbVMP
         M0BhN9ZE+HTPX6Fpp2ACQ9UPaSwOrtNzBMWTiRII6vGDkqIDpPmAKcXKFUtJCO40zA+p
         5utnvxnw2fwaIb3dD3rY3UBS7cRckEteOgHTluAoIrxTuIf/mPL3eppnPZvaATNN6PD9
         OKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714529794; x=1715134594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5haz21yR4hpgCaVy10GDfzhYcReI5QYdpnKMGaUSa20=;
        b=GvLKV+CYA5XxoEWfW76S04L5DVwnKCg5u+BiJuRP5gsZA+fXoRbWjyiftCQjdI3rtu
         2OTNXdA/dp8Tf6cEpbl6u69YcRjelojjHGvOGCAOVykBZMgNMfM/E/xLONgT6Mh84Y9f
         6bAE1bCRmzJ76iLzUjldMoMYn4kGkSaKfSLE8eIuqU5sJBF4s0K+xTHHEenEZFIqZ8EE
         oez7KDldRdhdPX3Gd7mXfm/CcrWkvJR74Qn58J9NpulM18TaQIk8GN10NzSoO8e8jwuv
         WBZ8p8KKJtDdZs/MvqUTojey4SY2G9PV+FQJwzs6scFkYrqirWpEanaovVckFw61UuFw
         UCSQ==
X-Gm-Message-State: AOJu0Yx6czIL91NVmUIEOaEV3gctbmN5/wN0fsOZajXMOdTBPKebHAGj
	Vrv1GcknpOmXFyMI/3nIIa0ajNeylBRsnjh2IAJeaXrjuhmxB7PHQZT0FcKGkPE=
X-Google-Smtp-Source: AGHT+IG1ESpdbGVW8M5nn/Ac1UoX97jTX/cMbe9l2gINS1rxGiDe6u2nL1RxeR3sAAR94NhFMTlepQ==
X-Received: by 2002:a05:6a20:da9d:b0:1a8:2cd1:e493 with SMTP id iy29-20020a056a20da9d00b001a82cd1e493mr2019076pzb.29.1714529793791;
        Tue, 30 Apr 2024 19:16:33 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id b21-20020aa78715000000b006f3f062c4f4sm6382886pfo.136.2024.04.30.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 19:16:33 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: optimize pthread_cond_signal calling
Date: Wed,  1 May 2024 11:16:24 +0900
Message-ID: <20240501021624.1865253-1-asai@sijam.com>
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

Call pthread_cond_signal once per file.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 7fef698..29307a1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1261,8 +1261,9 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 out:
 	cwork->errcode = ret;
 	pthread_mutex_lock(&ictx->mutex);
-	++ictx->nfini;
-	pthread_cond_signal(&ictx->cond);
+	if (++ictx->nfini == ictx->seg_num) {
+		pthread_cond_signal(&ictx->cond);
+	}
 	pthread_mutex_unlock(&ictx->mutex);
 }
 
-- 
2.44.0

