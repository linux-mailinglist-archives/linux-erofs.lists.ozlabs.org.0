Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB531B0EE
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Feb 2021 16:22:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DdrZl3lCzz30Gq
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Feb 2021 02:22:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1613316159;
	bh=1o4tD7/vbQrfp7EtTi5HAawZb5YthZ+Vk907CfdaW/w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QUI/ungk3vrinzZmu5NyFC2oGndcF+o9rmot6Yt2f4tTwbs3ivNfKQIu1i+QAC1Vh
	 kT9pzU1ikwJygKlhlKFF2yA5q67wPEwIz/TeFQRAM86SHh/PVnBUj7uir50Z6iqPTY
	 AuTJZBWvHOU/tL3sUlQ2qWL33XGXLyQ6HubDNFgtkbWh3xs+ldyxt0OZTx9xO8lJ21
	 QGNjgR1Za2uCusXAZWDdKXWAsV9Mq1tfLyWKQGgJVniG3pyCfg5azjjbZqh6alQJXx
	 Zi64OB2mS1zPKWLAF3t+qq123xMSBlpM53PE6pSvSmg2GvXUTlq6Dxk+avpxz7f8tD
	 HbhORMG2xbxEg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=D4r2Etq8; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DdrZh3BYWz2yRg
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Feb 2021 02:22:32 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1613316147; bh=TAaUx+T3H4RSKyLL/C+Qxiqa4AK6C+moknH+H9Dr+Oz=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=MyQIztfpPeRnJSFd7Aurz6tn6x0nfyrT/FAs+j9sbRb6i8uDhtHAHRJAxiExHH8S9wN5cBnu4vwfI5KIfzX0b2pWcm1zLK3XcfEHYANcKtcp00za2WY2V3o6jinbaF8aj3IriTwd6kGWqiSdnNcVIA8Qq4sZZ7/U5j2WVVukjzE2cnUEft/aG86iEWL7GG6SZNkADbxguXqI/eFfq4cdpU2X5h3MOtXN9B3NHNFWdQFsPMswM4iub8vd+WtZz0vw6NeT7cwgglOUQfqA+3F8ksdad/s3s/LY8aMWEwPJkuVkQ/1oOnr3dnDb8PmVk3lBBxG0PlwZWhhPqZ182sekvA==
X-YMail-OSG: BJsKlIkVM1lVjC_lrCy11ruikcYQbhYQw4tVc1I3zc6sN1ctgoNzmO4b3JdyOBs
 cXdOTjxt84ar32iKOtpuuqo9oHYm_fpYDD_ObVVb5_gWLh22aM5MW9OBaR5L_YEVHZl9ZiRi4UmX
 sUSJy_dZvVcR7mTDOPXbBKExg9mooKJGj3pbMFvIrSv4CtWCDr5C3lOu2S2tmnyG3g72de.hnr0J
 24AfXl71ALbeutuScP0WWHYxcO1HPmHEpAO.kh_tqxPb3P4gy4zZOYs5iO1YVg_xChLeKFU_j0gD
 iQ1iHr96_v4cBpBN2UPYhwKjCNlWv4gUbn3kan86pJ1CbwISC9IpwcbXZj9LtiDVzc2gSvfAREIb
 xP7sCMRwcDcHnfQVhAVKX60MgasphpOPgPkHqNRVDKUG.9m2PQxVDlKthaJU4VC5TMxhFoL8cWCW
 auiyGYKcNa4XIXEPx08aI0ze671sVgMfuatO16_CGdc9yywTJtZasThfDbAAfbxgjYLVDULQnd7j
 GcTERH1S3OzO_l6ssWLDxeS4.G4iJJe4rk3oboc8icZ6FObRMqPOzlvKDqRk5uDgBTOQJvhfRyx6
 wRrG7LdTZu7SaWTpa6joziX.1jMI0i0lh7KWB3dOVmPYZuVfdoFefy27D3g369ggR8fZkBzJ7XKg
 DMuib9a_PUWKUWWUhere7lW.1QVq5FrhkOnEKtvhiT0ujOzRH7E6iIpgFq5IG.p.Pjw_u22nynkO
 KE0Q7AIQ3_USE3pwcDqNC7knZeUPJet1DChAbmEkTw.vnbCKaq_MF70Y7QG0Fp14eVDa_PMaqeE0
 rCZTmwHue_pbJXftRjtn.OKU_BR5FdjcRWQ83Vf6G657bRwXFjHGhqM.rE1OntnloeRmglBdRull
 qvmNQYxLXJ8Qa9mhT6IbP0fhoa0Iyzy1Br_kEI5hh8g8NjJE4G8uDhLYjGGNQtpn0wg_jfXC45g4
 9lY7ZXTY1hn8r8Xl4p.52O6bH1WtO3zGyb.uyRzDAw5CDYjaMoVqFoMfOI_pA8eqjHa6a2r5ZGzR
 egjVedsdtgVcjrwdB3uzuceUdofhpq29Mnf8To.UmX7y9jqaSwcwO5G0OW1ihzPbwIDW0gWLi5RH
 taTk14AYVJeox_ArPFise.4FeDjj0mLdFpoQy5VIN82Un6m3PVbzinFFoyyEHs7Clsh6.KX_UPsq
 ST1sbHeno0cEKQMiKcUdKGkwV4emJDkeLci5pILUGL0g5ygNsv72A7sV.KTqyBmP9u3yBiD22VBW
 ig4qlkV1PQatqtU2FWCl1J.L.muidtpwCUUPAtUjgeYDt.6p1H3p9Fd_w90r3nSoiPyDg6WtYiQ6
 k3Z4s6PjtSyhsW3Gz5Ry9BT.p1n.pIifMrNvBtXkb608GJ6Rl7BVd5ueoCnBOCOdrCrAviiypJO4
 tcvYPcdWDfpS6QcRamN.SKzzTO5CdRwGhRtBoJwVKVtCii61WEfFDhbRV8J6Iias48jvdz8It4li
 4yxKWKYZwuMz620nYk3epVNYXBL8GoUapRdZxmwCgkpOeOqq.qf1OAX86nwm6.aUW7VqBTMx9sHt
 ZUUvHIs0qIGeYhNQK0E5NS8idC0uMM4dlZYSyyDp_bHSVleJ.4HidrnZwwnkVO_8vdBui6n6.J.f
 krYXz7Zj9CTkTduDgCM4rRvA4cs4o9wKxN2DXIR0ZSTKoZ5RJO4tR_4g0B1UjWffWkk2hXewypDW
 JUh.fFl537LrOJt18Ey0zpU0KAQjFczLriBVhOLM8eZoDrM71GIZjTsCI8RiHmpFWEyrXDAMYSWi
 DVlPqaukoxB0GH1WZKJdWyi97RzIxrMHlMu8qfckt1tcKfVbPiSyTkG2e0ghtOT1T1t4C4dLxl25
 rEuPB4l5iX5NQHnVR.IfAx2Z9v975BE3dW_xsU2c6zffp6fHLMrUtV08LpnznzaZyPjk2gQrN8pc
 r.2Examd3GkbZvcDCiS8P6BCTVg8s4lVwfPqkJ6plec4hZ_6j9rZJnS1CUK3tDoR1qOo_VK5euJN
 ViYlUx8vIxv536furqglDu29Kv73hEmupdfvMV_jMmPX02IR.1sVFF5o1mSwj5RVBRsDC9RoLjMX
 sYnyWWatMu_.stKtmwG0HZMBwtr6QDRTShBjEJOv3bEnWWDAZuQa_eaQqms50cnlFaiLXnbedXNq
 MSFwqCD_YmnjlFo5mY4ShXwCkDJrliTxPE6K3yanspwHXF40SzjYRyTWRg0aLM4OSBYPrjQzkDpC
 zqfmJT_sLM87kI4N9CQGMWhv9YP4x.W..rce9r.JmTdOJzLVKItzEPow_eLxBma9XZaHxsVPa1Av
 tZ7604Cs5wWrRN_7cLUqwlljr8keO3PLwHvaEpitX2W5.764ZKTq6mciEKlrcmATTI9KDiZWhu_4
 XNI1uZ3.iDUkNZhvyBhQViWL2C6WY9eIifsal1k6UCWlEiGNlOWZ3q3td0LfNcpg_LPtWfqDLoL7
 OltlUYg_gs.mxdAq2hVKLf4.0HMv3.G8hYlpgVx45yDPpdRM7vA--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Feb 2021 15:22:27 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID f44844d2a2b523938aa04bf428a617e8; 
 Sun, 14 Feb 2021 15:22:22 +0000 (UTC)
