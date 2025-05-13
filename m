Return-Path: <linux-erofs+bounces-308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837AAB53D4
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 13:27:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxZ2X62MYz2xWc;
	Tue, 13 May 2025 21:27:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747135652;
	cv=none; b=fQAGv5/o+XHVzeKq1FXn1p+EtoGuP0x/m3xREKkLaPvAjYEydBf8FAICEP1JbFhv0LbaJzGKBiSidsc0hynO//dL6TQuUSf3ondacrbS6yNqXUYMjuAhDR4sadWejss5aYTULAyBQCMGFC52dyPQeMfx9qF3v8XoRwbfJ4FJmP6bKCBUrBECCWwdHeKy0/FYuKjI3fqmvxW1MsXp/2vNVG9rGDAPhdmgrXfuu1WLZhOxMbWJCR2bYq7tWTNEQ54/EOVOrdMEkTSktk7lscuSCj+ENy7qa2q2w6hk1TOdJRxV/pgnWZ7ttdB6uUo6mWxhgMNHdPcCapTD44cAPWiqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747135652; c=relaxed/relaxed;
	bh=+WzS+061KZbqHJHukj1CgszBBux+L9XmYCZ3RhOiE98=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MrRNwxYZLYx8vHB1BBvcJhKKkVD4bO/2HaBC6W1ThLN4QuzVNhIMO8Inz4xXaZysWut/jzRT5OXOqYhQYWDZwnBunEugisAeM6furx2wYT1TqcfuN+3AWQpLXXJZ0GRwGbksicbg35f84aVV2PRWebBwVCJKzFAT+x4G8al2/v2aBZJASNqnKcBp+tXNWm52kUl6lbvJ7sttTMfD93FEk5ThtVwnQjvX2XdripRjT24DW7K6AISKYHslmkCrQzzDzNLRqIvpbGbWdqj1MqtrIzw/LoDBMlhk1Ippb6yW1DMnTxKpNVyS2wvhrhDGcDxl3hmu4MnBer50gJJYM39u/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f+R6eOww; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f+R6eOww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxZ2W6SL8z2xVq
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 21:27:30 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so6348744a91.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747135648; x=1747740448; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WzS+061KZbqHJHukj1CgszBBux+L9XmYCZ3RhOiE98=;
        b=f+R6eOwwAnfPl7K7r0voTT69GTXI2NG/iw88OhNcyWY44xT9LKgjBYEUTOYtlWSRGd
         nTvXvDgcOZjeZVp0mTq9eiIxsqBfgX453fR//3OQszUHcpReA2cnch1l4aEHzdVQ8wwU
         /fNwQTQyxdIcwEmfpJQW+gqDIwzMQXWRMYp+nQZf47ISU6AL/pOhPNAhC1krwmKyxoEK
         QTooUnbUo1xns7kCwCAQfF39hftPd1AI9nh42RmcS3J9QJH2L1X2ufuop0SpBlwZOgUp
         GOLv5JDFfCtFU489jyyNuJn+aqlRFfLOyRLLh3BsCAXu8kedLD0rjmpGKeM8ShFqY/Vi
         a6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747135648; x=1747740448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WzS+061KZbqHJHukj1CgszBBux+L9XmYCZ3RhOiE98=;
        b=cFUmsTfPCwNvkZCJRdisbbcvS9fSOpxkTXVnKUqNGTlrzs9CZCpsP7K//ZWWZRz8I4
         VjntpKQ6DwwGv8X918rpkfnVZwzgvLTv2WIsWDVS5bfj2Cj+F2sjifkcrO36nUm+WP3t
         Fmq5OS6GKbD92JqUXtmTeerZpTNovBvnW+AQGx5p6qN6cY405QYKSQAibm0jtqrVSbt+
         gTT/8mPVcdLomdL9L/tqMhq9zZbzjitccGJhCj6i+55rkNzISDJEAMQVgo7xTsB2tzQI
         cdZhEowDOA31mhqjIENv/UdogwuOlzQJ6zOVs+W6WLmytl46WaR+i+MWT5AthMDSbkz+
         wEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmzvawLGb9pHx6K/KPD/zWVyFjwh9W0eM0e6H2k7K5ivee8jcIpN3fwVmA55aS380oCNafJ+RLCcyCYw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz+iNgDa0+VgLhfOLJqplJ9nm8SrfknQn2fkWxVcjUQdhQwI4cz
	4XacO4H9OU0zZmd5tyzZGaQpISY4mFThPBFlisagQeVAazkk7mal
