Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 979376D948F
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:58:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Psdlx3jRLz3fJK
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:58:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=HXlgZjFU;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=i3db14652.fm2 header.b=RVcPjQRF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fastmail.com (client-ip=66.111.4.230; helo=new4-smtp.messagingengine.com; envelope-from=dlemoal@fastmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=HXlgZjFU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=i3db14652.fm2 header.b=RVcPjQRF;
	dkim-atps=neutral
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Psdlr2VT6z3f6W
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:58:47 +1000 (AEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id 7C3DD5820D0;
	Thu,  6 Apr 2023 06:58:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Apr 2023 06:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1680778724; x=1680782324; bh=Q2m1kci/EP4IG1lF0MfJfyKUGN/Uk8YX5ZS
	0D1+MIUk=; b=HXlgZjFU+cAzi8fVYZ3ieEuyXVgmr7WPTsesBy2rLFPMYCKpIyn
	v12cjlEDMTp1gBJBK2JCL9L+UUdyekKHC7Zl1tPF8XtFF8kTYGeBk+kdwT2QbaId
	ZgZCmGl/OsQO4k5Q3TP+QZ28CqAoNhT1KAJSG5EWmLq162ZRFYRrnqvsesqU6ruP
	k8Mwx/EuwvX31/uCswzZjU5vZlvEdDvoR+KGPudBQddh4+XJ/bfqA2lzMl9FqvU2
	kk6eVKSs4Hv1hVtC5kVpiCnCfu6bdUsfzuH8p2+V8RzUBhOPMHsWIn9++bWngpk+
	SMC6UJu2JU+X5Jl66ycRCqOeP1JR9RLR4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
	 t=1680778724; x=1680782324; bh=Q2m1kci/EP4IG1lF0MfJfyKUGN/Uk8YX
	5ZS0D1+MIUk=; b=RVcPjQRFbdo6hVuCZI4+6tK3Vq86w7l8TLKbX19OqrWM41Wd
	8JJf26gLcPAJLCXknkmubxbSe4pZC8R3JqWhLJF4OZlv0kK61yD54we5+4b9sm37
	FVNtqxBLsASydtPAh22nPyBvy6Hxn2rxYb7/eM7kdaBpCkLzE4Y43f62O/YaTdyV
	f+kalY7a2tPW9tAHSS9bCDewSzXvXf1e/iMXrCJvDMf/Yd1BFWUH8imnbPT6rg6P
	nYmzHNwinZG3tVpntBg2hhOEGI6JxIHzx+II8OwdNaGX1ORXAoIGK7eGMU645Tk/
	YeImSalhXU/YAAGAnGNOAZbPTKbKL1qxbbitFQ==
X-ME-Sender: <xms:46UuZPWWKtHuO5l0LFAk3w3YC-eb_XKzKbYBpAgJmrcIJeHy5omKCA>
    <xme:46UuZHmAlDonNJjvRk-Sftt76Y_ESVGzz54QnLSbZ2jjThl_0WONtP6l4ip5mt9Pk
    kfRIbPZP3stG8u0sBY>
X-ME-Received: <xmr:46UuZLbBk7Hay6gHYKlJ4OPlgPvdhcVxuAqJW6qjZSkky7dPEbtrTWypEQ4T4m6N-dvdrSfiYu-QaaAGPaUwJFqsMoYUrjvd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:46UuZKVqnghzZigo3_xc7UQ8d7BarGx6dTWkv96qclX1YWAI2tbSyA>
    <xmx:46UuZJlqo6Hc66G0ia8wUIQT7a_n1tQuMzypRSRkkqALEx7eUybdoQ>
    <xmx:46UuZHd1TBjHAAB_-5sN6JGRoJSXImiE-IkEeBzXS5cHS3azzwOKhg>
    <xmx:5KUuZPfT1txrBWxq7cLwYw1ahBDxMHmtYr80E9DOWMmcJXDtXSxkXA>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 06:58:40 -0400 (EDT)
Message-ID: <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
Date: Thu, 6 Apr 2023 19:58:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
 <2023040627-paver-recipient-3713@gregkh>
From: Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <2023040627-paver-recipient-3713@gregkh>
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
Cc: naohiro.aota@wdc.com, Yangtao Li <frank.li@vivo.com>, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, rafael@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 4/6/23 19:26, Greg KH wrote:
> On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
>> On 4/6/23 19:05, Greg KH wrote:
>>> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
>>>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
>>>> BTW kill kobject_del() directly, because kobject_put() actually covers
>>>> kobject removal automatically.
>>>>
>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>> ---
>>>>  fs/zonefs/sysfs.c  | 11 +++++------
>>>>  fs/zonefs/zonefs.h |  1 -
>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>>>> index 8ccb65c2b419..f0783bf7a25c 100644
>>>> --- a/fs/zonefs/sysfs.c
>>>> +++ b/fs/zonefs/sysfs.c
>>>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	sbi->s_sysfs_registered = true;
>>>
>>> You know this, why do you need to have a variable tell you this or not?
>>
>> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
>> fill_super will also return that error. vfs will then call kill_super, which
>> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
>> added the kobj.
> 
> Ok, but then why not just 0 out the kobject pointer here instead?  That
> way you will always know if it's a valid pointer or not and you don't
> have to rely on some other variable?  Use the one that you have already :)

but sbi->s_kobj is the kobject itself, not a pointer. I can still zero it out in
case of error to avoid using the added s_sysfs_registered bool. I would need to
check a field of s_kobj though, which is not super clean and makes the code
dependent on kobject internals. Not super nice in my opinion, unless I am
missing something.

> And you really don't even need to check anything, just pass in NULL to
> kobject_del() and friends, it should handle it.>
>>>> -
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>>>  {
>>>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>>>  
>>>> -	if (!sbi || !sbi->s_sysfs_registered)
>>>
>>> How can either of these ever be true?  Note, sbi should be passed here
>>> to this function, not the super block as that is now unregistered from
>>> the system.  Looks like no one has really tested this codepath that much
>>> :(
>>>
>>>> +	if (!sbi)
>>>>  		return;
>>>
>>> this can not ever be true, right?
>>
>> Yes it can, if someone attempt to mount a non zoned device. In that case,
>> fill_super returns early without setting sb->s_fs_info but vfs still calls
>> kill_super.
> 
> But you already had a sbi pointer in the place that this was called, so
> you "know" if you need to even call into here or not.  You are having to
> look up the same pointer multiple times in this call chain, there's no
> need for that.

I am not following here. Either we check that we have sbi here in
zonefs_sysfs_unregister(), or we conditionally call this function in
zonefs_kill_super() with a "if (sbi)". Either way, we need to check since sbi
can be NULL.

> 
> thanks,
> 
> greg k-h

