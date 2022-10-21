Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06D6071ED
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:18:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mty6D4RZWz3dqt
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jgzWKnVM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jgzWKnVM;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mty66541lz3bXn
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:18:38 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0B7F2B82B49;
	Fri, 21 Oct 2022 08:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C09FC433D7;
	Fri, 21 Oct 2022 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666340313;
	bh=8++5V96CRoT3offEW1sfGPjlBhG5kCvkZ9nTWWOETBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgzWKnVMDL4jjfh3rpyIZnQ6lzYGvVQFOfB2Sz0ckbK8TSaMML0PB6ejva6LPIpVh
	 ec2TKJYGoaFx30SX5W4+m5zVlvfmFnd1+qS08e2EpH9AWzJBI41sDGDR+b9qaC68rY
	 UySyAc400Lqb6/UqLIyGB/GHeIBa76ZzCFASzYBo=
Date: Fri, 21 Oct 2022 10:18:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1JV1wxf/7ERAMhl@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
 <Y1IwLOUGayjT9p6d@kroah.com>
 <5efd73b0-d634-d34f-3d7a-13d674e40d04@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efd73b0-d634-d34f-3d7a-13d674e40d04@amd.com>
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, Yang Yingliang <yangyingliang@huawei.com>, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 21, 2022 at 03:55:18AM -0400, Luben Tuikov wrote:
> On 2022-10-21 01:37, Greg KH wrote:
> > On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> >> On 2022-10-20 22:20, Yang Yingliang wrote:
> >>> The previous discussion link:
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C65b33f087ef245a9f23708dab3264840%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019274318153227%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1ZoieEob62iU9kI8fvpp20qGut9EeHKIHtCAT01t%2Bz8%3D&amp;reserved=0
> >>
> >> The very first discussion on this was here:
> >>
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C65b33f087ef245a9f23708dab3264840%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019274318153227%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=9joWxGLUxZZMvrfkxCR8KbkoXifsqoMK0vGR%2FyEG62w%3D&amp;reserved=0
> >>
> >> Please use this link, and not the that one up there you which quoted above,
> >> and whose commit description is taken verbatim from the this link.
> >>
> >>>
> >>> kset_register() is currently used in some places without calling
> >>> kset_put() in error path, because the callers think it should be
> >>> kset internal thing to do, but the driver core can not know what
> >>> caller doing with that memory at times. The memory could be freed
> >>> both in kset_put() and error path of caller, if it is called in
> >>> kset_register().
> >>
> >> As I explained in the link above, the reason there's
> >> a memory leak is that one cannot call kset_register() without
> >> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> >> in this case, i.e. kset_register() fails with -EINVAL.
> >>
> >> Thus, the most common usage is something like this:
> >>
> >> 	kobj_set_name(&kset->kobj, format, ...);
> >> 	kset->kobj.kset = parent_kset;
> >> 	kset->kobj.ktype = ktype;
> >> 	res = kset_register(kset);
> >>
> >> So, what is being leaked, is the memory allocated in kobj_set_name(),
> >> by the common idiom shown above. This needs to be mentioned in
> >> the documentation, at least, in case, in the future this is absolved
> >> in kset_register() redesign, etc.
> > 
> > Based on this, can kset_register() just clean up from itself when an
> > error happens?  Ideally that would be the case, as the odds of a kset
> > being embedded in a larger structure is probably slim, but we would have
> > to search the tree to make sure.
> 
> Looking at kset_register(), we can add kset_put() in the error path,
> when kobject_add_internal(&kset->kobj) fails.
> 
> See the attached patch. It needs to be tested with the same error injection
> as Yang has been doing.
> 
> Now, struct kset is being embedded in larger structs--see amdgpu_discovery.c
> starting at line 575. If you're on an AMD system, it gets you the tree
> structure you'll see when you run "tree /sys/class/drm/card0/device/ip_discovery/".
> That shouldn't be a problem though.

Yes, that shouldn't be an issue as the kobject embedded in a kset is
ONLY for that kset itself, the kset structure should not be controling
the lifespan of the object it is embedded in, right?

Note, the use of ksets by a device driver like you are doing here in the
amd driver is BROKEN and will cause problems by userspace tools.  Don't
do that please, just use a single subdirectory for an attribute.  Doing
deeper stuff like this is sure to cause problems and be a headache.

thanks,

greg k-h
