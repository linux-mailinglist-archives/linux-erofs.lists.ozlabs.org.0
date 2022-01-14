Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443E48EB94
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jan 2022 15:21:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jb3PZ6vYRz30H3
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jan 2022 01:21:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=g60dh5/2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=g60dh5/2; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jb3PR08l4z2yyK
 for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jan 2022 01:20:56 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id
 ie23-20020a17090b401700b001b38a5318easo14245927pjb.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jan 2022 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=FWA4Yk5Y0Jcg68gewVhtCzAhox+VDVaZRIZAXDWpBl0=;
 b=g60dh5/2MzZ82VH9X5vzasWMnCZJExJdAfNmW6efH1OhAOCsLBc0xmJb2d7BQ6IHuj
 lYCXd5qnr8Wa7OEe7j+my38kVu222f4HiuW96PKxsU/+xIjX92bwHbuQ/BEOxtHIYAr1
 zkbBuhyP9as9B7nPA4p0OCjtexWnOA8NtYn5wXjBFDIdFxZQwykuvzJlkQ3zRD1Jpcke
 QtzVszHGQ9RW5xqmOTgmP8Et1zBenWr6C5Kq0QwbgMXzMJK1Wu57I2NKLMsTBLZMMh8/
 wVdHpSkL+NjtRDJDPXYx1VkDiv/Q2gHykoYnL2fObobKrPimZEo65dCtg0SbvjApXx10
 u6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FWA4Yk5Y0Jcg68gewVhtCzAhox+VDVaZRIZAXDWpBl0=;
 b=sZ2YaH8FAX6njgtoiyA5yTiL4XuHsXWkXJ5aWRRkQy0saJ6o1LePbhMHHJyugumv6R
 42l+asYBYgfefu4ImQex3do16oSvmF3UzXUwso7A7LjguUKQmz9ywZRbJaprfGFSIyDs
 MQFg3ei6Gu8pLDELN6ezgRuP4a7Vj/ZzH2x5tgHJvBiv4SQF47lMZLrFe1CE/q2j9uDf
 Puo72LOmHe5ffVqeZpt7Vjz3BRayMs8xoKNzeVYrhuMmM143BEOx7o+tv+/G4ZgLDuJC
 4jWn04LpRMA++gBlPvEkXd9SN0e4SLEW3ehDz8kcvsXpoc6Z0LvHZBs0WSA6RuYlKsux
 Py1w==
X-Gm-Message-State: AOAM533w0P8DOEIspnzezVhF38NCR1Db4wGwSLicnC5cw1bfjTxGAxJR
 lpNvUkzixWtgFxJrnaGMUNw=
X-Google-Smtp-Source: ABdhPJwh8LooMNvlhocZpSRYGt9xgpUuOwkIShQB4ler+yHQbAI59GAjBloFq3IQyGb4rm1OIUK1cQ==
X-Received: by 2002:a17:90b:4a45:: with SMTP id
 lb5mr2611999pjb.220.1642170052679; 
 Fri, 14 Jan 2022 06:20:52 -0800 (PST)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id g6sm4804961pgk.37.2022.01.14.06.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jan 2022 06:20:52 -0800 (PST)
Message-ID: <0feb9212-f515-62f1-033f-a4af78241be6@gmail.com>
Date: Fri, 14 Jan 2022 22:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/3] fs/erofs: new filesystem
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210825224042.GF858@bill-the-cat> <YdWHxPMyojsdcg9v@B-P7TQMD6M-0146.local>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <YdWHxPMyojsdcg9v@B-P7TQMD6M-0146.local>
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
Cc: Tom Rini <trini@konsulko.com>, linux-erofs@lists.ozlabs.org,
 u-boot@lists.denx.de
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/1/5 19:57, Gao Xiang 写道:
> Hi Jianan,
>
> On Wed, Aug 25, 2021 at 06:40:42PM -0400, Tom Rini wrote:
>> On Mon, Aug 23, 2021 at 08:36:43PM +0800, Huang Jianan wrote:
>>
>>> From: Huang Jianan <huangjianan@oppo.com>
>>>
>>> Add erofs filesystem support.
>>>
>>> The code is adapted from erofs-utils in order to reduce maintenance
>>> burden and keep with the latest feature.
>>>
>>> Changes since v1:
>>>   - fix the inconsistency between From and SoB (Bin Meng);
>>>   - add missing license header;
>>>
>>> Huang Jianan (3):
>>>    fs/erofs: add erofs filesystem support
>>>    fs/erofs: add lz4 1.8.3 decompressor
>>>    fs/erofs: add lz4 decompression support
>> Aside from what I've just now sent, can you please extend the existing
>> py/tests/ to cover basic functionality here, ensure they run on sandbox
>> and in CI?  Thanks.
> Any further progress on this work? At least sync it up with erofs-utils
> 1.4?
I'm still working on this, the new version will be sent soon.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>> -- 
>> Tom
>

