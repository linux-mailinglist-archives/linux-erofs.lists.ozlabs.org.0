Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D49A4B8FA2
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Feb 2022 18:48:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzQRR6RXVz30LQ
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 04:48:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dq1v+rUo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=Dq1v+rUo; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzQRP3pnlz30LQ
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 04:48:17 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D82B560F13;
 Wed, 16 Feb 2022 17:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52DAC340E8;
 Wed, 16 Feb 2022 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1645033694;
 bh=P0xCoobi3PX2V5oBKTfTY1baelnZ+APwbOUC4Rkw/mw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dq1v+rUoe2FpPJGFuqDUodPgLvzQCLHuayIj0VVCSvEISd4clE8/41zsxytE3gser
 8T6D2eGqnIedjy7sevCAsK/uWM3moR0nXbwhJX2v9ZQypHt7L3Nq21Tu4lUi9l8ZHq
 iL4OaNpL24iXjhJxQGtiCj5FMGQSy485+zPO9cTY=
Date: Wed, 16 Feb 2022 18:48:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 05/23] cachefiles: introduce new devnode for on-demand
 read mode
Message-ID: <Yg0421B10PPwunI+@kroah.com>
References: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <20220215111335.123528-1-jefflexu@linux.alibaba.com>
 <YgzWkhXCnlNDADvb@kroah.com>
 <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 16, 2022 at 08:49:35PM +0800, JeffleXu wrote:
> >> +struct cachefiles_req_in {
> >> +	uint64_t id;
> >> +	uint64_t off;
> >> +	uint64_t len;
> > 
> > For structures that cross the user/kernel boundry, you have to use the
> > correct types.  For this it would be __u64.
> 
> OK I will change to __xx style in the next version.
> 
> By the way, I can't understand the disadvantage of uintxx_t style.

The "uint*" types are not valid kernel types.  They are userspace types
and do not transfer properly in all arches and situations when crossing
the user/kernel boundry.  They are also in a different C "namespace", so
should not even be used in kernel code, although a lot of people do
because they are used to writing userspace C code :(

thanks,

greg k-h
