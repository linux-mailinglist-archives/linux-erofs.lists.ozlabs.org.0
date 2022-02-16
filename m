Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30E4B87A1
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Feb 2022 13:29:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzHMH549Dz3bW9
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Feb 2022 23:29:15 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzHM75Z4Kz2xs7
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Feb 2022 23:29:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V4dQyhi_1645014525; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V4dQyhi_1645014525) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 20:28:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/2] erofs-utils: refine tailpcluster compression approach
Date: Wed, 16 Feb 2022 20:28:43 +0800
Message-Id: <20220216122845.47819-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

This patchset refines tailpcluster compression. Firstly, instead of
compressing into many 4KiB pclusters, it compresses into 2 pclusters
as I already mentioned in the previous comment [1].

Secondly, it fixes up EOF lclusters which was disabled on purpose before
in order to achieve better inlining performance for small compressed data,
which matches the new kernel fix [2].

Still take linux-5.10.87 as an example (75368 inodes in total):
linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384 => 331292672
linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936 => 321961984
linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152 => 313344000
linux-5.10.87 (erofs, lz4hc,9 32k tailpacking)  338649088 => 309055488

(There is still another improvement working in progress..)

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local 
[2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org

changes since v1 (reported by Yue Hu):
 - fall back to uncompressed data if EOF lcluster inline is no possible;
 - fix `ret' signedness.

Gao Xiang (2):
  erofs-utils: lib: get rid of a redundent compress round
  erofs-utils: lib: refine tailpcluster compression approach

 include/erofs/compress.h |   1 +
 include/erofs/internal.h |   4 +
 lib/compress.c           | 156 +++++++++++++++++++++++++++------------
 lib/inode.c              |   9 ++-
 4 files changed, 119 insertions(+), 51 deletions(-)

-- 
2.24.4

