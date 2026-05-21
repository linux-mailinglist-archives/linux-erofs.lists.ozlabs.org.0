Return-Path: <linux-erofs+bounces-3474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCY4GAlWDmry9wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 21 May 2026 02:47:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27159D63F
	for <lists+linux-erofs@lfdr.de>; Thu, 21 May 2026 02:47:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLV9L3bh1z2xlh;
	Thu, 21 May 2026 10:47:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779324422;
	cv=none; b=ihNTEcJtGV3Bu+eM68pxnFTZFeij7MNX/7repi7oUq9B8MZc9WOqClukFsAOcPkuXOJXkbCfK/JqUpjShPPSevol1xymUazrSXx2iA9zBUh2fyv72SnZzZ3SySboiuNwWWixgyZmvdKtIO3kr4hLaHnQA94UpE1s7jZl/AmE2bofNxnSLkZPiE+ZLxoHbBUkTi9xKNozVU+0kSD66/t5SfV74rEk4+cG1MT4I5MaMfpoNIXqETylA78Io5DJxfX4F8OaalJpUkLqwry72Vf3hPPsIW7Ws4c1V+KS8QobI6wB3ek2vLTDhFg7PWPziAwCKiRE2P+0SVEspRQ4BgEwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779324422; c=relaxed/relaxed;
	bh=Bt22P5t/+mjz1RdpsEpY96HBJdQBUISmacBjvXL1uHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmnSThWdWFucVaL8ZsrveunaHssr06kpes5Hmml7/7B8tGBYqa0Opmhl9pwckb2xDfXx0YfzyPkqR3tZGEO7Vi0EZ9/jdt65qgC2YD3Yl/nLgKH3RBuGISf9rKpp0vUdLmZcM5pvDQ+2riziIx1XrWXs95dGNhRzcRq6Nhuspd/xdhI+ld4LfZfiD4qrSmT6EZj3x9fdPYGf/mEaW/UPSv/OrvRHHL56JXzLXLVSVrWhFQ1c0fgKSksluQmT9TQ2xWv6ghNBc1dd1TKJBlCstncS3qTexIHzHd3tP2s1SOILg+P9ZhdkKyQjN13VDmmJw3p6CAcguCPokMHhTzpSTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ORc3DZS8; dkim-atps=neutral; spf=pass (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ORc3DZS8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLV9J2d2rz2xSN
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 May 2026 10:46:59 +1000 (AEST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78EFA3F94E
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 May 2026 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779324415;
	bh=Bt22P5t/+mjz1RdpsEpY96HBJdQBUISmacBjvXL1uHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ORc3DZS8pYRo1wDl2Now7mkQQKXrYQK+L96HU5xOZIiP13t7Vgr55DDtPYMCaZC74
	 gqSJMuL2hngo+gcXCe676KQ3TKJSpPJGWPlfPMRahvkrjWNfOYfHCOnIjxZcPwnCsx
	 ClWK6+FmKcLWALhfSJzrNWJCajLDeuSiw1YSv2I27SsRHKw4iXF/ifL6Dt73mhLCBQ
	 6EjRoiiQrgq23YwOEEazLQPk/SfJoq/bzpoPQUUJU4/lQqA7osAQfYJb0bjzVnBMJF
	 YyH6OrVfLRTroqL5Nm6X6shToBRBP6Ph/7YAhu2LosQXEjmEufmaxRd6wLRUEpRX40
	 a/iDzHGtT39UM2qAZ8M/eAQ4OnR3BzJzMO0Afb9UOsgl/d42fYyxyrN3+bAWT1L5jS
	 USBNH6Esas5oPfLZY9MW15P/imuvEe+3n2/W6Nh2J1P8/vUzpTmLkl1vvRfWEzQlhJ
	 y7Sx/F12/tAqbM3cv9RBfgkSOIoaNTq68FP6510S1XIl7BFjQE60Io1QViOY+YS4oP
	 wbSG7FFGBzq++KLIWXIAspcLjiChTMjEBcSwJZyOlH7G6uvKImE7NIkTnw1ejQoU/H
	 IGAqNl94Vjv3LnzWNzTVkgaqdD+oMeE7kfwSinKVDZlskwgBxq64NplTNHw+dtxkZD
	 npgGNueh3WCyzEz330iKmqBI=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45dbbbf8d57so7274185f8f.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 17:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324415; x=1779929215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bt22P5t/+mjz1RdpsEpY96HBJdQBUISmacBjvXL1uHk=;
        b=MXTYko3A1feYR7h1WLFFspWg8GeTjg69mWHvqO3J++O2+yPiTMS1rKNsmHv1pquCmL
         hajG5YDWwtaUrRj8D9QttF0kQKDGN8dfRiThKLXNh0FAKmhjZsdLmcQPN8WpauTnUk6y
         GE6pUhkh9DigwlJmqSgohmojrYFfHyurn4xX++AUL2iIVNtEeO6ZA/gFdZn7p7ASfaiI
         Tn8fH6ZiW12o4fV1gUEKvk3Og4bgLPnvK3ijl84feENMRXC/U7I0V4MQaFlpYTptajPg
         s5n56CqON9KpcxmrUSNgE/2zSn1/OgUt6MNDX4CSOOXt85T7Wuhsp559ReaZvsT/i+fE
         OvmA==
X-Forwarded-Encrypted: i=1; AFNElJ/VN8/rqBJ42KM4xmUnyO+3lagpXmA2Wk+4z5FrOWdQJx07hQhTXAXuosMPhNEQJwu9SEfTiO1+haes2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8RAIH0DmnbJDascoT/JnXAzGPzJJcJJLMi+X+2mXp7I4+0yR2
	cvIDLvZjzYkwKsgADxQZ40w/v26lKjryXz0g8kZw6eiWDjtwTaNF+mqXAt34JkKBt8+hhy9kDrM
	DLEoo6oY1xqHrbYdXo/unm1u+8z/e8Uhyys0dJZL7/biZ9PQRqmNp5jmMsp2tISi3oSmNroYr09
	HXi/S+Rw==
X-Gm-Gg: Acq92OGHThxN5e5n6RHMl2BxVWcjXing/RS8vRZS8LmEPZnvDmr6uN55MUqPi9gbdV2
	nv/ZQp+eR7UnpLKVAWITFKr0ZyvSqwgkSo24YHaJ3VmEVPM2aYUUtWnsR//g9/aKwn7qaIiwUvz
	zldVIysm+HZByXvVPecad6Dz5pQ7ETGWU7V6oln11cAPOkY8MOu73Olge7N9+GIJac8hzqW5qxA
	+ILiqEOdPlIh3Vi0w9rmu5dY1GGEg4YcZuBptzAysPViijoRAtyIdaZcN7VB2F7RY2W2qN4MKZ/
	YPib+rhPzCicB6qo64BjNLu6kSZgJTZPDG48perN1l+PWEcRihIofeI+ejZ/ti9FlJvcIhI2Y55
	exOdNThYpK1gztwZDMpEUg5n4Fp04thK8Soimzc1JhmsXsCKvv36UV/8S7Xv/Jf/tRBQm6ixQMG
	2BUwSrH2fmdfYkXY5rR3mL9U+3xI3d1IRYVC+uDHcECcWUhXCsI9KuO28T
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-49036041d5fmr5262345e9.8.1779324414977;
        Wed, 20 May 2026 17:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-49036041d5fmr5262205e9.8.1779324414586;
        Wed, 20 May 2026 17:46:54 -0700 (PDT)
Received: from [192.168.123.154] (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035eeb4f4sm3618385e9.32.2026.05.20.17.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 17:46:53 -0700 (PDT)
Message-ID: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
Date: Thu, 21 May 2026 02:46:51 +0200
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3474-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:sjg@chromium.org,m:trini@konsulko.com,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,canonical.com:email,canonical.com:mid,canonical.com:dkim]
X-Rspamd-Queue-Id: 8E27159D63F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 22:42, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
>> displays the modification date alongside the file size:
>>
>>   4096 2024-03-15 09:30 filename.txt
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   fs/fs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/fs.c b/fs/fs.c
>> index f8e4794c10e..482a5523712 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
>>                  .fstype = FS_TYPE_EXT,
>>                  .name = "ext4",
>>                  .null_dev_desc_ok = false,
>> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
>> +               .caps = FS_CAP_DATE,
>> +#endif
>>                  .probe = ext4fs_probe,
>>                  .close = ext4fs_close,
>>                  .ls = fs_ls_generic,
>> --
>> 2.53.0
>>
> 
> I would prefer having a head-file macro which expands to nothing for
> xPL builds, rather than adding preprocessor macros.
> 
> Regards,
> Simon

Hello Simon,

In the internet I could not find what a "head-file macro" might be.

As struct fstype_info is not defined in a header file, a preprocessor 
macro defined in a header file would not make sense here.

Do you mean something like:

#if IS_ENABLED(CONFIG_XPL_BUILD)
#define FS_CAPS(flags)  /* empty */
#else
#define FS_CAPS(flags)  .caps = (flags),
#endif

static struct fstype_info fstypes[] = {
#if CONFIG_IS_ENABLED(FS_FAT)
         {
                 .fstype = FS_TYPE_FAT,
                 .name = "fat",
                 .null_dev_desc_ok = false,
                 FS_CAPS(FS_CAP_DATE)
                 .probe = fat_set_blk_dev,
...

A line without a comma in the initializer is easily mistaken as 
incorrect. I am not sure that a code reviewers life is made easier with 
defining a new preprocessor macro.

Best regards

Heinrich

