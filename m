Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E698986F5
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 00:03:49 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DMBB2gmxzDqXt
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 08:03:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566425026;
	bh=1mdHok/Q+VJvdk8B1AULNOGoqbmHms7Y5H3kuw/C5b0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=T7UdFrVu2I00uxQGNCz2HCr4Zp3RGTihwMTvPhxAAO7heJrgAyUqrTN91DmmwpjKw
	 Gx7Flgh+Gz/DIG3MUnlEvEmKLpKBnOkqTC2kMSnz/I1paS8XS4L9RK4w+uWUowbBd+
	 55Z2sBrA3rpE4VMbVff5qvFx15EJuRYYFoZ3C7Z9Rm22Nc8XcM8CoV4wa4plt7FiwA
	 jY+I5I5mABLLXkEYq2qaI/plLSofxrugNDU2aYggd7Tq+FS/k65lmq9mSGqpsIFN93
	 EpT6/YP0ypi3nysiNuvn1cwX9H2ozpI9l6YdVwY9yYtVbd6vPtxHZhAuRjbNge8nja
	 laA3dnAedfCwA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.146; helo=sonic308-18.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Zl4j/lIS"; 
 dkim-atps=neutral
Received: from sonic308-18.consmr.mail.ir2.yahoo.com
 (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DM9h3KsszDqf4
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 08:03:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566424991; bh=as+yRgvr59Q4Mb1Ow5BUWgU6I3h8mr1OBmVUpM5VRtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Zl4j/lISQARmPg+8JlHaIzDCuSFsNdiFqs4Pk0IFt6sBVxbfh+A1e0DvUaPJRGC8OMY5WGuCe98D921R9tKIdWWXshTtTFMgYUWDVOF5Y2lH618rg1jJ9R+1LX50imsoMzSO0HXN1wQQTTKn2963AtNZG1Y5py64MSPHp1gaDMhhBuCAr522h9ud/YsSVfeVfYbwVMbg+sOjIqf7nNrx/5NxTEr7MdwC4Yy4WFANZ/SEagd1xJMQLHz0SEOVG5L89q7fxKHZnL1zLc+7GOmAvqGQcAkXSVyNrpjThvhXpQIp0mgRG2zOujcV2mFGvS6xVQgXnMcYdLYcWqfNK29o+Q==
X-YMail-OSG: A.ECbDoVM1mH2SvniMQ8WTJAGNX41Ss04dcKYTDXD_NYt1M9pMP1QbuMG_TIxMA
 9UM9lQ.0F.BcV7NktkePrIPlYxoCxMLKUrnW_q4RqrVsULq5pQDvdpDy5W6JJpsjY4N3nuc6vX6J
 vg.PArYIC2udo_E7QOUfnZidKsEYhje4ZUVOQ_LwZjf1nqsdbEXUdUDqAeHz4S99A09JZ1MB02vH
 Pj5leyWB6lQ_OatmIAcdq4Tn6shv0ynP3SFBHBlua8wxB7SF2xsEoVOZo4hNdp2naQpQxNKUU1kC
 PJSkErf6laINDlQBxlPQQ7AUTOzSRm_1mCTiGEQe4LAZFhyohsJ4M2sQ8S596MwJsaD4WqOFB7EB
 MUZFDoATAUDBN.UlMeSk5SUrYesnyb6a7RMOUaghjJmhaCfHGqLabVVhbYrVWHNtGoPrTGzguKkg
 ap7WdvQLdNQxHsxPnkisKXhNwZhZ5WdDVOohitrkueCgGGjrv1Lr9VpxwsMl9jvx_NiVlx9PPErH
 NyKfAHp4QH_FSMMI6oNgB0bVlpC1gU..aoEKxUp2suiX.PskpVUItKpelvWAOQv6qe9RgDMauFgb
 ujAgegAyAlJjsr0yu9nmT6tva7C5lCvV4r6hS8Z64vKEJfgtLmfxKqw529bbrFm5DAXajpA.7IjX
 cmpxxpPD5ta62B2DQryxlulpOjuQVmko5_db8j3HrChaUT1UlV_8UgKfiHqFYLTgJskd7CRaBDmZ
 ulT0yiLDILnb55D_HUswlfHyXj3F_J_gpQVE92x80jKxu_iotv1XJcL19daxU2z.PKTO1VuAkLvc
 S3Pz_PVzNwWt_Jqlzx2cF9GpuqnrJcXujVSItmyU3X0YRdbvoAqwRCmiagTzTpGppDiVDqs4LFpC
 yGPMisnOnIrjHmODjJfQgRcZXyVDHUMmlumd9HSk9JbNR0rAGFzBwANV56DerpbSLkOvSGRMmZcu
 .wkQNNlbddSSut6_vM48tce6hKu4HJFlV.syvJw6YzDCJw4FXmSFeMZW0EgoYwVH_Lf1231zOoW9
 0ZSwxynFBLXRC6bpRydQ.C66DfDJDAgQIho3In_zo7qmEGcy0q5ofxu_jFBMgEUlpczwPiq1Sjdt
 38ci8aJxoHg6dwWlTTcFC2zimn79lN_4uCQJ6ml6RYFTKH256PCO0Q2E5QAU8DPIUeSbfF_J.w9y
 iCEfgfZlZrRymhxE1jRAFrLbpEq_7UdZ2lm7qdVPJAnrGoKFyg5P_NCUOw2DXiHy897xyd4fZQ1E
 3ajWf8suHEE6IkyEEm13nhbe8qjlIcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 22:03:11 +0000
Received: by smtp432.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 148febfba35ac7974540a5f89d49d2fa; 
 Wed, 21 Aug 2019 22:03:10 +0000 (UTC)
Date: Thu, 22 Aug 2019 06:03:03 +0800
To: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-erofs@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Richard,

On Wed, Aug 21, 2019 at 11:37:30PM +0200, Richard Weinberger wrote:
> Gao Xiang,
> 
> On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
> <linux-erofs@lists.ozlabs.org> wrote:
> > > struct erofs_super_block has "checksum" and "features" fields,
> > > but they are not used in the source.
> > > What is the plan for these?
> >
> > Yes, both will be used laterly (features is used for compatible
> > features, we already have some incompatible features in 5.3).
> 
> Good. :-)
> I suggest to check the fields being 0 right now.
> Otherwise you are in danger that they get burned if an mkfs.erofs does not
> initialize the fields.

Sorry... I cannot get the point...

super block chksum could be a compatible feature right? which means
new kernel can support it (maybe we can add a warning if such image
doesn't have a chksum then when mounting) but old kernel doesn't
care it.

Or maybe you mean these reserved fields? I have no idea all other
filesystems check these fields to 0 or not... But I think it should
be used with some other flag is set rather than directly use, right?

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> //richard