X-Gm-Gg: ASbGncvYExz26J4PWftNDJFlhD5eLneDEVGA+1WpE+MC6Q1xe9MxGcgoGXdTzz66Z9+
	rAlqlZCG4BeGCTcQ1Rb3yvz95kIUp2FNe6cQMKcFASfTYZz46uBcTJdyu7YNmtq+etIdCIth61B
	8E7dnIm6QJJhdHz6f9TsT3o1Y0UMZM/AEIFpb4cUQipJRvyIavipOKTuhMM3wr4vZgOQpBkBX8l
	p/dYDVNRex+XSYCnJu9zb2NtKeO2Q5PD6xou8yKv2hPErfuL6s7jT0MTbhLjZSjrp+vXq6yhn2s
	5OMgpIlkb9upwjCom0knwlo6zVmQ4ItPtMl2QfQrbtr3+sz9Gx9SRtHPt4cHX2R2wQvJ4OLE4A=
	=
X-Google-Smtp-Source: AGHT+IFS1Eor0FFmhj4uPSY1y/HkGaln0Sy/2YWp+Kyd2uby3lMtvFohuGkQ0U2ElF3N2jKks4dCDQ==
X-Received: by 2002:a17:90b:1c05:b0:301:6343:1626 with SMTP id 98e67ed59e1d1-30c3cafda39mr22744537a91.1.1747135648123;
        Tue, 13 May 2025 04:27:28 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e60fe3sm8208255a91.32.2025.05.13.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:27:27 -0700 (PDT)
Message-ID: <68236af8-6302-44b8-9f6e-d0228bd40b61@gmail.com>
Date: Tue, 13 May 2025 19:27:25 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongbo Li
 <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
 <20250408122351.2104507-2-shengyong1@xiaomi.com>
 <4aced850-18a0-4b05-80f4-4f690e387a13@huawei.com>
 <c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/13/25 15:17, Gao Xiang wrote:
> 
> 
> On 2025/5/13 15:06, Hongbo Li wrote:
>>
>>
>> On 2025/4/8 20:23, Sheng Yong wrote:
>>> From: Sheng Yong <shengyong1@xiaomi.com>
>>>
>>> When attempting to use an archive file, such as APEX on android,
>>> as a file-backed mount source, it fails because EROFS image within
>>> the archive file does not start at offset 0. As a result, a loop
>>> device is still needed to attach the image file at an appropriate
>>> offset first. Similarly, if an EROFS image within a block device
>>> does not start at offset 0, it cannot be mounted directly either.
>>>
>>> To address this issue, this patch adds a new mount option `fsoffset=x'
>>> to accept a start offset for both file-backed and bdev-based mounts.
>>> The offset should be aligned to block size. EROFS will add this offset
>>
>> Hi Yong,
>>
>> Why the offset should be aligned to block size? I mean, we can use the 
>> original offset directly during read, and then add this offset after 
>> reading.
> 
> Currently metabuf and bio are all block-based I/Os (otherwise
> taking metadata for example, it could cross page boundary), I

Hi, Hongbo and Xiang,

I agree that "we cannot handle cross page/block" is the main reason. And
for use case, e.g APEX file, to achieve a better performance and make it
easy to extract filesystem image from a APEX file, the fs image is used
to put at page/block-size-aligned position.

thanks,
shengyong

> uess it's complex to support unaligned offsets.  Also it seems
> lack of use cases?
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
> 
> 


