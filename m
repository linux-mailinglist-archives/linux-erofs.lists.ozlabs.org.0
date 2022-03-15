Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973034D99EE
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 12:05:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHrDT3DPHz30Fn
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 22:05:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qrx7ZR9n;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=qrx7ZR9n; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHrDM1LbTz2y7M
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 22:05:38 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id
 mj15-20020a17090b368f00b001c637aa358eso1657374pjb.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=kuK4I2tojx5UmkgwIWGWy7dBaK7RpGnhCg0EIQSmGxw=;
 b=qrx7ZR9ndfJG3lJpJBz/HJZ9Ap9HB1jiHmW+Yf9ayVXtZ+5iVwMyYWMNpvOp6TXiGR
 L7zUbiJ/prSfJZfnwV5vkWPFV9Hpx4ISpf8pRXKFrGBHz3j/OJTHsGRWOHj6MZaC+acY
 scMv8RNLAw9oEzrojECbS7FpI0+JYvXd6X2PWp0CPTk6MA8PVGuoWqnqkuOy2mU8PhRU
 ocqww9WBDEbxrWrRmEUfm2dKL9Dp4MbeqxN75bPu4ex2uCZYBh4nBh8WtxY7yRkDleb7
 HI4rkOj37DL6db7N6oMcVOMhEvvmU5m4WdhpN3p+1WWymVThvUCzN5R+4e+omsVcRAAI
 uMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=kuK4I2tojx5UmkgwIWGWy7dBaK7RpGnhCg0EIQSmGxw=;
 b=cBqLkn5QLgmkimbzyEeu0A7pUFO3ztB7/wsvwFsNJzmoBT5V3KXPbB8eYnwgfOAr6p
 2EoCxxRj0CA1gJOeQcxLBwHRlkUZRMSUUr5Pn2xVpWHY4EX1ky8ZSoR4ZybfUmDE3W8r
 0hHJk7ZQOF0JU0tOmA5e3kQNPaVVdgsdthP30wAYHlRpioKFjB54VG+P0JeBqHsWLkKW
 nHWzbKg/E3lMnkwKLFWxjWO4hm+APX7NiTdAj0jJNP/6Z2yg46mZ79UYsMi8VdcrLQVm
 lpbRSwn3ApSlkAPcm/t3pyy9dgsQYP6E4e6TDMLo3Tgx8CC53/kMUf6i9kKsv4iogKlr
 QcyA==
X-Gm-Message-State: AOAM533tlvvGJhrV6kANzNRnWpdYQYDRmuNfu+M8vjODuGSeOTUn8jWZ
 cSXkqQEmyfZRr8DMIpOigu0=
X-Google-Smtp-Source: ABdhPJypZlFCeCodjEQKPkdy0A15ZfdulIZDg/AcsnNrzl7o3ou5sEUVcNOUj3lYdGf68D4r8WAGjw==
X-Received: by 2002:a17:902:e848:b0:151:e3a5:b609 with SMTP id
 t8-20020a170902e84800b00151e3a5b609mr27320794plg.137.1647342335590; 
 Tue, 15 Mar 2022 04:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([103.97.175.139]) by smtp.gmail.com with ESMTPSA id
 lr9-20020a17090b4b8900b001c645bf9a0bsm1798544pjb.1.2022.03.15.04.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 04:05:35 -0700 (PDT)
Message-ID: <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
Date: Tue, 15 Mar 2022 19:05:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Dongliang Mu <mudongliangabcd@gmail.com>,
 linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/3/15 18:55, Gao Xiang 写道:
> On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
>> 在 2022/3/15 15:51, Dongliang Mu 写道:
>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>
>>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
>>> is triggered by injecting fault in kobject_init_and_add of
>>> erofs_unregister_sysfs.
>>>
>>> Fix this by remembering if kobject_init_and_add is successful.
>>>
>>> Note that I've tested the patch and the crash does not occur any more.
>>>
>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>> ---
>>>    fs/erofs/internal.h | 1 +
>>>    fs/erofs/sysfs.c    | 9 ++++++---
>>>    2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 5aa2cf2c2f80..9e20665e3f68 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
>>>    	u32 feature_incompat;
>>>    	/* sysfs support */
>>> +	bool s_sysfs_inited;
>> Hi Dongliang,
>>
>> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
>> sbi ?
> Ok, I have no tendency of these (I'm fine with either ways).
> I've seen some usage like:
>
> static inline int device_is_registered(struct device *dev)
> {
>          return dev->kobj.state_in_sysfs;
> }
>
> But I'm still not sure if we need to rely on such internal
> interface.. More thoughts?

Yeah... It seems that it is better to use some of the interfaces 
provided by kobject,
otherwise we should still maintain this state in sbi.

Thanks,
Jianan

> Thanks,
> Gao Xiang
>> Thanks,
>> Jianan
>>
>>>    	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>>>    	struct completion s_kobj_unregister;
>>>    };
>>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>>> index dac252bc9228..2b48a4df19b4 100644
>>> --- a/fs/erofs/sysfs.c
>>> +++ b/fs/erofs/sysfs.c
>>> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
>>>    				   "%s", sb->s_id);
>>>    	if (err)
>>>    		goto put_sb_kobj;
>>> +	sbi->s_sysfs_inited = true;
>>>    	return 0;
>>>    put_sb_kobj:
>>> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
>>>    {
>>>    	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>> -	kobject_del(&sbi->s_kobj);
>>> -	kobject_put(&sbi->s_kobj);
>>> -	wait_for_completion(&sbi->s_kobj_unregister);
>>> +	if (sbi->s_sysfs_inited) {
>>> +		kobject_del(&sbi->s_kobj);
>>> +		kobject_put(&sbi->s_kobj);
>>> +		wait_for_completion(&sbi->s_kobj_unregister);
>>> +	}
>>>    }
>>>    int __init erofs_init_sysfs(void)

