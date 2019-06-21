Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EA4E0BE
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 09:02:59 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VV4w0328zDqB5
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 17:02:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcjScGWR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VV4p1HjmzDq5n
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 17:02:48 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DE862083B;
 Fri, 21 Jun 2019 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561100566;
 bh=V2/ZszNh8MaMq+1MrkmLu3HXHRSK/lWKDZYg8J7l7f4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bcjScGWRo2Dcr6gz3qELAjBxdKcR+WPANMXHjmb6IMWNRy8DcpSV1hJTl6XtROLim
 l7LFnUEqItG3ZUfpKK039oC4vYDDGKu8NUqoL42Nuszv4ZiadBOUGjEzEV7F8BwtN0
 HNOSG1KbElQYPyqohRq6DbRzbu3UfP3PxjVxWL+M=
Date: Fri, 21 Jun 2019 09:02:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] staging: erofs: remove needless dummy functions of
 erofs_{get,list}xattr
Message-ID: <20190621070244.GC3029@kroah.com>
References: <20190621040808.3708-1-zbestahu@gmail.com>
 <f6b2ced7-79ea-9cc6-5e88-43552b5947a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b2ced7-79ea-9cc6-5e88-43552b5947a9@huawei.com>
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 Yue Hu <zbestahu@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jun 21, 2019 at 01:08:39PM +0800, Gao Xiang wrote:
> Hi Yue,
> 
> On 2019/6/21 12:08, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > The two dummy functions of erofs_getxattr()/erofs_listxattr() will never
> > be used if disable CONFIG_EROFS_FS_XATTR.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/staging/erofs/xattr.h | 13 -------------
> >  1 file changed, 13 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
> > index 35ba5ac..2c1e46f 100644
> > --- a/drivers/staging/erofs/xattr.h
> > +++ b/drivers/staging/erofs/xattr.h
> > @@ -72,19 +72,6 @@ static inline const struct xattr_handler *erofs_xattr_handler(unsigned index)
> >  
> >  int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
> >  ssize_t erofs_listxattr(struct dentry *, char *, size_t);
> > -#else
> > -static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
> > -	const char *name,
> > -	void *buffer, size_t buffer_size)
> > -{
> > -	return -ENOTSUPP;
> > -}
> > -
> > -static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
> > -	char *buffer, size_t buffer_size)
> > -{
> > -	return -ENOTSUPP;
> > -}
> >  #endif
> 
> It's mainly used for erofs to directly call erofs_getxattr / erofs_listxattr (even 
> xattr feature is off) to get a xattr in erofs itself, just follow what other
> filesystems (e.g. f2fs) did, although these apis have not been used internally
> yet but used as callbacks in inode_operations only.
> 
> I have no positive or negative tendency since the patch is minor and the only
> benefit of this patch is that it removes some code which seems redundant currently.
> However, if erofs_getxattr is needed later, it should be added back of course.
> Therefore I think it could depend on Greg whether accept this patch or not.

Let's leave this as-is for now.

thanks,

greg k-h
