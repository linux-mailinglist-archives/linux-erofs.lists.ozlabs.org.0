Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B578C463
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 14:41:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZn9l6yx3z3bVp
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 22:41:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZn9Z4nCGz30dt
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 22:41:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqrYOOW_1693312887;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqrYOOW_1693312887)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 20:41:28 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 0/3] erofs-utils: introduce xattr name bloom filter
Date: Tue, 29 Aug 2023 20:41:24 +0800
Message-Id: <20230829124127.36719-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changes since v5:
- patch 1: update distribution license
- patch 3: rebase to the latest -dev branch

changes since v4:
- patch 3: the feature is refactored and implemented in a more cohesive
  way, that is, the hashbit is calculated in erofs_export_xattr_ibody().
  For xattr_item in the long xattr name prefix style, reconstruct the
  full xattr name first, then derive the corresponding predefined short
  name prefix and finally calculate the hashbit.

changes since v3:
- patch 3: "-Exattr-name-filter" option rather than "--xattr-filter"
  option is newly introduced to enable this feature (Gao Xiang)

changes since v2:
- patch 2: introduce xattr_filter_reserved in on-disk superblock;
  remove EROFS_XATTR_FILTER_MASK
- patch 3: xattr_filter_reserved is always initialized to 0 by default


changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
- fix the value of EROFS_FEATURE_COMPAT_XATTR_FILTER; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)


RFC: https://lore.kernel.org/all/20230621083939.128961-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230705071017.104130-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230712121331.99671-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230714025330.42950-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20230722042414.126630-1-jefflexu@linux.alibaba.com/

The xattr bloom filter feature is used to boost the negative xattr
lookup.

Refer to the kernel patch set [*] for more details.

[*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd73a4395d47


Jingbo Xu (3):
  erofs-utils: add xxh32 library
  erofs-utils: update on-disk format for xattr name filter
  erofs-utils: mkfs: enable xattr name filter

 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   1 +
 include/erofs/xxhash.h   |  72 ++++++++++++++++++++++
 include/erofs_fs.h       |  12 +++-
 lib/Makefile.am          |   3 +-
 lib/xattr.c              |  63 ++++++++++++++++++++
 lib/xxhash.c             | 125 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |   7 +++
 8 files changed, 281 insertions(+), 3 deletions(-)
 create mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.c

-- 
2.19.1.6.gb485710b

