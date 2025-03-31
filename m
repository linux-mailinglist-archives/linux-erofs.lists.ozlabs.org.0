Return-Path: <linux-erofs+bounces-129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979ABA75DD7
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:30:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQw8d1k7Kz2xlQ;
	Mon, 31 Mar 2025 13:30:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743388225;
	cv=none; b=hu22KT+5qnLE6cikL6Ts7vof6AQE+GVsCBUBzn4SOGb+XMYFJdxs+DJr38hZ5pU7k0n9SXKqRk+3aYe2p+BvLWwSkDV/yTSbgGFpPWjP13G/f0K3EOFMJDqpj790VuXh7MIuCaI7r7yv1dCLLBbA2I85gJc+JpQoeqowk7pQ1CNgpF+bTEePNy19ZKOROaU8jfxszi9PW5H1Shr7wALVghGLtKUyoHbR4k1+V58EU1ao8kwwk0mWT7U1ckToU4VHK94jtLSBQxP8dyxPxbO/XET3E8xaAAKdFBsCUe8mIrPfmYMLKhbooNHb981DWeZ6csPS6j+fa9767IDUWaDqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743388225; c=relaxed/relaxed;
	bh=cCSIsXsWLh8nLOnVpruJGY2KF/jUdlnjLGWQiptmWYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKSUYWYc4v7M5kTgw9QynYwA65CYbHcaIOSMvKkug9VZ8WDmvOwHhFBVbdJMC0rxWh8iAqd5nRpLgp8ESV0jo11HFzo01c2BSLdKv6zfvuZ6wqi+QX7wihyWoH1yVaGbffwCi5Pr99dljwI5BKG0ZgV8qy9EpvxGICng4jtyPgQFObEZhUqf3qj/Z96XWaXKZbeMW2xq94IjcZpWviKCeaGhnPjrFTXspk0RflND3z4JVoVNiIX1/YuZoX26TXVSQIMAzrDqYWLbpo8rw+xqNtQIznEn3OvJRun2TjZg5xn5JM7PlVoTuaubZNsD1kVffeuRFhb8co00PsXd7S57yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XKisMETt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XKisMETt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQw8b6T7wz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:30:23 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-227c7e57da2so60441155ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743388221; x=1743993021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCSIsXsWLh8nLOnVpruJGY2KF/jUdlnjLGWQiptmWYQ=;
        b=XKisMETt1wheceueXOl8IEHeEh4rWZ+r1x283OlIfh5C7mkCszzZA69OejNeBZ4vxU
         E2HwYQzELNcb0PkDVP7t7UFvBH0XJ/N9uSE6BzSvZQm6FE/C157kqmlPhTAJwfi0Gcmg
         9fQ5IP+9SmyFq/cVEONoDlkTGwI8/sR1C0gzjFnvZL26KAcEvNqtFhY7yUhmU52rA63E
         7WLvNiIitEGKASf+WXBFiIuiNRCZijGM+jM3D4lBc+PVuubDxurFUwdf7y7/sAxudmbZ
         X0k+YIVxhI35nz84kKZ1uj2Hx0oXPDjsLbfEq2FDUDNEZvmDHL1XwVOvT4cPwIS7nOiF
         J8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743388221; x=1743993021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCSIsXsWLh8nLOnVpruJGY2KF/jUdlnjLGWQiptmWYQ=;
        b=EcSEXZ/frCxKRWPkVEgNUqWPUz1xpieMcp0llsE5W3BVTVUSH1jbko8cO13l03538x
         J373f/LTFnEgtcP9vPPja64LgoMAl3cEefc5KEQNnM9VQnQtxTYHJ2hlf423lTO5cvdd
         yB/+R6tKFODrpGdtzys598ZQ4X4ijTOI42Ep2juyMnZxOFUxG4BMpy+7UmZP3kznarDH
         YJkOUmA+RVV/S1jGqr6u/5+mLBWpJ/z6+Pc2h3OoAgu/vO6/hBrDwCS3XFWjkP+7hhiX
         RRveVwkO6f4sbQSUaG1YaGnY3AoHabpRDLSyCe5QDS/P+9T7rf1Ix+GnNaXpOigv4NYq
         vONg==
X-Forwarded-Encrypted: i=1; AJvYcCVUk0E/IFZ8CdUa8K8fflhhunB4yDD8TDLxiBx0l2LGKvMiVZUFE0Dve+MVw5Mw8WGSj18cJBkvO02GYA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGgieTHUSwlprImUq+t9B3AoqpmwxreVViXk1Tdsk1aUyR/g3E
	e/Z1SSJ/cYw7xsN2lYVo1KgaCYEPmjJukUtNLWOW2XQGa55tIBz1
X-Gm-Gg: ASbGncvvd4OCjWSZiz27mMEMsWJ+ghTSZ0NwwFErkGL+fuiMObN5XKYf1W5X0jQICgE
	VS+R9Dgrx6xCvJOs+rtb0KwlhyCzskGu3PpbV30SQEsS6LwvvznVXPvx0FlQKJ90xZGtX2IGPcL
	12UHjiA6j+da5YZuwZbECCCwIr5z5fqIrHwHRTBErV/8HxzNPHKyrihpbeHJwZkg7wSUlJ4CWB9
	c2ax4F7NI3j7qPqFzqSEoEySePuu/CXHKpRxd6u8gHZu8+SvvdJz/Iu+JsvYw3xXpfh5QBwxoSN
	VM8fIB6ZcHxt0aI2k+5OgEvkRgmMWiNp/IQPlZAGlLSI7qOtHdE=
X-Google-Smtp-Source: AGHT+IGNs2fWsfpwW0vdCBT5zu4Jyegp6G1yGKg40tJ6xfLop3eW3mnK0b13Tsv2M7JNc4DzYZQm4A==
X-Received: by 2002:a17:902:d507:b0:216:794f:6d7d with SMTP id d9443c01a7336-2292fa058c5mr133439465ad.48.1743388221122;
        Sun, 30 Mar 2025 19:30:21 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71cfsm59455955ad.45.2025.03.30.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 19:30:20 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	wangshuai12@xiaomi.com,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v2 1/2] erofs: set error to bio if file-backed IO fails
Date: Mon, 31 Mar 2025 10:29:37 +0800
Message-ID: <20250331022938.4090283-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

If a file-backed IO fails before submitting the bio to the lower
filesystem, an error is returned, but the bio->bi_status is not
marked as an error. However, the error information should be passed
to the end_io handler. Otherwise, the IO request will be treated as
successful.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/erofs/fileio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index bec4b56b3826..4fa0a0121288 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -32,6 +32,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		ret = 0;
 	}
 	if (rq->bio.bi_end_io) {
+		if (ret < 0 && !rq->bio.bi_status)
+			rq->bio.bi_status = errno_to_blk_status(ret);
 		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
-- 
2.43.0


