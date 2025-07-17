Return-Path: <linux-erofs+bounces-650-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BAB082A7
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 03:59:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjGLg4z1tz2yF1;
	Thu, 17 Jul 2025 11:59:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.247
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752717547;
	cv=none; b=Gtw7mgHPLRYhe2f2WTV+EXu7A7SYxUwKFjhEHqeF98ocaaFodMnhdVXi/6y0SYdbn+R35a36ysQ8LpaDbsbKVa4ZgfG8+l2OnOEEJ4GE1hwe+CSCoVHZIUeGIwiznbzpYZcoDExtmCYpSldXrZTyt02kHojXX52OcnjPghR67nA6RireXXyvgxEInSESSHPcpeMcQA4/p9zjoLF5pGVy8zr2pFUOXZhHNvZdEkFD5Zh/w0xHjgLaCDwfcPgJxoRYoy6chV113XY0Uh2vc+3NMGDrCbE6x/C2bTd1cnZ+dsfhdR6/HKKtZ6nGudfCpjGpNfhECWrEMxd4N/2vp2fNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752717547; c=relaxed/relaxed;
	bh=N8M3/dOOczfrUoDujFmC0xvnF/Lg8Z70JkSj4q+LSGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iB+2de2xXRfQVC3fyTNLE+hT65H8Bq9XHzTgZPT+tGG/jg4e6yW2oLRwaiicPq/qw46nr4Hq3VK7EIYp5Kv/UHa44rnWgTiLlu7v7rwLJrr41VA8zqbvXyaZxd01LMjXQiOB/tTONBWX28HkCXGy/o8mxJiXa9YT51B8OJBxla5qviSTTeVslSjffsY2Gac2iNneg4kNPwyqfoJcBnNbwX1kYfR9fYF5QYbibE1EXufXn2Pr2O+rYPHbwRm0GetkR6WKSUS8iFT0MhSd0HN0fW+mfY5GrX3rq49wsiVRa4BYI79xmiO+HSWSokpV74zDNg9f5GyVPmCL6E+2diSSrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjGLf23KXz2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 11:59:03 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202507170958577543;
        Thu, 17 Jul 2025 09:58:57 +0800
Received: from localhost.localdomain (10.94.15.194) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 09:58:57 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v2] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Wed, 16 Jul 2025 21:58:48 -0400
Message-ID: <20250717015848.4804-1-liubo03@inspur.com>
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
X-Originating-IP: [10.94.15.194]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 20257170958579e39912c5d14bf5a236e6e429856e73f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
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

v1: https://lore.kernel.org/linux-erofs/7a1dbee70a604583bae5a29f690f4231@inspur.com/T/#t

change since v1:
- add Fixes commits
---
 fs/erofs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..60510a041bf1 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
+	select CRYPTO
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
-- 
2.31.1


