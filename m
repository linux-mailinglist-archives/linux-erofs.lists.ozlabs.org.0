Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBB9136C
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 00:07:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 469vSW0BvxzDrdJ
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 08:07:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566079659;
	bh=VSqMqNzeZnSv6aIVyqtbTkz9Qp56T4sm7JC+NotSQYI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZQ4GCHLGT2VdJIRQAHp8eGqHj9xZhSDhmawXIdHrb/CpLz+gidbJoTuU2RSi37tsS
	 pbptn6ZsAI2nu/CJhIZ3pGBjcRwtlVvdIPXSPNerih+I5h/qYXse0wUvZnH0WOHwAY
	 jQMA3WYV57QCpQ0xK+9bPeKKDrllbMfupsETW1QMuGUvk0LCSat8jJNe7qVsdNR34z
	 o5APMX7NqF65X9BzuDbu/f5ZOKp1//eJX6kRAECpaurzfud0eWPrraWT2JS9lfY4Sx
	 XKzAO9Eh50HI99ofBgiArvYx9ta3cnFP1SUDzwi1e8vD9ldPxNxs0iM70JJTN2Wktz
	 VZoXPbYioSfsQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 469vSH0NMwzDrRJ
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 08:07:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566079639; bh=26eP1y8zgvwC7tDEbSrCZDGdjPiTLQsD1xucwKQlOQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=IQmWtUpiqH0I56d8gXpOUepQBjIeos+73NC/v6LtHOw1YWBDT38CUFSR9kTSOzfsaGuxtm25NEAuP+vmQ17anzsSkCXgL8BxMwBj8snkbfgsrKBPN/nNGZ22DgxekdFnAMNYz959desiE+T4i+GmtiXWuo3V3pcBarJG2uxLy65OheQ0Wq4b66Y00Lo/1cfeEEINY5SnqgN/SlSKkS7e0QyJii0NaiLGtWBQ+/Dk/sOKMi48apgj68S+DWdiKvPScYMjAqx+ZlY8eU0XF4f6lpqiXlXvwPdl4Ls9yHp0wK4iYtd3tqvhWR1EYkdlcauXxOz7pmoQ14ATwX4FdUMRTg==
X-YMail-OSG: vHJ52NwVM1mNmnrN5URQmFswc5FfTt7..sdPljkO27m9bxGo.BsD7T6P1ZQvERg
 CtMm7RU.R6VsQW19a402hg.Q.ABAsR0_.qkwY09O6RB8OVvwdy.5xsN.Vrnf0f7qqzMMUzZDyDDH
 AvWcgr22As4vhRCrYZO5kk4FnOd3rko1ubfVKcWf0D2P44VBOzndwPPK2pphLGp3PU304Yrxakzj
 28HFCirgd11ioC5EsD7ESmYzHLSz4dbLsl1pnMmuDvUNU7A1bw8HKqtzG5WOI7.eI89VoO.ALb_y
 RLQn3RlQxPkPm9pPpAgOtiDOfOYlqpwHTCj9x7aYPjH986kIQiNQ4JwXn5F96zTNul5qXELeZENb
 KD_UiDW5NGFeUjAb__cYvsNFUxAiwRfro_edIs6_VwPIfI5Tbit.5hS8mELUFXwPkesrDEosWDvD
 Hit55xcQaI_Z9UzfnljAoXNkjRtP1qIKpcUodU9jd1Yt4XjFnRIzNSZw438P2.X36Jtp3hquhHGm
 8R3WQ0erGzhWCfZ9Cvjel1fZjNNvOIEzG3AEHfFDob92KADLM1tTvd2kb0eq9qhDhFvAGiM2fWf.
 9UUcZ26C9GeO5GeGoGEJeMu4qmrLOw0TXhf7phvpqd1_E9x_l.ujtzasiKALLq7.0G5qp.JNT2Ek
 cFurYuI1AkDRi4ueWDTDBLTnGU2MrTq8NbCIQ6Q087Yz47zfLJrMf4znrrakT.HrtUbVUUix.kHS
 PSvycxxvAywh5197lyeLKrGdThNLMCOkHGb._TxLx61QUOp1IABfbQiYjiED0DnGSEjYM69YIcli
 zeep.PEZqs1K.5dnPzhX_6n4c546ebUIcihtXB3LLxR.GQ35kDUosAjFoup9PyhnS.YMOzxi3dt9
 rta0a7GtoHVgKm9YWpYbSP3EQ54QaQL0H01kEHtxQLy4P5a8HgBaKs4sA3lXo.Oyr23pAzKqz9X2
 cZQWYAUbD8A1mWf0QdTo5_4Q.H3ZrFAuIkNldjd0mvy.Ph2ZXqUmYLb_a.Tap5g8HGpCMsIRmcfH
 YB2FqExCDjaKYFaOq8TUDWb5UFG3WSA7y5aF0.x67vJzVpIZaW0spPXoXrGdE437qnp29hv3jpKc
 gpvMOq1f3cUU8FQJqp6uI8NTodga9B47ChtLrRNJd7q7hbmQlgzwLJM8Sj2dkJH6wsfHuHSkVsL4
 UTzRjOO0hBiOiRy94OMtXccMH7Du5LuIKrdW.D6ESa6SVoiEPmeZKhApKvhxBki2Xi.LdYJFfOz5
 WRhdce1iVz7obXGl1Qz7Esx0MqvQyTIGe1_s7SMLc1dBMxevdkJ4-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Aug 2019 22:07:19 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f1835cace093bf9aad1c22c8c8f4eeda; 
 Sat, 17 Aug 2019 22:07:16 +0000 (UTC)
