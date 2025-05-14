Return-Path: <linux-erofs+bounces-316-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5537AB6865
	for <lists+linux-erofs@lfdr.de>; Wed, 14 May 2025 12:07:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zy8D72Vjwz2xfB;
	Wed, 14 May 2025 20:07:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747217271;
	cv=none; b=UF8Wg4Wxh3YkgoiLVeA8oh9gXy5bP2ZSg3pj9r+AP5hKFQh2u6THytUdNuY/PKT1XrAGt7qKmBa82sM8Q/Y7/lFle8n3P8B7QuAPS006GhjUr3Z+ZWP/KyVEwmqhaKO6CQyfTN/votidBDrcU6g5bb2rXSxhJqlDTMWOW3k+v8zpCe3CTu617TM7k60o88P1frEY/GQE6JrjJF3DSaV95FhUdDU1RfI9+vqcXTxqsEaVc98Z7ZBW5Oprduo+MmD54uaPu7D6u/mWeUJnMlr/ncCV8z9jak/kWVlgtNV8EkQp31Kp+nM7ZfpxsJnGQBs8mg4qGb+UpnwexnkcTZdaig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747217271; c=relaxed/relaxed;
	bh=hDwCtBv7jcsC4Bvyoe8GLW3Z1LQ6+e6P0xNNZskD4xM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=C0zly32GBxfbU4cGxJxWqni33CEDHS9MXB/YE3ewVzl5ZXL5O73+b2iDzmivDm09zAv2EBGBI2gklbmMmk6pZODUN8PYvv/F4WV/AvTkDh8kE/J39xzv8EOOc5X45CC2AayEWxKIy2DSA9hmerkGHcRaqPd2ip/35M+hWZOefxTOGuf0SYo8paq/fYZnRW25Ux5z1YJl4wluWBLTKpsEIWpIA96PQELtVMvxwSIEFnnlz3WxCia9s/HTbaShfwgcd/t6U+91ZlhppNvRPoJDO068Emnsi2jll99qWNpbD73Vz0tEgPWp5GxdD5mmscAwRYwP9eMbEE3pQN164eDtTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EHPiBrs4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EHPiBrs4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zy8D56DRzz2xWc
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 20:07:48 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3106561b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747217265; x=1747822065; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDwCtBv7jcsC4Bvyoe8GLW3Z1LQ6+e6P0xNNZskD4xM=;
        b=EHPiBrs48k11bUxIcsV0acRIBe9VpLDRJBNcwq3wkeHwr2EWi478InxY4vLI24pLqp
         H6wGzNWUDAyjq+2gmW2d1ZOJdmfEhdSapOKD3PaVvh3eQd1CdAT9JcDJuX2sHIXlPKYH
         iMsFheAR/zwUND0+YyPVdEnLvy3PdZ3dxz50159pGowNjbrvw4X4Gn9Gu/AkB9HMADS7
         +KVfeNw2XcNkxQ90UMq6Dv8KcAzvoMPFY5Zn0omGQFGo1BczJErG7m8UutXtEn5yYRHD
         iQLXB3k0MMJR6Liw8JTtpBl93uoJ9P5pvD/iUNMs/7wpDC23Q33bgI1dFAN7ptAcIGbL
         LSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217265; x=1747822065;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDwCtBv7jcsC4Bvyoe8GLW3Z1LQ6+e6P0xNNZskD4xM=;
        b=thEEqKvO0vuT5u1a/E+GtG2xo3PfgtoNjMAEnmrg3Ivp6S6kKFYAgDuLUuo6LjjYIo
         hVKrLkUeGoMof1XhOnDbmnitwtiv2JFqAVTM7l50eVOffWOk+3/Rp4/luf3tnSfTFPv7
         ThkMAEoj2UN3P/00qrBiq59nwgfe9sqrSx21HFZ/O+Fydq0jS0W3FV5OsMiMDVtoK3HW
         kpN8NNcP/IiJ6c4viM8DvVt0um573Nu5sIUm9wmW6y7WHhTMu8GU54QCO9l2XGm5RN/1
         RlqLYuc+0agnr1/eX0D0MVjKJ9UjnR59VlXbHk/qgRdAIePnl1jr6YjSj1AYWQ60K57a
         8MNA==
