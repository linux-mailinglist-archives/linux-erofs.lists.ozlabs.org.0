Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F704A9CAC
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 17:10:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jr0qk0DLbz3bmf
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Feb 2022 03:10:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jr0qZ5GsGz30Md
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Feb 2022 03:10:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V3ZWJPS_1643990985; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3ZWJPS_1643990985) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Feb 2022 00:09:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] erofs-utils: refine tailpcluster compression approach
Date: Sat,  5 Feb 2022 00:09:42 +0800
Message-Id: <20220204160944.120151-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
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

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local 
[2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org

Gao Xiang (2):
  erofs-utils: lib: get rid of a redundent compress round
  erofs-utils: lib: refine tailpcluster compression approach

 lib/compress.c | 100 ++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

-- 
2.24.4

