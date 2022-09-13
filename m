Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8B5B6704
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 06:37:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRW0w4kHcz308w
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 14:37:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tDZt8AcW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tDZt8AcW;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRW0t31Tfz2xfs
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 14:37:48 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id a80so2027952pfa.4
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Sep 2022 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=b7Bt/6YykyrjMchIDnbFXbVoXcDSV6FDpCyHEofA/qI=;
        b=tDZt8AcWokd/xVHEI5fGydFkbJEPKf/viuCMk7B4IQI4/2/VcQwYi1aOxJUi3CE+SO
         lDX6xyUveu3H03QWTLGMIEuSIA9Qc9KdB7APrKrxHt8Jpry8IEvY4nMf2AmX457HS95L
         K9NNtnlsucaFPOaNgmPoXoDZACoBQ6HRRoYeE/MivzjAdB/JpSnsmlC+uROYaKaBLp3a
         ugjk6/qyB9SLQCaQ7HIFafa01ei7997gJBzIkILPvCvIShXZiD7jWbeISymZzRn7yhdu
         vYfc0Mh+ip3peQVLfCqR6xKLjUP11unFz7AAHtMiCT9Ir+52CQ1HRoLQI+uvxcWNlGKT
         7hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=b7Bt/6YykyrjMchIDnbFXbVoXcDSV6FDpCyHEofA/qI=;
        b=PiMdzWykAxrNHh5gBwiEu/+202JxhuXWSVH/MPqmCBdmJs6ZBx/VnpCl2oaNVzkJqk
         Tir7S5q0//z96TJBmzcNCa0zxlkIHUiar1LbsOpUBsfruxrpzrbQg9Fg8gotUo1BpNlE
         ixSKZxlYDQI/bu8RhOyHmA0Bgzt9kBWMbvGeIMiWvN1FHOFGqg0IBYu2pHWDy9XOj+jS
         bAmvpYgCBQQGekMw2NVaqswWhgkFf0QguM12nm29N6XE0MZzdWCTnhBWDY1pkgnQMa1E
         CXkd29FIMuBJujpjQEsK8hSSPnwemGfPnFY2PWD0NtFRKEnBa6jqHEX/lWw5YM8SyRvh
         T3Lg==
X-Gm-Message-State: ACgBeo3Pi9BIuRxhjBP6e2XieYdjJ912jFbYl5G96WhRjrHCmFKpp8Oc
	h5TJen+phOiQVao/vtpa2sSOmg==
X-Google-Smtp-Source: AA6agR5kvBhdwDorYv+Mc7NkXS46ff4TVEzUhnp1Hcyrx7C2S7lBeLtqJ9awLb2i14mmmLKXZuFm8g==
X-Received: by 2002:aa7:9e12:0:b0:53e:27d8:b71b with SMTP id y18-20020aa79e12000000b0053e27d8b71bmr31213065pfq.46.1663043866649;
        Mon, 12 Sep 2022 21:37:46 -0700 (PDT)
Received: from [10.76.37.214] ([114.251.196.103])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a6a0300b002002fb120d7sm6198682pjj.8.2022.09.12.21.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:37:46 -0700 (PDT)
Message-ID: <8c17fa4d-96a3-36e7-38db-17673c4bf552@bytedance.com>
Date: Tue, 13 Sep 2022 12:37:43 +0800
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
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
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



在 2022/9/9 17:55, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> In erofs umount scenario, erofs_fscache_unregister_cookie() is called
>> twice in kill_sb() and put_super().
>>
>> It works for original semantics, cause 'ctx' will be set to NULL in
>> put_super() and will not be unregister again in kill_sb().
>> However, in shared domain scenario, we use refcount to maintain the
>> lifecycle of cookie. Unregister the cookie twice will cause it to be
>> released early.
>>
>> For the above reasons, this patch removes duplicate unregister_cookie
>> and move fscache_unregister_* before shotdown_super() to prevent busy
>> inode(ctx->inode) when umount.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/super.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 69de1731f454..667a78f0ee70 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
>>   		kill_litter_super(sb);
>>   		return;
>>   	}
>> -	if (erofs_is_fscache_mode(sb))
>> -		generic_shutdown_super(sb);
>> -	else
>> -		kill_block_super(sb);
>> -
>>   	sbi = EROFS_SB(sb);
>>   	if (!sbi)
>>   		return;
>>   
>> +	if (erofs_is_fscache_mode(sb)) {
>> +		erofs_fscache_unregister_cookie(&sbi->s_fscache);
>> +		erofs_fscache_unregister_fs(sb);
>> +		generic_shutdown_super(sb);
> 
> Generally we can't do clean ups before generic_shutdown_super(), since
> generic_shutdown_super() may trigger IO, e.g. in sync_filesystem(),
> though it's not the case for erofs (read-only).
> 
> How about embedding erofs_fscache_unregister_cookie() into
> erofs_fscache_unregister_fs(), and thus we can check domain_id in
> erofs_fscache_unregister_fs()?
> 
Thanks.
>> +	} else {
>> +		kill_block_super(sb);
>> +	}
>> +
>>   	erofs_free_dev_context(sbi->devs);
>>   	fs_put_dax(sbi->dax_dev, NULL);
>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>> -	erofs_fscache_unregister_fs(sb);
>>   	kfree(sbi->opt.fsid);
>>   	kfree(sbi->opt.domain_id);
>>   	kfree(sbi);
>> @@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
>>   	iput(sbi->managed_cache);
>>   	sbi->managed_cache = NULL;
>>   #endif
>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>   }
>>   
>>   struct file_system_type erofs_fs_type = {
> 
