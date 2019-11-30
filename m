Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E346010DC03
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 02:29:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Pv1P4xvXzDrDm
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 12:29:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1575077369;
	bh=YlcAMHHVpZU/vtinfRE7Q4o1IKm5FuA/UG8HR/b5EsE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fN/FUv1vB32ECIkWKBggi4nzKwi8d7RMEzKfnGGU91V+9oNN/XONZq3hfr1t7u0VC
	 TG8eCzo3BopI2RPypYkumuXLpYeH4/aCAW83cJUgrew1O+0ZfpNCqgaMNiY1S5qA+W
	 Rp6gaGAsUNI+KQ2mSHVLttGwZLeumC930j1DkpBTFh7zcmn9AmesH/vT7kTK0rFWtJ
	 AsLtNYUZOX7CzygCMIFTiRIe+O33xdrZqiYMWhtTdSsJX6oi9SpKOy8WJeyCfH1m6J
	 Bjv7yeR5+3uhgZMfJ2j7sBH5OUJ+TXSRk4mYoMJCl1qDPRVuAdGKyDnfs+1arKXRXQ
	 kCCFwUQMjXlFA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.31; helo=sonic316-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="PJlZyWS8"; 
 dkim-atps=neutral
Received: from sonic316-55.consmr.mail.gq1.yahoo.com
 (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Pv1C3j9WzDr7f
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Nov 2019 12:29:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1575077353; bh=VKpqIjbH76/NLT3a5CjirIh27LyU7i5S4NjPigLdMdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=PJlZyWS8yBdnSYNOi1ToNZqLPskBf6wryE6VKRiG2geafms9qTwiB5we2lhaBrZ/eI+Yn0hpw2WeGmy9D9THI+9AmAMtZlaaz6u3weEJ9ZMay9kJiw2WlwtUJQB1goNatweizVwgSOx9Tr8dVKQ0Mt4d24DHsCcnyQvoW0kA2Z8+LlofG63hPpe3D7rgNE2y9NOTMVVtjTUxHHl9GRzkGPqXkLlYAtnV6YlXO1cRpzp3WBTsoRVWP8RrXJhRzs5hP5drURu7YGD0GLOyzcWQ/cf9qItzXto9duWL+PFndi7SuUiybRSz4f+YT3A4887EWPLVGAQZa8YthHiW4g20kg==
X-YMail-OSG: FcrT0GkVM1m.eh6WrOzTNNXDPUKTT9VQ5vKC5l4qz_J8bg0jdwvH3FyOLAmedLZ
 KjrVH_6.BaxAzQ3WSFEPnnzj0jPaIhRaqCR5C1Hfqs70hhLZoM.EoVxiWGk9AilSS7lGAYapwkiH
 cWx1zivsGENQcbQXcKj4k5x76cFeDC2nUHHUlPSI7gY8p32knEzuEsG29U3fdPpVET83COTAndp7
 sTDseN1xoZrcf9wzHKH_YDCzh9rAjPPadLE8hmHOIzaJ_cbhwKd5aSyqvb9_DuE4XQPUYC77HnL.
 xtWlVvpBuqw8EwdrOtX9.IWyBSb1Zi2BbOOLN2DtcshhPtZsX_OVs.urUhXhQomICaSu6x7W9X1d
 g2RpGjyDrSq3tV1yWPJz3gqYzdtoQBg_Y56fJR4vlPgKTx7Q_uZdQmWGb0MDtwIhF8MzVhUmbGsp
 Diz.OwoqGXlIQF0jR0J6MRCgwinphQ7gi_AoFVLB7jFEDsHHMb0q6ZPF0CznW1Si2H5O3Zhym7It
 aeB0eSjTO09B8SGhAH1Q9Z2m9sWCluOTsTXoMMz9FLUZxWs58rFFYOcOsQTayksSQAPx3mOqzVXq
 wwuamMaF7utFD3L6fyVcU2I_qMRKPv_99gQubxAI_aIMJxd5_jx_s.XWpqcidq3rL1Lcn3N4ojxg
 u2yvbhIveooMrab0vQJCXINecQJDfthjjE6PBW7rAJ55t24.MuSZdAa1D893kXyoxVBuYElJjQI9
 V.xe3JcwZ7m879gG1SJmd4ZqMjuycRNP73zkwZppts6mVEngEQkI0.2V0EV_siX6P6yUgNgiD.78
 cEvyMOrgA5g9omFXTiZ68jMkvZeeO.DcGHYmFi118zOz7PcYMJyTvIXzEdtKsSB5NUJbayBAru__
 CCRG2lRa90prlGbUknt8DCSdwe1dhDfeUbxTDdYT6nUBELJSCIMpAPi8kgOmFbx1fbRtuS8X13fr
 1zq.xLWZK3XDk4B3__ntc0ZtJRMOd9ftwCpGFdaZZxAVFWLO6lSBPNh98jiMFp.ljn5BOtvK6b6P
 GyuEW1AzLMTp0BK.4AsTkK5t3TX06Ks6y7FJKYHXT.K8kDjEeAiYQh7VKq88Fg6e_iiC17Ryrup2
 N_Vrml1b_ZXGrRdP6fY.QZLoMpEErM.kQdGzfafATrznNDhqEO07f8LuhUH1ZKZSw5CuQP0CmSSe
 yCkqXRrHGBU6dwE_1BOb8jvl2nsBbe5ptLW6m1jlYXMgF8HnHPi6xJbQ1YbcJbKWJmEL.E7r_eiG
 kvpOhTdovUTXmRJHlOP7QWTL4xasAPOAPXebRLoAUMIBV_SK3PP2hmQeKOVeZATplcmqL7XoHfeB
 v5O5dDcRYHg3yhiXaWj8OZXWQcJ6WBcpLGTm6.S0wrGVFw9DPJuGsHwP36MZqbxIyKmaYmDm2ugX
 FcEwu
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 30 Nov 2019 01:29:13 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 990a34f2ac92cce4f76f378668ee19cc; 
 Sat, 30 Nov 2019 01:29:08 +0000 (UTC)
Date: Sat, 30 Nov 2019 09:29:04 +0800
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: Compatibility with overlayfs
Message-ID: <20191130012900.GA2862@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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

Hi David,

On Fri, Nov 29, 2019 at 03:22:15PM -0500, David Michael wrote:
> Hi,
> 
> I tried to test EROFS on Linux 5.4 as the root file system and mounted
> a writable overlay (with upper layer on tmpfs) over /etc, but I get
> ENODATA errors when attempting to modify files.  For example, adding a
> user results in "Failed to take /etc/passwd lock: No data available".
> Files can be modified after unlinking and restoring them so they're
> created on the upper layer.  This is not necessary with other
> read-only file systems (at least squashfs or ext4 with the read-only
> feature).  I tried while forcing compact and extended inodes.
> 
> Is EROFS intended to be usable as a lower layer with overlayfs?

Yes, and overlayfs were used on our smartphones for development use
only as well. I think it's weird, I will try it on the latest kernel
now, and see if I can reproduce this issue soon...

Thanks for your report!

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
