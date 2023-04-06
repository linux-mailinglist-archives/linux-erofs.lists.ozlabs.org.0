Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEB06D9399
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:05:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PscZ151s6z3fJ6
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IFDIe4Fe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IFDIe4Fe;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PscYx4yzwz3c7K
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:05:08 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C20C56453E;
	Thu,  6 Apr 2023 10:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D2FC433EF;
	Thu,  6 Apr 2023 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680775506;
	bh=92lTD3EX6QZGcz05caCSQGuverBGUc9p+3YV5LN7ZSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFDIe4FeiUOzbC59cAl1tE1lGX2tjalx7s96DwtifkQljZVqq+gTmWhspg+RQf7h9
	 EfF6Gza3ykeaYehWWBBfJjDzlJRDtzXQ91BIKws7z5Xn2An7LjW41Nk+tlTvAGx8tu
	 HToafdlfkrlTxVzsZqyeuyITw91bjpabpMF64WxQ=
Date: Thu, 6 Apr 2023 12:05:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040616-armory-unmade-4422@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-3-frank.li@vivo.com>
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

On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> BTW kill kobject_del() directly, because kobject_put() actually covers
> kobject removal automatically.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/zonefs/sysfs.c  | 11 +++++------
>  fs/zonefs/zonefs.h |  1 -
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> index 8ccb65c2b419..f0783bf7a25c 100644
> --- a/fs/zonefs/sysfs.c
> +++ b/fs/zonefs/sysfs.c
> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>  		return ret;
>  	}
>  
> -	sbi->s_sysfs_registered = true;

You know this, why do you need to have a variable tell you this or not?

> -
>  	return 0;
>  }
>  
> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>  {
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  
> -	if (!sbi || !sbi->s_sysfs_registered)

How can either of these ever be true?  Note, sbi should be passed here
to this function, not the super block as that is now unregistered from
the system.  Looks like no one has really tested this codepath that much
:(

> +	if (!sbi)
>  		return;

this can not ever be true, right?


>  
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> +	if (kobject_is_added(&sbi->s_kobj)) {

Again, not needed.

thanks,

greg k-h
