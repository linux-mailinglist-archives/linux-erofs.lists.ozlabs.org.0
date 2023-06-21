Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9A737DCD
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 10:49:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmHHj3D1Tz3dxS
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 18:49:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmH4K1rFqz3dFk
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 18:39:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlfFK.A_1687336779;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfFK.A_1687336779)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:39:40 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [RFC 0/3] erofs-utils: introduce xattr bloom filter feature
Date: Wed, 21 Jun 2023 16:39:36 +0800
Message-Id: <20230621083939.128961-1-jefflexu@linux.alibaba.com>
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

The xattr bloom filter feature is used to boost the negative xattr
lookup.

Refer to the kernel patches [1] for more details.

[1] https://lore.kernel.org/all/20230621083209.116024-1-jefflexu@linux.alibaba.com/

Jingbo Xu (3):
  erofs-utils: add xxh32 library
  erofs-utils: update on-disk format for xattr bloom filter
  erofs-utils: mkfs: enable xattr bloom filter

 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 include/erofs/xxhash.h   | 35 +++++++++++++++++
 include/erofs_fs.h       | 10 ++++-
 lib/Makefile.am          |  3 +-
 lib/xattr.c              | 62 +++++++++++++++++++++++++++--
 lib/xxhash.c             | 85 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  6 +++
 8 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.c

-- 
2.19.1.6.gb485710b