Date: Sun, 18 Aug 2019 06:07:07 +0800
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Richard,

On Sat, Aug 17, 2019 at 11:19:50PM +0200, Richard Weinberger wrote:
> ----- Urspr?ngliche Mail -----
> > Von: "Gao Xiang" <hsiangkao@aol.com>
> > An: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "linux-fsdevel"
> > <linux-fsdevel@vger.kernel.org>, devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > CC: "Andrew Morton" <akpm@linux-foundation.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "tytso" <tytso@mit.edu>,
> > "Pavel Machek" <pavel@denx.de>, "David Sterba" <dsterba@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>, "Christoph
> > Hellwig" <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, "Dave Chinner" <david@fromorbit.com>,
> > "Jaegeuk Kim" <jaegeuk@kernel.org>, "Jan Kara" <jack@suse.cz>, "richard" <richard@nod.at>, "torvalds"
> > <torvalds@linux-foundation.org>, "Chao Yu" <yuchao0@huawei.com>, "Miao Xie" <miaoxie@huawei.com>, "Li Guifu"
> > <bluce.liguifu@huawei.com>, "Fang Wei" <fangwei1@huawei.com>, "Gao Xiang" <gaoxiang25@huawei.com>
> > Gesendet: Samstag, 17. August 2019 10:23:13
> > Betreff: [PATCH] erofs: move erofs out of staging
> 
> > EROFS filesystem has been merged into linux-staging for a year.
> > 
> > EROFS is designed to be a better solution of saving extra storage
> > space with guaranteed end-to-end performance for read-only files
> > with the help of reduced metadata, fixed-sized output compression
> > and decompression inplace technologies.
>  
> How does erofs compare to squashfs?
> IIUC it is designed to be faster. Do you have numbers?
> Feel free to point me older mails if you already showed numbers,
> I have to admit I didn't follow the development very closely.

You can see the following related material which has microbenchmark
tested on my laptop:
https://static.sched.com/hosted_files/kccncosschn19eng/19/EROFS%20file%20system_OSS2019_Final.pdf

which was mentioned in the related topic as well:
https://lore.kernel.org/r/20190815044155.88483-1-gaoxiang25@huawei.com/

Thanks,
Gao Xiang

> 
> Thanks,
> //richard
