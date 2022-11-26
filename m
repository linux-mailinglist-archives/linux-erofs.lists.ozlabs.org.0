Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DACB6392F1
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 01:58:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJtdB3P99z3f5s
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 11:58:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJtd734b3z3bnZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Nov 2022 11:58:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVgyB1f_1669424276;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVgyB1f_1669424276)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 08:57:57 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] erofs: support large folio in fscache mode
Date: Sat, 26 Nov 2022 08:57:54 +0800
Message-Id: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patch 1 is the main part of supporting large folio in fscache mode. It
relies on a pending patch[1] adding .prepare_ondemand_read() interface
in Cachefiles.

Patch 2 just turns the switch on and enables the feature. It enables large
folio for both fscache and the original device mode (in uncompressed
data format). And thus I think the previous patch[2] exclusively for the
device mode is not needed then.

[1] https://lore.kernel.org/all/20221124034212.81892-1-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20221110074023.8059-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: support large folio in fscache mode
  erofs: enable large folio support for non-compressed format

 fs/erofs/fscache.c | 117 +++++++++++++++++++--------------------------
 fs/erofs/inode.c   |   1 +
 2 files changed, 50 insertions(+), 68 deletions(-)

-- 
2.19.1.6.gb485710b

