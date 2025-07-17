Return-Path: <linux-erofs+bounces-656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28952B0844F
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 07:37:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjMBm6VKGz2yDk;
	Thu, 17 Jul 2025 15:37:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752730656;
	cv=none; b=blTRrS/GWi27Xm5KnvaR48gy01XOei6g6a0/CI0RVs+rvM/JrIQXSJ5j9QA41t5mdBWk0YFZclhBzRwqN+OWQBJMQsndtD9cAgolWhI/slSaclkCpr+MwpCI3bITEUn370g2/q5vLF9CuN63mhwZfT46W5qgg7+KEk7CEHwQlUvv+ArTnLTBpupM0V3J3AgTLhIUHo1fc420nNqqy8W+5Ayh7WJJ2FuT2POFmrjkK6ADKzMnynXyDyUkKOHa29eu7jS+uzq2nzD3MTyWsKohuHBlh5IMc0ZGL6Qzape3vbhG4Y06+OOmLKbm2ob2GTLHgnui9HKRFaO6Q8JT84uXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752730656; c=relaxed/relaxed;
	bh=OF56z3mse5NNgznj6mo/5SOtM1H0nRSCB9W2hoEIka4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3KXm7ps/XsfofnN89zNV21eKHhNdOCldgMV//dgUK7aUnYZE9F0qE9Zg40LxG0eWo9hD2HalCT8tUycB2NUYWcBTcVfclY6+SA1HoEDNif1RRUX1bHuCvJyQ3owWSXiPXbFJbZD/w68jJN3XzZO78WuVBmMKfwFnFStYKQAaEHHY7Ny+zoRD7yvHTiIc5tD9BWtd77dHiWQZrMLpsWdpAmxC466jha+6oIhkXk9ELH7xZZryFhVXroMMnv3hA7r+rQfUopFC1Y+W+KyNXogxTf2DQ1RwwwDd+WBDA3gSIDeoxiXKAaoonMPazr78uemfpZe9H6WRGmFar0cIhk+BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjMBl4fhdz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 15:37:35 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507171337302780;
        Thu, 17 Jul 2025 13:37:30 +0800
Received: from localhost.localdomain (10.94.9.142) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 13:37:29 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v3] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Thu, 17 Jul 2025 01:37:24 -0400
Message-ID: <20250717053724.65995-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.9.142]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 2025717133730dbeb9e6738e4a486ccb1d56d950e6f6f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.7 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

fix build err:
 ld.lld: error: undefined symbol: crypto_req_done
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_acomp_decompress
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_alloc_acomp
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..4dfec0834733 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
+	select CRYPTO_ACOMP2
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
-- 
2.31.1


