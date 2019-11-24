Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3321084AF
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Nov 2019 20:10:43 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47LfrY72m2zDqYC
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Nov 2019 06:10:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1574622638;
	bh=bASilMXk8a6tF14LpCEbZgC3H+3xLiTAv/YHqpRVSa8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=av40VBy62tcrIy/7A/1qV+8Px/72oar6EkMU9COn/39RRbHra3YybxwHu6bFEtTsd
	 eZxCtVG+U49NwZ7HT/8brVc/ShhG9IxmMc9K4XXf+S57AFDDAR0hdyFCcsdc9Vvw5B
	 zQyRpSoths/WxXjsUzdkJ6xyZdfCP9Nf2sS3Quv/HUicekRpUO8K1XNF3ZnP0UQs/p
	 OKx+oKuu8Deon+CkjXx1IlN883lEjV79GcT0zv077JtCYEQBiCw9UaT2nBEef5ufpk
	 VOJgqvxNy5zCIEw4ziTUNfF0gfrr0LxtbbAGTzZgEikzqAoS3veC/7h7r+s0B6vGFL
	 7a41rFQhSQoFA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="HMVp76OL"; 
 dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47LfrB0fQfzDqXs
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Nov 2019 06:10:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1574622612; bh=7ia0d5/+7N2lnZw8t1LoUMuMgmslhvBOPbVRAFMeios=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=HMVp76OLV/Z7rKxMcqP/MH/aIkrCIPqrsJQ8B6LJIAfdysPgbC5uXJMuLV/6h0em2/BlBf5Aj/al5/9OsXvURme3j3tTVV3TD0zOE+Cm3SutxSuZ9MsGZjrIbj31dNLvDBLxMWPTANF9zherPyjMulkiV+AFbFxx4f00wdv0lR6mkhIlJq7kVIjS5Va3n8WfO5+ODpxlsjjjcJn98SDECDnM6fFt/qhQqhhSFsp/rlUXEUaCqp8dDVTCD/j5MZUTEFi5CywYlZTUqC14MibeTBx/QsspDzHEUI1PWOR9axuTVimr0dY46ribf6KZFM3gkiKxff0bPCEl9Nev4WnpdQ==
X-YMail-OSG: q257OrQVM1kKkn6o0ji2bRXgsmBLxANCSGO_F46J8O38X2LnljoAAy.QeYkEuzP
 9cZnWkwhUWGk7nf2eyb.XrgvtB8ifXmavBql8Yw9.YRWnTRZuPS6RcxkEDi0taH7oOhiXqyJ32gs
 PjFQ098xfrk64XCKRQek.akErjebbp5piv.cG42OGzT2umqGkCKs0vueC.mPKKIhl236g7iZdMrc
 QuWqyzVuBziLk2ufX6WyC9ReJNnN6rRxB6_S9qxsfP0pgLRPPVENt2dzsyGmq6u.CPwvXgQSgCfe
 70iugkfp5D9UDt7vqIbji.Mh5jS_1RySce7ZCAi0C9FJ6fXIPQ3LAcPafSsR48kD0.QV4NL399Op
 MSp3TYlf0.d4m7wJLrPfpyTZ4ZNagZIKQQF9qUE6CWGRLyw14h2EL9vVBByeUeR5cJ9NQK2NW44G
 85A8xxCCgeuvl68.8wUWHcF0sOWjpxoSI9Dbk_fsvClOcNbKGXN4zxOqj3nbrNVCnFCHViOKbcGH
 g5JOsqtJTxvXr5Zyftd7BNGqh.JK02hwfiuZ36KRMS0KCWGidFh8qB.pK5FkHOt5BWD2A8geEpqO
 jx4qyNmWNahzKtLEdRQ5MelMwhsvMs6mz5KjkJoL6aN3kxf0Fl5VsPt_lowir2vwIln7GSTLfUKY
 28s4xcZdJsorTyUuCwCLPOxKvCYS5GwZ8CysTXE825HnsU3_rkYjxbivx3_6xFUL6A891yPQmGdb
 UrUe8an098e7LfEjXx701Q4zwh6oUKv5B140huqzc0IH8zw0ARSPGTCEBer.LgvB71OQZZDd1iSl
 wuD7VgaYFL.cDl4avr3vFyUGum_ov3dmLES7y77t3veNzGFqoIDSKXK9_InvhCWVDJ5r43dMtVEN
 ESnrxCzARcRX.42iYavvCQLhesu3DSOuG31NzKC7UVDAEUeEoXyn9sGGoFsU84kxQVBKe8mi8E1Y
 6K5g3Bfb9jlrRiRsSnNlXZA8v.0yIl4sX8AZVLk5MvDIGGiJRojWmMQ2luByPbMwhmZj5HhzT7nE
 326XKMtVoYdqKyBmWjNbVKkPuYW5nzoM3yPZHM6Lp6.9y.CAgA1jMMHdcqCnv6u24RPJFsv0fSmV
 S8Mqr4B1kjtNOi8OXFYlMry397MF9fcWBk5sXfWCNCRnnU7O1kxeBnfmUBoX_2ZKli3fvNKHJ3B3
 bPYdaBF5BAcLiwOCYc.Lf4Wac3wLVSQ.23H2wq.BVD8d5xOD1CWis4ztqEriPAIXWdiutWNGj5Pj
 bTR1nUL5dbCUTce3gA0NYP0SvhkVrlJ0i3Fwk7of4wdb0Wu.cqETXbSeoc0w45qsYW9f29l79ReJ
 EnOTyp3p2UiYswtN8nuxEd_8hx7goQd3kX6QTqp34L._GNKISozGZ7_z1vNGBIzTSFMIoGCXqarn
 wQA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 24 Nov 2019 19:10:12 +0000
