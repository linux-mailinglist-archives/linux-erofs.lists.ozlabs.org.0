Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96337688E24
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:47:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7M6p74Fwz3f5p
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:47:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7M6l3gLnz3bT0
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:47:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Van-GYb_1675396041;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Van-GYb_1675396041)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:47:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com,
	houtao1@huawei.com
Subject: [PATCH 0/2] erofs: cleanup for fscache mode
Date: Fri,  3 Feb 2023 11:47:18 +0800
Message-Id: <20230203034720.24619-1-jefflexu@linux.alibaba.com>
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

These are misc cleanup for fscache mode, while patch 2 is dependent on
the page cache sharing codebase [1].

[1] https://lore.kernel.org/all/20230203030143.73105-1-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  erofs: simplify instantiation of pseudo mount in fscache mode
  erofs: simplify the name collision checking in share domain mode

 fs/erofs/fscache.c  | 84 ++++++++++++++++++++-------------------------
 fs/erofs/internal.h | 15 ++++----
 fs/erofs/super.c    | 37 +++++---------------
 3 files changed, 53 insertions(+), 83 deletions(-)

-- 
2.19.1.6.gb485710b

