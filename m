Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C660168FFCB
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:18:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC4sV5B2Wz3cdZ
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:18:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC4sJ3VFsz3c6R
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:18:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEauig_1675919918;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEauig_1675919918)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:18:38 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com
Subject: [PATCH v2 0/4] erofs: cleanup for fscache share domain mode
Date: Thu,  9 Feb 2023 13:18:34 +0800
Message-Id: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v2:
- patch 4: add EROFS_REG_COOKIE_SHARE flag to indicate that the blob is
  shareable among several erofs fs instances (Zhu Jia)
- patch 4: rearrange the prototype of related functions to make it more
  compact (including rename erofs_fscache_domain_init_cookie() to
  erofs_domain_init_cookie())

Jingbo Xu (4):
  erofs: remove unused device mapping in meta routine
  erofs: maintain cookies of share domain in self-contained list
  erofs: relinquish volume with mutex held
  erofs: unify anonymous inodes for blob

 fs/erofs/fscache.c  | 148 ++++++++++++++++++--------------------------
 fs/erofs/internal.h |  11 ++--
 fs/erofs/super.c    |   2 +
 3 files changed, 68 insertions(+), 93 deletions(-)

-- 
2.19.1.6.gb485710b

