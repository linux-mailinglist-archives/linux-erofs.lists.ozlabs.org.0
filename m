Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BDF3EAFA7
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Aug 2021 07:29:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmBvl4s6bz3bjK
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Aug 2021 15:29:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmBvZ6tDLz30J9
 for <linux-erofs@lists.ozlabs.org>; Fri, 13 Aug 2021 15:29:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UiqodgM_1628832571; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UiqodgM_1628832571) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 13 Aug 2021 13:29:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] erofs: add fiemap support with iomap
Date: Fri, 13 Aug 2021 13:29:29 +0800
Message-Id: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This patchset mainly addresses fiemap support for EROFS. After this
patchset, end users can observe (un)compressed extent distribution
by hand.

The first patch is also useful for later LZMA support in order to
decompress full LZMA extents if needed (according to specific
strategy.)

Btw, the current development status for LZMA is in the following
branches (yet these are not aimed for the next merge window since
it's still some work to do):
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/lzma
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-lzma

Thanks,
Gao Xiang

Gao Xiang (2):
  erofs: add support for the full decompressed length
  erofs: add fiemap support with iomap

 fs/erofs/data.c     |  15 ++++-
 fs/erofs/inode.c    |   1 +
 fs/erofs/internal.h |  10 ++++
 fs/erofs/namei.c    |   1 +
 fs/erofs/zmap.c     | 131 +++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 9 deletions(-)

-- 
2.24.4

