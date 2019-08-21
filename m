Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1866C97F6D
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 17:52:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DBxt03bqzDqnW
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 01:52:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566402754;
	bh=XqFCbLFVf0riDfs2WIC9jy0ErofcF43Rv22cRPocL/Q=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GU+LLnFO89KYhXHhaqlyps2l40dh2XXkbLiIszpNW9vWVmFmBr8yPnoigWZ5XPyVx
	 qWiX5cGmEqMe5WfdVrmF3NnaxSoEsdIOH7AskWu/OUgQLiaoKZ4VhCqL6bbIZr0F1f
	 gSbNvJ2oMux1NFvqlkXRWHBpyDtr6JYD1zzuZ0Ltgt9D/pyPJN9VBHsr/LH8kaOV/o
	 rzPB9uAOX3HvvUvVhVV+WfaBCgsM6MWC+ACOQTOHup3uzC8iquL6n98J6o2XRlxjQn
	 piuXU4n3NOAuPrjgq4fhzKZXkQgzOfySDpvnCSX778G32Euj4cB7FtTx1cqGbpqOgo
	 /G2pZyHbe7A6w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.82; helo=sonic314-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="tpWLkJHv"; 
 dkim-atps=neutral
Received: from sonic314-19.consmr.mail.gq1.yahoo.com
 (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DBxh6fKCzDqcK
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 01:52:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566402738; bh=iTroMwNCz0Ok+97McvMjs1IUkl8f42sTIG9Axgs6bb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=tpWLkJHvp5wDL9lOErA+mK5oaMKtJi0s4i09AHBLHbf95o6w5ASKzs6O/9dKtvC5Pa/wp+acouUpwhClDxofcjmsVmABXh4l45rl0wVMz6viNMNt9ihbZTNDQD6PYeHWieJtCzbHxHWxZGk8rimEdbOi5aF9CUHlkQh2pTiHzCkRDt1IQRyfyTP794vvDGOZOmuud/xj30fkkl+it+3IJDlhTNu/v+2cfSO5x1LltfcEeeSEvpQYAQ2ZPduS13fRUWdYxiSF8dvHQ7nB2AKhRTHfOlL8Y34q1adsdmNPxmFylGk2ctfX3Je8iJ8QTw5cRtpUHrBAoDxlwgF0SrX28Q==
X-YMail-OSG: ACr3z4gVM1nQcSJWKwDoFqS9sY8unHRHRiwM9wt_EilF9KlIPY1BSkpT9aqvnq8
 NHM1x8Yzu3SZPqv6Loh.JKQsZN.qZGVhNBBisiIACy1lnFbWqd_mEFFCDSyvgBMPgDiW0NMSgJnV
 Vywe6hfL15SYBJ.Nj4lUpjpbPBxCxoLa94lr08SfRDRmmYl7JQCcT0ih.iuxckBLtlKJ0ALw9AlM
 5BFHSJ9BTMS9pHgX07eLgozEoakSvBbE1DiVovzTF34Q6Z9t2V_rXeAJ4HJsHFRfmIhqhXABuj5w
 J6qOqdbdv2oP0VHnSmtJZFJpnlwrobY5qzoPUHaCpRzuY2Dnnrxi_CtxAR_Ojo2tWFC2Juh9IBZa
 KaiJw4rAKHL.1Od2mzdmf1Pg1Dcm3XYwblQk71jU8jMS7o8J9aYiqt6wHNdjoSEL3wL_vyr2Yqc6
 TaBeOe2ePbE1tOplYVPjZQPwZHgh8OBhoQS6HaIgd6Ej5D27QpKYNum3OO91VQ2y1nzLBsNwelmP
 AZCRO1DF8rR1EBzytFg8nAtFRZ2c3A11JFjQi4E18RbleqsUWD6x0NKXDqOrLGNoVQ4ZMX__br9M
 7cVRZJstjrv10E7G9Onsdd1Xd0DJbnNy36u1mCMr26k0yscqul4BYP2D1PN_YHq65HrVCA5q1_x6
 GKpy5N.VSrbERBBVaUemEBK.eAnzkD0vftwdXp0bMh.fkPkkdWeqdH_d8ym0zBCy7XIN1sArvI2t
 7lmmg4AgJ0Q.dxn6ZI8dMTFSFwuJXkWOFeeMvrZZoqwIAElwRcU3cCwTpnjciR_CaV8B0pIZBi0U
 JLXSsUVCu.N11CuwbRm8e4gGzB6HWjfOYnCug0FQRfDilv7_88oLkudbdRPzhhQDW7Ij6GC_Y2yg
 OkpS9uO59tlPbq3Q0ZagSxx5CWzpxyVd1F1s4dzWHeonvvC_JfG3XwRVlUgKfArQRpyC73P20Abd
 huyiX.nUI1u7.Utfo8RTX6gt2hUaC6Sjr.B5bQoSeaN7jQlrY19Ipk3dkVC7vyfGwcItJ5ju4Yt1
 Kk4Zo46YSt6jwUtRv6YvJapziBmjHQ46k0_yxhDqAeAalOdXtzDy37LDtSNt4R8_8fUnrvjiB9T0
 a4FcIse013QugDOgvyGmVdHmMkj.PxauN4XPqdGHu04SEpWiHH53XDyMhz6BtXXWpjT7.6PZB_44
 .MMyM1l6w1xYeWYq01w.7kcvqCFhcIifG4kT1Jz0eLh2FYh9wPepNH1IPMgNhgli_0gPGkaM5SVN
 yjKYGiCAbGpiQ9cR71Tzp7N7acQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Wed, 21 Aug 2019 15:52:18 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 49078682cac6f4c277a5635d11b259eb; 
 Wed, 21 Aug 2019 15:52:17 +0000 (UTC)
Date: Wed, 21 Aug 2019 23:52:09 +0800
To: "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
Message-ID: <20190821155205.GB5060@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
 <20190821023122.GA159802@architecture4>
 <20190821151241.GF12461@ares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821151241.GF12461@ares>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 linux-erofs@lists.ozlabs.org, Caitlyn <caitlynannefinn@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tobin,

On Wed, Aug 21, 2019 at 08:13:35AM -0700, Tobin C. Harding wrote:
> On Wed, Aug 21, 2019 at 10:31:22AM +0800, Gao Xiang wrote:
> > On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> > > On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > > > Balanced braces to fix some checkpath warnings in inode.c and
> > > > unzip_vle.c
> > > []
> > > > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> > > []
> > > > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> > > >  	mutex_lock(&work->lock);
> > > >  	nr_pages = work->nr_pages;
> > > >  
> > > > -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > > > +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> > > >  		pages = pages_onstack;
> > > > -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > -		 mutex_trylock(&z_pagemap_global_lock))
> > > > +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > +		 mutex_trylock(&z_pagemap_global_lock)) {
> > > 
> > > Extra space after tab
> > 
> > There is actually balanced braces in linux-next.
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762
> 
> Which tree did these changes go in through please Gao?  I believe
> Caitlyn was working off of the staging-next branch of Greg's staging
> tree.

I don't think so, the reason is that unzip_vle.c was renamed to zdata.c
months ago, see:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs?h=staging-next

so I think the patch is outdated when I first look at it.

Thanks,
Gao Xiang

> 
> thanks,
> Tobin.
