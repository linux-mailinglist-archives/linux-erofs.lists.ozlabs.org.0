Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427B75C500
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 12:49:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6mXK6p4xz3cQm
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 20:49:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6mXB6FNtz3cN9
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jul 2023 20:49:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnuH80X_1689936563;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnuH80X_1689936563)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 18:49:24 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 0/2] erofs: introduce xattr name bloom filter
Date: Fri, 21 Jul 2023 18:49:21 +0800
Message-Id: <20230721104923.20236-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changes since v4:
- patch 2: polish commit message; declare erofs_inode.xattr_name_filter
  as unsigned int instead of unsigned long; rename `bit` to `hashbit`;
  use bitwise and instead of test_bit() to test the hashbit (Gao Xiang)

changes since v3:
- patch 1: add "Reviewed-by" tag (Gao Xiang)
- patch 2: make CONFIG_EROFS_FS_XATTR select CONFIG_XXHASH (Gao Xiang)

changes since v2:
- patch 1: polish the commit message; introduce xattr_filter_reserved in
  on-disk superblock; remove EROFS_XATTR_FILTER_MASK (Gao Xiang)

changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
  Refer to patch 1 for more details.
- fix the value of EROFS_FEATURE_COMPAT_XATTR_BLOOM; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)
- pass all tests in erofs-utils (MKFS_OPTIONS="--xattr-filter" make
  check)

[*] https://lore.kernel.org/all/74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com/
RFC: https://lore.kernel.org/all/20230621083209.116024-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230705070427.92579-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230712115123.33712-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230714031034.53210-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: update on-disk format for xattr name filter
  erofs: boost negative xattr lookup with bloom filter

 fs/erofs/Kconfig    |  1 +
 fs/erofs/erofs_fs.h | 10 ++++++++--
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  1 +
 fs/erofs/xattr.c    | 14 ++++++++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b

