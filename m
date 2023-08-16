Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1C77D945
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 05:49:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQZ04630Bz3cLl
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 13:49:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQYzz4Rhsz2yVl
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 13:49:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpuLGlC_1692157781;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpuLGlC_1692157781)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 11:49:42 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/4] erofs-utils: support long xattr name prefixes
Date: Wed, 16 Aug 2023 11:49:37 +0800
Message-Id: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
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
- add patch 3 to introduce erofs_read_metadata() helper, so that the
  long xattr name prefixes could also be read from meta inode

v1: https://lore.kernel.org/all/20230815091521.74661-1-jefflexu@linux.alibaba.com/


Jingbo Xu (4):
  erofs-utils: lib: fix potential out-of-bound in xattr_entrylist()
  erofs-utils: lib: add match_base_prefix() helper
  erofs-utils: add erofs_read_metadata() helper
  erofs-utils: support long xattr name prefixes for erofsfuse

 include/erofs/internal.h |   8 +++
 include/erofs/xattr.h    |   2 +
 lib/data.c               |  84 ++++++++++++++++++++++
 lib/super.c              |  14 +++-
 lib/xattr.c              | 147 +++++++++++++++++++++++++++++++++------
 mkfs/Makefile.am         |   3 +-
 6 files changed, 235 insertions(+), 23 deletions(-)

-- 
2.19.1.6.gb485710b

