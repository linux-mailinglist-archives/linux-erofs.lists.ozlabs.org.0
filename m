Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485D60AE36
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Oct 2022 16:52:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MwyjT2zSQz3bjl
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Oct 2022 01:52:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0R1tizG1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0R1tizG1;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MwyjM6q7Lz2xl5
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Oct 2022 01:52:39 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 62D49B816A2;
	Mon, 24 Oct 2022 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EFBC433C1;
	Mon, 24 Oct 2022 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666623153;
	bh=iIf7CBp4DRtS4RK5w27tn1+7LfTAdJA8NimWQF9sSvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0R1tizG1JTD1VZMfei9eZUwBceJMo27F3IPhrwxgizVbdIXR/VebztKIjUAfm+TJ2
	 cpiPAbSdylVk4YR/PmDNZIIZzoMbWnp7XnOykqA3Po0XqNtgjvxOXuMeqXyiEX1VR+
	 i+cMHZA9GYInHS3HEvmT7UEBSkL+YkXi0BemMqzI=
Date: Mon, 24 Oct 2022 16:53:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH v2] kset: fix memory leak when kset_register() returns
 error
Message-ID: <Y1am4mjS+obAbUTJ@kroah.com>
References: <20221024121910.1169801-1-yangyingliang@huawei.com>
 <Y1aYuLmlXBRvMP1Z@kroah.com>
 <8281fc72-948a-162d-6e5f-a9fe29d8ee46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8281fc72-948a-162d-6e5f-a9fe29d8ee46@huawei.com>
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, luben.tuikov@amd.com, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 24, 2022 at 10:39:44PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/24 21:52, Greg KH wrote:
> > On Mon, Oct 24, 2022 at 08:19:10PM +0800, Yang Yingliang wrote:
> > > Inject fault while loading module, kset_register() may fail.
> > > If it fails, the name allocated by kobject_set_name() which
> > > is called before kset_register() is leaked, because refcount
> > > of kobject is hold in kset_init().
> > > 
> > > As a kset may be embedded in a larger structure which needs
> > > be freed in release() function or error path in callers, we
> > > can not call kset_put() in kset_register(), or it will cause
> > > double free, so just call kfree_const() to free the name and
> > > set it to NULL.
> > > 
> > > With this fix, the callers don't need to care about the name
> > > freeing and call an extra kset_put() if kset_register() fails.
> > > 
> > > Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > > v1 -> v2:
> > >    Free name inside of kset_register() instead of calling kset_put()
> > >    in drivers.
> > > ---
> > >   lib/kobject.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index a0b2dbfcfa23..3409a89c81e5 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
> > >   /**
> > >    * kset_register() - Initialize and add a kset.
> > >    * @k: kset.
> > > + *
> > > + * NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
> > > + * which is called before kset_register() in caller need be freed.
> > This comment doesn't make any sense anymore.  No caller needs to worry
> > about this, right?
> With this fix, the name is freed inside of kset_register(), it can not be
> accessed,

Agreed.

> if it allocated dynamically, but callers don't know this if no comment here,
> they may use it in error path (something like to print error message with
> it),
> so how about comment like this to tell callers not to use the name:
> 
> NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
> is freed, it can not be used any more.

Sure, that's a better way to word it.

> > >    */
> > >   int kset_register(struct kset *k)
> > >   {
> > > @@ -844,8 +847,11 @@ int kset_register(struct kset *k)
> > >   	kset_init(k);
> > >   	err = kobject_add_internal(&k->kobj);
> > > -	if (err)
> > > +	if (err) {
> > > +		kfree_const(k->kobj.name);
> > > +		k->kobj.name = NULL;
> > Why are you setting the name here to NULL?
> I set it to NULL to avoid accessing bad pointer in callers,
> if callers use it in error path, current callers won't use this
> name pointer in error path, so we can remove this assignment?

Ah, I didn't think about using it on error paths.  Ideally that would
never happen, but that's good to set just to make it obvious.  How about
adding a small comment here saying why you are setting it so we all
remember it in 5 years when we look at the code again.

thanks,

greg k-h
