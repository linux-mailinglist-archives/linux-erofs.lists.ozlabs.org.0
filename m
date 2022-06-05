Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861A53DAA9
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jun 2022 09:14:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LG7DB6g3Sz3bl3
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jun 2022 17:14:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=BELKzJtj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=101.36.218.2; helo=v00.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=BELKzJtj;
	dkim-atps=neutral
X-Greylist: delayed 615 seconds by postgrey-1.36 at boromir; Sun, 05 Jun 2022 17:14:40 AEST
Received: from v00.bc.feishu.cn (v00.bc.feishu.cn [101.36.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LG7D06Y4Yz3bXg
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Jun 2022 17:14:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1654412534;
  h=mime-version:from:date:message-id:subject:to;
 bh=jl+6QmbGl5wE99eHYE96ZM8S7lzoKnq05HvX4Lp1ND0=;
 b=BELKzJtjC39rGDP2HlaMNx6QgfIScybDuxSCVuZvDwM8PmDrqD2u4kUDdhWvdVvT0BVxDY
 BnBYZfEKnN0eMESqTBdGfXAhArbPUK2K0YyJWK6Fq9K0CILamSjtazFfjwAAJ4XYturPWg
 en6qSeTlwaOO0zwvGx+VrRd+xea68Om45WdXE61jSZJfHzE1Zq3fG0/kFAg60vExUatrKw
 y6yuJDaIo105/in+mcjfAB+oD7H29gwKhh2iTOXzGZA36BR89uqGOmGpSlBQWkEurvpsk4
 T9UGd5yoo+LzMfkMsoLLWFl/T4NkYZMmFQVSUjMUAEzGpc1ergaXVma5+BgBOA==
Message-Id: <20220605070133.4280-1-huyue2@coolpad.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+2629c54ec+e51c0b+lists.ozlabs.org+huyue2@coolpad.com>
To: <xiang@kernel.org>, <chao@kernel.org>
From: "Yue Hu" <huyue2@coolpad.com>
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Type: multipart/alternative;
 boundary=2686b63449307b446e706d386fa3ba56f156d59f521a6ffa3e23bbeed4cd
Date: Sun, 05 Jun 2022 15:02:04 +0800
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--2686b63449307b446e706d386fa3ba56f156d59f521a6ffa3e23bbeed4cd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

I have been doing some erofs patches. Now I have the time and would like
to help with the reviews.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2691d8a219f..2d0e28d7773b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
 EROFS FILE SYSTEM
 M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
+R:	Yue Hu <huyue2@coolpad.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
--=20
2.17.1
--2686b63449307b446e706d386fa3ba56f156d59f521a6ffa3e23bbeed4cd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>I have been doing some erofs patches. Now I have the time and would like
<br>to help with the reviews.
<br>
<br>Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>---
<br> MAINTAINERS | 1 +
<br> 1 file changed, 1 insertion(+)
<br>
<br>diff --git a/MAINTAINERS b/MAINTAINERS
<br>index d2691d8a219f..2d0e28d7773b 100644
<br>--- a/MAINTAINERS
<br>+++ b/MAINTAINERS
<br>@@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
<br> EROFS FILE SYSTEM
<br> M:	Gao Xiang <xiang@kernel.org>
<br> M:	Chao Yu <chao@kernel.org>
<br>+R:	Yue Hu <huyue2@coolpad.com>
<br> L:	linux-erofs@lists.ozlabs.org
<br> S:	Maintained
<br> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
<br>--=20
<br>2.17.1</p>
--2686b63449307b446e706d386fa3ba56f156d59f521a6ffa3e23bbeed4cd--
