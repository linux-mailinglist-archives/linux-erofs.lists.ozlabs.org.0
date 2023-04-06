Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3A6D9375
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:00:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PscSF5xWnz3fK3
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:00:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kKx34QXD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kKx34QXD;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PscS66H7Tz3cCF
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:00:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ECCE464553;
	Thu,  6 Apr 2023 10:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A27C433EF;
	Thu,  6 Apr 2023 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680775202;
	bh=WvH1QLnSC75c7SwSR4krkaAJCUF9p5g8TKLp+jWis7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKx34QXDiBpYMeOdyqG1cMkXCMSHVlSTIRiwCWuJuXOMOXlrex211Y6tZRGc5mlOO
	 fRN/5A/7zX5zx5GFHEf7VFMATL90bpAqXa9WnIaFMuoISHzLy0/Hx5Kw3bc2ZYw7bj
	 kloCJgm5v9nL3I8Ocv+IrclcbnDtuZphLhtewL64=
Date: Thu, 6 Apr 2023 11:59:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 1/3] kobject: introduce kobject_is_added()
Message-ID: <2023040628-cocoa-lizard-9941@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-1-frank.li@vivo.com>
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

On Thu, Apr 06, 2023 at 05:30:54PM +0800, Yangtao Li wrote:
> Add kobject_is_added() to avoid consumers from directly accessing
> the internal variables of kobject.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  include/linux/kobject.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..b5cdb0c58729 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -203,6 +203,11 @@ static inline const struct kobj_type *get_ktype(const struct kobject *kobj)
>  	return kobj->ktype;
>  }
>  
> +static inline int kobject_is_added(struct kobject *kobj)
> +{
> +	return kobj->state_in_sysfs;
> +}
> +

No, this implies that the caller is not doing something correctly as it
should always know if it has added a kobject or not.  Let me review the
please where you used this to find the problems there...

thanks,

greg k-h
