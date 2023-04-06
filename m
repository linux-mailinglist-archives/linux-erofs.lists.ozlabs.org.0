Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AC6D94E6
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 13:18:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsfBF27Khz3fQb
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 21:18:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YjUoDe2+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YjUoDe2+;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsfB820NYz3fBJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 21:18:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BA0EE645FC;
	Thu,  6 Apr 2023 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60D6C433EF;
	Thu,  6 Apr 2023 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1680779884;
	bh=GyJOOLUgPQG224uVjUpkRJJAcshV6DM2oQoUOr1cS1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjUoDe2+6RDMyo9BLMvHjvcbbxBkcF+kLXTQY4fa1bGOPvfLCjlZnDQr30Ei7P2/m
	 73gXcpIPFQMH6CE/IsyYFgCiGRvMeOfATcd2AumKv4fvZ/lxuuGHTT2ZKxOHrCMvu4
	 dkQSyA6xzVe2MeKyz22DSYwYXI400iyEMVvXeLCk=
Date: Thu, 6 Apr 2023 13:18:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@fastmail.com>
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040627-platter-twisted-c1e6@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
 <2023040627-paver-recipient-3713@gregkh>
 <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
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

On Thu, Apr 06, 2023 at 07:58:38PM +0900, Damien Le Moal wrote:
> On 4/6/23 19:26, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
> >> On 4/6/23 19:05, Greg KH wrote:
> >>> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> >>>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> >>>> BTW kill kobject_del() directly, because kobject_put() actually covers
> >>>> kobject removal automatically.
> >>>>
> >>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >>>> ---
> >>>>  fs/zonefs/sysfs.c  | 11 +++++------
> >>>>  fs/zonefs/zonefs.h |  1 -
> >>>>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> >>>> index 8ccb65c2b419..f0783bf7a25c 100644
> >>>> --- a/fs/zonefs/sysfs.c
> >>>> +++ b/fs/zonefs/sysfs.c
> >>>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> -	sbi->s_sysfs_registered = true;
> >>>
> >>> You know this, why do you need to have a variable tell you this or not?
> >>
> >> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
> >> fill_super will also return that error. vfs will then call kill_super, which
> >> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
> >> added the kobj.
> > 
> > Ok, but then why not just 0 out the kobject pointer here instead?  That
> > way you will always know if it's a valid pointer or not and you don't
> > have to rely on some other variable?  Use the one that you have already :)
> 
> but sbi->s_kobj is the kobject itself, not a pointer.

Then it should not be there if the kobject is not valid as it should
have been freed when the kobject_init_and_add() call failed, right?

> I can still zero it out in
> case of error to avoid using the added s_sysfs_registered bool. I would need to
> check a field of s_kobj though, which is not super clean and makes the code
> dependent on kobject internals. Not super nice in my opinion, unless I am
> missing something.

See above, if a kobject fails to be registered, just remove the whole
object as it's obviously "dead" now and you can not trust it.

> > And you really don't even need to check anything, just pass in NULL to
> > kobject_del() and friends, it should handle it.>
> >>>> -
> >>>>  	return 0;
> >>>>  }
> >>>>  
> >>>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
> >>>>  {
> >>>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >>>>  
> >>>> -	if (!sbi || !sbi->s_sysfs_registered)
> >>>
> >>> How can either of these ever be true?  Note, sbi should be passed here
> >>> to this function, not the super block as that is now unregistered from
> >>> the system.  Looks like no one has really tested this codepath that much
> >>> :(
> >>>
> >>>> +	if (!sbi)
> >>>>  		return;
> >>>
> >>> this can not ever be true, right?
> >>
> >> Yes it can, if someone attempt to mount a non zoned device. In that case,
> >> fill_super returns early without setting sb->s_fs_info but vfs still calls
> >> kill_super.
> > 
> > But you already had a sbi pointer in the place that this was called, so
> > you "know" if you need to even call into here or not.  You are having to
> > look up the same pointer multiple times in this call chain, there's no
> > need for that.
> 
> I am not following here. Either we check that we have sbi here in
> zonefs_sysfs_unregister(), or we conditionally call this function in
> zonefs_kill_super() with a "if (sbi)". Either way, we need to check since sbi
> can be NULL.

In zonefs_kill_super() you have get the spi at the top of the function,
so use that, don't make zonefs_sysfs_unregister() have to compute it
again.

But again, if the kobject fails to be registered, you have to treat the
memory contained there as not valid and get rid of it as soon as
possible.

thanks,

greg k-h
