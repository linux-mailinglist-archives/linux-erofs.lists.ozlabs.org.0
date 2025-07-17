Return-Path: <linux-erofs+bounces-646-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF8B08279
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 03:36:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjFs26XDpz2yF1;
	Thu, 17 Jul 2025 11:36:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752716214;
	cv=none; b=lwmAUWieOjpTpcQYaJvRris8RjXFzmWENkPjvuyi0PwYnFT7YJCZ/LzAMcPl1xIhSIKohXHC4XnAVL9wYu34WJZBXn6BdJb5sXwJk6fsm3KYWmSmB6VN+wvh8dpeGoE4iB0usHAwaj4ko0p6cG2whNj27RVhhsu+TIHItJuxeS8C+eXky7wiUyxX3Vq1IBwt07d3y/3z1R9f9mTEN7Y+uzvM0P5OIS8DwMF1IzJYm7bdo6Nw1e/95kTQ9yBy+HTeZaUOXcdbPm2i67tNsqLDFZUj5kRAIjWw1UnIJsjltU9dFuX+HkpoOK0CKadiB97/tkmjsi7yZKoUromoaiM/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752716214; c=relaxed/relaxed;
	bh=w6qjQ9Y6Hqo2yWLyLJGUb4I/vMyUpiddz9h3sTgrsWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fMMfgoixhiW72BhwaKVXBHl8x62PvOBNZQrZtOxv7klOy/1LAVX2tE1BmpDZZzLuoy8ztRyVHdBwuPi/JivVhuf+erJ0yLRl5bIcKNEVqXDJaAS9cwIQZFwd6DazEZIba06u8PI+6w+bJU9pWINRtfbpWlQSZzcHy0TzCTl1WY0JXZmGXSUOKURPwwQly3HFnXxVuz43irenBLwRrlIi0xoMjJzawQ0n99Tjs+VzQpvrtxc8nVveww1hhOT1efRBTmF/Psg7LhI41YsqPMtNkf4vaM66YbVEVDnEAxyyYA/5c1VhHCwbCJZaR4Ht66Qo478HL3edDcPycgwiZPKkqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjFs11RMWz2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 11:36:49 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507170936400856;
        Thu, 17 Jul 2025 09:36:40 +0800
Received: from localhost.localdomain (10.94.14.188) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 09:36:40 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Wed, 16 Jul 2025 21:34:31 -0400
Message-ID: <20250717013431.15589-1-liubo03@inspur.com>
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
X-Originating-IP: [10.94.14.188]
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 202571709364085b46b73e7c417b7275f06097cc29a55
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

Signed-off-by: Bo Liu <liubo03@inspur.com>
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


