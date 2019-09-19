Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615EB7DDB
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2019 17:12:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Z0gw305yzF54F
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2019 01:12:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1568905932;
	bh=Vpc54zYbPTNIKk1uSjvVJHtcoUcZyHXRpe6zsiWnxA8=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ct9EUEmFGyazVjzAG+Lq2UfPjGr6KuNXLWazr4ZZ2kkfEkDD5U71ku9FMYVFpN0ps
	 ce+olhpVkWFmZifaCwinbMC+Ar64sRimcQOHCbGmQEigbL13z/VQNEq0OGss2Am5b9
	 8ldFdiZ4PhO2RXTPmvlY19xMbZIl4+YyjC8bjRef+PflA99x1bPX4JQbpJtKWBy4DR
	 Xi2vp705VJIUeQhsYW+Q9e7aLiTcoEwpDjIzX9AVUnwn2kpjnyTk5QzMmVP2p8dJ5V
	 KeP5AkHe4wLHUr15vha0wiuagXVxtQjSkI8zYz2F3giIJfgDBQnCkvchkPs6h8XDbr
	 CuREStsCdtkqw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="aydgU3m7"; 
 dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Z0gB4pplzF4jD
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2019 01:11:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1568905889; bh=1O+vcGjb05gALj1QAad6oTp09F1ELiXLmBDLOinwAuQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Subject;
 b=aydgU3m7Ou6Rcnz6J90S7pTQcDjThuA2WPQTJwSkPWoS2z//BLXddJq5s0FIIxfaIkDw9GsWzVsJ3mhoEjJB2KwyM86cnkdUnJF4FRvMq6zK5jHa9EY5UaLGN+U2930WKF4Nl77Z4gVcp1Y7Lo/ycnR7H0e7zH0FMcz5jW5WyktIZ5iEhJaw5J+XUYrij+21psX814JVrwyNcqszA+jUlvoKRD5Bou+E7jbCfmZiLdasSj5fZvOo0u7INbn/L8sddkOLaQU1uZKkySaQKN5iGLq/w7BUKwpPp/WWwFPfofKxfIbhZAZGwlikpN1ncrVg8L/ZnYAePT9Cpb3DXNEEkw==
X-YMail-OSG: bWS3MbAVM1n2bVlxeCjg2TlJXEwEXoEGyq.F13_51W51aumfuTjEoZcd2ZUlYYp
 stFoP_2g5EeXEqZeYPvxKWq0fNMnCYZHDZ0fkrERKiVX36Vt1W.TKP4AJDypwy3m2KyC0OVOnJZL
 lNWHgRlUkG3GvIryChc7kpQmFEER56RW6RRxvUKy9Dw7i_m4K9W6LEnel6TXSkrGxFScevHaLPIb
 cIaD7u1cl4BQgucbUHhIxkljUrG8rKIQdNRSkm3sUPLMNWC82p1TGNyuLMGrxVImSzAH5HOAbqIr
 eb1nEvNXAmBlzuQe1gd_M9cMy0aU7Xp5xwllx7WdHOt7u4o.wqP.PsP2nBLOIHV7rHwqPZJutNsk
 GVgcFZvwY0QOVy.22QoRTHqitXF5IV4SBE0tdpg8FjikNo76Gss5NPN5QKMc1AR10t0YSLtAU4Lh
 eCIa7QVMsKdJINa6K8SHDOoTaZNHZEC84uzTgbnpcqIuXpzG0WFKU5NwKdWTX6mzC827UX5l86_G
 Y3I2V2AC1m3cczrnTg2Jk_78saePb3O4tROy2dpdi2eUJmGtpnQhMXfprvzIQoPCwvhPJAm0VSaR
 7igRx3fUIVzar9zL8EXd24N88KP98alU2UYYoOcK1xpz5yeBTR9LV_JrBUH3kM06LUBPL7kKQ1FT
 _rsK62RKBhagfpGB_sNarttM01UB6cZXFSS0QGalITrL4p8HXXIOuGZkpJYMenvUcXcePXJz7k9m
 mRfmhsDdC37ejqg4NAF2sQLgjJDTnarPnJUUhGxHI1L95Cdg5Qs3FThDjIZP.3Zszf4bCgtdoSJ6
 8oOXIGi2MIhHwYyH5clNw89yC1UkGi0NN4A4UYecGMZnKT2FL89uiNkWmGA30V4P8ipi5sZj1blV
 11JrBME.JXClK.hTYUmyonRj8.7yedYE1ierTiuQ8as.QyIU0Ip6Awh8aKuSCyauYhItHz7mvI_Y
 q.uB7eY1deNgdTngRS14yIMl9dyfpHZ5KHdDmQ1KwlKbRv_uaMUFAdxJwNQWFcFzXKC525vzR4.U
 37WeCqn04LlTvF8ZfyHyzhiDsBHO8dc81WzLIVGw22BC1FaAPSSQh05BNHurY3kmRAK9nOLKQL5d
 SfhFvCWyCuub334uX7tNlsPqXJTMdSOJ_pLJJqWJ0Hq4JM.C5.tqPAZ27YnwBAfyqaijr_go_Byl
 i6mQPFDvtpUFArRx3S35wK5NaIsf8t6MLYLRQ3MhchdystDZ8aOBTbGtGKDKGcDUXi.gvfpM0s8M
 tEHadBg0X207GBLRP6HyVhfM6PBxpuMBu4JH52Hv1ahnKngljmMqC8IpAcQ_mIvpB84TwN7WBt6_
 nMZ4OeTKJpgWVob0Qfs1fYuVo.vuXrf_J5.0rwtwzOg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Thu, 19 Sep 2019 15:11:29 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d8617a679873d1c43053a5376a695e1e; 
 Thu, 19 Sep 2019 15:11:23 +0000 (UTC)
Date: Thu, 19 Sep 2019 23:11:16 +0800
To: Mark Brown <broonie@kernel.org>
Subject: Re: erofs -next tree inclusion request
Message-ID: <20190919150213.GA6138@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919145027.GN3642@sirena.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
References: <20190919150213.GA6138.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.14303 hermes Apache-HttpAsyncClient/4.1.4
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-next@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 19, 2019 at 03:50:27PM +0100, Mark Brown wrote:
> On Thu, Sep 19, 2019 at 10:37:22PM +0800, Gao Xiang wrote:
> 
> > The fixes only -fixes branch is
> > git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
> 
> > Thanks for taking time on this stuff...
> 
> OK, thanks - I've added that for tomorrow and I'll try to remember to
> add it onto the end of today's build too.  Like I said before you might
> need to remind Stephen about the trees when he gets back on the 30th but
> hopefully he'll see these mails.

Thanks, I will keep eyes on -next branch and remind him when it's really
necessary.

> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and
>      * destined for the current or next Linux merge window.

Yes, I understand these rules (by keeping up with several previous rounds)
and thanks for your reminder again.

> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

I will give a try after these commits are all solid and pull request with
my PGP key then... Thank you...

Thanks,
Gao Xiang

