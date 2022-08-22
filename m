Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7559B8E0
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Aug 2022 07:53:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MB1kZ4tG1z3c6C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Aug 2022 15:53:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HyZrFAGr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HyZrFAGr;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MB1kM3lglz3bbl
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Aug 2022 15:53:29 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id c24so8481333pgg.11
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=LcNHrnEhxuFZm+K7EEF8OzzvN2HFfZimKpmmavzN8HM=;
        b=HyZrFAGr4rovcGDB38Cq87BHaAK7i7EozVlYc5ZSe3WVF5SbSmB1UYNP7m2/jM6gix
         t+iE76zr1Dwg2h6qNamSJF0tpBmfRxxOm/Sj2wni4lkqIb5itP90/AQ7NsWFeS3AcEWY
         Z9dogkwIzc2GpGe5O+Lr3mOyyfpQy908LVsX00DDjoFLnAkpdVNSZvsVAfXwdLs1GHn3
         4w9i4ZZwElg1yGt0wDZMWjMbHHNGigb97W6N31eoIk4IatVqytejMOULcJo9du91D+Mb
         YcXjMy4jZ8dAaPBDmx700c+amt/cHT+tnJaJxYOOFF/VGb6up8CytAU2QDdUkAuPoHZk
         dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LcNHrnEhxuFZm+K7EEF8OzzvN2HFfZimKpmmavzN8HM=;
        b=CfQPGqtaWmeT8jMLEpLDLQI9O8xvfxKg8PY1GPT0ZEub58PklkjdlhxY9cv3Dvhx0N
         SiFsEyzIRLpaIIA71EnuV7je+lMgh62g7bVWhlBpMN0yPQWfbhyattt9wxaD2YUDRYjv
         HPE/g73ZwTSlbH43PcqgSM54Oqt2vPLzyBXk0cR4rlhpweMxOZY0/pcCI41FMj4k3cfw
         YDfpaKLFHSalZwb0bqH0NKnfVEQoYxooRZtoas8JEckVzEtw/b+oILpyowhAYqw98KLm
         j/QeQYqyvwSQTgQndsxNU0VD9Hoqa5NQE+kqBDVPAYMb3syBpc27w4kYMSu8aWDNWtSP
         qMkg==
X-Gm-Message-State: ACgBeo3IPdcyu5rUqC3tT9crU3HtzrHh1WoUYVLI168e9B6L6/hPOjA2
	1Ax15Wyoi5fAvwnXeGvDdyA=
X-Google-Smtp-Source: AA6agR6T1osXtaulkEyVdRKlQkXIF4y6BvJbde+f0ksLsYhTQiAJw4/8wisjY4GIrZ8y7O9LxqE+jg==
X-Received: by 2002:a63:6e81:0:b0:419:f7b1:4b12 with SMTP id j123-20020a636e81000000b00419f7b14b12mr15579172pgc.406.1661147604728;
        Sun, 21 Aug 2022 22:53:24 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm7078817pjb.46.2022.08.21.22.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:53:24 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH 0/2] erofs: support compressed fragments data
Date: Mon, 22 Aug 2022 13:52:59 +0800
Message-Id: <cover.1661146058.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

mkfs v4: https://lore.kernel.org/all/cover.1661087840.git.huyue2@coolpad.com/

Yue Hu (2):
  erofs: support on-disk offset for shifted decompression
  erofs: add on-disk compressed fragments support

 fs/erofs/decompressor.c | 15 +++++++----
 fs/erofs/erofs_fs.h     | 26 ++++++++++++++-----
 fs/erofs/internal.h     | 16 +++++++++---
 fs/erofs/super.c        |  6 +++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 55 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c         | 40 +++++++++++++++++++++++++++---
 7 files changed, 141 insertions(+), 19 deletions(-)

-- 
2.17.1

