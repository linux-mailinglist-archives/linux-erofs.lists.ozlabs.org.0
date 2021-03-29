Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E24C34C107
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 03:23:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7vwj1rzqz301P
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 12:23:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616981013;
	bh=eqjbd9XPVN9T1S8YUn7KgLJFn/FuoUGCgnWER5Xp9f8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WPzNKENb0yr0+SsuhpWj1E/fMqctK5wS9JvZOKqE5i8r5BzY2pYf6Mlx1b9o5WX1w
	 ln8OaPPZdYnzxGfev2+/ptGnZRDYmzu1JDpRHxfw/sdrMV7E2s7HA3gF7YJQJ5+JQu
	 WsmZvF/2xL66Yk1G3fuhRrCqxfsP1RMjo2cB2htjhgB+tcuR/JBhaWM6hyaOe4Esm7
	 ita4G6LDzChEcky4MGd78cfzJSksHoEBoQbxhjPgXUNPVw1TPgPKnYO4qdkinolVJw
	 AEH+8BXJvBSiv38m2jOJc17gSoaFbcupfm7qF7akp5GC6rzpqraliladS20Tq5pKZr
	 Y5y9Qs4f6NxSA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=OIM0FmFb; dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7vwc1jtZz2yyl
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 12:23:26 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616981001; bh=FleFYLBVxh+knR0Xrnpl+o2628vwHspYRAYB9/hA3gI=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=hHuBcsURN0XDJLApm7KfqA6ioVUQFo7N/Dh7pRupl6mzQVHs2MWpJgq18mQVPN+/BCXVSJiGQyoCfG8nGfPmFRQ2wJDOelTvTUT9OGJiX3X+Z9BZ9S0b18yvuenn5QThWBe+3nqxpEVjhQsKXyO3GmAHboo2gYLcXbDBcl4RGKaha1UQ9K3XWVSMNo0p14MoCTOHxfK1yjnIPniYK9MvQvSgyb9VtmKBOxSivvsC70Z+4+0e96iRrnbKUHeXmWk57sWbXrCpkffH4ZdTOZyNsE6bo4RBLuTzKBicuXeQTyhevGk/TIftMjUlg4sIISQvrewWA1YHI+W6qeVWNf2qXA==
X-YMail-OSG: 30bfElMVM1nPtLbpxwA6z1HfY061Fy2tXgB3M0I.lKaOt7kk3FfJ.UzTKN8GhSu
 nqtWsa.MgfwUWrqd5LvRiQgmht1qTdF5tFa9Yyca8Yv08E_2vWi8snFGqVGeF6OU3WNXoWTW.7XO
 aQwkCn82viWu5FsXLrtBjTZzxSrl04eN9_5u9Mbxwkp2bvdjnf9VhQ6emZlrUDNLLujt9qqqWxND
 MyaFiBvmJb4XdfBeOB_Yk_ygsYkfSE61aWzsWO7PBQ.C8MXBevjRsGKoKmXRbvYDMPRoeHAZS2v2
 6PFr_PdVHg9ZGxfYcyEO8KLz9wDY4dEek.driTLer2Yi58MT45NeLcEX3wuSYppCL7k1i_dTi2kC
 ZKVCtkFlyVsf13_CXRWXLUaIwZrl_whEJO9VhANtvH3CmURo67OBuz8myeuWcMuebkfo_KTihF24
 R6RbVeddxT3D.FtquatMaCJzsJ2.UBKp3gj9AFx1U2ZPTNysgplTAFJgBGBfDZekzUSrcWEXjlzu
 m8nwSuJ0CCp1_R9TPCcchAGW03dZ0g.G99uk3HnLdrfcMz9NCuWwb439PoNqkF.nAds4EAeOzpCU
 JkCajsNQJcTlhWUf5zPCLiOCBNWfVnBZNBsu6WNnZnVYn5PaXe9EpTC7RCVi8ifQb2pOTnsNG3cu
 bJysS_YPoPtKr_AhqhL7aEAQPpXI55vgSZKCfnxpNGPZ.SONYWF.zvo1IiVt4eeF0CyNh56kw99c
 jzWBGWhKwzfwSwS4IXbZHFlB7OaOQI05VoJb8JvkEDUVU3RU.qDsOKp2UozNS3k7yLdlN_g1wKj2
 UCFpho5VbpQLx0FMKO3ouBmnYihDFG8ddEp5X5gaL1znytgAWwsw5J1eAL7PRhJ5tFlT0l5gI6xL
 KnMO9eprhlNXKIlzc0Ge3dUAJcPVf2RHKcdiFkH0R9zgPmg5pcoe1UFJNYmd.07cAQthnI2v6myx
 YNRmT_r19o5fIp8neMgjuXmnHvl.YvUkZeP7Q3MotoJxdn_.f.B2V3qkfjeo5BC7brHTSQ4cEvsv
 hA_7N6IESKhTo66yIKnzG3s54CIlECXVVldbpaomS_eGE6qqS0x0Kz2IcfeDESdd9Lc74cETIPTE
 u1OtC87.dwYrPb.qPbMJ9iTeoTj3SHjDQzkPNTIrElsEsws_zhbsSOVj0.G8jRBgeMTEjNv0bJQs
 e1.BmSskvBx9nBtHTaQOxDnf.EsWSLLrFnYn4wiO8ypndCEbyyezjprAawqtrmGPvp6OKuQkPAZZ
 oa91aGlxdBi8Yo_7yY85NyEzrvHrYY434E1udnryUzeamwm2BXCPGyALPsfp1fnecaB.REszoHux
 v5S9qWKoepAr0yTg6sMpW.yTiJcVEhbQ6KiYpTOBiiugTQvz3vFghnUHWLMy4TDiesRJtdJo0Q81
 tShEJZ5BQiK.05eF3lDZmaozXqjBX0zauuW55vpQUTM6LXL2uxox88aZG269_VmRXoHRbuT0XjPs
 zhcn2IhnTXLFdQGZc0TJSXNMfm7Lz_rY7rHv0CO2MXJctvqEHrpserS9p66fSHTm7MSQ8T_HoIG2
 x9OqO19D7IAEP_35K2FBelLbo8k_R2lE1CtkIx3i62dLdqy91zSGN.ZABYbjzZx6QEP0AzyILrqs
 t04MF2rZSf3M90As82JbYn8nGMLLRLcSyr80dCf1mYLzdovQEREZ5TWn2QrsH.qVwfYETx7aQqQI
 PaVH8XeWaw.blA06MJKah_us0KE1b8h662JgTIlAnLiQ0QbmEWy9fULPbZMSqxm87EiYTBsAAgbr
 UtVhUrq5B64QtPx47d.ZpWYjf7oJhsfJCbjYVzYetINqD2jUDqhfHdRGWZlgPDd4Vv3xG9o77nCB
 J.zWoSdYelBFPNA5lS0RrO4iXJbnmhRs8ChGu4CON_ZJ7NhUU9LkGtmQXuqjOgT6_jVOWZdPjA8_
 yEqsSB5eNUHPxwPy8Og.fDNFKXi.w10eIz6OLPwcD_Mw5wC2TSZfdHbllRiqjbB5N2Coa6MU4SIV
 WhMufeudIhtnBjAMhdk8TtP2_KNyQWvG2_ilIegc9AvrlVGOjqWa1m4CRuCvXob1VsyTWcHru2oW
 Hcal30gDPHyVktjmKb8fl_xRAJ3gjG9lfHpFn_7Pu6fWeYziwniAUXRhDWoill0pYfW0C6pSGRuf
 aI82sE5CQOGvRVa5cuQwH00e0U87T3DvtsrPVmAfzPycXTZnBipLIqkSV19O84luuYwn34AqWEOF
 FEclDOC5MjskWowXV0MSO5yad7F4LgYCcPRZaUBAz1PHiyffaQsrHfjxixqbN10Nca5e7tFh5npF
 GEETp9eVahK9J46NUy3OSpcMgWUF6aHLcbyS.JFJQqBjEfDSIhwZyAqe8sxqrZVxVM1mFfg89xgj
 LpYVV7YurvBUhNg.HCEzZKQDCkim2rdkTi3MpwghPsdR9sKhA4KOYdGn_puGOI8S4rBJ4CKmp61_
 PZQIoQXUX8py6N.dnffznd2Cik17Lr0Zbje3yjG1DhSMizcraVGsOsf5QVWeduQpV9OzAM9DJHQS
 QaNpiXnRDFlicPwV.k71yq46EMroVtEwmlffCdfO6v.CMjh06CxWp6HVX7UjEG45tK1UUs9i20ih
 2i3jrJ6qtTc4uDyZj7L2mSnoUQ1t3IVW0ay9J35Mnefu.rA--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 01:23:21 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3d9d64f8790c67205a0f6cb47abdabe6; 
 Mon, 29 Mar 2021 01:23:17 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 0/4] erofs: introduce on-disk compression configurations