X-Gm-Message-State: AOJu0YzUcsH1YLYg+EFCEgYaVdhNwzE7G+xPesWNhMtcbjYWXf3z6wyi
	iyYhN4GDvW0lMPU/qpoI9YAjyRlUDe1WH94om3dirieIC1qBh8SEldkUYw==
X-Gm-Gg: ASbGncsMRlxOeioyW782FrLkxyqpVmn0s7bTgsCcdROic2dK41mvbRdUjzsbkaJZ53w
	4JHbMPOBSXd+JSxfYfShWlEKcyPKZHEiDkXoXx4D+dmIefI9pkIiJEN1iI7Gehld0xN/QR22MA1
	OWkNXKNRyxvY2AcwE8TmZ8uetzfUK3T8oBq7RDyKjOuEzNSa8XBE7rCyIejuFS5msvxIXGDWSwQ
	3z897TnMYx1OeefzfDNJ/gPSvdlY/Ht1q3VDARSoSFQGsMo8LuZ8aioXK0dOtL1MI0TH2O34Ixw
	MqP9ksudUw3lfpzFrW1tt6mQvW453yAb+Lrfk8YSKLjRcR7G5Tx+gcRmV8XSt10=
X-Google-Smtp-Source: AGHT+IFZVByNe824O7mf/nqzzbTZzdR34wjJ6WuFCcuFqNf7ujVr2Nbv1wA01Dli/o5sLqM2uRarhA==
X-Received: by 2002:a05:6a21:7a8e:b0:215:dfd0:fd1c with SMTP id adf61e73a8af0-215ff191124mr4557606637.29.1747217265011;
        Wed, 14 May 2025 03:07:45 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33482fd3sm1176238a91.37.2025.05.14.03.07.43
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 03:07:44 -0700 (PDT)
Message-ID: <beab668e-d06b-4da1-bf76-e47efac9d85d@gmail.com>
Date: Wed, 14 May 2025 18:07:42 +0800
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
From: Sheng Yong <shengyong2021@gmail.com>
Subject: Re: [PATCH 2/2] erofs: avoid using multiple devices with different
 type
To: linux-erofs@lists.ozlabs.org
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
 <20250513113418.249798-2-shengyong1@xiaomi.com>
 <c02f6e33-6788-412a-8622-49364d67d369@huawei.com>
Content-Language: en-US, fr-CH
In-Reply-To: <c02f6e33-6788-412a-8622-49364d67d369@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/13/25 23:10, Hongbo Li wrote:
> 
[...]
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 512877d7d855..16b5b1f66584 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf 
>> *buf, struct super_block *sb,
>>                   filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
>>                   bdev_file_open_by_path(dif->path,
>>                           BLK_OPEN_READ, sb->s_type, NULL);
>> -        if (IS_ERR(file))
>> +        if (IS_ERR(file)) {
>> +            if (PTR_ERR(file) == -ENOTBLK)
>> +                file = ERR_PTR(-EINVAL);
>>               return PTR_ERR(file);
> 
> Hi, Yong
> 
> Thank you, I think it is indeed a UAF problem. This fixes the problem 
> introduced by fb176750266a ("erofs: add file-backed mount support"). How 
> about considering adding the fixes tag?

Hi, Hongbo,

Thanks for the comment. Will add a fix tag.
> 
> In addition, I wonder may be we can only check the fc->s_fs_info (we can 
> set it to NULL in .kill_sb) in erofs_fc_get_tree rather than change the 
> error code. So this way we can reback the correct error message to user.

fc is not available in .kill_sb. And in this scenario, fc->s_fs_info is
already set to NULL in get_tree_bdev_flags(primary bdev)=>sget_dev()=>
sget_fc() before fill_super. So we cannot use fc->s_fs_info to indicate
the error.
Since EROFS already handles case of primary=regular & extra=bdev, I
think we could return the same errno (-EINVAL).

thanks,
shengyong

> 
> Thanks,
> Hongbo
> 
>> +        }
>>           if (!erofs_is_fileio_mode(sbi)) {
>>               dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
> 


