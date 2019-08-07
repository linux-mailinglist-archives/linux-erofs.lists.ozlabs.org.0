Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DF85304
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 20:34:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463gC55TX8zDqlX
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 04:34:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565202865;
	bh=YdLT089CVCLNE7OHhFj6gd6YgoruoPRf8K9ndfkxRJg=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bs5wKfCAinNtcFfsyQAX0zAPucnur0OyyrvuQw652piWI9SgMi1M8zz+kc2Ko3+Pi
	 obykvnCDyd0xdRXYRPa6L9bzsmtVAZAwjsKHuex97sskkIWpdbvj8ru3hpwbOBjXKi
	 Zr3vE5cLrh/RxHrCs8OXPg+/BR8beEab6g05zzQWaE9xFSIJT10voOusKg/dvs24ON
	 VVMVmmEOrCmRFZxk+QgwI3729mqqOAfNpE5ND92O9WRPBtIEqbs5Bs20ZG8oCUWr0K
	 mkp5qD/sewIi9VMJmPcL5H25DcX+pYBqaa6xJ/j6Q6YO1KSLGXFz/I5XOY4oGXzcSz
	 vzVl8ZqsmXNiw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.32; helo=sonic310-11.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="WVFTQmVO"; 
 dkim-atps=neutral
Received: from sonic310-11.consmr.mail.ir2.yahoo.com
 (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463gBy6H1wzDqfW
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 04:34:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565202855; bh=mBVtEl6marp7y9LAxAAAZaMRE1c2vs29ZOkWERsPIyU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=WVFTQmVOBMtTeyYNDrLC5nrglmcACarq2HU27WeF/C/OpMEQk1EmcfuGye9eQu6H8lp3wccqypbb7WNlR3r9EnWprc3NMlwwmHWFqMcMSDjhH0YXOe45zVyNtpQpKeYZWEIW2/jwfNY8EJEIg2l3YtnzIenyRAjubTxvdmtdkyvhbQymcY1tIpaZXvzyTSqQjfcx+I+YvMlNcHAcXd0MkTU6rwZknTHheib83OX/R4jlMjyUOtI0LJsdGpy7Ja44WMRZbB6moel3oYA0on5X94SjBTgT+6LIrAlJg/NiQi1HMKRYuldUevgtJZfYm1Mwj2DXkxDkBFJCvjHRoRi+XQ==
X-YMail-OSG: Pp_QmrUVM1mekKL5HXHQDePK7AclnneOreqk.dLGiZsbvz.6sCNa.YIAI8ObtKi
 5fpT6LXplCzKOF2MyfL.IyV4A9Ql4sMw1Ya1i.jKSDB1eOIDhI.t8LGA51XgdWTBuTdnQna87R.f
 YjiVMhIXKCRoXepjxphyLVpNzRjuyGOaiI0VDjG2gKEPYYrTAsD9NkuOWAy3UTsJi3K04NVlzDdy
 UyJQliiTE2OBhyrCJms_fxLqtOo0c2gaFgKwrV4R9lpuKtWRYU6zHSB0lmZtrlo9LFXNFIKo_0Ty
 IDxHCmYX.2pXnDqpZzllH6mRONTzE5unBxgVNQtp90rTbYu73jPguaQXeH8jc7nbRUYan7wDkgYx
 L1DtmBvnXIx0WGsaMsMVlX6sdRihba7FThcAWfc0A5WFBDrJSRB_Q41YOgHEaMXkqSZnNYRN3bw0
 osW29ChBXsNQLrSkhG3olPuzxpy1UInrubnQH_3k5du0_.tSGEzRc5NtRcdwCiKGEDfR0rIoptwg
 jV7kLCsOUeYQhVg_q91z2tk.G9nhMCdlvNxsXj8sZRHcU2askfTq7EBYk_V3VnjExLWUVt3O_RM5
 PTjRRlv8xhJ6oyDfvCPZhVKOH9gPtgETzaIoD59pFZjLml0KeJpWY9Feb3t8F5a_jKqN.HdMhHEB
 V5leHtXnVAVboTYY6ETFyTQ6_6nnPc3oa9ouH0aXarl_Weh9FD3qWK9lADf5kNVG0SQla61R7GXQ
 vYCkHmyJBftSCEgoWqhuZcTyP_42BpI1kS3fjH0RZNqhRe6hfeOTvzPoqdmVeppmldzW1nLQh9XM
 fTHrP5PMKKbwzkoBwnFtG7PQC6Gbrbjozc2u7kwWg2eL8eq4rmrQPkhYA9adRMZXHYWcgdeWXMFz
 TpH7vOGnuIswZHbEOb2lA2mdsbvfhIu_zWXDs0zXBe6.nGOTqrb27.MykRp.cvTEWkpx4eZ6xa27
 35GHRUJzpvUtIlJG0f1wo6Qi7eRQvMnhd.Ay4D.5pVOPFKEcVx4W5pEswG5YZhtMJeYQ3C0rgiXQ
 ejqsVxoz9bIGXhcXiZtd1jZrgluUTUcnsscQCitNXYPnCsaunKCVWM1sO7UbY64ff5H2IWCx.Gvb
 QY3ciIaesr6qrVvDUp4ipu20ydrYAL2Ee_6IQqTEMFGgsiDgIShva2WwwHhJtWaAjCUop2JEKSw4
 ufRcweGUKu_P0LoUW94qqXP079c6A13FEJ7bqwKQz5KTFixVod2UEzJowidWsE0qkdbuREtsYU_Z
 oAfyRgyMp9FzGC0kqX2YlqX2Ueg1sMZaT
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 7 Aug 2019 18:34:15 +0000
Received: by smtp423.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID eda0b666a511c8098fb45698649acf1f; 
 Wed, 07 Aug 2019 18:34:09 +0000 (UTC)
Date: Thu, 8 Aug 2019 02:34:05 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: Test case suite for erofs.
Message-ID: <20190807183403.GB13848@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAGu0czRhmT7vSnFB-9pnJS=fhZp7RFL2ZwYfbc1RK-p5ddQ6tw@mail.gmail.com>
 <20190806160524.GA26612@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czTjLixYux78ORnQEhx=VnMt_N_PaBAu1zbWAKXJTfo6Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czTjLixYux78ORnQEhx=VnMt_N_PaBAu1zbWAKXJTfo6Lw@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 07, 2019 at 10:44:01PM +0530, Pratik Shinde wrote:
> Thanks for the comprehensive answer Gao !
> So we can use this channel to post Test cases that we think are needed for
> erofs.

Yeah, it's a pretty good thing to see some new EROFS specfic
test cases are developped later. come on! :)

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Tue, Aug 6, 2019 at 9:35 PM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Tue, Aug 06, 2019 at 08:18:42PM +0530, Pratik Shinde wrote:
> > > Hello Maintainers,
> > >
> > > I wanted to ask if there is any plan for writing a test case suite for
> > > erofs. If not, how do you think is the idea of having a dedicated test
> > case
> > > suite, so as to maintain quality of fs?
> > > Let me know your thoughts.
> >
> > Currently we have a modified ro-fsstress for EROFS to do fuzzer tests,
> > and we have dedicated constructed images to do all regression tests.
> >
> > Yes, I personally think that is not enough (thus we have a large beta
> > users as a supplement) and we asked squashfs maintainers for their tools
> > last year but without any luck.
> >
> > new xfstest testcases for read-only filesystems developped by another
> > HUAWEI
> > team is also available at
> > https://www.spinics.net/lists/fstests/msg11398.html
> > but without further progress till now...
> >
> > It's better to develop more testcases for EROFS, and we can put forward
> > xfstest as well. :)
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > -Pratik
> >
