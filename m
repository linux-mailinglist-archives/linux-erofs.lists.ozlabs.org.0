Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652E6D9B04
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 16:47:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PskqJ08RCz3g3S
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 00:47:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kIoXODhP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kIoXODhP;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PskTH0Yqyz3fXt
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Apr 2023 00:31:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 23D986451A;
	Thu,  6 Apr 2023 14:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1AC4339C;
	Thu,  6 Apr 2023 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680791487;
	bh=XeI9KfiYdDhLQo7ETsetlFQttpL3vF0ZQRlL4DrjO94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIoXODhPxDBIJeLdJ53pjgicprZj+Q4MZ9pJlpKxGHW//XKTtdP3WoW0DpEm1ZgMJ
	 mjc5yPJj26Xm03Kdfrc+NQfnVusWWRsJ25te7hsy2Q/Lwt+8qdqKX5cRBTQErBDdhx
	 14GL7sjuTczZYdD73fKJ+57w5AfueFBtoY8hSByo=
Date: Thu, 6 Apr 2023 16:31:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040602-stack-overture-d418@gregkh>
References: <2023040635-duty-overblown-7b4d@gregkh>
 <20230406120716.80980-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406120716.80980-1-frank.li@vivo.com>
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
Cc: naohiro.aota@wdc.com, rafael@kernel.org, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, jth@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Apr 06, 2023 at 08:07:16PM +0800, Yangtao Li wrote:
> > Meta-comment, we need to come up with a "filesystem kobject type" to get
> > rid of lots of the boilerplate filesystem kobject logic as it's
> > duplicated in every filesystem in tiny different ways and lots of times
> > (like here), it's wrong.
> 
> Can we add the following structure?
> 
> struct filesystem_kobject {
>         struct kobject kobject;
>         struct completion unregister;
> };

Ah, no, I see the problem.

The filesystem authors are treating the kobject NOT as the thing that
handles the lifespan of the structure it is embedded in, but rather as
something else (i.e. a convient place to put filesystem information to
userspace.)

That isn't going to work, and as proof of that, the release callback
should be a simple call to kfree(), NOT as a completion notification
which then something else will go off and free the memory here.  That
implies that there are multiple reference counting structures happening
on the same structure, which is not ok.

Either we let the kobject code properly handle the lifespan of the
structure, OR we pull it out of the structure and just let it hang off
as a separate structure (i.e. a pointer to something else.)

As the superblock lifespan rules ALREADY control the reference counting
logic of the filesystem superblock structure, let's stick with that and
just tack-on the kobject as a separate structure entirely.

Does that make sense?  Let me do a quick pass at this for zonefs as
that's pretty simple to show you what I mean...

thanks,

greg k-h
