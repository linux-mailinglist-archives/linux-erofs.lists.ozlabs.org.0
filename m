Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970176071D9
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:16:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mty3t2nGPz3dqt
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lO82TxFX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lO82TxFX;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mty3l06Ggz3bXn
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:16:34 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6D8AF61DF6;
	Fri, 21 Oct 2022 08:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F7C433D7;
	Fri, 21 Oct 2022 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666340188;
	bh=nDtywa6mieJPfGn7a73ycNgAHcz816CMD4ioaA/ZgqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lO82TxFXbxQ1cn2DOqHCEKyNscPmKusZYKwJGtS1W9wHd/+uOdMexrwxM5m/eoZGP
	 ixuN1pMyIVVKVRufxw1DnKqd7DCICC9i7tVNcPFmRr0aUFAthWwsrDgNS/LTSDl6lj
	 lH2fmm/4fi6QX2qSDaq/NHngB7BNdQ/cZRRC7bts=
Date: Fri, 21 Oct 2022 10:16:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 01/11] kset: fix documentation for kset_register()
Message-ID: <Y1JVWsLs0EQ3dtxM@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
 <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
 <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 21, 2022 at 04:05:18PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/21 13:34, Luben Tuikov wrote:
> > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > kset_register() is currently used in some places without calling
> > > kset_put() in error path, because the callers think it should be
> > > kset internal thing to do, but the driver core can not know what
> > > caller doing with that memory at times. The memory could be freed
> > > both in kset_put() and error path of caller, if it is called in
> > > kset_register().
> > > 
> > > So make the function documentation more explicit about calling
> > > kset_put() in the error path of caller.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   lib/kobject.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index a0b2dbfcfa23..6da04353d974 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
> > >   /**
> > >    * kset_register() - Initialize and add a kset.
> > >    * @k: kset.
> > > + *
> > > + * If this function returns an error, kset_put() must be called to
> > > + * properly clean up the memory associated with the object.
> > >    */
> > And I'd continue the sentence, with " ... with the object,
> > for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
> > was called before calling kset_register()."
> kobject_cleanup() not only frees name, but aslo calls ->release() to free
> another resources.

Yes, but it's the kobject of the kset, which does need to have it's name
cleaned up, but that kobject should NOT be freeing any larger structures
that the kset might be embedded in, right?

> > This makes it clear what we want to make sure is freed, in case of an early error
> > from kset_register().
> 
> How about like this:
> 
> If this function returns an error, kset_put() must be called to clean up the name of
> kset object and other memory associated with the object.

Again, I think we can fix this up to not be needed.

thanks,

greg k-h
