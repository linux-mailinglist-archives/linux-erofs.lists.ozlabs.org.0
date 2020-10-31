Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCA2A1339
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Oct 2020 04:01:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CNP8Y6lNwzDqwW
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Oct 2020 14:01:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604113293;
	bh=qnnIKvHbtAIBAVuVtc2dfZ3Pr2l8NOL/zW3AqnNvT1s=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=CbjPHpgLi5/GL7wXhhwJOCww19ZLGvOsdHSGZJLc7Hl7ETPICT0FqCJ3aqi6RlVAV
	 iWIT/kAHfxozty6b9zyxTJu/qDWb7kgBFoV1MY4LOC3kg6FCEYhtadGYq41b5+85/F
	 cvPSWFebSkJhFFPJq3AyGKONMS3HihTW6QcsaRlONqrhvwFXDfbAlw8NxnuwFRgA37
	 tY/T5dw8/2HqCor2645StVE3S1rwUt4SNW4HCPxT2x9NV0pMoMxJInOBT8jb55YDRU
	 7LcWkUY8gaCnVDnvtXI54nM6VdwdHtIcjP9oVdBpD+XZmT9K87oKaSefsVXKV2vVdw
	 dBfJdN0idn0qA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.32; helo=sonic307-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=q+paeUcz; dkim-atps=neutral
