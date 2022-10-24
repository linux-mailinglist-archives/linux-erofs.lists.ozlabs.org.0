Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2A60AB6E
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Oct 2022 15:52:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MwxMh5NBmz3bjd
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Oct 2022 00:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a2H9OWmU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a2H9OWmU;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MwxMZ62D7z30NN
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Oct 2022 00:52:09 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9A36CB81B73;
	Mon, 24 Oct 2022 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1728C433C1;
	Mon, 24 Oct 2022 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666619524;
	bh=QIHnXVxCIGETsd0dywR9WOXQe2R85leBxjgt9psJDlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2H9OWmUuPXe1nsvDHzMz7pk28v9U01aePXWCqE/PYv8mU+b3XDQLri0CqGVaRsJz
	 jDX3YxQNP/rC/SyUqCZ86yUqxIXbKkp05GDQaItPKZLX+Z/tQqtvt0HtDKDldCwU2Z
	 RC0760eEL3DTVNddcLXXtAu1W45/R1VDk/n+VsGo=
Date: Mon, 24 Oct 2022 15:52:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH v2] kset: fix memory leak when kset_register() returns
 error
Message-ID: <Y1aYuLmlXBRvMP1Z@kroah.com>
References: <20221024121910.1169801-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024121910.1169801-1-yangyingliang@huawei.com>
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

On Mon, Oct 24, 2022 at 08:19:10PM +0800, Yang Yingliang wrote:
> Inject fault while loading module, kset_register() may fail.
> If it fails, the name allocated by kobject_set_name() which
> is called before kset_register() is leaked, because refcount
> of kobject is hold in kset_init().
> 
> As a kset may be embedded in a larger structure which needs
> be freed in release() function or error path in callers, we
> can not call kset_put() in kset_register(), or it will cause
> double free, so just call kfree_const() to free the name and
> set it to NULL.
> 
> With this fix, the callers don't need to care about the name
> freeing and call an extra kset_put() if kset_register() fails.
> 
> Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Free name inside of kset_register() instead of calling kset_put()
>   in drivers.
> ---
>  lib/kobject.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..3409a89c81e5 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>  /**
>   * kset_register() - Initialize and add a kset.
>   * @k: kset.
> + *
> + * NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
> + * which is called before kset_register() in caller need be freed.

This comment doesn't make any sense anymore.  No caller needs to worry
about this, right?

>   */
>  int kset_register(struct kset *k)
>  {
> @@ -844,8 +847,11 @@ int kset_register(struct kset *k)
>  
>  	kset_init(k);
>  	err = kobject_add_internal(&k->kobj);
> -	if (err)
> +	if (err) {
> +		kfree_const(k->kobj.name);
> +		k->kobj.name = NULL;

Why are you setting the name here to NULL?

thanks,

greg k-h
