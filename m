Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24260747DF7
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:10:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwrQs0W24z30fM
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:10:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwrQl1nSMz2x9L
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:10:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VmfgKEb_1688541017;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmfgKEb_1688541017)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:10:18 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/3] erofs-utils: introduce xattr name bloom filter
Date: Wed,  5 Jul 2023 15:10:14 +0800
Message-Id: <20230705071017.104130-1-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
- fix the value of EROFS_FEATURE_COMPAT_XATTR_FILTER; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)


RFC: https://lore.kernel.org/all/20230621083939.128961-1-jefflexu@linux.alibaba.com/


The xattr bloom filter feature is used to boost the negative xattr
lookup.

Refer to the kernel patch set [*] for more details.

[*] https://lore.kernel.org/all/20230705070427.92579-1-jefflexu@linux.alibaba.com/


Jingbo Xu (3):
  erofs-utils: add xxh32 library
  erofs-utils: update on-disk format for xattr name filter
  erofs-utils: mkfs: enable xattr name filter

 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 include/erofs/xxhash.h   | 35 +++++++++++++++++
 include/erofs_fs.h       | 10 ++++-
 lib/Makefile.am          |  3 +-
 lib/xattr.c              | 74 ++++++++++++++++++++++++++--------
 lib/xxhash.c             | 85 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  6 +++
 8 files changed, 197 insertions(+), 18 deletions(-)
 create mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.c

-- 
2.19.1.6.gb485710b

