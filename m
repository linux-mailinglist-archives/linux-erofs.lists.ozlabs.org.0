Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA177CA22
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 11:15:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ5GJ58Wwz3cG1
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 19:15:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ5GB20RMz30NN
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 19:15:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VprOquP_1692090921;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VprOquP_1692090921)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:15:22 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/3] erofs-utils: support long xattr name prefixes for erofsfuse
Date: Tue, 15 Aug 2023 17:15:18 +0800
Message-Id: <20230815091521.74661-1-jefflexu@linux.alibaba.com>
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

The first two are preparing for patch 3, which implements the support
for long xattr name prefixes for erofsfuse.

Patch 3 is basically synced from kernel commits:
	erofs: add helpers to load long xattr name prefixes
	erofs: handle long xattr name prefixes properly
	erofs: enable long extended attribute name prefixes


Jingbo Xu (3):
  erofs-utils: lib: fix potential out-of-bound in xattr_entrylist()
  erofs-utils: lib: add match_base_prefix() helper
  erofs-utils: support long xattr name prefixes for erofsfuse

 include/erofs/internal.h |   6 ++
 include/erofs/xattr.h    |   2 +
 lib/super.c              |  14 +++-
 lib/xattr.c              | 171 ++++++++++++++++++++++++++++++++++-----
 mkfs/Makefile.am         |   3 +-
 5 files changed, 173 insertions(+), 23 deletions(-)

-- 
2.19.1.6.gb485710b

