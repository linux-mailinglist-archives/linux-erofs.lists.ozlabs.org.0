Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6F1712E07
	for <lists+linux-erofs@lfdr.de>; Fri, 26 May 2023 22:15:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QSbkv3BYSz3fF6
	for <lists+linux-erofs@lfdr.de>; Sat, 27 May 2023 06:15:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QSbkm4V8Mz3fCF
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 May 2023 06:15:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN-8_1685132100;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN-8_1685132100)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/6] erofs: random cleanups and fixes
Date: Sat, 27 May 2023 04:14:53 +0800
Message-Id: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

These are some cleanups and fixes for the compressed part I'd like to
aim for the next cycle. I will send several versions if there are more
patches available.  This ongoing cleanup work are also for later folio
adaption.

I've set up a stress test for this patchset at the same time.

Thanks,
Gao Xiang

Gao Xiang (6):
  erofs: allocate extra bvec pages directly instead of retrying
  erofs: avoid on-stack pagepool directly passed by arguments
  erofs: kill hooked chains to avoid loops on deduplicated compressed
    images
  erofs: adapt managed inode operations into folios
  erofs: use struct lockref to replace handcrafted approach
  erofs: use poison pointer to replace the hard-coded address

 fs/erofs/internal.h |  41 +-------
 fs/erofs/super.c    |  62 ------------
 fs/erofs/utils.c    |  87 ++++++++--------
 fs/erofs/zdata.c    | 238 ++++++++++++++++++++------------------------
 4 files changed, 156 insertions(+), 272 deletions(-)

-- 
2.24.4

