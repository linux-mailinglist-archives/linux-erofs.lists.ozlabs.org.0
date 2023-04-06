Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B696D93F3
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:27:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Psd374zwZz3fQW
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:26:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aidUVLAQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aidUVLAQ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Psd303t99z3chw
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:26:51 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 32C7962D20;
	Thu,  6 Apr 2023 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA4C433EF;
	Thu,  6 Apr 2023 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680776806;
	bh=Bsh9tIqIOFj0EL11HwEKb+7UATkQiSzOLRPewqBv8aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aidUVLAQPrfxqyxIJ8H2KA3Iu3QUlCzSt1mPN2LXJAUinCNhCQr5NOIsC93/jkqT3
	 LMgoBgHx7BDkNBDJfjglJhI+glRVMJuDVKQ98K3XACArPJs4SZXBxgU+WaAWjnfA/0
	 PsjsODrFNVfT/dKlZgVxaQ14zXY1RQo9rPK5RSAE=
Date: Thu, 6 Apr 2023 12:26:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@fastmail.com>
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040627-paver-recipient-3713@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
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
Cc: naohiro.aota@wdc.com, Yangtao Li <frank.li@vivo.com>, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, rafael@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
> On 4/6/23 19:05, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> >> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> >> BTW kill kobject_del() directly, because kobject_put() actually covers
> >> kobject removal automatically.
> >>
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >> ---
> >>  fs/zonefs/sysfs.c  | 11 +++++------
> >>  fs/zonefs/zonefs.h |  1 -
> >>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> >> index 8ccb65c2b419..f0783bf7a25c 100644
> >> --- a/fs/zonefs/sysfs.c
> >> +++ b/fs/zonefs/sysfs.c
> >> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
> >>  		return ret;
> >>  	}
> >>  
> >> -	sbi->s_sysfs_registered = true;
> > 
> > You know this, why do you need to have a variable tell you this or not?
> 
> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
> fill_super will also return that error. vfs will then call kill_super, which
> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
> added the kobj.

Ok, but then why not just 0 out the kobject pointer here instead?  That
way you will always know if it's a valid pointer or not and you don't
have to rely on some other variable?  Use the one that you have already :)

And you really don't even need to check anything, just pass in NULL to
kobject_del() and friends, it should handle it.

> >> -
> >>  	return 0;
> >>  }
> >>  
> >> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
> >>  {
> >>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >>  
> >> -	if (!sbi || !sbi->s_sysfs_registered)
> > 
> > How can either of these ever be true?  Note, sbi should be passed here
> > to this function, not the super block as that is now unregistered from
> > the system.  Looks like no one has really tested this codepath that much
> > :(
> > 
> >> +	if (!sbi)
> >>  		return;
> > 
> > this can not ever be true, right?
> 
> Yes it can, if someone attempt to mount a non zoned device. In that case,
> fill_super returns early without setting sb->s_fs_info but vfs still calls
> kill_super.

But you already had a sbi pointer in the place that this was called, so
you "know" if you need to even call into here or not.  You are having to
look up the same pointer multiple times in this call chain, there's no
need for that.

thanks,

greg k-h
