Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9B77A6EA
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Aug 2023 16:27:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OvYEl9eR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RP0H738vYz2ys8
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 00:27:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OvYEl9eR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::134; helo=mail-il1-x134.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RP0H269wdz2y1d
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 00:27:24 +1000 (AEST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3490cce329bso8141185ab.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 13 Aug 2023 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691936839; x=1692541639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LTkTYG2V7V+b/XJGrS5FjZaEUNwdXXPW8dIYQ+5i7g=;
        b=OvYEl9eRsMW34XwD8LzRf6sWxh0Bz+FGRcwLZ7VsyynHiM2YEmXzHqJz/eIoQCntQ6
         kOToaBlHMmL4jY0YT4G92MbR7hl7jgx/vJzsk8tosDjReYBLX807bbJg5McpAsV3SXWd
         FK9KxldwSl4hUhsyZw8hnPFnnzwfhier9cr9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936839; x=1692541639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LTkTYG2V7V+b/XJGrS5FjZaEUNwdXXPW8dIYQ+5i7g=;
        b=JDD43nOPPbCtkscBcvZyp1gtpMvJBLczpAimnEgLcun8mlMlk2OmpmSko1/gbyE6BB
         4Eg+VFsZNkBotkPRcgocBowzHeCNMRw2v0fxD6+dQEt+kRS0R3UhOrHzSfqXnbWfNwbO
         hd0lWpTF9h+TqtsKjlW1Fxt2DJnBGqFj4m7IOKUvbV8+u3x0qBMMdU9THq+zJGn/TOz8
         xXx6smlIDIlbN/lJiozT0Fk5V6Lv1rrFiWiOvGbpC1INs+/x2MGt9EsGLlIQp+qSsTWq
         rNuNdv1w3s9h7YLH9CLUXDk1s63dVlN2YrWEh1nsZkDl1x92GC+QiDdeJYSWQHWcet5U
         bnjw==
X-Gm-Message-State: AOJu0Yzy+56wmTVJKiHm274ekxT85j4pOOlj659ujQUqsERcNnlPqb3t
	7Ab1ybopLo0oi7JXp5A8jY+cTg==
X-Google-Smtp-Source: AGHT+IE2I+zPO+NcmP+2OWQP6eHhowhjF1Wna3VKls0yj7SVnk718cfnowrtu6RoIjrP+2KSyuqHig==
X-Received: by 2002:a05:6e02:1a82:b0:349:9328:6554 with SMTP id k2-20020a056e021a8200b0034993286554mr11496520ilv.16.1691936839053;
        Sun, 13 Aug 2023 07:27:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id w7-20020a02cf87000000b00430cf006d9bsm2280952jar.30.2023.08.13.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:27:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 00/24] bootstd: Support ChromiumOS better
Date: Sun, 13 Aug 2023 08:26:28 -0600
Message-ID: <20230813142708.361456-1-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
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
Cc: Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Jose Marinho <jose.marinho@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Joshua Watt <jpewhacker@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, linux-erofs@lists.ozlabs.org, Pavel Herrmann <morpheus.ibis@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This updates the ChromiumOS bootmeth to detect multiple kernel partitions
on a disk.

It also includes minor code improvements to the partition drivers,
including accessors for the optional fields.

This series also includes some other related tweaks in testing.

It is available at u-boot-dm/methb-working


Simon Glass (24):
  part: Use desc instead of dev_desc
  part: amiga: Use desc instead of dev_desc
  part: dos: Use desc instead of dev_desc
  part: efi: Use desc instead of dev_desc
  part: iso: Use desc instead of dev_desc
  part: nac: Use desc instead of dev_desc
  part: Add comments for static functions
  part: Add accessors for struct disk_partition uuid
  part: Add accessors for struct disk_partition type_uuid
  part: Add an accessor for struct disk_partition sys_ind
  part: efi: Add debugging for the signature check
  fs/erofs: Quieten test for filesystem presence
  dm: core: Correct error handling when event fails
  uuid: Move function comments to header file
  sandbox: Add a way to access persistent test files
  test: Move 1MB.fat32.img and 2MB.ext2.img
  bootflow: Show an empty filename when there is none
  bootstd: test: Allow binding and using any mmc device
  bootstd: Add a test for bootmeth_cros
  part: Add a fallback for part_get_bootable()
  bootstd: Support bootmeths which can scan any partition
  uuid: Add ChromiumOS partition types
  bootstd: cros: Allow detection of any kernel partition
  CI: Add ChromiumOS utilities

 arch/sandbox/cpu/os.c      |  24 ++++
 arch/sandbox/dts/test.dts  |   9 ++
 boot/Kconfig               |   2 +
 boot/bootdev-uclass.c      |  24 +++-
 boot/bootmeth_cros.c       |  48 ++++---
 cmd/bootflow.c             |   2 +-
 cmd/gpt.c                  |  10 +-
 configs/snow_defconfig     |   1 +
 disk/part.c                | 226 +++++++++++++++--------------
 disk/part_amiga.c          |  34 ++---
 disk/part_dos.c            |  78 +++++-----
 disk/part_efi.c            | 281 +++++++++++++++++++------------------
 disk/part_iso.c            |  52 +++----
 disk/part_mac.c            |  59 ++++----
 doc/develop/bootstd.rst    |  11 +-
 drivers/core/device.c      |   3 +-
 fs/erofs/super.c           |   4 +-
 fs/fat/fat.c               |   4 +-
 include/bootmeth.h         |   3 +
 include/os.h               |  10 ++
 include/part.h             | 215 ++++++++++++++++++----------
 include/part_efi.h         |  14 ++
 include/uuid.h             |  94 +++++++++++++
 lib/uuid.c                 |  93 +-----------
 test/boot/bootflow.c       |  80 ++++++++---
 test/dm/host.c             |  44 +++---
 test/py/tests/fs_helper.py |   6 +-
 test/py/tests/test_ut.py   | 148 ++++++++++++++++++-
 tools/docker/Dockerfile    |   3 +
 29 files changed, 982 insertions(+), 600 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog

