Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2D63BF8E
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 12:58:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NM18C4VVkz3bTk
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 22:58:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.6; helo=out30-6.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NM1804fN4z30R6
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Nov 2022 22:58:39 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW-kQll_1669723113;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW-kQll_1669723113)
          by smtp.aliyun-inc.com;
          Tue, 29 Nov 2022 19:58:34 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/2] erofs: support large folios for fscache mode
Date: Tue, 29 Nov 2022 19:58:31 +0800
Message-Id: <20221129115833.41062-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v3:
- patch 1: when large folios supported, one folio or folio range can be
mapped into several slices, with each slice mapped to different cookies,
and thus each slice needs its own netfs_cache_resources.

In the implementation of v2, each .read_folio() or .readahead() calling
corresponds to only one request, and thus only one netfs_cache_resources
(embedded in the request).  In this case, fscache_begin_read_operation()
may be called multiple times on this cres, while cres->ops->end_operation()
is called only once when the whole request completes.  This can cause
the leakage of the corresponding cachefiles_object->n_accesses refcount,
which will cause the user daemon hangs there forever waiting for
cache->object_count decreasing to 0 when the user daemon exits.

Worsely, as we mentioned previously, when large folios supported, one
folio or folio range can be mapped to multiple chunks on different
cookies, in which case each mapped chunk needs its own cres. In the
implementation of v2, each .read_folio() or .readahead() calling
corresponds to only one request, and thus only one cres.  This will make
the only cres used by the first chunk gets overridden by the following
chunk.

To fix this, we introduce listed requests, where each .read_folio() or
.readahead() calling can correspond to a list of requests, with each
request corresponds to one cres.

v2: https://lore.kernel.org/all/20221128025011.36352-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/all/20221126005756.7662-1-jefflexu@linux.alibaba.com/

v2:
- patch 2: keep the enabling for iomap and fscache mode in separate
  patches; don't enable the feature for the meta data routine for now
  (Gao Xiang)

Patch 1 is the main part of supporting large folios for fscache mode. It
relies on a pending patch[1] adding .prepare_ondemand_read() interface
in Cachefiles.

Patch 2 just turns the switch on and enables the feature for fscache
mode. It relies on a previous patch[2] which enables this feature for
iomap mode.

[1] https://lore.kernel.org/all/20221124034212.81892-1-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20221110074023.8059-1-jefflexu@linux.alibaba.com/



Jingbo Xu (2):
  erofs: support large folios for fscache mode
  erofs: enable large folios for fscache mode

 fs/erofs/fscache.c | 166 ++++++++++++++++++++++++---------------------
 fs/erofs/inode.c   |   3 +-
 2 files changed, 89 insertions(+), 80 deletions(-)

-- 
2.19.1.6.gb485710b