Received: by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4bbeceb15d081dd67cf1956eebd0154e; 
 Sun, 24 Nov 2019 19:10:07 +0000 (UTC)
Date: Mon, 25 Nov 2019 03:10:02 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: Support for uncompressed sparse files.
Message-ID: <20191124190959.GA2029@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAGu0czQOorHC=JxQVpWDB2KD0NOzh13OuHj3r_4_U5hCWkkNwQ@mail.gmail.com>
 <20191117173027.GA21516@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czTT=s8xU0uLruAE3a3jnPDd_eQS290u45OACYrb3Z3L0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czTT=s8xU0uLruAE3a3jnPDd_eQS290u45OACYrb3Z3L0Q@mail.gmail.com>
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

Hi Pratik,

On Mon, Nov 25, 2019 at 12:00:28AM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> In the current design, for uncompressed files, we only maintain the
> starting block address.because rest of the data blocks will follow it
> (continuous allocation).
> For sparse files we have to do following
> 1) We don't want to allocate space for holes (Holes will be multiple of
> EROFS_BLKSZ ?)
> 2) For read() operation on holes, return null data  = '\0'.
> 
> I have few thoughts about it:
> 1) Without changing the current design much, we want to keep track of holes
> in file.
>     e.g maintaining some table OR bitmap(per inode), to check if given
> offset falls inside hole or real data.
> 2) Accordingly changing the readpage() aop.
> 
> Let me know you thoughts on this.

I think it's roughly correct. Assume that holes aren't greatly fragmented,
I think it's useful to introduce extent table format rather than
some bitmap for sparse inodes.

Maybe we can start off with RFC PATCH of sparse files for mkfs, and thus
we can have common sense with on-disk format as well.

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Sun, Nov 17, 2019 at 11:01 PM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Sun, Nov 17, 2019 at 03:40:43PM +0530, Pratik Shinde wrote:
> > > Hello Gao,
> > >
> > > I have started working on above functionality for erofs.
> > > First thing we need to do is detect sparse files & determine location of
> > > holes in it.
> > >
> > > I was thinking of using lseek() with SEEK_HOLE & SEEK_DATA for detecting
> > > holes.
> > > Let me know what you think about the approach OR any other better
> > approach
> > > in your mind.
> > >
> > > PS : support for SEEK_HOLE & SEEK_DATA came in 3.4 kernel.
> >
> > That is a good start to detect sparse files by SEEK_HOLE & SEEK_DATA.
> >
> > And as the first step, we need to design the on-disk extent format
> > for uncompressed sparse files. Is there some preliminary proposed
> > ideas for this as well? :-) (I'm not sure whether Chao is busy in
> > other stuffs now, we'd get in line with sparse on-disk format.)
> >
> > Thanks,
> > Gao Xiang
> >
> >
