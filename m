Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014B10478D
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2019 01:32:42 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JL9z4qYjzDqvn
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2019 11:32:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1574296359;
	bh=eKsj4oUT5cjytNRN8veebgij7X0X16wdkdVxxZGr0BA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oAVvOKAXTsEh6XEk0Deid80UpFFnTIWKfYVEctOieWfut8SDWjCSC3LFX4PHPwW6d
	 o5acHBcYk2JGeG5PFhQnkc/hJeA72c8gZkh7wqFET1b70l6xOkYLlhtir1ZASbcGy5
	 zhhSbAM5KPR6dXUIGGMFPJbEXQY9yLbh8If0jrgfBTw7Ir8vn34taMlpXFbu908jcd
	 i78IncNb2xIrzwrdeCrmvYx2w/TnNDjdAOH6do+LZM622rw8hcA8Jugzu8aep3J4F0
	 xS4o3nKlcb16dKe5eJpftRJCulZa/p5OUxgA8bk475tY05QdnTGwCA6Fedo9VdnekS
	 OfI7e9POPB7Pw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.31; helo=sonic316-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="KgeINcZB"; 
 dkim-atps=neutral
Received: from sonic316-55.consmr.mail.gq1.yahoo.com
 (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JL9j31bfzDqvD
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Nov 2019 11:32:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1574296339; bh=9kmHso3mSurnOZWQzhC9+/Sw9IyGT+zjKJiHJB1GUFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=KgeINcZB+nI+0qRC70RenDgKt/GBUZTCWSKCNNat40BzKQ1Xv2W2luVhJvw4ajV6g794k8kUbWuyGSZr9vqufpyPIdIG8uLkvk9WyxjhI4AAnHmHBydc7f0LPznCaL/ts3OsGboWOcT4aGIM/z7guPtnS9zAkn/qLDRJFbOTfybqtKkmhtnySr2+tHndaH0YMZ2WrMDxaFWwbIlOpBgPImoi8Znh+4JxVdgvdAHKUbwe7OoxAnYsqwVdXGRqjYnXp55jwSOO1Os8XQoUMkfz+BLdKfWDJTtMnYAgX+ZOimYUUSJAiXqW+jHeDHLgA05SypYLhTSJkeZskfsw6ymlYA==
X-YMail-OSG: .tzMujYVM1nolGPpia9K__k7sHu_4l9yqVYeYqG0cs6imXZn2yrpidDmhBAcvG3
 mToYQ08NoF08qFDKiCyVdGXMG.iv82rc6Ybh.MR8NRoNLIbaEb_7pT8F6AIdndbLYJ_G27kd7qhN
 DuLQL8WYzoXPR9EtWomJ8K8RSTAfGvYouFuedQJKxU7IKLcFnSja2kQOP5WGp8uWm9RgYKLWpeJY
 2NJFOIh_G1Flg81rs96hEggC7OQ8GKRkSQWiY0RVF9g8YlW9XAK0ShcFbiu0Yn.xUKEsZYjTZgQj
 K99U_NimA9OWUvCFVVbwfSd8aDLIJOrFwTDJ.W7yxDW.fxvY6sGmKms6VEcxQCduLnWakxe9Niz8
 ydlLltYe5xuIatpXtjMzW2hnziyASMdjP7nf0eVp4.4djPPtjZEtYM8fvcFDowZL0biKqNglZdej
 .aeFlUbUbSWCkkl_Zrj4DEk.U3ehu.kfoH9Qwj6uA0khotc7.TgTkoLTHEyKn_i.xWL9XrLAwBd_
 _.yV3i1HaPV72gc5nhmxE.1l7tHnfaPpiw2jekHcRWCJt.qGyN3ssoyO1I6FK0Ngups5StgCoVIp
 0c0SmiEKtd3jWmoKWKhjYmuA_Vy_ts.qjjiYogGbJ7Ji35Gu7zEV3LO4lO3xw1J_d5P0rkG9kgH9
 VPC9dPBXj6oJjFlsYqUi4Xdcgcyl4x9kMPTLphdSpJD9J92rO462MTARzWc9PjkNEWR0DJvYdFou
 g0WQo75o4Wh8YyxoD_1HXzippuPc6E_LMLJRI_uJh002.E1xEP1q66gchhKQQc.qnqqZcBN6vFh2
 tie9xEIBnauO_uKZdBBJpwzTJx32dUWZPBinf5u369t1Ptkwu7iZaqMjSqk2CXb4CXLqhDPvi9VZ
 aPHQAvVJsYpFKT7FXNiDVv5AXT0MJSESU69aaRIekXYPs7YFe9nKaVUw3xxZiG7WUaFTioYO4.nD
 QEVWzbeW2berTHg0XJ2N_jKVKeWO4jirPyCWyEgmHXHc9EfJWyQJgF3JEdFWv9E_jZTlbUgQvPm1
 VxeTUwLP7jTJ4iq2jZwchqWSgqiPhqKa.7ImGVssGzl5krtA947HDNmCNvzWO7Vanp0yoSK5.RvW
 AxihfMcVYH55M696w3uexn35XhLejoS15vJPaRGaTOzjzNy2FZiEs6Y8aE9OCg81pgokHhv5HYHH
 jCPLMLCNQNgUC8yjOJYhsnKESzBQ6ZIl3386Yajy1b8JXzyV21sKrfsmSf_LQ6q7fijsnFZ9_mBf
 bBs_R6OXroyRUbjY2Z7pVc0rQhmhXXFLku1ph5k6hfJ8OKFSxIRieDQvRGaU2dTSL_Cpc3PMd5Ka
 wfgNydLiOyrtIfiexfAfsHIr9YhoRWp3JblWERyFxnAzdxx.nQSQa1Ic6Mu1VhFun9AWxRoEo6g-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 Nov 2019 00:32:19 +0000
Received: by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4312a8f81c27aab3243774b5ffad1dab; 
 Thu, 21 Nov 2019 00:32:18 +0000 (UTC)
Date: Thu, 21 Nov 2019 08:32:13 +0800
To: Vu Tran <vmtran@gmail.com>
Subject: Re: EROFS to support XZ compressed file
Message-ID: <20191121003205.GA23848@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHfisdKeLY8o=b8aAWhKgf9NndaMjBUmfro_D_jhXaGmXQ_6GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHfisdKeLY8o=b8aAWhKgf9NndaMjBUmfro_D_jhXaGmXQ_6GA@mail.gmail.com>
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

Hi Vu,

On Wed, Nov 20, 2019 at 11:52:04AM -0500, Vu Tran wrote:
> Hi,
> 
> In my understanding, the work for having EROFS to support XZ (in both
> kernel and userspace utils) is actively developing.  Is it possible to know
> the timeline for when the feature will be available for end users to try
> out?

Streamed-based XZ decompression is not hard for the kernel part. I've talked
to Chao about this offline, he will work on this. (AFAIK, Currently he's busy
in other stuffs.). It can be tried out when this part is ready.

For mkfs part, The problem of fitblk-like XZ compressor is compression time.
Developping a multi-threaded mkfs is not hard even for fixed-sized output
compression (segment-based compression), hacking LZMA2 compressor is more
preferred. Finally I decided to take some time on this (I'm taking much
time on LZMA format and (its entropy coding) range coder now.)

We also hope other forks could join us as well, either filesystem guys
or compression experts... It will be of great help...

Thanks,
Gao Xiang

> 
> Thank you very much and Best Regards,
> Vu Tran
