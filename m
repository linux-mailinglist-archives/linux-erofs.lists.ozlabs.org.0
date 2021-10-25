Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADA439669
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 14:34:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdDsz3nNsz2yPp
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 23:34:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.85; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
X-Greylist: delayed 70 seconds by postgrey-1.36 at boromir;
 Mon, 25 Oct 2021 23:34:20 AEDT
Received: from qq.com (smtpbg476.qq.com [59.36.132.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdDsm0R0kz2xtP
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 23:34:19 +1100 (AEDT)
X-QQ-mid: bizesmtp46t1635165105t9udyi6o
Received: from tj.ccdomain.com (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 25 Oct 2021 20:31:20 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000000A0000000
X-QQ-FEAT: e00egQTBacRtD6R241aeCCQoFQ0XFfaQGPYE/ECVVgOJWVmg3cNUQOe2yG3gp
 pAK29sqEt6teX9D1uy0gG2ZCqTCaPFpx8FCvdSHzS9OPM0x446vjF5qjZqJw1D+5GN+EEgu
 +X7jAti9rowJNNPk6hh54a/F3Qk6giaaQjOeFg6txN83DRjsAhH4RWn/K9yihgpMlxLGDVm
 8U3o643Njm8/lLvUJeYkAURYps4EdfQxj4R1nDmo9rJNuipFDGqDMYPkpUlzH6FBlGTlHAI
 wG3J0SMW3NZSLVUzGnDKLi4gunUs+nFcY8IA+u7dqTz0pHJi3Sg7oRwT6adO7QExFFKBIPb
 4MicLjmTid/ykqnrCyh/tMNXFw5s8oehNxZcVDd
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 0/2] erofs-utils: compression inline feature
Date: Mon, 25 Oct 2021 20:30:42 +0800
Message-Id: <cover.1635162978.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
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
Cc: huyue2@yulong.com, geshifei@yulong.com, zhangwen@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Now, we only support tail-end inline data for uncompressed file. We should
also support it for compressed file to decrease tail extent I/O and save
save more space. That is original intention from Xiang.

Note that, current mapping logic code in erofsuse is only based on
non-bigpcluster in erofsfuse, but i would like to present it. May refine
it for big pcluster later. Let's foucs on this on-disk improvement first.

Thanks.


Yue Hu (2):
  erofs-utils: support tail-packing inline compressed data
  erofs-utils: fuse: support tail-packing inline compressed data

 include/erofs/internal.h |  2 +
 include/erofs_fs.h       |  6 ++-
 lib/compress.c           | 74 ++++++++++++++++++++++++-------
 lib/compressor.c         |  9 ++--
 lib/decompress.c         |  4 ++
 lib/inode.c              | 50 +++++++++++----------
 lib/zmap.c               | 95 +++++++++++++++++++++++++++++++++++++---
 mkfs/main.c              |  6 +++
 8 files changed, 199 insertions(+), 47 deletions(-)

-- 
2.29.0



