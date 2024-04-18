Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3588A8FC3
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 02:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713398469;
	bh=VxC5jxhKrCityl/AkBM42Nv0lXHF7RQqmrz5UVWtpE4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=nM/sfNATw3dBNPDSW56sI9Wr/0QSsM+fA/nw+zxQnhlja8Rt9H6wBe9q+3ytLVqeQ
	 Czc+l+0rZ7ygM7chPP0oV6UC4MQK4cU3+i8p7TpQpHcoKbw0c16XliuAav2jvrsnBF
	 GZ5ca5NI32Ol8/WK7ArBTqoTrZ3MqGujgzSouXyq1P7gISrD4MFAuwxdT09S+F6k9/
	 7LCT3kOsNcmdZN/339dkYkzKyZSHPEKo34Q+3/7cD/7c66b3F1byQnvxrRvyv+qxUn
	 xgRIIm2nikAm/2OfX8ArO673hRMJ+g1yS7E1w9hZyT/c4MqgKy3G/yesMDQdI4ukT1
	 WbC+id2Ve6igg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKdGY6PDzz3cRB
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 10:01:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=3N+tTi1v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3uwigzgckczgxbupufyaiiafy.wigfchor-ylizmfcmnm.itfuvm.ila@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKdGQ0yyqz3bs0
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 10:01:00 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so575580276.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 17:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398457; x=1714003257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxC5jxhKrCityl/AkBM42Nv0lXHF7RQqmrz5UVWtpE4=;
        b=G5ETNCC4Y+SIz+BReXs2YUVivnpt9qoeGLjg2mF1AifTw/PrYINQN/8OhIBvxXrnje
         2OO906Bv7UFHSAbeTJ1I92+96uEiyU93HXk2RU+uvhXFxQk5WJ30A65cgEvu18SftfVy
         bJHZoDlZ1Jo/ilJ+kvX5SzgxdBn4FvHVkzxcdFhynN24nnInB1i9pWLUyqtLF43i0OzJ
         1jURvPpbZvGxxDJak7S7sYR/s32s4tyGuQrQ6zdchI8Gr9Jed35HXxJ1Xqhh3OsNifiM
         MZYK1Kw34pLyyIOzsZtsSEBWDVAvsDeSTtVPSyDuE0Vn60GYsVnuv4GYYLXV2WPoHfSY
         VOGw==
X-Gm-Message-State: AOJu0Yw2sRiXtv+AL8n7rVu6mXrXPGnlJh/xIfbFHyHf1pLBHGanjPCH
	hMS0FDhMNWHHTG48c2j5DtkmNO7R1WWh4TfQAK24zm830MS5FbWSdVKU88l7WRmkJnC46e07Vqg
	JjIlBUcSbSNR/Pe4F2J9SgI2/l42eL2lGhec3pJ9PemP8r5k7D5qLqAz3apThmq9KBqZkeQoYKS
	6zbXn7dwFIr2kuTFnJ7o/2OpgTcrb2jkuUWfP6xC3l9uMVew==
X-Google-Smtp-Source: AGHT+IHzgxK1Zzpcu3D8uyMwjQqFbVFYiS4SNtW+8RLyVzYX35Ojjo7wPAM61TS48bX/VjEymV+Lf3QjLA5x
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:75ed:d8bf:5101:cbc8])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1005:b0:dcb:fb69:eadc with SMTP
 id w5-20020a056902100500b00dcbfb69eadcmr122680ybt.6.1713398457548; Wed, 17
 Apr 2024 17:00:57 -0700 (PDT)
Date: Wed, 17 Apr 2024 17:00:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418000054.2769023-1-dhavale@google.com>
Subject: [PATCH v3] erofs-utils: dump: print filesystem blocksize
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

mkfs.erofs supports creating filesystem images with different
blocksizes. Add filesystem blocksize in super block dump so
its easier to inspect the filesystem.

The field is added after FS magic, so the output now looks like:

Filesystem magic number:                      0xE0F5E1E2
Filesystem blocksize:                         65536
Filesystem blocks:                            21
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       10
Filesystem created:                           Wed Apr 17 16:53:10 2024
Filesystem features:                          sb_csum mtime 0padding
Filesystem UUID:                              e66f6dd1-6882-48c3-9770-fee7c4841a93

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v2:
	- Use %u to print the FS blocksize as we don't expect it to be
	  very large as suggested by Gao
Changes since v1:
	- Moved the field after FS magic as suggested by Gao
 dump/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index a89fc6b..dd2c620 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -633,6 +633,8 @@ static void erofsdump_show_superblock(void)
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
+	fprintf(stdout, "Filesystem blocksize:                         %u\n",
+			erofs_blksiz(&sbi));
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
 			sbi.total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-- 
2.44.0.683.g7961c838ac-goog

