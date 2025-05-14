Return-Path: <linux-erofs+bounces-315-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640DAB6085
	for <lists+linux-erofs@lfdr.de>; Wed, 14 May 2025 03:42:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zxx0d08VDz2yhb;
	Wed, 14 May 2025 11:42:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747186928;
	cv=none; b=LNjS4bzAVo32MkptA77fntnnN+WXn4IB+bSo8/mF+cmzHDBXWIzi1G+Z9YypBUMgWkaVuOu7i6PITKQ3GAW0MRBp8P3dlgn6wxeLEiJwLJbaAY8fI8Bx2lOvWUmnhrqHa3HwYt04vdF4eCQvNA3NxYxinrjqQz3H6t0nxdtPFRfyuMm7Dce+2BY+uF7NrdE4ASB1eyKgdT0QndDCYTQDi0PZfRsesdd0CUEMyVC1vhd41tg5aR88iKB3JOG8mCKwPEKmKWM77AjYvbom87Bp6P/VJMd9aXRejOvCuDAj2eY2TnJNl6apXgGGm91iX4VroJFBmD3qlzdczNnVMnl7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747186928; c=relaxed/relaxed;
	bh=82tOiKYSlWiRPbo/gDIQRfx9of4V2dOX4JgTL8C7ii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+7zjaE3LkboVmp62nPx9BwPVZd1bI8wSAX/XMpzkPBn/3Tp1HBW9zQODuZQF2epa50FP8I2QboxbDjHLr0q9tFXKzltVZ8PijPtM2s1ZTjflRpdq8CMVbjgJCFuHQrywa0JT29yL485HQEw1g5H1A4jQUardntqZEVObN89exhf7V1yOAOslLNW6EtntaOeKvvLIkUKQhpS6rknrHwV4T7Swq1nba3MXA9N0ZMRUqZ2hjfLeNdrGaFO1hHYAFDaw+kRCeuOlGwPyhUWtdY2tEuENsGgfBN2rLWk8C4/7ds20kMUN0MW4BYxc9/9zC/VFvYl57gbQreAWd0S7D5n1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kkI9awSd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kkI9awSd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zxx0b4b2Pz2ydN
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 11:42:06 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-22e16234307so4462265ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747186923; x=1747791723; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82tOiKYSlWiRPbo/gDIQRfx9of4V2dOX4JgTL8C7ii8=;
        b=kkI9awSdG3CbEra8KJk6PZXEgclvB1fFhtX9zbtNxD2ilARmaMHyTftxFRAinpd5l9
         R1Md/W8M4aa+cjWr+KoeuR6HsLePcswwurlt4D5Vywj26AaraHMJ71i+h5yuUu1UGhv2
         rW8uvdzIkhJTAsn7HFquRYl5QU05qPRNGmwt/ulI653G4SFbCOLeA6Kt7dqVw9sCM+T0
         8cbl1uedPVL7DA14Cy5Oj4WyQq9evBG94o/Hh8EgIkIH93ba7R7cRb2NMerFuCCyHO8n
         QdWpJsoCvq6pKvOEE82N4NtfOpp1isBKN69OCDZJdtKCWX78dWDb0MHZsxWercchLhat
         YGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747186923; x=1747791723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82tOiKYSlWiRPbo/gDIQRfx9of4V2dOX4JgTL8C7ii8=;
        b=W+FmUfMsPH8frI11QTAo1GsbCoXVsKL5VbjMyDQQON/rlnptKNPD42PKhq7Q3D2x/g
         TP+BqgRwuPc2AWhBhvLbu3MRzzVTKwlezMmHCsf1xJ6E+JkujTqWy9RLXrunrdj4NneK
         41UzkAHi+UEvAVfkY4Mbuq+RRXl3GL1PBUCsajM7CLxAzx7/rWxlMjuHCNuX3eEvn0hm
         atqfDXnIdPiGkKi5Y5bV0G8R1YgMWzk772oiZDX+f1M4dGAf+RxX15vjvLkybL2HHfjZ
         duWnQn3IcbwL7deePG16odp35kTHc1+xSz92FBW3tofpHoswQIgxwwoqaWCSIvzuvsLS
         Xlsw==
X-Gm-Message-State: AOJu0YwQmojbvwILBsOj1UxKvcKUwv2D0dbV5qaJmCKQy8eFVhgLoFPv
	i2Jr40EcCd0tX6wQvWPORofvs2XvLNtGijlCPmGWThKn2OUai0s+
X-Gm-Gg: ASbGncvT2aJImUfXeUKmD6QhHEwM9JhrCH+PjM8mSToRcwyqaSXrbD/RToPSedEvPFC
	9w7LBOAk7b7xUSJFuMHj4/SlyBZrcG22PaBVD5ocTeW5AuuvV5I1y6nainW5qV14Ou6Lg7iS2cj
	0Qi7uPze1+8hx6RDYHjsLCaXCHLzZgdJtoxhkkeS+99COkwXBqU2GKIVhIAZL1TRP6fL14Kd47Y
	OjAlbpGgBvzBc2wH59CodCyc37ABqWfSgBnO7POw3G41Fz5IBsdRzVhnobAF7QIvHQYbqMnVBDh
	yJjeOtXE2Yv/YZEk5sZh72xOVLHlhf2pHmUQRvTfXf5CUaDUdtOyibBFd8G3RgA=
X-Google-Smtp-Source: AGHT+IFIk7IJGw/uTRyIdBXZ7R74+M9tJir8t+7eJlq7ujoV0qWJhLnIh10ZuaUyIj7mBfGlJWXqbw==
X-Received: by 2002:a17:903:18b:b0:223:3394:3a2e with SMTP id d9443c01a7336-23197f92bb8mr22478725ad.18.1747186923276;
        Tue, 13 May 2025 18:42:03 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b38csm87518545ad.173.2025.05.13.18.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 18:42:02 -0700 (PDT)
Message-ID: <f62b0d18-f5af-4063-b644-f6b8069ca200@gmail.com>
Date: Wed, 14 May 2025 09:41:59 +0800
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
Subject: Re: [PATCH v5 1/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
 <a20ac409-f8a5-48d6-9e8b-3c40f829bea9@huawei.com>
 <a78509f0-f333-4a53-a618-2f05a53ff91b@huawei.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <a78509f0-f333-4a53-a618-2f05a53ff91b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/13/25 21:59, Hongbo Li wrote:
> 
> 
> On 2025/5/13 21:56, Hongbo Li wrote:
>>
>>
>> On 2025/5/13 19:34, Sheng Yong wrote:
>>> From: Sheng Yong <shengyong1@xiaomi.com>
>>>
[...]
>>> can share storage.
>>> +fsoffset=%s            Specify image offset for file-backed or bdev- 
>>> based mounts.
> Hi, Yong
> 
> fsoffset should be formatted with %lu ?

Oops, yes, it should be %lu.

thanks
> 
> Thanks,
> Hongbo
> 
[...]


