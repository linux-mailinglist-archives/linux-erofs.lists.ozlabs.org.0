Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D270300959
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 18:12:44 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMm6K34xjzDrq8
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 04:12:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1611335561;
	bh=gtFaGnWhVtW+MZT/tG0VddjTF6Fig3frthNtXkK++gM=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=LOPlDi11n6x5ko3aoktP0Te/QvBi31ET9Y5KtGfViu/rXu2MwI/SlL8pZTHoFqNJU
	 FlCdL6k6DxNnZEHnjnIwB13RhfWcP2wPW0+HdPsrtJ4fL63SIt7xZ+cSdGFKFGOwVr
	 AvnqkSMBk04AAPTZ0I8DiaFaIaeWgZ1cnc/vHUrIasTe7YkAJWc3SLYfGf7oaGsz4t
	 xSJ+IVasea74orfOBV/C+nq99KjGqAy/aQl/G9Kk3knBxMqPEKd4v48uklDdQzmKa6
	 K8A1CuxE4y2p9MvlUm0fu9H0JnS5BjxnqR46nfgJjaGvf9f+eztFaxmpCmu7cfcm0l
	 4CumYcjiNxbgA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=JXdW1J9X; dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMm61188CzDrp4
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 04:12:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1611335536; bh=YmuKOcdoI/QZbIwlWOe7CRGkvqwVh9W4g4UFciMvEVw=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=JXdW1J9XTCEgCYd9xjnOg62pt/EXSj3HR9MIfEMzUKxfYRSa7U9W9zZuOE8wT2IXJzw3ovfduXfIbP9Ea7tLuMMIHW6TUupq2hOLIv79jdGAaifSU/ZOnaNdl1P+XHNf4m5jEFM8yyqo1ILQbcwmbsijO8aQ8hPJzW3tXdtvixEsEpRpiPJbgvPJ0/Da2GC+V7kIia0YqAE0+BAdlTXaKLzaAncQm0CsLhAu158eF+fgFm1oadTE2ESA+ifhi1Xk1vIeyJJyf/R0HniacB/zww22P6Sx5NrS6zbYd2sqHiy5rcfcNAyba4KujmGaQ2J+AYOGVchssbcGItkcQljBJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1611335536; bh=FNv7D6Z2ICAj9b4Ss2esTpbc/B2oXiu7kW5jUKwCrxF=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=WwnPlzdbMh9wmSNwrvkiW252F/F5RouKbBAq6jgF8puwz5cJud3DWsx4ePnPOoSu9FonK0clLS7yMk9WeOZsYaNhRhW/2Hte/16olvtwNI/v3hwFJ2BUzi/HK4kc1tfn5hboCoCjs+IbXDnELNszXcsM5w1X8d5b0JKN/fpiBFrvqRsgGkwM8oRQ2Xg5GMH+fD2G41b+giSHORMENpQrGnsxRZ533R5swD/aoXYCZf0jPbLzhroBe1dlt+tFwWri79JDruHYG/FwnomtrLtOwUZxOpzgj6xFNA7RBiT1IrfllnxqfKVQcFoZLGstTtuBaMKD6Kethk2b/0XVlk/WMQ==
X-YMail-OSG: G6.qK2EVM1l4vw1QkgMQ2XKJsrU.m9GCVoLEVLZ5NEN9IdOoC_alTXtIB8ln6Og
 6Rk0LojWr29bIevIkK3wPVDf5KReDmD56hPWeFaSezCRNJBi1u5r9ETMyrWtlvW6MXyw43L757DD
 r8OhYHiePm2OW.i60ZXIP3RrrUTroPtDEvL8rZQq88Fg7_0rQML.ofyPGX0biZOKlvSQtuG.CPEg
 4hz3xlB_2K.no3lDWcGibqURWPzRMTjV.YC.2wfT0HQMIACPeGyaQhNPSVpIHrQBe13g4U1cCsvx
 FPDhR6bKjFeIdijUAujyhDyctjqn5ATRWlmwvGqSl_iy1x1vVbQYELHS1rFoveH8lYeLdA90m22e
 tSsxjK4MAT16pUfcj78_x6U9obuiQBIrsxEsyQAEDVZyPg2AgCpjHpsJlyrg8X3M7s.8N.dR9U7W
 sOBGwLYDpOEldhU6ASVZ9r7etzJdQwzK0Fsx3xrfdjERpTj47QYWsJpfciz3t9Kr_O_qWO5it1NH
 bwBMCTg9MU520caBOJf8OVOqSifgURJBj2SDO.Zma8M65dJI2Ej6Of5ulZLeGbCTzrj4mLssGEr4
 ThYxCJacEl36.ivCREhzMAASbAcW58Ay5VDAKWJ4OJVB5WAsVDfwtwvf385j5y0_3WXUG6CAVBUk
 pxwNXIXfzcTC6ZqItXPw8fCxTD7b0HsuOpvgjgL7p2Qa0iRlZAa_egUtxcLUf1.HfXXb9IQ3OgDU
 scHGigV52tYobdjyVddGV3ex932goXg6cNMu.U7D6d6.D2NnS.SxBMmNs1msKWuotGxPNpq9PYVr
 b7OwblKNI3Bb_VbEkH1FzoxIyp00bohkCwCexVYebvLGPcZq65OGSU5o4oIHOeOxge7EhvccWdPp
 v8MC7UrU2cUrkX.s4VcbgTZbb_TMCbgO5YeW6z9byUG_EUejh67TwlCNXzF8.yiyEAaIkgLdmn5U
 .i3MZ43yxxGvsRCJ0fAoDdwwvGJpp_rEX_yMAMe37OMAnuvhNOqThKMdoQCAEpKVoip9zhloqr6e
 A3cBPRgB6U.UpJLpR2KZTgYcnuupv.I0uA3RlwWPEc4LHw9ZO2Ih0xO2ysQWP6hprtsBzlZ6SAhm
 g1_9TjqaprOJW6U_.IpIpMj4RuL4qGXt8CXjX1nZaiTudCY2cojlT5rwTxSrAZIaoHAr1O2XGUme
 UTAMzCVOo3UlcgVnEBVFzAxzgKlrbQQ0KcHls_VTGDIWk12Yd8WfqY_oKso8EWrLFLOtpQmUusYo
 9GRVyAP4vHTwTgwYL40GGcHLiI8bNQbElGtCkxxyU6JA5PCkJ0Wbfu_v2gPRt0aANZh1NWdZcmmY
 9mRtCE5x1kDq3ZJpbt_Lpb_kowK7KQAgAzyF938lpzHrOG2UPKOC8TTDoGAECWoONtYFpT5fVPCq
 fkEYXZoL1uR1jAqCwed7RjiPGlKWymyRai7lZici4hbRixzxI9YSAaAdG3a.I_LXm8trG_wYHfj3
 BQ1l4iH2.c8FeAgdOt65uGhslXhxWuGFPzkOR6.l3tjVwQsHF0YTpNTv6J7XL.jhvru67BXP2AFO
 OgLVF_t.ptOSFLgS.HtJyCqOjsvyxWnqBAFqjqk_mbur5Wvtarapocqz4IUi.42SOyHVpU7ZwpCl
 xwY6orC4tIxlemdYwZd5xH6GHn503XPf3UukT1320hAw9k4fkWpbN8SuMQRl2FE3pNmxYrv2doRb
 peFtWDHjuVRM8QjKGrGyGOmxrwZleH2r5ZurS737ioeuXsePu9KN7JUluQWlmY90HF78_OA.v_ah
 ncCNOHW35WlgpJnNVTHEWI3AuzLp_ENOSlkMEofr0.zkrbU5xiIPycS2oyHhvcaEwTKyfDN6LO6Q
 CvWnH4tkTCYMkZjNGI6OIiJYFIlObfBYzy1cs0bsTWNmYOxrTC.Fc9mr2hni23V2XO2ptVIL.qA5
 QBf1SsKXoS2domm4zs5jXLX8XzMWNFREARYxD4kl71._WqQxV3fEBrnpgmfnfCGLBy3mCtRX4fcR
 TmqDIx1lmF_IBUEeVxhPF3jLxvaDexaGssyhjyK_tw1D_a2JWT2AOMuvZ2aOXnyhYOCAFVppLghQ
 2nCgZIviTUa7yhCbdgXq7Umh6NehW6SqfYfl787LbD3SU2R4AaawZIflH3.IWCjkXYSLz8HJ1b1z
 eUIXq28QVsSis1DVq6fcBDBrH.EDrMFSa4.uiBehjG3z16yfLsPJjXvPfTrggkU5_Ig7FAB2BNrZ
 aCHpEBbD2.sm42e09x9uCJvLcFHuWY1_UWh9bXMLTtlAG3jNKbZbNFJnjzlAtPJ_yC23RquqUPN6
 cRJGutveo8NShc5rGsFc4Zw3SXroKlKVvOvik0aOldJXZeMfITgfw7H2Dg3yXTt89AaDVMsDNQcU
 TJoRiJ9.5g43pz6hXN8Cr8K8fb01Q1droI2qlFIvgYvTJGT8tGA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Fri, 22 Jan 2021 17:12:16 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 421cb1d2e6456159bc18db7d03d7fd0e; 
 Fri, 22 Jan 2021 17:12:07 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 0/3] erofs-utils: optimize buffer allocation logic
Date: Sat, 23 Jan 2021 01:11:50 +0800
Message-Id: <20210122171153.27404-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210122171153.27404-1-hsiangkao.ref@aol.com>
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

Hi all,

This introduces bucket lists for mapped buffer block to boost up
buffer allocation and buffer mapping. Thanks to Weiwen for
contribution!

changes since v6:
 - introduce erofs_bfind_for_attach to clean up erofs_balloc();
 - use a new formula mentioned by Jianan to calculate used_before;
 - only DBG_BUGON on debug version for __erofs_battach < 0.

Thanks,
Gao Xiang  

Gao Xiang (1):
  erofs-utils: introduce erofs_bfind_for_attach()

Hu Weiwen (2):
  erofs-utils: get rid of `end' argument from erofs_mapbh()
  erofs-utils: optimize buffer allocation logic

 include/erofs/cache.h |   3 +-
 lib/cache.c           | 186 ++++++++++++++++++++++++++++++++----------
 lib/compress.c        |   2 +-
 lib/inode.c           |  10 +--
 lib/xattr.c           |   2 +-
 mkfs/main.c           |   2 +-
 6 files changed, 151 insertions(+), 54 deletions(-)

-- 
2.24.0

