Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D25606F7F
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 07:37:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MttWl6bk7z3c8j
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 16:37:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QlbKpgGx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QlbKpgGx;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MttWg14YDz2xKV
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 16:37:03 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B01061D9D;
	Fri, 21 Oct 2022 05:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD180C433C1;
	Fri, 21 Oct 2022 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666330619;
	bh=C4x6hYFDAWi4DXcimrF67aLQPsZW93Mx96V0amCnWn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlbKpgGx1qrMgSdaJyivXXf5qor/X961lpc0yRR+woSzH3tCcgiu1gmz/NBYEXQfe
	 K4vsmjcCVpegODndBu2vg9R9eT4zstEkXIb1SfoFeTNCPoQOhnVD+4siGARAhiytQw
	 tUVK0o7ipMo473nLX2GyW5d8TYlaC0oYKW+aMHhw=
Date: Fri, 21 Oct 2022 07:37:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1IwLOUGayjT9p6d@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
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

On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> On 2022-10-20 22:20, Yang Yingliang wrote:
> > The previous discussion link:
> > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> 
> The very first discussion on this was here:
> 
> https://www.spinics.net/lists/dri-devel/msg368077.html
> 
> Please use this link, and not the that one up there you which quoted above,
> and whose commit description is taken verbatim from the this link.
> 
> > 
> > kset_register() is currently used in some places without calling
> > kset_put() in error path, because the callers think it should be
> > kset internal thing to do, but the driver core can not know what
> > caller doing with that memory at times. The memory could be freed
> > both in kset_put() and error path of caller, if it is called in
> > kset_register().
> 
> As I explained in the link above, the reason there's
> a memory leak is that one cannot call kset_register() without
> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> in this case, i.e. kset_register() fails with -EINVAL.
> 
> Thus, the most common usage is something like this:
> 
> 	kobj_set_name(&kset->kobj, format, ...);
> 	kset->kobj.kset = parent_kset;
> 	kset->kobj.ktype = ktype;
> 	res = kset_register(kset);
> 
> So, what is being leaked, is the memory allocated in kobj_set_name(),
> by the common idiom shown above. This needs to be mentioned in
> the documentation, at least, in case, in the future this is absolved
> in kset_register() redesign, etc.

Based on this, can kset_register() just clean up from itself when an
error happens?  Ideally that would be the case, as the odds of a kset
being embedded in a larger structure is probably slim, but we would have
to search the tree to make sure.

thanks,

greg k-h
