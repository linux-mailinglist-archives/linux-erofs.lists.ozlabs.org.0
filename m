Return-Path: <linux-erofs+bounces-860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA1B2F478
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 11:48:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6z5d2LhQz2ydj;
	Thu, 21 Aug 2025 19:48:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755769685;
	cv=none; b=atjXBYGV+XLtXaT1qHUJ/zUDZYVsvGXWdR7KkfOrlU254t6MPt4dHeHZQC4xjb96e9TBYmTfKKkUCcNFpJxqcd4KU4pQXpUyASzUA0AdtOiQRTwC2/2LxKT8A8w0gsBAFMA/GQECB5eefiZKSZTgUBDfmnUupI8E5ilqnUHy7e6nyvxAuSv6pupPBSRJTTpUKiWLuNObbQwO/SlUORwMj4ko3BDOTU2hq32V25t0eXZmbYRdVWlwXhxKFAN/YeFPf5sQJZSX+EIVOtJliPNE5XMJ5atwjOmH3oF6+dTwyf+x/R1mPDBd1rCqBbMeBMoYhQWQiiG6gOpvkb00ZGtP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755769685; c=relaxed/relaxed;
	bh=WRpVITYQACcouR/Yb5lAqmjELogbdfbIz8t5ESfurWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nryf2Oxk3IwCr5ItSUNcaKAC5mHPnR5Ai021oNUp+z+7OByl6yy2k9rrIFPB4ZF+lgo2s+KE/AVi7V7vGftJ/5KKc1VGkCMMl3iSKfGCyfUXOac7UKMjarre9hfO5BDkTWu3f5wqiGGaXiwzFX3n2ip9Upl2s271zg1sQGQr17dh2crrUmiUSARijCFl3NO9MB69VjrS4Pnvn4g8OJ27oae9pe1gRLYuMuIGDCeZWnDld+HueiI0e+zv1F5xkTa1nZjVXkwrA1e5YyilhiRIoxf+FgrCHrTTPDANi5hW0eqCqQESWK2uQNF75AuaavFOqq2bg1Uy6oZb52508718rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B94f2qAO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B94f2qAO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6z5b1Q5Wz2yhD
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 19:48:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755769677; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WRpVITYQACcouR/Yb5lAqmjELogbdfbIz8t5ESfurWM=;
	b=B94f2qAO0lETMV1VT84eS8ut5JmrnN3m+pcC4jQQBUyPQPw5M+Ua+d3wVtqES5yrgtrjiD97DqIUL5ZPHuuiiee2fBtCdV6hNVRJb+KSANpCRBpLNHSKPfvffYvv2+GwjuwMjyqdtbdtaoszTpDNQXL7FlTaiutNG9ogmuD3OZU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmFdvuj_1755769670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 17:47:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-erofs@lists.ozlabs.org,
	"Bo Liu (OpenAnolis)" <liubo03@inspur.com>,
	kernel test robot <lkp@intel.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.16.y 1/2] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Thu, 21 Aug 2025 17:47:48 +0800
Message-ID: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: "Bo Liu (OpenAnolis)" <liubo03@inspur.com>

commit 5e0bf36fd156b8d9b09f8481ee6daa6cdba1b064 upstream.

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
Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
Link: https://lore.kernel.org/r/20250718033039.3609-1-liubo03@inspur.com
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Also backport commit 74da24f0ac9b to address:
 https://lore.kernel.org/r/ca432b9e-e016-4d2d-b137-79def0aaca85@kernel.org

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
2.43.5


