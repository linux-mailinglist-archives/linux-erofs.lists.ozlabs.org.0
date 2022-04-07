Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B44F750F
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 07:08:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYqCQ5dcVz2yjS
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 15:08:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1649308098;
	bh=tiXPEGMJ02IDfMbTktJwv155Tq6JqYutOMaCPVS4DGE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gHSiiNDnXaDliA3n2ZyT2M2c2jBV1h7AfIwL7glISPOlS/2C6iwmRBBdnA513pQHq
	 w7U11HbrhVyrrJbbkCSD1KwAlMQXW2WO+qfFqvxAZXiTYYDdNs+nqpzIyqqHIpB8Ac
	 dcinVjjJGmvkAt8zt/vkwLzpW66j9F3EeDoyQ9tz3KcxnDamvKEDkABQ1L9YOC8lDZ
	 XeFBkLXJK3V886rbAb3MH9lbo+Rfv1qRDS8uyFpnpCPeG9zg9LOPdmZLQkEYZPdIpE
	 O3lTzftcrOZdB1ZD+I2lQ4nJQxfoaIaTm7OA0uxBytItTcxYNP+tYnBnK7XFPURBPp
	 NAHzz2tDUIohw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=coolpad.com (client-ip=101.36.218.16; helo=v01.bc.feishu.cn;
 envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn
 header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1
 header.b=qNcngRxO; dkim-atps=neutral
X-Greylist: delayed 201 seconds by postgrey-1.36 at boromir;
 Thu, 07 Apr 2022 15:08:03 AEST
Received: from v01.bc.feishu.cn (v01.bc.feishu.cn [101.36.218.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYqC767NQz2xsW
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Apr 2022 15:08:02 +1000 (AEST)
To: <xiang@kernel.org>, <chao@kernel.org>
Message-Id: <20220407050505.12683-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH resend] erofs: do not prompt for risk any more when using big
 pcluster
Date: Thu, 07 Apr 2022 13:05:43 +0800
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary=935ee8ef104aa0c31a81bf49af574284f332759ce00b1850544cbca10576
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
From: Yue Hu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yue Hu <huyue2@coolpad.com>
Cc: zhangwen@coolpad.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--935ee8ef104aa0c31a81bf49af574284f332759ce00b1850544cbca10576
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

The big pcluster feature has been merged for a year, it has been mostly
stable now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3efa686c7644..0f445f7e1df8 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			erofs_err(sb, "too large lz4 pclusterblks %u",
 				  sbi->lz4.max_pclusterblks);
 			return -EINVAL;
-		} else if (sbi->lz4.max_pclusterblks >=3D 2) {
-			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at your o=
wn risk!");
 		}
 	} else {
 		distance =3D le16_to_cpu(dsb->u1.lz4_max_distance);
--=20
2.17.1
--935ee8ef104aa0c31a81bf49af574284f332759ce00b1850544cbca10576
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>The big pcluster feature has been merged for a year, it has been mostly
<br>stable now.
<br>
<br>Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>---
<br> fs/erofs/decompressor.c | 2 --
<br> 1 file changed, 2 deletions(-)
<br>
<br>diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
<br>index 3efa686c7644..0f445f7e1df8 100644
<br>--- a/fs/erofs/decompressor.c
<br>+++ b/fs/erofs/decompressor.c
<br>@@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
<br> 			erofs_err(sb, "too large lz4 pclusterblks %u",
<br> 				  sbi->lz4.max_pclusterblks);
<br> 			return -EINVAL;
<br>-		} else if (sbi->lz4.max_pclusterblks >=3D 2) {
<br>-			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at yo=
ur own risk!");
<br> 		}
<br> 	} else {
<br> 		distance =3D le16_to_cpu(dsb->u1.lz4_max_distance);
<br>--=20
<br>2.17.1</p>
--935ee8ef104aa0c31a81bf49af574284f332759ce00b1850544cbca10576--
