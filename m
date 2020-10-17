Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D57AD29102F
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 08:36:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCtZw2hZ5zDqyn
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 17:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602916584;
	bh=p33HRMDJuXbmbkoc+8zZL04bZzkdaXGHhXy95zM0W/4=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DmHClmmp5RyRJ3iWrwFrE4LDICcBwDAMJWavkWllyR5YKQNHGEhkOxCJsm8rBBHWj
	 Jss+LdSF1Mz6jKgaFPLbKtEy26vgbzTr6y3UdnXtugVvn+O9sJke9blKWsv7FIhgz5
	 eOMHgMz7Ii5dfgCkOtp8Cv6c3+CJg0EPT6bDbZ8t6mgdO73sCq+ms2Dv/XJHxXZRkV
	 ndqaIcfhC4qrwduHD3It9Bos1wAe6kaQmDcFMGcBYSoVpaFju/kAVnFKZsE0Iml5Gi
	 FJIGDDYBAN6qzvHWsDe5xzKMKJLQicuV+Ea/cnzvovPS3Dlpai/MGMt7MsKNVYCdFM
	 WeoPGzSrK/B2A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.30; helo=sonic307-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=EuuEeFp2; dkim-atps=neutral
Received: from sonic307-54.consmr.mail.gq1.yahoo.com
 (sonic307-54.consmr.mail.gq1.yahoo.com [98.137.64.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCtZn0QJGzDqxh
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 17:36:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602916568; bh=d3G+MqfipFF/j7lUg4/cOQ04OuCO+gJQL9OpxQ0sRgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=EuuEeFp2IZmJV5nlGlX60IAGAe5z5HRDfi02w0OiQp6sW+n5hwIMXmuUGvu0ckwHz/owooKxbCmxNw8a+iyjAuziGFqY0h9utklE2FGCSZMMCyWm2k1udomN5ep1JXWTXDo7EXd6/ynqwLG7VeGl3zxsxQQ6K15asp71C3gv5HVjnmOvaq0H5hgvBWdfUbBWTX0SxKatgedymEuuLXxx9nf+W7ikxaMmciGXkEoJqeZJZSbIi069apg1SyOlws2tBgJtcQnhgVW6eI3CdZ6rP2rFsYc9LyfultmHQ4eOWxoKTNmmqf8FeojzaJj7mvgUSi5X25vfIQ05SGN1cNrcOA==
X-YMail-OSG: PO0xr14VM1k03zxOw7AUEZiEVjyox5DyJYTDH10u9ds4Vuh88DL8U8obauiPJHj
 Nc52ggBNy4D3v.EMRnHRx9as22zVq5FqVwokasAXYTw79Q3YHeGo_d2F1iys5kCR0TKoWnb29fBW
 8CX7H2BBIEs5XTpwhcYifaL8WThCK2he7KwE_QBbGgv.kiNDeJf_Wv5PXh.Busl4VK7r9uHRXj_L
 TfGz3TMlTRMgPCO.Bw.uRadVCpAEsPgU4p7v5zh6s36DOUtpq9PP46ol7LECXzVGPNGZDbMqEROW
 Z5x3Ck6OkkQQZ4vGLFoK0Yv8rwDJkCDhjj9v20z0yJvRXAyWFsMDqXSHeH8QVPgpfvbTNxTqgF1y
 V6RJtlePHW5b5PiGcdu3yif8UVwB995oxAV3xTqeYzup0y.kGQUTKi4bGXgyx3DSMoVNF0detE6Y
 AwJtV909qQ7VC99I0ZPjRlRAHGfCPn0iP4auw6QF2dFBYV2yRkEZEeC4TMDz6dzW.HPMDEOi3JHg
 h_JUZW2r5PL5XpnUpzGxD7BzHfkmHV6aQuPJypBLnIm0IaaC9urmuK1P_Jkoq3rKYap31rQD_IID
 QHn6DA4RbH9BbJo1ShfRswdCPZNxGCOi.hPf0NdDo__Ub4swIA7syEk4G2VjErWpV1h8aI71cld.
 VLkafA4hjRHqrEKuYH1Uzu81Rhlg03hLj.hZeHLvWOBa6TF75uEyTXXFaqqdxje0Z5H_SbXvhhhz
 AZv0rx9k43spp45kJPt9RaIFKm.rtJbHjgcetFbc6ERSbp60jwwMbcDBT4mYM71fppn5.tglFZMC
 6rFqCiNS6F0TYz2O5cvg5XoGORvy34vRJ1JzU2jm_ikau_4eVajoZJQeybpo2_qkJyRB2n4F59wt
 1MG6d2GmZKg9UCCHxzGbKGqGffBZitHcqaypmMawABDNoVtofXs5.qp4N9XSn36Mfsj1Aco4kaRH
 IFxCvNfEYjk0S9RXXP6g2zlsROB_e48EOoNE.KQaCr9CNjaoAyHw_Cg7xO8Zb8ceCvbCvyDEurH7
 vcyJhxv7YTWhCz3TBirVeRQPkTBGD4n9u9Dm.G4w4.I4GGinpDX2steVGFam_SovUsnYrDNNt1nD
 H.Plq8Z4wHK18ZW7t_0dlgydDwN1dB.M93bqitkzswe_9yI1J2fJnL3EYHs1boD0iz0qwgIFirsP
 B2tQ1ydGUQiW1Sea4ijiLOLNBAPZOzjZz.5HBDDMVvG2N1pRCOKF5SpJXhuZacecy.TQPc1sP3IB
 b6Q8.5mNci6x5y.J4WVLqappjMnX.wuLjQWc8UaQiB6PwaASEXopfW8NusJ.J9vxu5DzfjUCpZh5
 NBOmTzxDC3.kkM8GYDHfoisoeewqwQzN.gHD2dKWOfsbThY4MMbn8Pjo_Bxl6t2.F3gDuxmzBiiG
 JcRwdG6ZfxbfTw.yqnpb389y4flO1kxS7v6WTUuUMzAeN1ZbG.p4ENQXRKpcUk4.rQmdrOU7KmsU
 L59UUp44eHcCnSv1yelEpYwt8X3Zeg3C0_NOtmmBhApTSUKJjKpMXOGBs_aJNhjra4HA_V_zu.sp
 t5es-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 06:36:08 +0000
Received: by smtp403.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID e6e2ac5a34d23b70ac20fc71ae8059df; 
 Sat, 17 Oct 2020 06:36:06 +0000 (UTC)
Date: Sat, 17 Oct 2020 14:36:01 +0800
To: "jnhuang95@gmail.com" <jnhuang95@gmail.com>
Subject: Re: Re: [PATCH 5/5] erofs-utils: support read compressed file
Message-ID: <20201017063553.GA19017@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201015133959.61007-1-huangjianan@oppo.com>
 <20201015133959.61007-5-huangjianan@oppo.com>
 <20201016161736.GC32727@hsiangkao-HP-ZHAN-66-Pro-G1>
 <2020101714241160424912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2020101714241160424912@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: zhangshiming <zhangshiming@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, guoweichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On Sat, Oct 17, 2020 at 02:24:13PM +0800, jnhuang95@gmail.com wrote:
> Hi Gaoxiang,
> 
> Thanks for your review and suggestions. It's great to communicate with outstanding community developers. I have learned a lot and look forward to contribute more patches in the future.

Thanks for your hard effort on this. I've send out a complete version [1]
which I'm also working on and you can review / comment your own thoughts
about these as well. It's always welcomed to join us and send patches
for kernel & userspace side if you have extra time or production is
needed  :) Anyway, our project needs more people to understand and look
after, so in that way it would make the whole project better!

[1] https://lore.kernel.org/r/20201017051621.7810-1-hsiangkao@aol.com

Thanks,
Gao Xiang

> 
> Regards,
> Jianan
> 
