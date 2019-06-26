Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE055DE5
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 03:45:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YQpD2ZFhzDqZC
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 11:45:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gQzkIarO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YQp44lnPzDqYh
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 11:45:15 +1000 (AEST)
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66EE6204EC;
 Wed, 26 Jun 2019 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561513512;
 bh=hqyt/0wW6fNJncwi8XXXg9qb9sSpkSwwTsNrPcBwcmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gQzkIarOJ6RUAHT1ksxCfNqnnaNJpF3By0s5QDXavFbNsh2kdWQgcbXGdV5RhznsE
 cYppvA32MlTqgkYQ9YON1Rf5lTPrMBg2685+01TTJRuYHh9Hhek+GK1lCKjXW6gcJW
 Y8y/pobQBN9H6IwOzOWJ97K7VROyyhLdniiURrIE=
Date: Wed, 26 Jun 2019 09:43:43 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] staging: erofs: return the error value if
 fill_inline_data() fails
Message-ID: <20190626014343.GA16013@kroah.com>
References: <20190625075943.2420-1-zbestahu@gmail.com>
 <b724c331-5338-d827-6618-1bded956c41d@aol.com>
 <20190625172912.00002d55.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625172912.00002d55.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jun 25, 2019 at 05:29:12PM +0800, Yue Hu wrote:
> On Tue, 25 Jun 2019 17:19:36 +0800
> Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > On 2019/6/25 ????3:59, Yue Hu Wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > We should consider the error returned by fill_inline_data() when filling
> > > last page in fill_inode(). If not getting inode will be successful even
> > > though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> > > fill_inline_data() to stand for successful filling.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> > 
> > looks good to me, yet I think you need to Cc staging mailing list at
> > least if you want to upstream quickly (including your older patches...)
> > 
> > 
> > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > 
> > (Don't forget to add 'PATCH RESEND' tag at the subject line if you
> > resend these patches.)
> 
> Ok, got it.

Yes, please resend all of these patches as I am not quite sure which
ones are the "latest".

thanks,

greg k-h
