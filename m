Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714C43F6D4
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 07:52:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgWlq1x6Nz2ynQ
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 16:52:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=113.96.223.78; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg413.qq.com [113.96.223.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgWlh6f9dz2xXc
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 16:52:00 +1100 (AEDT)
X-QQ-mid: bizesmtp32t1635486639t6g1enlz
Received: from tj.ccdomain.com (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 13:50:24 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00A0000000
X-QQ-FEAT: Mzskoac49OgAryltguf54KH8t16f3YIGLF+IJNZXPcwXU/qNj1yvx1wYFfzYp
 zSDob/pWeibO8iNhLOGWe1PCm3DL+jKn0uH5qN+EqDSMmISC5YTzHusX7o3bpDV60PdNLxx
 jT72/oaVHhVaHiiLkwckhYdmb+2Ks+Xrfu2jTiYGyMN5am2fsuSTmx7+8K8UvM97ag8D65h
 CbnwGON5SBY0xheXOnDLUlZwiZ8fFRQT9PfKIWRg+DgKzTIHGYfzamOwQjgOmZMR9ClJ9w2
 sgVKL5FP1IwgwfVDoEhzoze4a73UdeqY+GiVs6v5Lhr84lv2+RWY6dIRHMNdKDB3TQHDuGd
 yYCqEvoFiVbAHxmSnXn9eghcuO6n6AxW8bx0BBv
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 0/2] erofs-utils: compression inline feature
Date: Fri, 29 Oct 2021 13:49:29 +0800
Message-Id: <cover.1635485195.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign6
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
Cc: zhangwen@yulong.com, Yue Hu <huyue2@yulong.com>, geshifei@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Now, we only support tail-end inline data for uncompressed file. We should
also support it for compressed file to further decrease tail extent I/O and
save more space. That is original intention as well from Xiang.

Note that tail pcluster data is compressed by 4KB in this patch, which looks
like inefficent. As Xiang mentioned, there is another better way to handle it.
This patch is just using 4KB compression policy, we may improve it next.

Thanks.

Yue Hu (2):
  erofs-utils: support tail-packing inline compressed data
  erofs-utils: fuse: support tail-packing inline compressed data

 include/erofs/internal.h |   4 ++
 include/erofs_fs.h       |  10 ++-
 lib/compress.c           |  76 ++++++++++++++++++-----
 lib/compressor.c         |   9 +--
 lib/decompress.c         |   7 ++-
 lib/inode.c              |  40 ++++++------
 lib/zmap.c               | 130 ++++++++++++++++++++++++++++++++++++---
 mkfs/main.c              |   6 ++
 8 files changed, 228 insertions(+), 54 deletions(-)

-- 
2.29.0



