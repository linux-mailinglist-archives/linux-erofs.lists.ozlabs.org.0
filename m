Return-Path: <linux-erofs+bounces-35-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3BFA59058
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1Y0q8Lz2ykX;
	Mon, 10 Mar 2025 20:55:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600513;
	cv=none; b=DhBG8+rJyJlRqZxb9BXKfSvFsmoxH+3FN0W2n7P5QzXJHSgy4t+ynH7kSVDyioEL5GnT+5a/YDuIY40RfYxUNiBbZe+dakjRb8kPAGYtvjAZVA/fr+8FQnUzer8DS/LeWOqkywW4MqG4nBI5CvYGeHPoyk1ZKSbfzRzjfFDJam6AXYEIyKDctOrUyhQ7VX+GWuT6iqHGtqJ+nzYFqG3Uw587PfHN2Ppoza6BgKwUTvmhXvY9fkyB7FJtrka60wM+Txebt5KlR7BZ5wnU972D70msjDNV28Z5HHfwPQrGeYR/7hdvR+hpM5uURWEZawpyksgTWLzLfiijiwvRvuq2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600513; c=relaxed/relaxed;
	bh=bZhSrM1L07Py6ctqUAfultvaxatD2fvpBC6cnUPSk6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j00C4/YouA4b/PMKUkOgxFNjry8WuBomN+rBr6rfUa0KvmzGVO83FncIUOvrvBmovZR0GKwvmiI9vtCl0/atp2KF6R/WaZeca9OLQxQfrMSRNgRcNsPAQYJ5rwWFXCtoYsTsixoPufqSH/T4E46z2tb8fd8Z5AH32u/gBMEH0MQ/I5mrvF67XgMN7gQuM90Dtkufz2lSL1ZEkIztaU3p/CLJm/xRSgQ2UrkA764QyVq4PtO0Kev9nlHPJaYHyr4w25mprErlCwEHAm9pQALOmLvHZnmLwsGdKCEnyJB9H1Py/XKZv3qVPAegWQ1EFrEVAybz4oU5MLUk/J1/Ib5ppQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sw4UfiZW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sw4UfiZW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1V0TRfz305P
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600505; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bZhSrM1L07Py6ctqUAfultvaxatD2fvpBC6cnUPSk6Y=;
	b=Sw4UfiZWL7wKgsf6efS1gpIOePdQxaNwZtQCkm4jvW+mHc49LGM11uKTeW36d4gI0BfVfLkLA+TX3hnX1D/50VKjiuigasgrQVbURKzwruJSq49YMhx6MY1iX9IJi+JVEvDNg8xVLWq4CDeuEFJxsNJppX6gpGH1BPZ+4OyDrqo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3up_1741600500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 00/10] erofs: 48-bit layout support
Date: Mon, 10 Mar 2025 17:54:50 +0800
Message-ID: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Hi folks,

The current 32-bit block addressing limits EROFS to a 16TiB maximum
volume size with 4KiB blocks.  However, several new use cases now
require larger capacity support:
 - Massive datasets for model training to boost random sampling
   performance for each epoch;
 - Object storage clients using EROFS direct passthrough.

This extends core on-disk structures to support 48-bit block addressing,
such as inodes, device slots, and inode chunks.

In addition, it introduces an mtime field to 32-byte compact inodes for
basic timestamp support, as well as expands the superblock root NID to
an 8-byte rootnid_8b for out-of-place update incremental builds.

In order to support larger images beyond 32-bit block addressing and
efficient indexing of large compression units for compressed data, and
to better support popular compression algorithms (mainly Zstd) that
still lack native fixed-sized output compression support, introduce
byte-oriented encoded extents, so that these compressors are allowed
to retain their current methods.

Therefore, it speeds up Zstd image building a lot by using:
Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
Dataset: enwik9
Build time Size Type Command Line
3m52.339s 266653696 FO -C524288 -zzstd,22
3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22

It has been stress-tested on my local setup for a while without any
strange happens.

Thanks,
Gao Xiang

Gao Xiang (10):
  erofs: get rid of erofs_map_blocks_flatmode()
  erofs: simplify erofs_{read,fill}_inode()
  erofs: add 48-bit block addressing on-disk support
  erofs: implement 48-bit block addressing for unencoded inodes
  erofs: support dot-omitted directories
  erofs: initialize decompression early
  erofs: add encoded extent on-disk definition
  erofs: implement encoded extent metadata
  erofs: support unaligned encoded data
  erofs: enable 48-bit layout support

 fs/erofs/Kconfig             |  14 +--
 fs/erofs/data.c              | 133 +++++++++++-------------
 fs/erofs/decompressor.c      |   2 +-
 fs/erofs/dir.c               |   7 +-
 fs/erofs/erofs_fs.h          | 191 ++++++++++++++++-------------------
 fs/erofs/inode.c             | 126 +++++++++++------------
 fs/erofs/internal.h          |  30 +++---
 fs/erofs/super.c             |  49 ++++-----
 fs/erofs/sysfs.c             |   2 +
 fs/erofs/zdata.c             |  96 +++++++++---------
 fs/erofs/zmap.c              | 166 +++++++++++++++++++++++++-----
 include/trace/events/erofs.h |   2 +-
 12 files changed, 455 insertions(+), 363 deletions(-)

-- 
2.43.5


