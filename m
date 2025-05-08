Return-Path: <linux-erofs+bounces-303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3673AAFA90
	for <lists+linux-erofs@lfdr.de>; Thu,  8 May 2025 14:53:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZtX9x6NF7z307K;
	Thu,  8 May 2025 22:53:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746708805;
	cv=none; b=MoDfy0phXcjCcXjdRgAO6dMqWf7Y5MTG2YxGIJxOUT3BK6eDN0D4jhQMorcEZXTwYL4/9S0nkouEnQNl+uo9gZn65K7rlJv/BCVr8KJO719WdyX0xk11srdMYz2drcRZUBSNZb44uu3OMhcy6Uj9oLRDO8+IqvuJA9NK0tYhECmNfRKs2QtN53WVZdNKCpme9X4IZhRwGBESTkb4fFSY8o4DuQuLg42HwxPs54D1ZYc1OZxZbEhgY23qMaStLaj06yq4uyWgnqYjhccsxL8r+IP2rFRZXr0v3vG86OxEyDMwn1e+pPBi9+B31wZ5Ya4YgGn5JcUvXGOgAN9xHriB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746708805; c=relaxed/relaxed;
	bh=A2jdQICSbrWpPSzC616u74O39zxpPw10REWcsnl5lv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtZ4DX6CG9v7u1ELW99hpBMLf67J+xtNI0MYyX2VbqjdzztgHESx3RfD5V40JNBk+hMfGTKpP6+tQXA6RdjsWjUWZwEd+KS79wqNBV9+j9/63FtKf6yaK4A1LkadQrvYJvWA+cUQpDXcfxp2vm+WWvCWVUj9aetAShFUD6t3PZvhsujHXdYxOq0IXl1uumUcYrAVeh3+uEN4RsT0ghcyN9kRQkbm91VJNKEoJJMLrwORUaqdkxMqYCtovN31xmIeh3ZKXQoS4Q9wGDHxbiwQsqf84c79CaT5uweok5CPm+AeXNnLtd71945NRhpPbBXDgbSpB22mGGPO7CCrGCoQxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/58S/J8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/58S/J8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZtX9w0h1Hz2ygh
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 22:53:23 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-22e09f57ed4so22223305ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 May 2025 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746708799; x=1747313599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2jdQICSbrWpPSzC616u74O39zxpPw10REWcsnl5lv4=;
        b=V/58S/J8Ejoa2iAsPcDcgSVAfZvCKfrQqxB+CzZtkmhzzbqKTvdD0ucBOdfaM3ZdVN
         CgLqPEKV9p2/kMJvIWkfOqd+4IsQdx0XsBCHNpXEe5EJIqZ2rPOOw0kIhhwzNOkjcQqK
         UbTHygDp1vOehH6z173Nt0SoE++pKCt0wRjsglYJOPEX60hs5bjBPskr8XzNUaJFgS4X
         +Ade76EW2c92FlghCj8Svp1EgG9nwPE+NX1IEW+uwA3B8vuc0BEzhdDSG9Ur5liOexnx
         ogzf1PUpptF22cOJGsPk0LAP97ZGctqrH8eDBu4RX0QEAMCcI6H26WKNCgZYwJ48LHxW
         qRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708799; x=1747313599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jdQICSbrWpPSzC616u74O39zxpPw10REWcsnl5lv4=;
        b=cEcZPpHc4xjnQwrP3Zwz/IDozMiEqOE55rxitb3wBToxKUw7XokB+nKUQQPQyoyQTh
         5CBCq6CXpTjtcggPv8X6irweLh1QGrGh4VuJEAcakijEGZVnFxH8Ok1wmDRDwOiFuc9N
         aY/pX+VgRVRJ0FKzaA3pDKXpf4QKJb3c5AtvZlbRiAhw4E5WDnx7QJV1zl9G4VjpB08N
         olHS3Womn6/HUJ/pYwmNsybH7gK6o16HGCOSYzq04TGD+C9BQ363ujNueyHZ/jhT1bcC
         gp8PHaUaGI7xO1TCBxbtWMfpncfnDL9e6bxJeUGoC7o8L0jV2ED06aWpybwzOdBgHkOK
         +g9A==
X-Gm-Message-State: AOJu0YyEHY1LC7Ll/UtkAB2LOzNLxK/dVF/wmE9/Ejk0bic5fNtEJQMb
	8dNLUuUEwwtfSp5TcTKdcandLPPMS6kPnnwzR32crYbEjO0OkkY3
X-Gm-Gg: ASbGncsmM+rKoAr0qshjZ/jCjRdBZjPjymHKYFq2y3z9IMwIwapAbkWLX2lL8shOo0u
	XaNIJcmdbi6/b5Bp5vqS09ywhhBKPggtBeU1DNxbEsLF5JyiyVKW7B+uLYHe6fMKTpPC9megzM/
	tI8TDWaQLfDwf0vaLHgi91+dB1iQ9LG1f0qd7cAXzu8Cp88U9yGTmVGqqPL/pCc0IwM9aOd5LNL
	UDIITcCD0tUzZEd+p1kkF5bqA9S7byszapL/xs+Eh7dRMOh1Rty8hs80jM3DcnqvXsjfXWO/Zxm
	B0iudCsZx4C96gXW+NQk+/yF6yMdf8e0qQGyqau+SFg+Ph5GKCZg