Date: Sun, 14 Feb 2021 23:22:07 +0800
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: fix battach on full buffer block
Message-ID: <20210214152201.GA29988@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210120051216.GA2688693@xiangao.remote.csb>
 <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.17712
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
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

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:26:06AM +0800, Hu Weiwen wrote:
> When __erofs_battach() is called on an buffer block of which
> (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
> updated correctly. This bug can be reproduced by:
> 
> mkdir bug-repo
> head -c 4032 /dev/urandom > bug-repo/1
> head -c 4095 /dev/urandom > bug-repo/2
> head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> 
> Then mount this image and see that file `3' in the image is different
> from `bug-repo/3'.
> 
> This patch fix this by:
> 
> * Don't inline tail-end data in this case, since the tail-end data will
> be in a different block from inode.
> * Correctly handle `battach' in this case.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---

Now I get what you mentioned to, and I think this is a valid case and might
influence old versions (even I have no idea how to reproduce it effectively.)
So I tend to apply this patch right now, and thanks for your patch!

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

With updated commit message below:

When the subsequent erofs_battach() is called on an buffer block of
which (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' won't be
updated correctly. This bug can be reproduced by:

mkdir bug-repo
head -c 4032 /dev/urandom > bug-repo/1
head -c 4095 /dev/urandom > bug-repo/2
head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
Then mount this image and see that file `3' in the image is different
from `bug-repo/3'.

This patch fix this by:
 * Handle `oob' and `tail_blkaddr' for the case above properly;
 * Don't inline tail-packing data for such case, since the tail-packing
   data is actually in a different block from inode itself even kernel
   can handle such cases properly.


Thanks,
Gao Xiang

