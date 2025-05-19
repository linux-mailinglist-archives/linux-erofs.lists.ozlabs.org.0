Return-Path: <linux-erofs+bounces-346-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A150EABB3BE
	for <lists+linux-erofs@lfdr.de>; Mon, 19 May 2025 05:59:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b13pG2mRDz2xlP;
	Mon, 19 May 2025 13:59:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747627142;
	cv=none; b=oY4lbCOgRnHAatobm3cPg3DtwlqWXk7WQp2w6zvZ0c+dA6LKaThvs7g969y9T5H6M7gHVQp1hk8KnlHnn9xCA3GTyZLZMQ9q9R+0nlXc7gMt6JmAoQaZFndlOjCa2gfjoDF2rfqWKzgSVtO3qDe6Qo050POdPImj4UpmKhXsJkZjKcK1CSbEzo9KKepniljHwiIMU8/Ts/vMtgT1agF+uaMaTCnBcojxN+6CSeXdDUlPILZOrcbJ+6eY0aWVH4thjhjqp+foZLiEeSIZRKELSu9GledYIoPTZlET9e/2LsUSqA4ZRd+DBxcK1IWvKeTLIrJlM87nQdmtGd6gkbM7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747627142; c=relaxed/relaxed;
	bh=Jkk4NMafQXIS7Y0gvgk+dRyrvshPt3WFYQPSP11ctnA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GnlP2a+X47ZNvF4w00cXFnggv1VfuVYuoji3gq2Mq+ByXIg9r/LOdp2yxLYSM3MyMQZkIInELuwAbVlXlJEDi+IZ4eMsNQ3L/dV/EjTi0wbhPRdX65x0APEJoMUiMT7ObO+VkZPRn5QtLqlIWHSmOyHFQkE44mcMIPVKrGfKshZoIIqnXJ2Qr8vXzhMUG5tZqe6Fhmht5Ry59IH3VRMUHfoEvcw4f+cKi+MocXTCw6hyLriFpBnNNVG4IIVhmkLffux4k4wlFJbmNWZ/BVfB8AMzbLk2RSWMmmmsEMJVIFJNoCvNWikkZZWicPK133MhAMmxsEfza2s0TzUSIxJ+Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GBRgHMSa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GBRgHMSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b13pF1K1vz2xPc
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 13:59:00 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-30eb1c68386so966317a91.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 18 May 2025 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747627138; x=1748231938; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jkk4NMafQXIS7Y0gvgk+dRyrvshPt3WFYQPSP11ctnA=;
        b=GBRgHMSa5t7WgFTbzFtKUE0rptgAKm4t+eFCmAnRxZgzuV8l8toDRuOZ1xYhCA7al7
         t9sJJjTW3nF8dastwT7/pLs/xvJenWth796zodhggPLQejyJpnOYxlpFsMstqW7hBJNy
         731qa2lxmcHbbhxuPJdQ+ZJ6iQyMPZIboufLnUIEZLTmsGI4mRSBIc1bfws4xaZ4P/64
         JUQI+ZZAjy9o0JiDHFcOLVxUbIWEycBi2SdS8uqrp3p5QnQeumvShtE4GuAbsTrIoRGh
         IQ2IZR/WaL9xIvwl+Ktd3oH8SMuJYto3cFuFpO3HLvuV+AqNWRAO2tWiKgyrLlhl1Mlp
         39/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747627138; x=1748231938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkk4NMafQXIS7Y0gvgk+dRyrvshPt3WFYQPSP11ctnA=;
        b=h7Z/5Km0sXLr3muK/bx4QSGZCpsfEgOWpChxMCk5yVeKv5Gp09nC4OPRGJYFakeqiK
         WjSwwwBxrFBAjY4rlgdaWTJSnQHO02htEyb0fJGs0m1KDkHakGXqSmI40S5bpzTOcGnD
         OAlGz6dNulAl9dp15y1e4JLfTTts3h7LHMrzmofQcnBgm8hZyTSTc2NNZh1BHzxozdop
         A/7wRG8kkkUvlBK/R337sNI8u5nx14TrxJDFWIg4/PYHdhxlSQqbU4z4416GgQIet0Gn
         ve+GyvUJAGiCAL3o7GAfU9ciUkgXS9xvFkDOxEkUWMOzWnvZJUUllPKn5kefwPIBHioV
         zvhg==
