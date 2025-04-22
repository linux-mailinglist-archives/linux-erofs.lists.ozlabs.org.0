Return-Path: <linux-erofs+bounces-207-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E0A96AAA
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 14:45:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhhm60vL6z3bZs;
	Tue, 22 Apr 2025 22:45:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745325926;
	cv=none; b=jo+AsjnERq3RvMN8L8GFUAgU3i/8HHxJQtyJIL4trNxRIU6POBDrFSsIR2mwsaHSNS4UagkeD0gP1teaQfaygqpc3KpV/gtH+jOrlHuYdFUKYwll6eJHlGYZ9ZKLUaiCov2nZ+R6L0/BcQIE6AYNXdmM0KMl+FQX+m1PwaQl0bc3EG4MlujyDyNF2/0HwVOe8Muyn+TrdpQ8hUoFfE9ukRb0KDCRZL4M/hJC5zZDD7Zu5gmYKoyqWMf8m/P3Xhbwwp0IlCFCUn7OLMkXPVRsJvM94ZRFf6MATpbIDW4dxw8aYT1kFuu3z4IoBpZ2LfaTz6yM/eTDX3BtTkJJ5BSwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745325926; c=relaxed/relaxed;
	bh=awK/1M07aU9gwC2AGKi9dllTUsywayWQZTF7DRikkEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njN6CBfVJI11qsi1E7/0FD7VTt5nYfGkEx5oe6CwzxEsCOFsiR0/JYZQP4RGEpjPvsOiZDtskACGtazqCMN/DfP4OWb2tXUemidxDdIoURYCgKHJE3wrPUTIkRrtKOKjtK6RsSg6t7CnsBqhEhcanM5hmV6i+76b4XRliWa6MWyzvUzAUUlZBgZG5Gy4Q7yXY+UzkT6MmApk/n1ttuqAzbnE6iEOhcAnSwWqDsh1IdAIsAjEws1dw8tAdpIpEZ/prba3uJP0ZTYxJwG91PGvzcYBw12yJ8Iv/z4gelQasw0NlO3v15GlbEsE/qX/NyCp0Tj3QREeq/GIkQILRFCTUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhhm36F3yz3bjg
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 22:45:23 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zhhgy6Q3Kz2CdFF;
	Tue, 22 Apr 2025 20:41:50 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D9F141402C7;
	Tue, 22 Apr 2025 20:45:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:45:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC 4/4] erofs-utils: lib: remove the compile warning
Date: Tue, 22 Apr 2025 12:36:12 +0000
Message-ID: <20250422123612.261764-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250422123612.261764-1-lihongbo22@huawei.com>
References: <20250422123612.261764-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the condition macro to avoid the compile warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 lib/decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3f553a8..1e9fad7 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,6 +9,8 @@
 #include "erofs/err.h"
 #include "erofs/print.h"
 
+#if defined(HAVE_LIBZSTD) || defined(HAVE_QPL) || defined(HAVE_LIBDEFLATE) || \
+    defined(HAVE_ZLIB) || defined(HAVE_LIBLZMA) || defined(LZ4_ENABLED)
 static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsize)
 {
 	unsigned int inputmargin;
@@ -17,6 +19,7 @@ static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsi
 	     !padbuf[inputmargin]; ++inputmargin);
 	return inputmargin;
 }
+#endif
 
 #ifdef HAVE_LIBZSTD
 #include <zstd.h>
-- 
2.22.0


