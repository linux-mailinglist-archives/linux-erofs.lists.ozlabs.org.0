Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B060D21B
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Oct 2022 18:58:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MxdRj1yFsz3bqt
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Oct 2022 03:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IuS0pwxk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IuS0pwxk;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MxdRY5shlz2xgG
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Oct 2022 03:58:00 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A2DE8B81DB8;
	Tue, 25 Oct 2022 16:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C254DC433D6;
	Tue, 25 Oct 2022 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666717074;
	bh=TOr7/IBl9W+Hpc/R8LxJAyq9QpYQbWCv3WJvy2nka0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuS0pwxkNWhb/Pc3fD1YeILTwYuQDWG7J6hJ35bK6Ucsyh68N7Gpf7db0oIcWSg5J
	 +A52AVp6gq97BqnXsSXSdptDSLkW3H2w/eBLbjyhblutXXWvXsvxCZQTb1o8df8D0g
	 X2/xsNKaI+imRsgqBblFS8hu7gUdhG4pmfgst1Zw=
Date: Tue, 25 Oct 2022 18:57:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH v3] kset: fix memory leak when kset_register() returns
 error
Message-ID: <Y1gVj6Uq2NDScYdY@kroah.com>
References: <20221025071549.1280528-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025071549.1280528-1-yangyingliang@huawei.com>
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

On Tue, Oct 25, 2022 at 03:15:49PM +0800, Yang Yingliang wrote:
> Inject fault while loading module, kset_register() may fail.
> If it fails, the kset.kobj.name allocated by kobject_set_name()
> which must be called before a call to kset_register() may be
> leaked, since refcount of kobj was set in kset_init().
> 
> To mitigate this, we free the name in kset_register() when an
> error is encountered, i.e. when kset_register() returns an error.
> 
> A kset may be embedded in a larger structure which may be dynamically
> allocated in callers, it needs to be freed in ktype.release() or error
> path in callers, in this case, we can not call kset_put() in kset_register(),
> or it will cause double free, so just call kfree_const() to free the
> name and set it to NULL to avoid accessing bad pointer in callers.
> 
> With this fix, the callers don't need care about freeing the name
> and may call kset_put() if kset_register() fails.
> 
> Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2 -> v3:
>   Update commit message and comment of kset_register().
> 
> v1 -> v2:
>   Free name inside of kset_register() instead of calling kset_put()
>   in drivers.

Thank you for all of this, it's a much nicer and cleaner fix than
forcing all callers to try to handle it instead.

greg k-h
