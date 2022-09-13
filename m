Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A65B6713
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 06:52:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRWLD66kDz308b
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 14:52:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7dTZTr4F;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7dTZTr4F;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRWLB3GS9z2xk6
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 14:52:47 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id l65so10620874pfl.8
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Sep 2022 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=JLF2I4wOwXauDOEb5+Sh8J70kOC65ivJWEGZB27Sv0g=;
        b=7dTZTr4FYIktraDjKfcf82VDAwiKwQ9io1MDq8z8uKJytwJm6fYshMdfMlhRY8GgHe
         3fDCxLXATEjYBLmNGd0dJg7/5KTNHgeT6O8qaLU/05BXymesEDIzEecRwAlDkwIZxLxQ
         nFUe1rTAB7CG3WrDKzjXnHkke7NvZ0x8tZqW7+8hr6I9rz7PK3o1GQrg3W//Ge3EF365
         h8Le6mRlItymgSZJ778jtK7oBIelM1VMXuPSn50g5nS1cqQFRUoKori3HVcwh1ZxEur6
         MQLbzVK8wF3rWnuSErZ24/5MIRwwXRIX1DN1fN6M5TsgqqX2MdV3jmy+BDvBpeMI1k7u
         6+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=JLF2I4wOwXauDOEb5+Sh8J70kOC65ivJWEGZB27Sv0g=;
        b=zyzxOGsicNf460JhFFmf7ac/pJbv7BCIg0NccaQHwj4+UqoKmyNQP78XEyV1rIQDem
         28Esf1bGYl7vdaQ/QuH8B2BQ9ZH3armANYUSgy1i87hbpsBgTbn1P6ZGivR80tatpwxk
         VoJsNXDUBy5hUZQfWKMgWO4ukZXqkGqMyPClmlATtnOiMu6ZOtC+bgSw8aGjMHMP4NrB
         zzkM1PlsMSbfQxrV6Gz7tGP+59UnpFf9j1RKWMz+FW5p3a0NUoZAjShI7ANgSRGWQArf
         iAvylEMGfGRQ+VVZMRGWkuR+wOPaB+5f26Z67wmH2iUFqUaSCvN5P3zaFDDr9gnUQvok
         5aTg==
X-Gm-Message-State: ACgBeo3aL6oN3yY8zqFNa6orwSA/eTrz3wL9jgGD3FvYuTbNLT6BDfYd
	eEUhCAsclZ9ktpK0jIIshVKA/A==
X-Google-Smtp-Source: AA6agR5dV5R2BRbUXES4VtsugHRQDiNuiv2o2I1g/ph2SiQRoaG6a1nGMpB/RzAH04YkM8Dye47NnA==
X-Received: by 2002:a05:6a00:e8a:b0:535:cc5c:3d87 with SMTP id bo10-20020a056a000e8a00b00535cc5c3d87mr31153288pfb.24.1663044766321;
        Mon, 12 Sep 2022 21:52:46 -0700 (PDT)
Received: from [10.76.37.214] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x92-20020a17090a38e500b002008b7c9764sm6109658pjb.50.2022.09.12.21.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:52:45 -0700 (PDT)
Message-ID: <27143c70-906e-a575-ef58-ac9f3c5ab080@bytedance.com>
Date: Tue, 13 Sep 2022 12:52:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 4/5] erofs: remove duplicated
 unregister_cookie
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-5-zhujia.zj@bytedance.com>
 <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
 <8a239157-de28-44ae-edef-336092c34a15@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <8a239157-de28-44ae-edef-336092c34a15@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/9/9 18:28, JeffleXu 写道:
> 
> 
> On 9/9/22 5:55 PM, JeffleXu wrote:
>>
>>
>> On 9/2/22 6:53 PM, Jia Zhu wrote:
>>> In erofs umount scenario, erofs_fscache_unregister_cookie() is called
>>> twice in kill_sb() and put_super().
>>>
>>> It works for original semantics, cause 'ctx' will be set to NULL in
>>> put_super() and will not be unregister again in kill_sb().
>>> However, in shared domain scenario, we use refcount to maintain the
>>> lifecycle of cookie. Unregister the cookie twice will cause it to be
>>> released early.
> 
> Sorry, why can't we also set sbi->s_fscache to NULL after decrementing
> the refcount in shared domain mode, to avoid the refcount being
> decremented twice?
> 
In below case:
1. mount -t erofs none -o fsid=bootstrap.img -o device=blob.img -o 
domain_id=1 mnt
2. mount -t erofs none -o fsid=bootstrap.img -o device=blob.img -o 
domain_id=1 mnt2
3. Procedure 2 will fail since we can't mount erofs with the same sysfs
entry.
4. Mount()'s error handling path will step into put_super().
5. Domain's refcnt will be decremented even if it has not yet
been incremented.
>>>
>>> For the above reasons, this patch removes duplicate unregister_cookie
>>> and move fscache_unregister_* before shotdown_super() to prevent busy
>>> inode(ctx->inode) when umount.
>>>
>>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>>> ---
>>>   fs/erofs/super.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 69de1731f454..667a78f0ee70 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
>>>   		kill_litter_super(sb);
>>>   		return;
>>>   	}
>>> -	if (erofs_is_fscache_mode(sb))
>>> -		generic_shutdown_super(sb);
>>> -	else
>>> -		kill_block_super(sb);
>>> -
>>>   	sbi = EROFS_SB(sb);
>>>   	if (!sbi)
>>>   		return;
>>>   
>>> +	if (erofs_is_fscache_mode(sb)) {
>>> +		erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>> +		erofs_fscache_unregister_fs(sb);
>>> +		generic_shutdown_super(sb);
>>
>> Generally we can't do clean ups before generic_shutdown_super(), since
>> generic_shutdown_super() may trigger IO, e.g. in sync_filesystem(),
>> though it's not the case for erofs (read-only).
>>
>> How about embedding erofs_fscache_unregister_cookie() into
>> erofs_fscache_unregister_fs(), and thus we can check domain_id in
>> erofs_fscache_unregister_fs()?
>>
>>> +	} else {
>>> +		kill_block_super(sb);
>>> +	}
>>> +
>>>   	erofs_free_dev_context(sbi->devs);
>>>   	fs_put_dax(sbi->dax_dev, NULL);
>>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>> -	erofs_fscache_unregister_fs(sb);
>>>   	kfree(sbi->opt.fsid);
>>>   	kfree(sbi->opt.domain_id);
>>>   	kfree(sbi);
>>> @@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
>>>   	iput(sbi->managed_cache);
>>>   	sbi->managed_cache = NULL;
>>>   #endif
>>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>>   }
>>>   
>>>   struct file_system_type erofs_fs_type = {
>>
> 
