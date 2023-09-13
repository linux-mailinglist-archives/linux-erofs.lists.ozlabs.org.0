Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AED79F4C0
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643084;
	bh=ua4m9TKUideDxIDrPoqZ00Kb+iGg2luSneYjcSm4H4A=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=m8C6EKUF49VG4G9Yz6cGN7VmsdxwTE+wdakIpSmsIlgxnCTM9hUx9ejgshUbaoCxH
	 aTOShKXigzkS/9x9zkWEVjvAb061dvwT0KqN/3ZfU59N1fUP1lpwUj/6aTJbkUBtfe
	 NKlZCG3/lSt0Ue+dXM8IuOK7pTYY+x3WmzDkWzivM1C4lxBYJAxGmNGNoRAfTfIBJV
	 b5Py/sokbsASRHq4/oQFP/rCAOHx8AECouBu0S9cdxDJd7lHUTKcX5NrBlyNm4GcpT
	 5Bf1a/rRDpYFoYsLIuUMCjQYxTwVYpOzlB85xzQ9rjPELvLIo2h0MBTjX454mUdr4n
	 KLFWYLEMHkvBg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF643ml3z3byh
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=GnvjUD0b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3htmczqckcyqdhavalegoogle.comlinux-erofslists.ozlabs.org@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF616n4lz2xdT
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:20 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-577c25cda99so174316a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643078; x=1695247878;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ua4m9TKUideDxIDrPoqZ00Kb+iGg2luSneYjcSm4H4A=;
        b=Xpuz1d3ws2w05bW/IJ3ridc9SYt1fYVSgQtVgNG4nSWPWGxwT5oW60yLc3rn9Gs+UW
         ZWNHRm8dKko3VPB+HJFQkPC+PdFtR46wXO2HYdS5TiwQaimwC0aB8hmkmXTihjwv40qQ
         1uNmwj7iTxn6tlhGfcJqmuqpA5RTAW5yoVDPOIgU5yDj/9ZicnOCJ4mlUYOfk8q90WTt
         Ilq3msKhJf7Vuv/cTOrwnfJe1gD/W6LNfzOUd7SSWsn1wmuDa6dts3rm8qncSMBWAuNs
         qxFreSmTAFJreVpkAXccYuBoc3gsLb/eGKyFoRuI/5XxEGJfFeIF03EEJNfOu4bNeuLb
         vyYA==
X-Gm-Message-State: AOJu0YwHOEo1sj8RlYgg3BOInE7WnQEvgLCvKk7UOl8b/3w3s6hnAesl
	oVNPWeuT7VDZUQWL/Mu6jxu6bDwLL1Fs92zpNPwz9x6SHweoLQ8IikR0qFLMJwJezMeG+zi/qO3
	/BoMwViyI70ODjhVYhNlQGDSIdZ3Hg+ybVV6X1f8CqNB1tx3oXGaSEwJCTarTvuimL4ttlPj7
X-Google-Smtp-Source: AGHT+IELzv9ozr6EzSKiM8QLJC35TO41AhzSSLArHn1n/DvOWEXTbfRD8jDOpy4STGbbT+ytN5b/29DrpkYI
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:3d4c:0:b0:56a:36ac:3238 with SMTP id
 k73-20020a633d4c000000b0056a36ac3238mr97372pga.5.1694643077666; Wed, 13 Sep
 2023 15:11:17 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:10:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-1-dhavale@google.com>
Subject: [PATCH v1 0/7] Misc fixes in erofs-utils
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
Below series contains few small misc fixes found after running through clang
static checker.

Sandeep Dhavale (7):
  erofs-utils: fsck: Fix potential memory leak in error path
  erofs-utils: lib: Remove redundant line to get padding
  erofs-utils: lib: Fix memory leak if __erofs_battach() fails
  erofs-utils: lib: Check for error from z_erofs_pack_file_from_fd()
  erofs-utils: lib: Fix the memory leak in error path
  erofs-utils: lib: Remove redundant assignment
  erofs-utils: lib: tar: Initialize the variable to avoid using garbage
    value

 fsck/main.c      | 4 +++-
 lib/blobchunk.c  | 1 -
 lib/cache.c      | 4 +++-
 lib/compress.c   | 2 ++
 lib/decompress.c | 4 +++-
 lib/namei.c      | 1 -
 lib/tar.c        | 2 +-
 7 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

