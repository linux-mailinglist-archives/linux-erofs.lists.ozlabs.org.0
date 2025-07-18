Return-Path: <linux-erofs+bounces-665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D7B09A2B
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 05:31:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjwLB4NXtz2yD5;
	Fri, 18 Jul 2025 13:30:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752809458;
	cv=none; b=QCXRWne2Imz/Idpp+hgOj/4k3BEYfsBs1kIJS82KxWi6wpjULm4EihD3s4E1B52Us9+iaifXRAW4KWauOBNOo69mkhl//EzTI+zo3/Lw4xlJYsdcEGNaN83P+eiHKIM7Z/ZpbN87TnM85HnAWxBXJg5TXoyv6VrWvUC4uFP+L730FxLYRGH62C93/ikm7XkXytt4t0ppjxbkYdKYvhsZn7KdIaMvIWACXdcefS8Uay6h1nzQ4RPpNZho/XBG4wT1g3Fl/z8yurKHpov2hqpbsAAhAfmwah7oIjZ1A+uHMBrTBf5erT7GifK8Hdc3BGcZxvzeV029+fqLrxmKNZmJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752809458; c=relaxed/relaxed;
	bh=TO61bo5brYGjDppTI+bLWgvsPrFshIBZY++GhS5ttP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sl4raSA1RUIRaZqls9iK1Q22DyiblszJ1o56gX3Ylj4+CbLLJUxqCFp3PqIMFVpkVieeFmCuKqN8BD7x5atZqWysPV4Ale3lchhGu+aJ7qbMbE0uxeLfpdWwyodGpW+ghPTcHMwZleEvBXLgx6Dtuf2b+r1I6AgaQpNpq9adb7KVLW8/z3uFClWEbke96LnO0d9i4nXWXRSOO/LzW9Xf0OISkSfdS/ktO3WKGWw6w+fcCLxzLOV782b2FbW2n6RJa2o3RWIGTOg/Eq793BFg67i6yGURyvktVoI6cjgA44mpXYnyhGOeTVrm+a+cRT4rmA6mSRLHXmCq2/qMrgdwew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjwL85xF0z2y8W
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 13:30:52 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507181130422850;
        Fri, 18 Jul 2025 11:30:42 +0800
Received: from localhost.localdomain (10.94.18.81) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 18 Jul 2025 11:30:43 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v4] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Thu, 17 Jul 2025 23:30:39 -0400
Message-ID: <20250718033039.3609-1-liubo03@inspur.com>
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
X-Originating-IP: [10.94.18.81]
X-ClientProxiedBy: Jtjnmail201617.home.langchao.com (10.100.2.17) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 20257181130422c6370c10a21dd3e58b20e7c397c0a3b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [210.51.26.146 listed in zen.spamhaus.org]
	*  0.7 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
	*      [210.51.26.146 listed in zen.spamhaus.org]
	* -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/, low
	*      trust
	*      [210.51.26.146 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H5 RBL: Excellent reputation (+5)
	*      [210.51.26.146 listed in wl.mailspike.net]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
X-Spam-Level: ***
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

change since v3:
- change Kconfg to select CRYPTO and CRYPTO_DEFLATE

---
 fs/erofs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..7b26efc271ee 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -147,6 +147,8 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
+	select CRYPTO
+	select CRYPTO_DEFLATE
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
-- 
2.31.1