X-Forwarded-Encrypted: i=1; AJvYcCU96tTQOUsfiiCTdAs+oUMWmaqyj/afGcx0NTgPwqFLx7d8HgazYfmSGI3Hf7pq9TajSuCdiJYCgenYUA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YykvCjPuzuhX2LMgai9aOnnOGM/fqvG+12R5N+5hubHkPfmDMoR
	pYReX8KNGuCdtTy/UUTQIx2/zQ6ModLe8hvEqSvAfKyJJJ8h+c7s0Tgx
X-Gm-Gg: ASbGncumo/K6Gj79QbroYUBCEskNJI8v6+h2BqAl4wsuUzZ8a9GOf/qdxJswBHlm/oJ
	H99PIjpoKCbZs7FvehwvE2EIdnROoPzZsp7KTDGSHDFjv/qD/Q8iLTTnV2SK9y5VoVtSMpZvqbZ
	OwUf+K5jhskUlJrsk46GLFdfFAoLHFct+OkhrqmdaJ5++1IfjtqrIBUxSKWZrCvMd7nge4TsS2r
	U66glpq873Mb3lodak1tvDqKfgJH97RUoQqCstP8Hl0HOaERAIdf5Gd09orhRjyPz6Gs0KCRr1s
	29MHL8mIDM0/Ol4Uyac3UYZti40LlfD9sn0jVVujGOOp4+VXuuHFI5C4blr9LG4=
X-Google-Smtp-Source: AGHT+IEkC+lVM+ew9wvZdD7GrkR5/c3J8KLVLcGyoBLbeJcpSdeKeSSpIcQpyH9IBHalV5KBOc9Tfg==
X-Received: by 2002:a17:90b:3e8e:b0:2fe:d766:ad8e with SMTP id 98e67ed59e1d1-30e7d507e75mr17053952a91.4.1747627138499;
        Sun, 18 May 2025 20:58:58 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d46ef3bsm5582201a91.10.2025.05.18.20.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 20:58:58 -0700 (PDT)
Message-ID: <c45b46f0-65c9-4a4a-8622-c8ef2b9e69b4@gmail.com>
Date: Mon, 19 May 2025 11:58:54 +0800
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
Cc: shengyong2021@gmail.com
Subject: Re: [PATCH v7] erofs: add 'fsoffset' mount option to specify
 filesystem offset
To: hsiangkao@linux.alibaba.com, chao@kernel.org, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250517090544.2687651-1-shengyong1@xiaomi.com>
 <aCqrceu67F3rh3JM@debian>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <aCqrceu67F3rh3JM@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/19/25 11:54, Gao Xiang wrote:
> Hi Yong,
> 
> On Sat, May 17, 2025 at 05:05:43PM +0800, Sheng Yong wrote:
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
>> When attempting to use an archive file, such as APEX on android,
>> as a file-backed mount source, it fails because EROFS image within
>> the archive file does not start at offset 0. As a result, a loop
>> or a dm device is still needed to attach the image file at an
>> appropriate offset first. Similarly, if an EROFS image within a
>> block device does not start at offset 0, it cannot be mounted
>> directly either.
>>
>> To address this issue, this patch adds a new mount option `fsoffset=x'
>> to accept a start offset for the primary device. The offset should be
>> aligned to the block size. EROFS will add this offset before performing
>> read requests.
>>
>> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
>> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
> 
> I applied the following diff to fulfill the Hongbo's previous suggestion
> and refine an error message:

Hi, Xiang,

I'm fine with the update, thank you for improving the change :-)

thanks,
shengyong

> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 11b0f8635f04..d93b30287110 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,7 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> -fsoffset=%lu           Specify image offset for the primary device.
> +fsoffset=%lu           Specify block-aligned filesystem offset for the primary device.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3185bb90f549..e1e9f06e8342 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -654,9 +654,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	}
>   
>   	if (sbi->dif0.fsoff) {
> -		if (sbi->dif0.fsoff & ((1 << sbi->blkszbits) - 1))
> -			return invalfc(fc, "fsoffset %llu not aligned to block size",
> -				       sbi->dif0.fsoff);
> +		if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
> +			return invalfc(fc, "fsoffset %llu is not aligned to block size %lu",
> +				       sbi->dif0.fsoff, sb->s_blocksize);
>   		if (erofs_is_fscache_mode(sb))
>   			return invalfc(fc, "cannot use fsoffset in fscache mode");
>   	}


