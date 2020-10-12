Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36F28AF1B
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Oct 2020 09:35:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C8r7H2gywzDqW2
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Oct 2020 18:35:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602488123;
	bh=DFD5OlRQ+ljW/65qoWA5IWeOm/yKudQTnM64dTZ0AM8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=FSDerIDfU5bL+T63QIhdnC50trmMTucFdZZwns1JGLHuYwaB5DR4AAOy0TD/Pdcxs
	 m11AXCqDx30PGTVl5RKw2HI7j9qon+gNNg+eLPhKWjbWXwe9zxzyZlfGvE+VkxXoCW
	 l0nTivISctwlQHGqyyuU5OSBkyN2NHIHw3Pl88ERnwc0lRAndjyc699FHVbZqMk9QP
	 tKDYl7+ZoxSMXoGEJQSDoLFIiKZf/xYrdSDKqzj32ecY/sojN2n28e+IDI8isEx+EM
	 rY5RxSfNYfbuMdw13nKgtH7pSjirLy55xYBxyh9V2ZU8mGRPFiZz3NEHn2ik8Ci65J
	 QiBcdxPb6w+vA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=e1d+fZEH; dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8r775MFgzDqLV
 for <linux-erofs@lists.ozlabs.org>; Mon, 12 Oct 2020 18:35:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602488107; bh=p0BkvBL4SuORUkpzAx9J0w+rP1vn2iOf9a/Cindhx0s=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=e1d+fZEH982IJDLb+VIiI0It59LtgZfddD/8Q0fK2s9nVXRy+B5CzFxHPi4liPsVBJyO2xCOFJN74LJ3nChTUAwKJO4HnEm1W05G/2bp19CAQ23/PeCoMVbVe/knusmVtnS3MFSCSBwLrtajpsHR7owvfX7A+/CP4HaJ9KVkmk56+3EQqzcp7KY5R4k7ylUGxoT0WwVhSAPBTVFo5b+qKoO+gN6ZGdswH1owf6MLGUfsuxX9kVjSJfJpcH4OrxeJCCEWujYnPD5fpCTgtu0Q+u7ugveviFwhzD9Lz8qmyTCRT3kgm/AH4bwktDs9pvwCsv3F2neJhz2BbU0/E0jQyQ==
X-YMail-OSG: nQzN5_QVM1mVttp15QJKFye2HI4U2F6s4oNZ1bXG_YLuRdnsxD56rtE9GrpqBy1
 bNBXJYN7ATBB.Suhvgd7vD_2snDsYBd0phiFjihI.pLfW..47Z9Zr0m6U0pk3scDeJ5DBYd_vfeQ
 CDRrOz75gKSNnBr4Uf__gPq5dehwTP3MmwcCigi19UwE5Mjz8jkTcQ2AVTLDvMSXup4KUgvBceCj
 6QPSpO2yNVtkvm2gAt0lPMKyjntrZysT4oCceoBUezb5721id.Lba0SHlIscuXXgcyN0SzTFnf2C
 z0_firP8aTH9y3gfNu7g6Y38UQu9aRRBU07BKao6XeLhyKQEME37I3l_5z2zLrvwKA3XC2vhrUOq
 G9cOS7WMeDrdmaPTeJkjw7ocggsLt2NZntYOIToanFJe3.XQgjPnzq8FDAfT5LclSoUAhw.pkLT7
 dUJX_e0Hud_myAtGlp.OR9XzTulIIqUlx_9MADVaUPc14ziz3mpVrnMz59v24d4rwtH6t0U01WWq
 dEAKxxN_TXbGdPBRiwxmy9RGgu_6acaYhSK2XBsbksnam45fZUaQDNfPIjkQfvEJKnwbAUEukv6A
 nZUgfxIrSSkVv8WB1Xtz1oThhFwSIETiY7E6HFYPXxorZ6NoTYGt_Ko5fcw9VGPaUVmQUaolRMXQ
 5Ca25LfOt5YxUA2QhezkAnAR2FUQbJYpmJ4.wGY8Ohco2mMqbXypYSj82wT08ygdo1jJ7UGzSnk8
 54EBAra3PThgYx0jSXGrGip8TihQBbaTH51qPb01skIqsJbIrsidX2p0Z92GJssx7W_QrjOqTioW
 8VbBMG7P.yM8ndhpqrNMUbdikLPiUfQ0Qvk2bubeZFoBV5EIaipO8mIP9F6wJbyDL8CuVq6bkmfh
 1UlTtxgUKGvUTDh4WvVuHjNfITBibRLwrd2ANJdpjfuQ2bNy8VXiHjcNhbrEM0ZRm1Tj5ZuK5FCt
 0_80ejpy1m0PiihEzJocHuDHEW6AhA.hWu66u9qW4.eCvdyjuMnIz5nCO7uVh3dNFZcqBfUF08jX
 U745xVs21Iiu7EaaoOIApnMH4VtESKTYbAJCspxSqbJt9gAgwf6oBLuEYRUC7qYsIcd4OyHlJru3
 PfC5jpfEt5RovruWg91PLuE7kKJe_N9DrXG4w12MyTr3VGvy0e9YXagXl1b7rM0XDByl8c_JiBTd
 KiJ5OyzDz.N.9xAuUiCCCv1AwfTtCtnFT7Te7_Yf6Ddw7BXXpfiS_KtRr7_gP.82V5VBdGgWFaVc
 W3vsUeNyhNEdfRc.80J7I69MPlEWfJyXxKgQwC2PDlTAvmDGri6Nae_urwsHPzHvypVlSl9dXLFm
 MBAJXxY4CFJfEjuUSpElm.CTXGrt2qWZfCPoZDidvXTcPpp0X.h99d7Fp_UA6tXGmZJJHx1yoCx_
 wcQ.HMAfP.i5NTuc.mt8qgOCM9bVpc6E5zHrHhW0MCrXMAtvC6Mq.i2Y.aJNY2HhbToZk3Hr7S0d
 Go6.C07Bk_Bz1uuZOXvAPqhCPcgdLkt6syZ131y6raRPGKQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Mon, 12 Oct 2020 07:35:07 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 07bdac6b7c86c1d73ee5b2b6382f50f2; 
 Mon, 12 Oct 2020 07:35:01 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: README: update known-issue status of lz4hc
Date: Mon, 12 Oct 2020 15:34:46 +0800
Message-Id: <20201012073446.18103-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201012073446.18103-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Known issue of LZ4_compress_HC_destSize() mentioned in README
was targeted by lz4 upstream days ago.

Update README so all users can be noticed.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/README b/README
index 60b8eed6c1d3..5addd6b80e04 100644
--- a/README
+++ b/README
@@ -78,6 +78,11 @@ Known issues
    LZ4_compress_HC_destSize()
    https://github.com/lz4/lz4/issues/784
 
+   which has been resolved in
+   https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
+
+   and will be included in lz4-1.9.3 if all goes well.
+
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.24.0

