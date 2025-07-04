Return-Path: <linux-erofs+bounces-509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE8AF89D5
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:45:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfk5bJNz30Tf;
	Fri,  4 Jul 2025 17:45:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615150;
	cv=none; b=jm1pEEoXOXUYSs7LnzNES1FEM70WtW3IsYdD0T70uTirjtyDxmTJ3oGlDSm01B0iydHBRiliDEFhkDPdONqHdE3c1bUgeoM/0DMWdyOzt8NyTe4PfXgXLq9OkkH8i0xMzVubKkmjUuVNhJo0//51K9ktWS42LX6cDNmDc5fcazmDHk9hfVQwq8Vdjc4iMdD6bw62m7YCcpZff0fXcSeiTMCaK62yf4hDjlxvxl3+GKI9Vu63bw9mY51KWgI7jwSxEQQ8ufUvegY9hkU+ahICuHLDDN02ulhlODsvU3AH2oxX502GFwWrUhUHc3298QCqqCrciPJEN0HFadT1XQA7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615150; c=relaxed/relaxed;
	bh=B4+UQxwi03SRVIVJ7txhWJy+yOx9/nlzHfjuvkk5PdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pl7AnCv3DEvGuDrTqjvnQq/EqsHDH9vWZmqaLouVGSQJpVt/d/zM6NkvJkCcvXX5hJPerszETD0JrU9upPRMdlmqh4Gptl/YGlB2YwUBiy77K718rE1AM5hf1Bcwd/sRQQd5Ll8X3v377T+Xz2c9hqU41/5GLE5OomzM+Yxn92RV349tKClO0FCaRoFnpXDXmcSU4trvS4oVeLTinf6FBtuydEC04ddKagk/jtnQrofsLAyXyNaDICFY6efDkp86f1W7uGWgrEAAxaYogWAXUApIos7IKdjMeAMiOzy5HBGXgkVDO2pcu0OBdcSn3rGkhev2feZTbAylpMxZKp5RoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AmG0rM91; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AmG0rM91;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfh3Qdqz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:47 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615142; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=B4+UQxwi03SRVIVJ7txhWJy+yOx9/nlzHfjuvkk5PdA=;
	b=AmG0rM91631oBZglo49Qiwqi3HokeY5QgA94rA1XXWjsgrjC1DtZsHt1LWCfziGvJawDFKXzQoBhoRvaEFAAYzXeeUlAGM5TqPFc6Bftrrkm9YekZbdIJv14itvZ5+KdFLfdo29sAQM3Gd9/KjG/1tRqDblwOVxD0YImsDuh0ms=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC77x_1751615136 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 0/9] erofs-utils: 48-bit layout support
Date: Fri,  4 Jul 2025 15:45:26 +0800
Message-ID: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I think erofs-utils 1.8.x development should have been restrained.

I rebased this patchset for the formal erofs-utils 1.9 cycle and will
be merged into -dev branch.

Changes since v2:
 - Mainly random rebasing due to 1.8.x changes.

Gao Xiang (9):
  erofs-utils: lib: simplify tail inline pcluster handling
  erofs-utils: lib: clean up header parsing for ztailpacking and
    fragments
  erofs-utils: get rid of NULL_ADDR{,_UL}
  erofs-utils: lib: sync up with the 48-bit kernel erofs_fs.h
  erofs-utils: implement 48-bit block addressing for unencoded inodes
  erofs-utils: mkfs: support 48-bit block addressing for unencoded
    inodes
  erofs-utils: support dot-omitted directories
  erofs-utils: lib: implement encoded extent metadata
  erofs-utils: support encoded extents

 dump/main.c                 |   3 +-
 fsck/main.c                 |   2 +-
 include/erofs/cache.h       |   4 +-
 include/erofs/config.h      |   1 +
 include/erofs/internal.h    |  36 +++---
 include/erofs_fs.h          | 194 ++++++++++++++---------------
 lib/blobchunk.c             |  33 +++--
 lib/block_list.c            |   8 +-
 lib/cache.c                 |  24 ++--
 lib/compress.c              | 236 ++++++++++++++++++++++++++++--------
 lib/compressor.c            |  11 ++
 lib/compressor.h            |   6 +
 lib/compressor_libdeflate.c |  18 +++
 lib/compressor_libzstd.c    |  18 +++
 lib/data.c                  | 147 +++++++++-------------
 lib/dir.c                   |   2 +
 lib/inode.c                 | 146 +++++++++++++++++-----
 lib/namei.c                 |  38 ++++--
 lib/rebuild.c               |   2 +-
 lib/super.c                 |  37 ++++--
 lib/zmap.c                  | 216 ++++++++++++++++++++++++++-------
 mkfs/main.c                 |  45 ++++++-
 22 files changed, 827 insertions(+), 400 deletions(-)

-- 
2.43.5