Date: Mon, 29 Mar 2021 09:23:04 +0800
Message-Id: <20210329012308.28743-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210329012308.28743-1-hsiangkao.ref@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Hi folks,

When we provides support for different algorithms or big pcluster, it'd
be necessary to record some configuration in the per-fs basis.

For example, when big pcluster feature for lz4 is enabled, we need to
know the largest pclustersize in the whole fs instance to adjust per-CPU
buffers in advance, which will be used to handle in-place decompression
failure for inplace IO then. And we also need to record global arguments
(e.g. dict_size) for the upcoming LZMA algorithm support.

Therefore, this patchset introduces a new INCOMPAT feature called
COMPR_CFGS, which provides an available algorithm bitmap in the sb
and a variable array list to store corresponding arguments for each
available algorithms.

Since such a INCOMPAT sb feature will be introduced, it'd be better to
reuse such bit for BIGPCLUSTER feature as well since BIGPCLUSTER feature
depends on COMPR_CFGS and will be released together with COMPR_CFGS.

If COMPR_CFGS is disabled, the field of available algorithm bitmap would
become a lz4_max_distance (which is now reserved as 0), and max_distance
can be safely ignored for old kernels since 64k lz4 dictionary is always
enough even new images could reduce the sliding window.

Thanks,
Gao Xiang

Changes since v1:
 - [2/4] add a comment on lz4_max_distance (Chao);
 - [4/4] fix a misplaced label (Chao);
 - [4/4] enable COMPR_CFGS with BIG_PCLUSTER later since they share
         the same bit.

Gao Xiang (3):
  erofs: introduce erofs_sb_has_xxx() helpers
  erofs: introduce on-disk lz4 fs configurations
  erofs: add on-disk compression configurations

Huang Jianan (1):
  erofs: support adjust lz4 history window size

 fs/erofs/decompressor.c |  35 ++++++++--
 fs/erofs/erofs_fs.h     |  20 +++++-
 fs/erofs/internal.h     |  33 +++++++++
 fs/erofs/super.c        | 147 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 224 insertions(+), 11 deletions(-)

-- 
2.20.1