Received: from sonic307-8.consmr.mail.gq1.yahoo.com
 (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CNP8S3p3szDqtV
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Oct 2020 14:01:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604113283; bh=FeHupOjDLgTuh+cfBealVPpt32jZjy4W4SnCc6bzdVk=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=q+paeUczLHsvJH0AOAXysjKu8qdYtbIlU3xLrM+4RymPdj9WPiX6CBVAUAmfx9mqON6XBWZ6cgiy/osJrQU8yvYxEp3asmUU1rnu8hNQSGVxeIGN81SmHJ/jHkDGcQGQ3G47A0zgrNMk7vOCDxlIAQJvc8RcoN4mDNSu3osCoPA972xG1oAZWnrImQiPUyyw51ZvbYlwOrOMYcfIMhP4iPS3CRFWXNpBV1iPcH4g5rQZ0NWuZ5z+Z7V/Ldd7jfWEB3jHGhDU85hfnPIOI5Q5BrCA1QCWw2U8e8qauv4SP6fZPoqZ6g5Ke38ZRP7t+0ek2yVoHt4HifQwg2M78+AvYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604113283; bh=q4eG2tq56NKbl+CuAeiwd1ENJxzC06Y7x0v4iDhXKR1=;
 h=From:To:Subject:Date;
 b=JQTQWE4lix/1xlQnx5hKC0gDvpn1Hx1CMiwppAcfpw/KqSAUiNE1czbcnrkq8OEF6QnXEKuUhU/l3+pc7Z/n4H/PUIpyFrfI2E6ugicGkGRhbFRAcnw4I8ylOSKm276EqgG4A6FhWpV/cAwC2gnxod4s7iv/Oic9O1gasq88ccVG+IU5Bu2iDxsEpRh0/isU0lZom7DRY7vyDMxh16+C79zjiP7RHKnmYnGX4FNOA6ElQqt/UVSr11ow3KlmhdobWtISBZyA7zCEdrKKFYgNnE47xEdysg9yJdFWQcnXn01wPw2UIdvKeaE6Yv9IOrbLIhN5UX2O9RYXo9YMJhd+Ew==
X-YMail-OSG: NDVVqB0VM1mOE_b4Ai0Mvz6Bfz.pQ5OCwzc0hzhPXtoIXG1Zsrhfe9t8LYEbAR4
 oDUW34G00JKB8NeN4aXmBaOSH2PlIYLsgNHLfkvExQzyL8zGEuj24mzE4yFJOWLb9D_Ks214H0B9
 8JaqRqQxtGbB_oG0ymhsEpTrdLmTc8sgxwOsW5kQrf9DrD_qxCkNUKg9D7FN1EHbornsBWiEfQPM
 oyWNzNmZMTzkIdw7BxlOVACBXcdV.KDFwqU8H1RIm0UX0QcKioryelgyiq5WKE1bySIzFkXlu2Xy
 wOBfKMlXu8mnAI2THT8ckNwbGQvgZEsyKLAgF9fKwLRvHnpoCfHMPHWosTenMajkknJdneBK2C9L
 GJLi2EglcdApXHn7PmGC9a8d6J3yuYKjz.ONhcGvKu4lGn4DMUNovwqOpTJxm5HLPVUZgboBUU5x
 nQiRNRjvcOKiWeop91.ymJjuORBN2X2Gnytlry6HTr8ccknuRJ6CCnEcxNi9QJRVJRiuMQ8mjLPo
 GCv10jWPIqv8DbWAk4ECNYjDO1WekOQ8JAM96CbL3KN9rOs_P5wzwzckGMWWRpjlLIx084GtDyBa
 KyR5kPvCX2VOKtGQZt6l1rka55VHFVxwiL8bQRF_vmpuky7DVTs87443awknaXPbao_67X87d_os
 kn7mA1c5t7BPJvuGSNhJ2vuUyWyeC_DpTBkYUn.H0jwgQ9_xD.uHyh.Kl65LOf3O01daXWeHwK9S
 SoCODjrE9dcTBSt6JT7OOdH7C4eCHBeirR9GC4yH0JP91tCqsFTpIlqR0phuqIALNYVVfFS6zAPu
 az.SjoQTKmp5kH4I0_hhMRqywRA4aJH_ymkkdlBM6iAg0lQRDxySEkTrjBu71i75Fp45UacpXltD
 xSD2ewNg4UZXQ2xCfsVSk.JbX2ne7x_MHMtiFBfoV6MY5RcRwyNYLxK1z0TRePhZYpULKsRNjaxv
 7ZblyBsSBPCRe8eS4ZblLdwwJ0p374IaCzHNsicJTPmYgAMrgubzgvbKDhQD9ondIhMLqDFGNLzo
 MeCVjLOjPdhb7dp5toKXifEEcVRu2ttfr8zhE2fDZNv1YBuC8yBk3xk7kiceE8BLLb0csE8ysUtW
 moNH_kZw58uiz2DOG9oVh5MgoJ5blqba8YrSaUexBKtdB0TtpTyDFQDgRb7nBYY8fHoMbDXKRLFJ
 k9Cek4lJkSot4tTuNNhHZGgCE.uysnmGss41rZj9MZXaNUcqvNf4juqHeNBf1bl.Xf.a4RoRxhN3
 h_RRNNW5HQ4Gnv6t9sajg1Uis5YoW.G4nBPsDob8k66EYK77JaCSorTwF2XzIcgCBWOrM392oMLx
 6fJXTL1DURd2rT.MlnxLxwfaITYhpOnagtlaNnyCYrBvnr5rx3i8PQFEliZhBCIsdAoKTC0Of4Mj
 1MWfBEOxhjI1OJUQFra55ublI3HabUPcYc3y.nHaxPYzFn.ikM6nKMNloRi.7HISbAnrF4J2Nctj
 m25adbcxR23Gvy_J4BbujzI84BMxqUXUIMVMzm1U9D2ZTvD6BDAa0JN9cIlYhW5kEL6LmRW_hr6C
 3k9YFbekFXTHgz.y9VhkIktjDVg.IS3qqWmkv8q1HQJVIBVwphSDpDePal1VzesdtAP9x76cM33Y
 Xya0An6f89ZDqpcNQOPyq4EkZMm.tlSDg2PR.fn28e5Ctc7BxI.kqmepLl1k_7heaMr_HJhEDsW2
 o9n0JBCo..AL1VD37l6C6oEzGJ66QHa.68gQQupA0M_uh6.u35cyM0PPObev.FbB53gZXFZTebrv
 Jv6KmFHxeobuLrb9zNICjegvpe1Qb11q2xaDkcM8ckKWNb2eEI4rbaYuyb5CfEq5AFp2loUjnweD
 eTm3Uekl3Sz7XBlopLC_P.FjBecNiUjn8eEJfejU8qh86BgPQ9EY5DnGi68Hc1fUuNgz86hIh703
 PbJJq54u4OlIKOUDDGzxXBITVdLz2o8LVEAKSxFxL1RwRPJsQSx4HfmqnFLzsdo6xwjYtBiLMeB1
 wZvBqXeoZNfO.c5uZ_upsgsICMk8vay7JjkIMazTRv.qu.YA6HAp.nRMZCK.sYrAKI4vuRuN6NX6
 RCTGG1TIRrvHeVsWRCiP5XmoNM.qoSsdQ9RXVYslPzsfPU_n2D8dsi6gBPpaECXSQwEwcRz59kuE
 DhVrw3QhwPt4Wpgg1LZ4T4lNg1_DLdK49.dmV2PLUyGa3eoLuUz3TZQixpE4FHCUntYYrmOVpBsW
 JwOyxHUrv_H.JpI_bGNHDWdY49p7dMzPRskgyv1DnF7KNkZpn0gLIS8jgLn.f5f2w7hyzwEZGLPS
 1kqSKRaNGh3sqJpJ0ZIxwRXwQZBZoMgR4BOwedSxHCiKNqIyTre8qOdLCMMl8Nk6eUP.POIbxuUm
 jbjJ0xBLt3KbBf5oOqyJEM3qr7gW9wmfOspdoIULQtcvjNO9.blgcfXD8hOHgAKqzzGAzqet3oQK
 37696Gabf8dgVnIeMkFtF8KcoyzThEFIIo3QE_M3r6csBqubNOMbNZqXjXnAZPrAp9tlRvpGTvbQ
 _sdZ6wmwVUzkJ0cGIK7wCZx0yDolyHRdpywTcyh6qZOdQtx2SWOyGqYhndcKbplAwkw1C2BTaY2y
 HVOcc7k8gH9i8F3CDbzFsAkYpHMMgW8jweT3mXtAD3oFV85eCQenTIeBsS50HVnfAGEB1gBnT7nq
 StXKxCAKPxjMyGnSf_enVg9NZ1SZ74DnYAMcJV5DqVS8JphyDol9LLpGr62MpctJcsIUQoy0gVTv
 7ljI5gzi_DsaQLPbolALnEGKLPEanwtgk0CffYTXR_dQaePURSJi5ew1IrW9o8d01CreiRNA73cE
 GFfNJU6J.qIYCczgaZo4yUwtjg1mkwnjftPi41QQ0pLj33RdgZjAXaCgLfoGwIbUrQPgcZl05gi1
 3InLGWJvaAxwKipV_PRywWUJ2XBDin8PwO8kdFI2xoB78ZdARLUD8IQ_mlRpEyXKapxjQblxYAjP
 ad7VuEXMR4X2_3q0VEiU0UeSeIlvRRv1BiK5XmCsjPG8u
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sat, 31 Oct 2020 03:01:23 +0000
Received: by smtp406.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 8d93c36968a2c06b61e7cf2a8cfe1ffd; 
 Sat, 31 Oct 2020 03:01:16 +0000 (UTC)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 5.8.y] erofs: avoid duplicated permission check for "trusted."
 xattrs
Date: Sat, 31 Oct 2020 11:00:58 +0800
Message-Id: <20201031030058.850-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201031030058.850-1-hsiangkao.ref@aol.com>
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
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

commit d578b46db69d125a654f509bdc9091d84e924dc8 upstream.

Don't recheck it since xattr_permission() already
checks CAP_SYS_ADMIN capability.

Just follow 5d3ce4f70172 ("f2fs: avoid duplicated permission check for "trusted." xattrs")

Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
[ Gao Xiang: since it could cause some complex Android overlay
  permission issue as well on android-5.4+, it'd be better to
  backport to 5.4+ rather than pure cleanup on mainline. ]
Cc: <stable@vger.kernel.org> # 5.4+
Link: https://lore.kernel.org/r/20200811070020.6339-1-hsiangkao@redhat.com
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 87e437e7b34f..f86e3247febc 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -473,8 +473,6 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		break;
 	case EROFS_XATTR_INDEX_SECURITY:
 		break;
-- 
2.24.0

