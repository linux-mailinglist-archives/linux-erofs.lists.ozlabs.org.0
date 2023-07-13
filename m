Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950F7520AF
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 14:00:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1tTt2zlvz3c4B
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 22:00:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1tTm0KmBz3bb4
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 22:00:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnHiX-b_1689249615;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnHiX-b_1689249615)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 20:00:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v2 0/2] erofs-utils: introduce tarerofs
Date: Thu, 13 Jul 2023 20:00:13 +0800
Message-Id: <20230713120015.93308-1-jefflexu@linux.alibaba.com>
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

v2:
- patch 2
  - refactor tarerofs_mkdir() and rename to tarerofs_init_default_dir()
  - check return value of erofs_d_alloc() in tarerofs_get_dentry()
  - recalculate directory's i_nlink in tarerofs_dump_tree(), otherwise
    directory's i_nlink is always 2
  - don't fail in tarerofs_parse_tar() when st_size of symlink file is
    exactly 4096 (same as PATH_MAX)


v1: https://lore.kernel.org/all/20230711061240.23662-1-jefflexu@linux.alibaba.com/

Gao Xiang (1):
  erofs-utils: introduce tarerofs

Jingbo Xu (1):
  erofs-utils: add ERR_CAST macro

 configure.ac              |   1 +
 include/erofs/blobchunk.h |   4 +-
 include/erofs/err.h       |   6 +
 include/erofs/inode.h     |  12 +
 include/erofs/internal.h  |   7 +-
 include/erofs/tar.h       |  29 ++
 include/erofs/xattr.h     |   4 +
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |  47 ++-
 lib/inode.c               | 194 ++++++++---
 lib/tar.c                 | 810 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/xattr.c               |  46 ++-
 mkfs/main.c               | 134 +++++---
 13 files changed, 1191 insertions(+), 106 deletions(-)
 create mode 100644 include/erofs/tar.h
 create mode 100644 lib/tar.c

-- 
1.8.3.1

