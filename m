Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D342482909
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 05:01:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JRQCb03XVz305L
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 15:00:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JRQCQ0yVlz2yb9
 for <linux-erofs@lists.ozlabs.org>; Sun,  2 Jan 2022 15:00:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V0Xfdc3_1641096018; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0Xfdc3_1641096018) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 02 Jan 2022 12:00:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH v2 0/5] erofs: get rid of erofs_get_meta_page()
Date: Sun,  2 Jan 2022 12:00:12 +0800
Message-Id: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

erofs_get_meta_page() is actually inflexible since it's too
close to the page itself.

In order to prepare for folio and subpage features, introduce
on-stack meta buffer descriptor instead and convert all
erofs_get_meta_page() users to use it.

It can also be used for new potential backends such as fscache or mtd.

Patches are trivial.

Thanks,
Gao Xiang

changes since v1:
 - fix unbalanced put_metabuf in xattrs.

Gao Xiang (5):
  erofs: introduce meta buffer operations
  erofs: use meta buffers for inode operations
  erofs: use meta buffers for super operations
  erofs: use meta buffers for xattr operations
  erofs: use meta buffers for zmap operations

 fs/erofs/data.c     | 102 +++++++++++++++++++++++----------
 fs/erofs/inode.c    |  68 +++++++++++-----------
 fs/erofs/internal.h |  22 +++++++-
 fs/erofs/super.c    | 105 +++++++++-------------------------
 fs/erofs/xattr.c    | 134 +++++++++++++-------------------------------
 fs/erofs/zdata.c    |  23 +++-----
 fs/erofs/zmap.c     |  56 ++++++------------
 7 files changed, 214 insertions(+), 296 deletions(-)

-- 
2.24.4

