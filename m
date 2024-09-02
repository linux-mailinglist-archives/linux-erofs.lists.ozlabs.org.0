Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725E9680E3
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725263206;
	bh=LU82ZRnbNG36KcEB2cwtYaBM+0PeNRrwjU7twoI8AUc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hv5Un5XSvdOraRUkDzybiYk6FYZTZDMPWKgV13zDHeerl6PQkzkCSIDARsZnHRLwB
	 VWU5YOsselnC1qDu4cztCoU9Bh139i1z59D7slw0qYOMW+h18vCRuPrDT04ebWl3Zv
	 RpeRS+OT7/13rIAz8tcB60qqHyWiqIwlxPhDjXcuf9b3JHZDx2F0eCpyrtBqRFQ5Sy
	 C5Y+I4wzVWLjUf4tcmDpUmSgfHfvT2DwYO4gX8e2RroNOvyJv6oymW02NFe3Ef/n2r
	 YUUjJEY6hVyZPeqXcRxXE5cGJMT2NzOjEyFnChE2GfXwdDAmgyExsIelbgn5Loxfr+
	 lqbG3+5tFTZrw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy16Z46vDz2yNc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 17:46:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725263203;
	cv=none; b=gZaJVvsQLP9xFkGBexaXtF3ozrqAi1JdKLY9lhv2G5DjMrtBAOt4OC8AiAzde4SFhohD7QcdTiaL9KTiTY+38y3rjRt6nAlHHOtXhAHhx8wIIFkb/Iqony5997G7X7+cLMZlHHCBHyoUuogNpLj9mOkXFYZcSVXMdMenbBFB7Vn31f5W04wYhLMd86guwDWzKKw/P6WE95XDnYz34lonmg9sBsILaA7pTikSVLGDvcSuuY2vYIymaaTWEYj+Tx6lc4goF6S1bwgF8FvF90V9aZ2pfIYeRnmiWs4rIWcMXiKV/+stz8YHMS78rQmRsiCfxgO0tWConvhA9hdeCeaOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725263203; c=relaxed/relaxed;
	bh=LU82ZRnbNG36KcEB2cwtYaBM+0PeNRrwjU7twoI8AUc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version; b=DjDeMlxANY67m3TJbcrsIYj7XfICZed41Vu/SOt09CqvK6agFIEHU8cTetM8lN4VxEKO9VOlLqIk86nHTvWmYDmIaNEAtfIVezy9jcz1IRsnyj1Fw9x8xxIEtZjGeHxz94tUmdvmQ+IpEbMsMLs3+WHSdPM2d8KOBuHfCG2okseUpuLX2vfW359blfJ1jv367T7v/suL9dh8gkOeR7JcmN5ea16mx9IHUn77Fr1NRRmVpfDWppidT7TuAOPAwc0+iPgS4ccxNT+fmIiyiS/MyH90R93Fav46jG/QQlq4SjlZDsxkO1A5Rp1Bwi0i2QzGxSAIe3koFTubn61mZrNMiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Tgga4mPI; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Tgga4mPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy16W47blz2xHp
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 17:46:43 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 773D5697AA;
	Mon,  2 Sep 2024 03:46:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725263199; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LU82ZRnbNG36KcEB2cwtYaBM+0PeNRrwjU7twoI8AUc=;
	b=Tgga4mPIkaqw+cvxchA9OIX6PIR3zgw9gt7iryTiSylTJfuXCV5KT3G3bRFzxAcow7HPdw
	P9nkrolNQGj2yxQRdLCKfHZpr0J8c+5mSMJ/9SU0qkVJEeYWhlQEPXkPTnlaBFtQDgoogv
	yZYe8ajqCdPMoI9GnvUt2QyjUej5wWeGK3Q3Gqk2Psfh/cmHffAsm+5d9afJmlUvycFqC8
	iOQnOzhEDYmVsjRaugefqeeg/TrDxZwxVDwStNGdq4Tb1F/p3k0V+qspdsuLby6J2SJGGV
	XwaR+VcAP988/o41eYSphQgieLNYz79BcF/WW+kFzmLam2ElNOacKyp/750m9A==
Date: Mon, 2 Sep 2024 15:46:17 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <ql2vdd74fzsfzgxixa3hymagvo42dfnawpr53jgximuh7cwra6@2gn4skmbqkhz>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-2-toolmanp@tlmp.cc>
 <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 03:11:45PM GMT, Gao Xiang wrote:

> 
> 
> On 2024/9/2 15:00, Yiyang Wu via Linux-erofs wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> > ---
> >   fs/erofs/inode.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index 419432be3223..d051afe39670 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> >   		return 0;
> >   	}
> > -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> > -	if (!lnk)
> > -		return -ENOMEM;
> > -
> >   	m_pofs += vi->xattr_isize;
> >   	/* inline symlink data shouldn't cross block boundary */
> >   	if (m_pofs + inode->i_size > bsz) {
> > -		kfree(lnk);
> >   		erofs_err(inode->i_sb,
> >   			  "inline data cross block boundary @ nid %llu",
> >   			  vi->nid);
> >   		DBG_BUGON(1);
> >   		return -EFSCORRUPTED;
> >   	}
> > -	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> > -	lnk[inode->i_size] = '\0';
> > +
> > +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> > +
> 
> Unnecessary new line.
> 
> Also I wonder if it's possible to just
> 	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> 	if (!inode->i_link)
> 		return -ENOMEM;
> 
> here, and get rid of variable lnk.
> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang
>  
Yeah, it looks good to me. Fixed.
> > +	if (!lnk)
> > +		return -ENOMEM;
> >   	inode->i_link = lnk;
> >   	inode->i_op = &erofs_fast_symlink_iops;
> 

Best Regards,
Yiyang Wu
