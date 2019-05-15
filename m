Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA071E7B6
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2019 06:39:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453hft6dcYzDqPP
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2019 14:39:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=202.248.20.72; helo=condef-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="XZoH7GtX"; 
 dkim-atps=neutral
X-Greylist: delayed 166 seconds by postgrey-1.36 at bilbo;
 Wed, 15 May 2019 14:39:46 AEST
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
 by lists.ozlabs.org (Postfix) with ESMTP id 453hfp6PcPzDqHk
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2019 14:39:46 +1000 (AEST)
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-07.nifty.com
 with ESMTP id x4F4WNOP028276
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2019 13:32:23 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x4F4VXWg022418;
 Wed, 15 May 2019 13:31:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x4F4VXWg022418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1557894694;
 bh=GBhVHyqB4V20+0mYJbhNu4y/q2WNmGqZYid9a78MJE4=;
 h=From:To:Cc:Subject:Date:From;
 b=XZoH7GtXDV3vnWy/v1VeM769Jo2+KIK7XrWBoUzLH+vAEQVHuUB+aQ0pB1R+mRxKJ
 0U5BDbpC8OFqBsg2cPaunQNiFz4AeqGvD4Gxpkvjg/LfhCzC7I2ezxxMx9JXxx6hyC
 z0oJpm8ZlgNj9aoOsJOVkJ4x3qV/Q9wHUpQNuWSiHKR5EfiwRNY04P7fJI/1WGxshg
 CXt/t8aZTV9nNp9mZ9mclzGZtqZfqHTMMnYmm91G8ChGdesX1dEEzEaz0ibNc0XUw9
 daXB72Ye/pQ9liUDlNoL5b1wvf8XDVQPLtMF6er7M8xDkR28ez/IOA1alpkDiXzk9P
 l09lvnoo1PWIw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org, Greg KH <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org
Subject: [PATCH] staging: erofs: drop unneeded -Wall addition
Date: Wed, 15 May 2019 13:31:22 +0900
Message-Id: <20190515043123.9106-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The top level Makefile adds -Wall globally:

  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \

I see two "-Wall" added for compiling objects in drivers/staging/erofs/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/staging/erofs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index 38ab344a285e..a34248a2a16a 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -2,7 +2,7 @@
 
 EROFS_VERSION = "1.0pre1"
 
-ccflags-y += -Wall -DEROFS_VERSION=\"$(EROFS_VERSION)\"
+ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
 # staging requirement: to be self-contained in its own directory
-- 
2.17.1

