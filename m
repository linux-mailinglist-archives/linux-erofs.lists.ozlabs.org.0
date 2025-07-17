Return-Path: <linux-erofs+bounces-658-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0BB08616
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 09:08:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjPCW0mrjz2yPd;
	Thu, 17 Jul 2025 17:08:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752736103;
	cv=none; b=mU1mJXpyx6fPdMSkbKgWdcyUaCox33DLbSteKdfJ73rhtJckbJHTmTI5cHH6Y2w+ZvWOyHvt4lH8CVCbBDwGLcorbdwdLqShzNSaQXYEWv4s7wdBZUDvT3NFZHq9eOL+3DQ16vZbxoXahI1naL/XSa/sCMoQLgjFwpNKM+qkYbTaRXMtvf3X1SwmXU1SeqVzbo4j8DGE3yflo2F7HRW3jNSuksxmcGzxOOdVFJNJp5tZ6DJuDdKwYboA3SBmFUW6i31LPy/WA+U0+W9mH3l7ProAMB0lbyiKi2qdUBWrrj3PlXhlrOaUVHUqVAl9ilGD9O9hsMCh6hd5ID/mActarw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752736103; c=relaxed/relaxed;
	bh=tFm3HVr9LftpPFBNavNi/pytruj+9SyiAteNScDIPgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WowYxSVsPQahrkVlW+bybdzMzyNk50oww3QNFnTyn+qEdzKCsvR+0yjexfPOG9KMm2XtbNqPMxzrRDUTBGsunFt+Ms4oozYM76tb/FijUVJIhAF7OaeCOHsQkru9CVWc9JxT91y4sxWhDH3vUSAjquk3viKPjERRBUjorFdZLdW2Q/j4YaLKbixLuG4KqUFHqewhpzc1ovfKVMlWN2rsCBha4iTxsGpcCxRZR8VVuBQQveiCDJ/NowmOiMUZkONqt8LqrY8XmxVJ17cIBNK43QESBzWgigsLq49l/4EFth5d4hmWG7aFSzjbu09nic44Rfg8ScdGKkeeNBW//+BTJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGNij4k1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGNij4k1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjPCT0j4Bz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 17:08:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752736095; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tFm3HVr9LftpPFBNavNi/pytruj+9SyiAteNScDIPgs=;
	b=SGNij4k1Bvs8UAydW1ujNkPYOh4+nosU1qhcTfAs/oDgD7Uim0MzgDa2j0Hg4m0xMucCTjAKg4E8+zdrurLKB9U6uoshHzGpFIua4tX9NKPmKC3fBfXH1ro90B4tWEpq+crNJlFQVEDDSceLiEJdfxnCFcvKxer2BCGv55+Guz8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj791iq_1752736085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 15:08:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 0/3] erofs: support metadata compression
Date: Thu, 17 Jul 2025 15:08:02 +0800
Message-ID: <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

This patchset implements metadata compression since many users are
interested in smaller image sizes (even at the cost of some I/O
latency).

In short, it uses a special "metabox" inode to gather all inode
metadata and then compresses it.  Since EROFS supports multiple
algorithms, you can select a faster algorithm (e.g., LZ4) from
the one used for data compression (e.g., LZMA).

Also see the detailed commit messages for more details.

Here are some preliminary numbers:

Command line: -zlzma,6 -Efragments,ztailpacking -C1048576

  ______________________________________________________________
 |         |_______ Vanilla _______|___ 2554769408 (2437MiB) ___|
 | Fedora  |_______ `-m4096` ______|___ 2524504064 (2408MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|___ 2527326208 (2411MiB) ___|
 |         |_______ Vanilla _______|____ 378634240 ( 362MiB) ___|
 |  AOSP   |_______ `-m4096` ______|____ 377856000 ( 361MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|____ 377942016 ( 361MiB) ___|
 |         |_______ Vanilla _______|______ 4837376 (4724KiB) ___|
 | OpenWRT |_______ `-m4096` ______|______ 4734976 (4624KiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|______ 4747264 (4636KiB) ___|

[ Note: directory data is still left uncompressed by `mkfs.erofs` so
        the final image sizes can be further smaller.  Directory data
        is just like regular data, which only needs some userspace work
        so let's address it later. ]

Thanks,
Gao Xiang

v3/4: https://lore.kernel.org/r/20250716173314.308744-1-hsiangkao@linux.alibaba.com 
Changes since v4:
 - address build failure (https://lore.kernel.org/r/202507170548.rvm67YSU-lkp@intel.com);
 - address build failure (https://lore.kernel.org/r/202507170506.Wzz1lR5I-lkp@intel.com).

Bo Liu (1):
  erofs: implement metadata compression

Gao Xiang (1):
  erofs: add on-disk definition for metadata compression

 Documentation/ABI/testing/sysfs-fs-erofs |  2 +-
 fs/erofs/data.c                          | 59 +++++++++++++++---------
 fs/erofs/decompressor.c                  |  2 +-
 fs/erofs/erofs_fs.h                      | 15 ++++--
 fs/erofs/fileio.c                        |  2 +-
 fs/erofs/fscache.c                       |  3 +-
 fs/erofs/inode.c                         |  5 +-
 fs/erofs/internal.h                      | 19 ++++++--
 fs/erofs/super.c                         | 22 ++++++++-
 fs/erofs/sysfs.c                         |  2 +
 fs/erofs/xattr.c                         | 26 +++++++----
 fs/erofs/zdata.c                         |  5 +-
 fs/erofs/zmap.c                          | 16 ++++---
 13 files changed, 123 insertions(+), 55 deletions(-)

-- 
2.43.5


