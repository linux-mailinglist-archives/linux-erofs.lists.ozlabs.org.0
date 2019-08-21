Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0B96F60
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 04:20:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CrwJ1Xb0zDrMH
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 12:20:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ru6a2+QA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Crw52lQrzDrL7
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 12:19:49 +1000 (AEST)
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C84EE22DA7;
 Wed, 21 Aug 2019 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566353986;
 bh=99ObL1cP+jG7BwJuhGr2xRiHMfm0AyVNnY16uyz8mng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ru6a2+QADULs0wwoFX4YQsebNK/5qd6Kk+kCW16FnuAC9nOB84MNYRAHcouXWGbFA
 jxDDlseEOkfLWKdjTvog2K/cs7Lp3dY0OF8fKx5O3Mim0AfBj86ctChYFeQLuM/7Lu
 fYDzulv0SOkwznjOgALPI+7qG9dTtb1IsoG+OBUU=
Date: Tue, 20 Aug 2019 19:19:42 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 5/6] staging: erofs: detect potential multiref due to
 corrupted images
Message-ID: <20190821021942.GA14087@kroah.com>
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
 <20190819103426.87579-6-gaoxiang25@huawei.com>
 <f302710e-0c7f-8695-d692-be0c01c431ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f302710e-0c7f-8695-d692-be0c01c431ea@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 weidu.du@huawei.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 19, 2019 at 10:57:42PM +0800, Chao Yu wrote:
> On 2019-8-19 18:34, Gao Xiang wrote:
> > As reported by erofs-utils fuzzer, currently, multiref
> > (ondisk deduplication) hasn't been supported for now,
> > we should forbid it properly.
> > 
> > Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> > Cc: <stable@vger.kernel.org> # 4.19+
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> >  drivers/staging/erofs/zdata.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
> > index aae2f2b8353f..5b6fef5181af 100644
> > --- a/drivers/staging/erofs/zdata.c
> > +++ b/drivers/staging/erofs/zdata.c
> > @@ -816,8 +816,16 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >  			pagenr = z_erofs_onlinepage_index(page);
> >  
> >  		DBG_BUGON(pagenr >= nr_pages);
> > -		DBG_BUGON(pages[pagenr]);
> >  
> > +		/*
> > +		 * currently EROFS doesn't support multiref(dedup),
> > +		 * so here erroring out one multiref page.
> > +		 */
> > +		if (unlikely(pages[pagenr])) {
> > +			DBG_BUGON(1);
> > +			SetPageError(pages[pagenr]);
> > +			z_erofs_onlinepage_endio(pages[pagenr]);
> 
> Should set err meanwhile?

I've skipped this patch in this series for now, and applied the rest.

thanks,

greg k-h
