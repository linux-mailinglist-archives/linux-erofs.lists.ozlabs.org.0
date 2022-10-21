Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5C607270
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:36:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtyVT5bvgz3drV
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0LHArjuO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0LHArjuO;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtyVM3Tvsz3bXn
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:36:11 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 95B30B82B63;
	Fri, 21 Oct 2022 08:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E2C433D6;
	Fri, 21 Oct 2022 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666341367;
	bh=VYkxOdyqZTRP94uFOMrKlhrYPkv6+oVeaJOCigiokeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LHArjuO/emmogeedg4sidpH81EIC1oFajIQk20rr9Km/Y0ewObOQB0i43jXid6V8
	 MEWVl4mxIE2auEWLdOFh5S0zN7a5cdswL8kZv1F5sHrcBCX+9z8wc+kpjX8Czr8S07
	 DVGuTf4yxBxOxcpimxvN26SCCFuV+ZffgRv7I1WQ=
Date: Fri, 21 Oct 2022 10:36:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1JZ9IUPL6jZIQ8E@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
 <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
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

On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/21 13:37, Greg KH wrote:
> > On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> > > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > > The previous discussion link:
> > > > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> > > The very first discussion on this was here:
> > > 
> > > https://www.spinics.net/lists/dri-devel/msg368077.html
> > > 
> > > Please use this link, and not the that one up there you which quoted above,
> > > and whose commit description is taken verbatim from the this link.
> > > 
> > > > kset_register() is currently used in some places without calling
> > > > kset_put() in error path, because the callers think it should be
> > > > kset internal thing to do, but the driver core can not know what
> > > > caller doing with that memory at times. The memory could be freed
> > > > both in kset_put() and error path of caller, if it is called in
> > > > kset_register().
> > > As I explained in the link above, the reason there's
> > > a memory leak is that one cannot call kset_register() without
> > > the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> > > in this case, i.e. kset_register() fails with -EINVAL.
> > > 
> > > Thus, the most common usage is something like this:
> > > 
> > > 	kobj_set_name(&kset->kobj, format, ...);
> > > 	kset->kobj.kset = parent_kset;
> > > 	kset->kobj.ktype = ktype;
> > > 	res = kset_register(kset);
> > > 
> > > So, what is being leaked, is the memory allocated in kobj_set_name(),
> > > by the common idiom shown above. This needs to be mentioned in
> > > the documentation, at least, in case, in the future this is absolved
> > > in kset_register() redesign, etc.
> > Based on this, can kset_register() just clean up from itself when an
> > error happens?  Ideally that would be the case, as the odds of a kset
> > being embedded in a larger structure is probably slim, but we would have
> > to search the tree to make sure.
> I have search the whole tree, the kset used in bus_register() - patch #3,
> kset_create_and_add() - patch #4
> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
> amdgpu_discovery.c - patch #10
> is embedded in a larger structure. In these cases, we can not call
> kset_put() in error path in kset_register()

Yes you can as the kobject in the kset should NOT be controling the
lifespan of those larger objects.

If it is, please point out the call chain here as I don't think that
should be possible.

Note all of this is a mess because the kobject name stuff was added much
later, after the driver model had been created and running for a while.
We missed this error path when adding the dynamic kobject name logic,
thank for looking into this.

If you could test the patch posted with your error injection systems,
that could make this all much simpler to solve.

thanks,

greg k-h
