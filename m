Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965B5B941C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 08:08:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSmw74LXMz3bZC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 16:08:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ibO/wc2B;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ibO/wc2B;
	dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSmw125c7z2yYj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 16:07:58 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id b23so17026844pfp.9
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 23:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=ibO/wc2BrsXme6DE9SPHSIz2siu6/IST8u9oC8WZEquf/PZPbSZhvpQXmnHJvCRxY6
         P3P650X4Z6WQWqQoseR9qY9nnLo2AX/7WsCZeowWK7NL/MKoQUumTE1nOIeRMnp5zKJU
         smkb/ahHd7vLyMjcyF5Y3e3uyg/PPasvZb3VP2kbqY6flS59cC38dMMbusPYVuZb+bk5
         no4MQLvhxUIAOZ9XCgipS5DQkvNKO/ku8eGAZV07XkW0stvUSLsIX3le+noyLTfEi1b1
         8C293LGqPosYXxLNH7Ul8uZtcnn9FooQxc429gR5PnN650ZUBD6On+R+icpBcU2wzHJ+
         DEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=klpC8Gnc0DH9MlRbcVmGlOJ2WJNQlZzSZCvS99XBFTQGAvHOGxk3xye2ZvhMHd2zIm
         6alta84U7bkg8OQe2cNWKm3vWI50wAcT8ynShAmH3UBT2ui1EZ28A4otG2+zOf2b+h2e
         JtacB8HOCH3833SKzOKGsp3e7h7+sKy2HaDfgRrR6qBmzGP4hkxeomr8WEhrB9dwwaLS
         R52euvOGSVN2of8YaFIuEqCgi2y0hLUh743DRXQa0JdsSZIYavnFWZcU4bYuWzF4sspM
         sMmhG1GSlcJR/iKKhS2IO/qdWuC2D/MiYxnPwBhr/LFjhsw9XVMrwOlagj2/dY5tpKnS
         +MMQ==
X-Gm-Message-State: ACgBeo1zakYSjgZJzOIi0pSKTtPdJ2pvzAnjnAuIXvXQelFS7T0dBDCz
	nzGsUjcyvuyZp1DIq0CYAb8oLQ==
X-Google-Smtp-Source: AA6agR5KvTTWQBLOtQc+SAEQY+Ih2ccYRNJQUpPrsBPvLtYvYnw1Qsqe03kAV4U82cJFEsw36KS0/A==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr34969128pge.228.1663222075779;
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u197-20020a6279ce000000b00540e1117c98sm11247458pfc.122.2022.09.14.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Message-ID: <6da8b963-610c-9692-192f-aa611e64ac82@bytedance.com>
Date: Thu, 15 Sep 2022 14:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 1/6] erofs: use kill_anon_super() to
 kill super in fscache mode
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-2-zhujia.zj@bytedance.com>
 <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
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



在 2022/9/15 10:28, JeffleXu 写道:
> 
> 
> On 9/14/22 6:50 PM, Jia Zhu wrote:
>> Use kill_anon_super() instead of generic_shutdown_super() since the
>> mount() in erofs fscache mode uses get_tree_nodev() and associated
>> anon bdev needs to be freed.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Thanks. You're welcome to use "Suggested-by" in this case. The same with
> patch 2.
> 
OK, thanks for your suggestion and review.
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3173debeaa5a..9716d355a63e 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>>   
>>   	if (erofs_is_fscache_mode(sb))
>> -		generic_shutdown_super(sb);
>> +		kill_anon_super(sb);
>>   	else
>>   		kill_block_super(sb);
>>   
> 
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