X-Google-Smtp-Source: AGHT+IFwxfSao0kgRqnrILMlXsP5Q8tpHiPhGviH4oQ88rh5sv1UYwb+YKX9PMzCmcphLtnW6R4sAA==
X-Received: by 2002:a17:903:2307:b0:22d:e57a:27b0 with SMTP id d9443c01a7336-22e846e080dmr46241045ad.2.1746708798807;
        Thu, 08 May 2025 05:53:18 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fca5sm111609795ad.136.2025.05.08.05.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 05:53:18 -0700 (PDT)
Message-ID: <93df9b24-3a37-48ff-aa21-5f27a76ecf90@gmail.com>
Date: Thu, 8 May 2025 20:53:14 +0800
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
Subject: Re: [PATCH v4 2/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, kzak@redhat.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wangshuai12@xiaomi.com, Sheng Yong <shengyong1@xiaomi.com>
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
 <20250408122351.2104507-2-shengyong1@xiaomi.com>
 <6389156c-c6df-4e02-ab46-3aaf6230ef76@linux.alibaba.com>
Content-Language: en-US
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <6389156c-c6df-4e02-ab46-3aaf6230ef76@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/8/25 12:09, Gao Xiang wrote:
> Hi Yong,
> 
[...]
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 4ac188d5d894..10656bd986bd 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -43,6 +43,7 @@ struct erofs_device_info {
>>       char *path;
>>       struct erofs_fscache *fscache;
>>       struct file *file;
>> +    loff_t off;
>>       struct dax_device *dax_dev;
>>       u64 dax_part_off;
> 
> I wonder if it's possible to combine off as dax_part_off since
> they are the same functionality...

Hi, Xiang,

Thanks for the review. Yes, they almost have the same functionality.
Will combine them.
> 
>> @@ -199,6 +200,7 @@ enum {
>>   struct erofs_buf {
>>       struct address_space *mapping;
>>       struct file *file;
>> +    loff_t off;
> 
> I wonder if there is some other way to check
> if it's a metabuf, so that we could just use sbi->dif0.off..
> 
> But not sure.

It seems no specific fields could tell directly whether a buf is a
metabuf. But I'll have a try.
> 
>>       struct page *page;
>>       void *base;
>>   };
> 
> ..
> 
>> +        if (sb->s_bdev)
>> +            devsz = bdev_nr_bytes(sb->s_bdev);
>> +        else if (erofs_is_fileio_mode(sbi))
>> +            devsz = i_size_read(file_inode(sbi->dif0.file));
>> +        else
>> +            return invalfc(fc, "fsoffset only supports file or bdev 
>> backing");
>> +        if (sbi->dif0.off + (1 << sbi->blkszbits) > devsz)
>> +            return invalfc(fc, "fsoffset exceeds device size");
> 
> I wonder if those checks are really necessary? even it exceeds
> the device size, it won't find the valid on-disk superblock then.

Will remove this check.
> 
>> +    }
>> +
[...]
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 0671184d9cf1..671527b63c6d 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1624,7 +1624,8 @@ static void z_erofs_submit_queue(struct 
>> z_erofs_frontend *f,
>>                    bool *force_fg, bool readahead)
>>   {
>>       struct super_block *sb = f->inode->i_sb;
>> -    struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +    struct address_space *mc = MNGD_MAPPING(sbi);
>>       struct z_erofs_pcluster **qtail[NR_JOBQUEUES];
>>       struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
>>       struct z_erofs_pcluster *pcl, *next;
>> @@ -1673,12 +1674,15 @@ static void z_erofs_submit_queue(struct 
>> z_erofs_frontend *f,
>>               if (bio && (cur != last_pa ||
>>                       bio->bi_bdev != mdev.m_bdev)) {
>>   drain_io:
>> -                if (erofs_is_fileio_mode(EROFS_SB(sb)))
>> +                if (erofs_is_fileio_mode(sbi)) {
>>                       erofs_fileio_submit_bio(bio);
>> -                else if (erofs_is_fscache_mode(sb))
>> +                } else if (erofs_is_fscache_mode(sb)) {
>>                       erofs_fscache_submit_bio(bio);
>> -                else
>> +                } else {
>> +                    bio->bi_iter.bi_sector +=
>> +                        sbi->dif0.off >> SECTOR_SHIFT;
> 
> How about multi-device? I guess we should modify
> erofs_map_dev() directly rather than callers.
Will fix fsoffset on multi device in the next version.

thanks,
shengyong
> 
> Thanks,
> Gao Xiang


