Return-Path: <linux-erofs+bounces-366-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2DAC38B3
	for <lists+linux-erofs@lfdr.de>; Mon, 26 May 2025 06:33:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5NDX626lz2xjN;
	Mon, 26 May 2025 14:33:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748233996;
	cv=none; b=MzSbHwbOFwBWXNKPOhvMSNSUvKdVJVlSyhI4ZA26iv4tp6+aZ3yULHevMyVUiKl0CGC0QBi15+DEorzZBESuEd6lexCjinDHJbCBrWcvGPhvrmqezqxXqh3ugXSSAVe3ExPttH3LRzCyIX0qD1RCoSBTKI8VFRX16h3wdA7gPwCXJrCX2qoirxXLZ0SGgU+GuzpKK1ygQBXNDCPFsSEzROfF9Ud96cRqGo0WIE/MA/VwkRDnfWtEVoiH78AEgVtLsWeqKsUHCIJMZO1F19aB1hhBkIfqXDim++j8f745ZJ+EG0VyxlsGMNUXTmP6/NetXbHZZtiBJv6HH8ycAe1FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748233996; c=relaxed/relaxed;
	bh=dIb+VM+8m/8MkhIJ5Z2o7uYOl/+6D66WYZwUmQNLNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZckQmGxYhIri3X3VeZAQljwhBQajWBlu+cxEke9hyZU4xM+BKP5HbiXgo/rKkCixhhyktPeBVON+dhz1VqapW69tRI0jipOvDqCTLfq55YDJ+LS0OA8e/6HKYNUWFGEhea2YaTnDG7BXWaOWrGSMwnIXOXir9a/l4/bQrZ2m/QrhdPv2VvLA4lKA2tjjbQ8XQxWgeEMP4Vi+aNegW0pUPFBRcdpUzsmS+4VozWy9I2I/xgkcev0esiDS6+YzF5mcaStg4oTJBjyGMGhJT/PqfSRhe6KymEZUdUGfwPcnTKKiiR75l6eVa7h21zVmJbxtjUZAnkladDUwqcmvWo3U2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p+sUIg6o; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p+sUIg6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b5NDW6MGxz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 May 2025 14:33:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 90AE143CF5;
	Mon, 26 May 2025 04:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38908C4CEE7;
	Mon, 26 May 2025 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748233993;
	bh=vfujHF/QZsbAY6fnZ8+jww7Il9C4bpQWXm3/AJDvH7A=;
	h=Date:From:To:Cc:Subject:From;
	b=p+sUIg6oF6uoDy7lnoT7KDyVlp5gnf6WXQyIu+m5sAP4dK3wP7+K3fEplPRo7fom/
	 MIYmS9usdK26pPu0yk5GeStBUnngVMh9GD10W0e1bB80Dnoo1DDnYr2RkylXgoqhBP
	 qaENmp76urv48UHvBRKcj90TxrM5DqalAffKY+6KmMXRHB85uEh1CiofkPqT0aIf8S
	 Sj1/zU1M3wGFwX2fgbXogpCsXXpg9bOEFkmZ4Iz1u0WhAuAk3DO40cBKtUTzFYN1Bb
	 I71Sk2pcAzoZG3niSrkMNV6jPGj2LKQO0ZPaXeoCVOyVY/mL0kTb6NVQzP5DerqYq9
	 j8dNYccKu2edA==
Date: Mon, 26 May 2025 12:33:02 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Sandeep Dhavale <dhavale@google.com>, Bo Liu <liubo03@inspur.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.16-rc1
Message-ID: <aDPu/jffhb499L49@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Sandeep Dhavale <dhavale@google.com>, Bo Liu <liubo03@inspur.com>,
	Chao Yu <chao@kernel.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider this pull request for 6.16-rc1?

In this cycle, Intel QAT hardware accelerators are supported to improve
DEFLATE decompression performance.  I've also tested it with the enwik9
dataset of 1 MiB pclusters on our Intel Sapphire Rapids bare-metal
server and a PL0 ESSD, and the sequential read performance even
surpasses LZ4 software decompression on this setup.

In addition, a `fsoffset` mount option is introduced for file-backed
mounts to specify the filesystem offset in order to adapt customized
container formats.

There are other improvements and minor cleanups shown as below.  All
commits have been in -next, and no potential merge conflicts are
observed.

Thanks,
Gao Xiang


The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc1

for you to fetch changes up to b4a29efc51461edf1a02e9da656d4480cabd24b0:

  erofs: support DEFLATE decompression by using Intel QAT (2025-05-25 15:27:40 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add a `fsoffset` mount option to specify the filesystem offset;

 - Support Intel QAT accelerators to boost up the DEFLATE algorithm;

 - Initialize per-CPU workers and CPU hotplug hooks lazily to avoid
   unnecessary overhead when EROFS is not mounted;

 - Fix file handle encoding for 64-bit NIDs;

 - Minor cleanups.

----------------------------------------------------------------
Bo Liu (1):
      erofs: support DEFLATE decompression by using Intel QAT

Gao Xiang (2):
      erofs: refine readahead tracepoint
      erofs: clean up erofs_{init,exit}_sysfs()

Hongbo Li (1):
      erofs: fix file handle encoding for 64-bit NIDs

Sandeep Dhavale (1):
      erofs: lazily initialize per-CPU workers and CPU hotplug hooks

Sheng Yong (2):
      erofs: avoid using multiple devices with different type
      erofs: add 'fsoffset' mount option to specify filesystem offset

 Documentation/ABI/testing/sysfs-fs-erofs |   8 ++
 Documentation/filesystems/erofs.rst      |   1 +
 fs/erofs/Kconfig                         |  14 +++
 fs/erofs/Makefile                        |   1 +
 fs/erofs/compress.h                      |  10 ++
 fs/erofs/data.c                          |   5 +-
 fs/erofs/decompressor_crypto.c           | 181 +++++++++++++++++++++++++++++++
 fs/erofs/decompressor_deflate.c          |  20 +++-
 fs/erofs/fileio.c                        |   5 +-
 fs/erofs/internal.h                      |   3 +-
 fs/erofs/super.c                         |  65 +++++++++--
 fs/erofs/sysfs.c                         |  67 ++++++++----
 fs/erofs/zdata.c                         |  79 ++++++++++----
 include/trace/events/erofs.h             |   2 +-
 14 files changed, 397 insertions(+), 64 deletions(-)
 create mode 100644 fs/erofs/decompressor_crypto.c

