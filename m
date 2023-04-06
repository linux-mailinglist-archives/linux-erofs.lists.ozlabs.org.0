Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EA26D93D3
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:21:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PscwG66v0z3fLT
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jWekyNIa;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=i3db14652.fm2 header.b=Fx+uDooM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fastmail.com (client-ip=66.111.4.224; helo=new2-smtp.messagingengine.com; envelope-from=dlemoal@fastmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jWekyNIa;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=i3db14652.fm2 header.b=Fx+uDooM;
	dkim-atps=neutral
X-Greylist: delayed 419 seconds by postgrey-1.36 at boromir; Thu, 06 Apr 2023 20:20:53 AEST
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pscw50w13z3f4x
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:20:53 +1000 (AEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id CC3E05821C6;
	Thu,  6 Apr 2023 06:13:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Apr 2023 06:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1680776028; x=1680779628; bh=bBA7rsAiJx0Mf+CLTLAhKrfRRQaKuAim1uz
	YsGXHA34=; b=jWekyNIaj9US9/EkiLALLxgmaTGLp9r7UZn5jDkk0RDM0KPNF5z
	UMK6ecEnVy26YV+Z9PiTUx3ktktXQN5oSECvGROLW7TrhVN+L1VeJG417bTgQ7CE
	Smk/yBKz7ppsN4tkSYaicvlvuSdWQBzRbb5pTeABZ/S1QJBQpVedEypggPqw5h5j
	iFtn0TPOHfyhDiAaKvb428URrZtGlCZ9m9zJDW3hiAY0TtxmoCV0MBvk8BtttsOl
	SIDVi1XikFkIjBEmMnrwKrzwkd8EU5HBDEA3tS2tud+RjdKAuXYEzuLzvVIaoEBU
	ttNN+T/symi+Qv4xdexB2VdtNlJ1sBYSVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
	 t=1680776028; x=1680779628; bh=bBA7rsAiJx0Mf+CLTLAhKrfRRQaKuAim
	1uzYsGXHA34=; b=Fx+uDooMkxpX9uOe6vY7t/QuOGO4GCpZlcgkk6UJXFCEM8gP
	+bB+Kv2EHbV/yCvNMOAUVPcVEy/nKKPXh4U1F0SINCbP2mq7ySFUOdNwpWLg/F3o
	JpMSlJ+pYEbydGbUiy2tQuDry1wSIUUlR2GsmoO5RCq1is0/1vU6+GJ8P93ABFQM
	KCCU/+lyvARJSqmCbFK7iHwQKUejfRVFlNDYg6VnbLWTgjgCi84csIaP2KZP2RND
	0tT4d895QsuB8hNr7lwuCqrUIZacyESWnz6j/t/vobwm/DD5KJGRIh0UzYzFZ5v0
	7Zua1ealwITg5Ps0gm/XVfYuJgRzD8vRJkmTSw==
X-ME-Sender: <xms:WpsuZE0oCgoCLNZ6xY86KZNKXEw_-jHWliV__VeB61PbMi6DZg-UZg>
    <xme:WpsuZPFyepv-mERyREOrAtuUGwyUseQSWhgmLnTAysFCIyMEr8copwkzkm-gbl-Qi
    C5TEIJotsCCs9GUHsg>
X-ME-Received: <xmr:WpsuZM7O8yF8DkWw6-lu_6s1lBhS6YzKuXs9XOjDn86mkir9fMnMyUGI0GBYqrHOzNbbUQawx8UwYMMeNkyu2j7R5ejq_0jh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WpsuZN2NZw_I5NNbmq4KraI5W46jo2TsmIY_Vr-enYBsSqAckqc7vg>
    <xmx:WpsuZHG5i0JHUs6Ho-OOcZYeTmSInft03lPju2l1unu0urSU6RwrZg>
    <xmx:WpsuZG8XLFFtykina6flu9XLDlelgILBeyul5b2nZVBSA5G0yyT2Tw>
    <xmx:XJsuZO_jQnFlLCQHEDINuySJkxNnz1Qs1Nm7r-Kar_ncAKdAEa4A3g>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 06:13:40 -0400 (EDT)
Message-ID: <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
Date: Thu, 6 Apr 2023 19:13:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Yangtao Li <frank.li@vivo.com>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
From: Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <2023040616-armory-unmade-4422@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/6/23 19:05, Greg KH wrote:
> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
>> BTW kill kobject_del() directly, because kobject_put() actually covers
>> kobject removal automatically.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>  fs/zonefs/sysfs.c  | 11 +++++------
>>  fs/zonefs/zonefs.h |  1 -
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>> index 8ccb65c2b419..f0783bf7a25c 100644
>> --- a/fs/zonefs/sysfs.c
>> +++ b/fs/zonefs/sysfs.c
>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>>  		return ret;
>>  	}
>>  
>> -	sbi->s_sysfs_registered = true;
> 
> You know this, why do you need to have a variable tell you this or not?

If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
fill_super will also return that error. vfs will then call kill_super, which
calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
added the kobj.

> 
>> -
>>  	return 0;
>>  }
>>  
>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>  {
>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>  
>> -	if (!sbi || !sbi->s_sysfs_registered)
> 
> How can either of these ever be true?  Note, sbi should be passed here
> to this function, not the super block as that is now unregistered from
> the system.  Looks like no one has really tested this codepath that much
> :(
> 
>> +	if (!sbi)
>>  		return;
> 
> this can not ever be true, right?

Yes it can, if someone attempt to mount a non zoned device. In that case,
fill_super returns early without setting sb->s_fs_info but vfs still calls
kill_super.

> 
> 
>>  
>> -	kobject_del(&sbi->s_kobj);
>> -	kobject_put(&sbi->s_kobj);
>> -	wait_for_completion(&sbi->s_kobj_unregister);
>> +	if (kobject_is_added(&sbi->s_kobj)) {
> 
> Again, not needed.
> 
> thanks,
> 
> greg k-h

