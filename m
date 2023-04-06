Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5276D938D
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:03:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PscWn360fz3fJ6
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:03:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wqx/xHpw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wqx/xHpw;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PscWk0Phbz3cCF
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:03:13 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1D65160C68;
	Thu,  6 Apr 2023 10:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9BDC433D2;
	Thu,  6 Apr 2023 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680775391;
	bh=Q91LeGfazZCcvmkNSKQDh2S2zJ4XUfMbkzSQcwu2+kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wqx/xHpwzEgloQBD/CkbVAJsa84OKnowPu4b4Yi11M5ANZ6Wm5L3VLKJ+2JdWegoj
	 rF+9HKby+OQju13wlpp3kQ3yNagJHvqu9xAhdqLV4YS4tySFKDnQZJG+XsYj67nkLk
	 m7h0DVt/xIgASFFVk3MQNgxNFR7Bd8kZmpsVokXc=
Date: Thu, 6 Apr 2023 12:03:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040635-duty-overblown-7b4d@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-2-frank.li@vivo.com>
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

On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
> Use kobject_is_added() instead of directly accessing the internal
> variables of kobject. BTW kill kobject_del() directly, because
> kobject_put() actually covers kobject removal automatically.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/erofs/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 435e515c0792..daac23e32026 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (sbi->s_kobj.state_in_sysfs) {
> -		kobject_del(&sbi->s_kobj);
> +	if (kobject_is_added(&sbi->s_kobj)) {

I do not understand why this check is even needed, I do not think it
should be there at all as obviously the kobject was registered if it now
needs to not be registered.

Meta-comment, we need to come up with a "filesystem kobject type" to get
rid of lots of the boilerplate filesystem kobject logic as it's
duplicated in every filesystem in tiny different ways and lots of times
(like here), it's wrong.

kobjects were not designed to be "used raw" like this, ideally they
would be wrapped in a subsystem that makes them easier to be used (like
the driver model), but filesystems decided to use them and that usage
just grew over the years.  That's evolution for you...

thanks,

greg k-h
