Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCD9197A
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 22:14:50 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BSvq274czDrG2
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 06:14:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566159287;
	bh=GLOl+8OYKs61oFL5U+qsSpwrmTwN/GHT/wkFRPe3+x8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PFWKzsjznPu6G/v9zfl80YKtmrheLvxKM5Vl1M1amtD+IIHnDViNGFcnS9Jf/9fYl
	 1epvBMu0bO3afVAUvEk80MvcF/FHjJvf7/z2YOiEctLQtn7Nb71g4CLeGKWJW5BZUh
	 mrZRcK0TegkVuaTHBoYRPxt/Aorh1f1jVvFMbRfp7iwK3ZiePpA9IXUN5cBQ8EDeaE
	 StuXHa8Xp5W3p68uYv2L/V/xkyRHeul7/YuJ9VGRGV2OeG3U+QYiGpPePL6BwH+2EU
	 k8Wz2pMP4U0Uv0tHB9WwoTSfnC8X+ndSjHWpVW7VFBmsXmfZ7zm4XpR7RmX1StLU0h
	 cV0h8nKtgOtjg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.179.83; helo=sonic309-25.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="uOmq2/c9"; 
 dkim-atps=neutral
Received: from sonic309-25.consmr.mail.ir2.yahoo.com
 (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BSvf5rYRzDrFd
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 06:14:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566159267; bh=AFQH++1o8RqOOUXXy/R8iJf31JxjU49TDMxPTBy6oBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=uOmq2/c9/k0JwKIqGm2gloVmxlgPrw2KVO1WcL8YA9pc3GEMnMNjZ5Q15OZy+TMCWWHaFxCnxEVzIUfxT5Cr02/I8HuAsI2TxsBpf65988Mjop+COYO+FKOz6hrtR1w6dBJl6Nss5c/Ko5PQDnThLexu9ClvIIYUtp3ZWOxhorx9fwWcWx1QOhLdpa6ffZqKWEcRMq+ZjdPaBq5oLxdEOimBGXo0Op1Avh9F4/AY6pz5pMAmLiwxwoOavMJ05omgMClBZyg+3dxD7ZFhHjPVjBOk4vCMRBBHWzexu0ygQVpuKPxFuw0BWQfXnnOfvvbh/YMS0ebtPNCQh5L/9tqoIA==
X-YMail-OSG: .b8Nt5gVM1kx.R8Yaz9Pl9V_wC0zOVwY1sfzUw9vCTmDCP8Lq65rlFvtdnA6ZQN
 nZ9ikC1xCKK9cLbHJH8OSsBZs0isv.JvCfx8D2KN8cN.tO_WthRJ8ujtJ_8T9jwjjDHjhDQ7_fm2
 A6QqVI10xHfzzBZMl3qzpYRdfR.CYLsGWKcTZ7Iw8EUybB1ICE9Qm13F5H76scvUNXVlT72MX62d
 L.FH6bN6kj3uymZ7Q_oJTbLuT8i5qGD.e1bJzIEjhfvsVQ9ePWXvUjytRxIxLxvukmHDY6Jmm_ZR
 qstmSvMe6PZcrkhwhr562chlFiE7sPmYfuKNpJJkGhmq6aGYEEZr9JERIeA4NrxxwjngpeNx3Djf
 QvTBfKuhah.n0eR3J6maHtC2aiMqzomfBixMiJ15Bsyg8dPG72GcTNcPUAUY6kpkbCIvnwH90NUs
 i_7CiFf48U2xX3z4lmOD6K51xswQWDCBuKu2qRaosL9MYKZOy.Uo2dW7vdVaj8fIA1KyDuR3hoXu
 avPtCIOHr.AjaalOMyMtiU3S8dmFd.oO1L2NJu.8_fcNn2Wq4YSp45FgSW2bUbWBeqWu6U3g3RDX
 cewBlaITj9UQkHZe.EbCg_skUI3ca_dcD2TTzzoENlQuqcZCtKgfJ4B34REuUDRvoIeF7xY99Bab
 FNU_KMQg72Bk7Z33heLyrwTek6WbWo.wR3511tLpPUVEEoAEU4v7meG1iCOWMcLS8_iQICvcZE9f
 gJ8_0jDSK_KE.6yzygDgq9LZY4rTa1bgC6InA0uP_3OtZSB0wVTxjGMv.aqM9WJuZi1GKLKHDmXw
 oEL4gvIOpEfAnfR5o7tbqctLUzcv.XEp8ItWDjT260DKw5FfyEH.zk_KW_F7.vpi3QvNKTXdV2rc
 Vjnyk3x4I4lKpLKqUNYu8HaMmwNSukzt5O4Ya0pPidxdO2Ke6DShFcbHdPkNF9_ipK.siCzTXgKw
 JhxIgP21nFlhpKerZPQzESGLAA0c4Mvrjw8deEZ1sazRJHzFlqZdLjRE_41xjChF_B9sy0c3miGW
 pxKMWRxjAPApVb2ls8pAqHAgfsHBsTRfFE7GiqwEuXZYF2CowYGDb4_h3MZ_kfLAZDEnf7GbEQxS
 DwjsMFETT0O4js80_PWTxc_74ijPYa7FQfifCHgNgNPZqOMSJZa9Nm_Fwe6wtqHy2lmvJu4ndA5B
 Ry5.sYUTzj_g0toV79UwQYL.3M.PlWIbc35M7J6XTHe1fPXA9rNX8Ulh8s7vDIXZDLZtCkFQrVDm
 pRzpWGjxKvMuJW5nweQAINF980DgF4QCq8vPKer9leKeqn0Ob
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Aug 2019 20:14:27 +0000
Received: by smtp408.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 58ed0af1afde63f1f88d3ff16ad71068; 
 Sun, 18 Aug 2019 20:14:24 +0000 (UTC)
Date: Mon, 19 Aug 2019 04:14:11 +0800
To: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Eric Biggers <ebiggers@kernel.org>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs <linux-erofs@lists.ozlabs.org>,
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Darrick <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

On Mon, Aug 19, 2019 at 02:16:55AM +0800, Gao Xiang wrote:
> Hi Hch,
> 
> On Sun, Aug 18, 2019 at 10:47:02AM -0700, Christoph Hellwig wrote:
> > On Sun, Aug 18, 2019 at 10:29:38AM -0700, Eric Biggers wrote:
> > > Not sure what you're even disagreeing with, as I *do* expect new filesystems to
> > > be held to a high standard, and to be written with the assumption that the
> > > on-disk data may be corrupted or malicious.  We just can't expect the bar to be
> > > so high (e.g. no bugs) that it's never been attained by *any* filesystem even
> > > after years/decades of active development.  If the developers were careful, the
> > > code generally looks robust, and they are willing to address such bugs as they
> > > are found, realistically that's as good as we can expect to get...
> >
> > Well, the impression I got from Richards quick look and the reply to it is
> > that there is very little attempt to validate the ondisk data structure
> > and there is absolutely no priority to do so.  Which is very different
> > from there is a bug or two here and there.
> 
> As my second reply to Richard, I didn't fuzz all the on-disk fields for EROFS.
> and as my reply to Richard / Greg, current EROFS is used on the top of dm-verity.
> 
> I cannot say how well EROFS will be performed on malformed images (and you can
> also find the bug richard pointed out is a miswritten break->continue by myself).
> 
> I posted the upstream EROFS post on July 4, 2019 and a month and a half later,
> no one can tell me (yes, thanks for kind people reply me about their suggestion)
> what we should do next (you can see these emails, I sent many times) to meet
> the minimal upstream requirements and rare people can even dip into my code.
> 
> That is all I want to say. I will work on autofuzz these days, and I want to
> know how to meet your requirements on this (you can tell us your standard,
> how well should we do).
> 
> OK, you don't reply to my post once, I have no idea how to get your first reply.

I have made a simple fuzzer to inject messy in inode metadata,
dir data, compressed indexes and super block,
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer

I am testing with some given dirs and the following script.
Does it look reasonable?

# !/bin/bash

mkdir -p mntdir

for ((i=0; i<1000; ++i)); do
	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1
	umount mntdir
	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
	for j in `find mntdir -type f`; do
		md5sum $j > /dev/null
	done
done

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
