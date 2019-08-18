Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE2915E3
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 11:29:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BBb46TtHzDrQF
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 19:29:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566120560;
	bh=m4jIL6TjT9xIkMvtH9V4tjBDh40Gvy/vr9kHEiKRYaM=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VzdDN9MWjivnWzGxYvbvxK/oQZ5lHF57EHntV/nYVxDE+PntuEaE+BdjYfk3xVgqM
	 NgiYV/XjMRt4VYryXkc0BigTod7n4blHxnG7P3XVd5NIhLMVlEqs0x+okO8dxrzoE8
	 PTJ4xYoPcji/x/tQnCiXjQ7NMSuyCEWkrFyuFRvQSlo2HGozlbUKfWTMRdtgfXyiIP
	 0Qb1rQue/PfeILmqs0EZWzGfFq1gL7lWvywcyjPC1F9p9Ff9/QLVJKOs452N4A434W
	 H0zkzq09IWze2Vhtt7zMyYpX8QtIaM9oEsP1JVfl/6SQt1JitYwEtyu2OAsL0OCrvW
	 RE9Mc9LuRWhXg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rstR/tV5"; 
 dkim-atps=neutral
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BBZw72n3zDrQ8
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 19:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566120547; bh=elNzjKtOd8tHsVMRzwJVP/2i4hqq6jHwCebjdt6foXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=rstR/tV5mq2tGQnRWKksVEd7fTtZ6MYHGw4G3DzIxbKxuDi66go24Lkj+RdUh1INQ3mqogioAitvYF5OYwFWASXWFV8RyOb8gvYVKGS0VJAhNnLvHut8Qd/eiDKe+InBI4IBJOCL6UrGyWAzpbOCzup1K3NP/v/rWK0JRCLYK8KYVbFkeOYubBnDfDrYUFAIxuWs/2kRRrNDJVyfguRv+WkyLXgl2trngpNsRbfLtazlJAJikA7nzI8Sq8rlRJsaYUl1b4sLd7nuFpGzLCwUek+0234fKjjma16KpdjKBVzFLrEJhR/YqBC3xWPAhcQEUvMKCpCCdoUOe/+f/lk9CA==
X-YMail-OSG: 67dmY8AVM1n76X4YJ_Wsb_3kQNM256dgFTpNJZS_44izD_3iUPAYd8QsVETZem5
 MMFNmnKehg4a9oiqDbNtSG2ss6jL12h3ZrUYXqJj9oGWb2.JwlM2IvJonU8KVjv2HkRyFcIU3oO8
 MSw2TfrhrB.2vuHiUzTAEqAQkTqJzpC3iHb.MXJOqe.zHBUpYz3jlrDdRZj0wP97xJm1Me6_fZIH
 r1whmR_ZARK_nNlUdVH1blUkHRP74JVXEYYrAUWA7bk3wgIMSrPfQ9mf0blZeWWEsw0US3_KjNa9
 rDHJiPhps6WrviSV.VphpO6gqIagpp131eDTk0FFSezeDGIWPsQTe.5kqSdNgTdvkseQN6ES5Jt.
 dNSh4SAmIMtyyNQ8Rs7hJJHUIRk82ErgDCNO6LUdiPQWxqGkG0tdGHU1qdyptgRB1wp5shwqfwMm
 tKUgpGcQL6.O2pjqzP0ctoGWUOjf1L2a5psYJyR1HhAVLxxvEXM2xID05Fv2euByK88daRak.HjF
 VxusuvUUoJrSudbxh5Azlq2I1_lI9NqBcc50LQEGd_ea0OHfBz9c72Ut3iKWVSK4z4HEo0skdAJP
 R3DXJbq7xAlYEc8zIRpdshQFIa8uaFh6xI3ej3riFr3SwAOUayG8TjHsHoI1jqf80aJkUC55bgJO
 2BwwrzrvyPHC6YKMKCgQkP63z8Mzha0R5zYsA4C2z.p6S4kjTip3WMaTBH5D2L1I1.bTKVNBhb9Y
 YdhDxFCIuYixDzE4WZog6T7C7P3PJaH4CnBtadWWHWr5GRE4UV_CMmCocDglv4w3UbUVORTW37P0
 4xfEGGB7hocRFJPdmKYNLUtTdKh2jI6CaEqlp9bKFkYD2AX3lAXYJo7Q1CUq95OJ9kE3Pcv8O8tM
 Cutfs60iItiFgev6Sp1vEtJzeo4h7eTaNnPMCrik6LBaTmgxtOxFzc..jgMX5YPYBYOE_3u247Y.
 uMX8.W.EahwTYkqh4HDAPSYb7lehqS5C3n2Vg6ht5tU_v63I6r3SGY51Yl1bST3pnaj35cXIzlQz
 FhHDw6mEV.AqxjQC6gnBP9KK822l2V7728y67AmvXlVo4oPbM0.2zqomuqOIaOp2d0IsV_qc9lZ.
 zTqxG7qNgve6FtZpgI.38TCic8jI3Ud5Q6eI52lmTMpW2l7Ug_qKM.Js56ZWrRECx6qzyg_bZwqf
 j1IZXkcuQAf.C7BSWuUBnx83cAYXkad9xFbT_e7NSSfISOKL4Nf5JFLnCjVEDJLUXs..tfH92Tzu
 CoRl1S1djCKU6TrVudNK6kqQkxEMHZpYuUldf4A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 09:29:07 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ca20b18070ed0178b8c3396d5cdfbdc7; 
 Sun, 18 Aug 2019 09:29:04 +0000 (UTC)
Date: Sun, 18 Aug 2019 17:28:43 +0800
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818092839.GA18975@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
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
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 11:03:53AM +0200, Richard Weinberger wrote:
> ----- Urspr??ngliche Mail -----
> > I agree with you, but what can we do now is trying our best to fuzz
> > all the fields.
> > 
> > So, what is your opinion about EROFS?
> 
> All I'm saying is that you should not blindly trust the disk.

I completely agree with you, and I'm teaching EROFS to
make the little naughty boy more strong... (we already
have many error handling code, but I think I will teach him
more, yes.)

> 
> Another thing that raises my attention is in superblock_read():
>         memcpy(sbi->volume_name, layout->volume_name,
>                sizeof(layout->volume_name));
> 
> Where do you check whether ->volume_name has a NUL terminator?
> Currently this field has no user, maybe will add a check upon usage.
> But this kind of things makes me wonder.

Yes, I think this is a good point. :)
Since volume_name is not used currently, I will fix it when
it use late.

I will make a note here (or more straightforward, I will fix it
to avoid potential bug now.)

Thanks,
Gao Xiang

> 
> Thanks,
> //richard
