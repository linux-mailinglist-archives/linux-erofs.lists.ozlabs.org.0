Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3228A05A
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Oct 2020 14:19:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C7kWh5TJ0zDqw8
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Oct 2020 23:19:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602332352;
	bh=iooK/oK30YWJjMpCWwYmpszqFBdmZ8ccmv3WOXJe2fo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kpelxF3ek0xBmWOG/hxVX9eb/t465r7imO40X52gJ6hiBSmOSfhns8fFlggL7/g1b
	 GQy+OkSQ3A1CTfr3FOv7nf9huz8UY5VYU0zI6gIR5V/CDTfb+rIodyGicRriQZxD0i
	 WoZINeee/nChThBvMLCPyStwSN1OHdJbmfT5321dOvUsVUd4l36GuPxYrHBJ0SVJm+
	 VD4laxeVrBs2REVv/thMBnX54qjT1Ddcm4Y4MDNKGFtlNFiUE06DIuAIq4yiOXASAe
	 WyW3Vtms985Ks6IcsNuMTbOqOo4hGzTgAr45AJid550iJr1qkN03vE2gfcY6H+Y7OM
	 3wl9SdQ9xzvNw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.146; helo=sonic310-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=tcnvgL9K; dkim-atps=neutral
Received: from sonic310-20.consmr.mail.gq1.yahoo.com
 (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7kWM4W0FzDqvN
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Oct 2020 23:18:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602332325; bh=nzbf152uxbhosooJHvU0QLqVxYVbgPdtcUll47+gryo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=tcnvgL9KoMPpnnA+yBLrBmUAFsSwP05RvN3lFb0+9ujub4fy1k3zw4qRR79xfJT9TTgbOZnzDADkh9lNaL9UZ316d6m8jUnI3SOIqokx7dV65ir0ooNjcdOdTLtjpD2UaspJqFldgFPQhjfuuOa3JHqWHiNAxDJXNmSjH86Gm8aG9mzntnE3dbxgoUEC5wJnzY8GfiRy3RCTHUycARz2ZaSUzcpLrryTKjLHZZOaD3Q7OxjHk+Msb7RnTld2GcWzSdeaRcZDnyh77TfXMDoTd8hWjTXPNOGSQa89590hSfmxFbR/Vf5BaJ6KtWKoEOoxVDBurL4HKFXCcBuTHZMhjg==
X-YMail-OSG: gJS4IVQVM1lmCYPgfkFLqDDqpcIF76.7q.fUujT7VKCMzL1H4lyjNSXAqpR5Aiw
 _w7OJ8wohZCvHal7NIITTMCCL9LN7Bf8yFCsRVxL08zvnUrXYHwFSgPS1GuYy3M_1MaQmsQLl2aC
 B7Su52XVEJGOMd7WhrG2A_14Uwt6Wja2GUYglwHMZWcNgmwMHBsLH_HURZZ6CeynPKVJsjdKQh23
 _qxg.3AsTP4S7mzl0LdI.ZF1Dhr0ijG4TESytWy5trZUBvvKv5Z2hc2hwDg1b_E93qJSwaKpcgV6
 tJNEHfZ7qU1h433t1Kqff.eTfcjA6sct2rbpwWhhT6.JYBR9GTWcJC_1hhMODgjZFGwnLAm2xQ1S
 MHZJzmg12Gj.R5.zusX4y0IsNZDIHxgC.0Y5OxEDiGRf.QfDQ_cZ39Lan1el57c0v9OOQbm5HUla
 2xqSeSc0xEh.4oSlSZcwbgr7dzzxUse80K0hkJ_WoewqgMDu558gKcMyL_eitq1PCGXA.ziDnx1p
 nRArmJnU2Fa7Y9MX4xYyLyPte1AqyMJpTZsA2BKEJ3vtNpRze0GzyxAYTWunEp3eeMG.y8R.byTW
 kFVvAXp02rDjIaNB_dADKzCDCoYpq8Az56wmpqACWYnngj7RAqaKZnMLAZ7VTE2fKGeoWy.wXWI5
 qnmkJowWdQAyY5jkphggzxJTxs7OETsNQzJ5vtADPdkEHQt9NRv8BDTr8lS9Z3NiXLEcTwvRFGvo
 1Uj.GUoPAQe2PuQriEqMl0mF.c1BxddWifkvxPMEcTJw2BCTSy23O5z6Pui0x2Ya53gAFI5yIDSw
 rt_ZDBiFA6Y1Vf.AySKFhQ.e9A6tN7m_tTQNPv.qtxxUz9MYJZrQCmW3E4FHUQnWxuCKwmSrn3Sj
 tgBPQs4JIt5VaUBn5fDPokAwFiEs3mdv.ol6FECLzGJOVFeDnE7vWjOQxl_Nkh9gmIZZTXxwZfGE
 uvMJ5o7PN1TLYLaz7LbzOUlKLAKEWOo4WR4gacyQXaID_8vsBmQoG45vIlAiFwv6vrC_9cY5qU3n
 86BtcUC_t5aTY50oiZpV5Dt0S1QbU6iPfrrrxiy54CS7J7PO2pIY0.ejkHFtGOnrrnCLkl1If7Sf
 3KqVOGn6qx3HCPetd6ZFMFcW9hxfgQ.r7FDes4wd2KijS.zHn5h_28gEmvtbo10RWBXX1TcXFJdK
 _0Y0TYqLU9sT_isGA3xcQO9GEYohl1s6jnPxDHCGjJB_AiFDJd4Z7NH0sgigWAPe2QqtKwCwO2B9
 FKlUhk13dZGXrpduHUu4jGSrRPFu.cEFZ78sC6wVqs2nvjaFR6yLyzUL3ogPH1VZlYxvObTS1P0N
 cdbV76ei8hOFxwDsl7Dgk_Nn_Pu0RTTGRoRpX5vt4iL.F8lBMZ7LGxtWF3ggGZSl8cqIviJHwR4P
 nYatajhyq7QkZyUt5OtzA9HYP23nYJ0QtaJBZnqzd_VwaYk3VIIoyC8_Yj7XToAsC0NlX65d59h2
 MoKOVRiEqDYnOl9sOqoUv5mnzI569CfQ1_TJzhFcNeuwwxX2XS0zLpBpxtyglIuQAftfXHZzTkJY
 wmz1dLPaknw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sat, 10 Oct 2020 12:18:45 +0000
Received: by smtp422.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID decaad7fd68db5532a56b60fc03ebe8a; 
 Sat, 10 Oct 2020 12:18:43 +0000 (UTC)
Date: Sat, 10 Oct 2020 20:18:33 +0800
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: add fs_config support
Message-ID: <20201010121830.GB27556@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200928213549.17580-1-hsiangkao@aol.com>
 <20200929051302.3324-1-hsiangkao@aol.com>
 <20201007150215.GA30128@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20201009023048.GA16011@hsiangkao-HP-ZHAN-66-Pro-G1>
 <8f2addff-8a46-2cb6-5d72-5a0ba2f96dda@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2addff-8a46-2cb6-5d72-5a0ba2f96dda@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16795
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Sat, Oct 10, 2020 at 03:31:47PM +0800, Chao Yu wrote:
> On 2020/10/9 10:32, Gao Xiang via Linux-erofs wrote:
> > On Wed, Oct 07, 2020 at 11:02:18PM +0800, Gao Xiang via Linux-erofs wrote:
> > > On Tue, Sep 29, 2020 at 01:13:02PM +0800, Gao Xiang wrote:
> > > > So that mkfs can directly generate images with fs_config.
> > > > All code for AOSP is wraped up with WITH_ANDROID macro.
> > > > 
> > > > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > > > ---
> > > > changes since v1:
> > > >   - fix compile issues on Android / Linux build;
> > > >   - tested with Android system booting;
> > > 
> > > Guifu, some feedback on this?
> > > I'd like to merge it for AOSP preparation.
> > 
> > I will merge this if still no response at the end of this
> > week. Since this main logic has already been used by other
> > Android vendors for months and I do need to go forward on
> > AOSP stuff.
> 
> Good job! :)
> 
> Acked-by: Chao Yu <yuchao0@huawei.com>

Thank you! I will merge this version since it will be of
great help to reduce barrier for other potential Android
vendors and promote this into a virtuous circle.

BTW, I'm no longer contacting with Guifu by email, hoping
that he could also seek some extra time on this like what
we're doing now.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > .
> > 
