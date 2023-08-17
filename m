Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E477F105
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 09:15:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRGVY69HCz3cGc
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 17:15:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRGVL5Cc4z2yWD
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 17:15:04 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpyuTjM_1692256495;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpyuTjM_1692256495)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 15:14:56 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/3] erofs-utils: support long xattr name prefixes
Date: Thu, 17 Aug 2023 15:14:52 +0800
Message-Id: <20230817071455.12040-1-jefflexu@linux.alibaba.com>
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

v3:
- patch 3: rename to erofs_read_metadata_bdi() and
  erofs_read_metadata_nid()

v2:
- add patch 3 to introduce erofs_read_metadata() helper, so that the
  long xattr name prefixes could also be read from meta inode

v1: https://lore.kernel.org/all/20230815091521.74661-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230816034941.126866-1-jefflexu@linux.alibaba.com/


Jingbo Xu (3):
  erofs-utils: lib: add match_base_prefix() helper
  erofs-utils: add erofs_read_metadata() helper
  erofs-utils: support long xattr name prefixes for erofsfuse

 include/erofs/internal.h |   8 +++
 include/erofs/xattr.h    |   2 +
 lib/data.c               |  84 +++++++++++++++++++++++
 lib/super.c              |  14 +++-
 lib/xattr.c              | 140 +++++++++++++++++++++++++++++++++------
 mkfs/Makefile.am         |   3 +-
 6 files changed, 230 insertions(+), 21 deletions(-)

-- 
2.19.1.6.gb485710b

