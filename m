Return-Path: <linux-erofs+bounces-1716-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E4D01D6E
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 10:31:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn05b56sTz2xcB;
	Thu, 08 Jan 2026 20:31:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767864675;
	cv=none; b=FpZOPprIesg9OC1wRMXIcDWSlUREZFVX+Gi+dbccf7LNXBgKzkMy8L/dTWH3GpO0zx698FgE4RmuuQQRU83K6xqJvJ3VKe2RWIFAwIw+HRxhDdd1qTgek+PVWMdcZfeuKIIkOS2xwYvYVV4/eqA3eC5rWI/X11q0Oitq+QlnU9Kdb+zC5IgDSNjCGe2hGCiL1CN05Pq7ULWJ3Y0AjhVnwv/YrPx7RRLkkWaybFkmBVduaIUN3N8SQC5P7Tg9Kf5Ot2viloXIyuiRdqG+1+5iz7W9NmnjQjWqistVfvT6jLTpDzvl+xolOb7uAkHzonUzafyXnX27o14CxMHvr1vLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767864675; c=relaxed/relaxed;
	bh=2BZj+c9peL3DJDhE+3l/bTa4UM4O6gj9bpwLXw91wmE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZY2rTGKjno0Zitxw27Wr0ZrBS0NIqB+R/9RYXb2bwcIwRr4YFTc+uzpO8eHFexhYZHOj8mPfC4elsSjpAS4jbTMHv8cpOuZT917aq7XIet1ER4miukWi6KY/KhovUOaVmy203jwDga/MN4M0iQ9FgOnfO7qlMBJPfcrz6JhPeAfk7ytxwNe3a90QOgm77CmFGY3PGkVgDWMwn/9zr1DDsKjNSpLsC3nOMFmosPbBmC05qu4f+HQROMoU5mFz5GUSOUxo5/Sj9J9lxRrAbTy32JTrZV7OV6imGolCZeyztWexpb9NJ+O6G0nOOsH4HuUfHVTmr5ME1X3C6LHv3NzKEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jSc9S4lH; dkim-atps=neutral; spf=pass (client-ip=209.85.215.179; helo=mail-pg1-f179.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jSc9S4lH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.215.179; helo=mail-pg1-f179.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn05Z5r2rz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 20:31:14 +1100 (AEDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso1269766a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864612; x=1768469412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BZj+c9peL3DJDhE+3l/bTa4UM4O6gj9bpwLXw91wmE=;
        b=jSc9S4lH0dELitFpzd+/nO/JurL/CtB9NzoRbRebpDK5qsmcsxjvq8OpcDl7d5d2XP
         1LVYNej08V7yl3trX2Mhaztmrv+BqMzEq880Hv/uIK4x/LGjEse7ExBEuEiz/3phiJCL
         WfTVKkX+EdTtptmd4EG67HvSThlcfSYmbZidWNa//4AzE4MBdRY+2d/GIHMmqZuh4gx4
         cugpX9d/1NibgOs86TFYTtmGr4OrmwStJSUiLEUnUbYDNAmfTDb2UnYieEqfI3PXgD3m
         RKc9+grLVpb21oZUdx8wd/IwQ3WIXCuZtu98jsroa/gSWy4hnCaUMsCZZNYVYtV1+t5m
         6eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864612; x=1768469412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BZj+c9peL3DJDhE+3l/bTa4UM4O6gj9bpwLXw91wmE=;
        b=IcauduzKDEo3Lc3epyOAq0JnUgYmx7hV84BRN04b/v/2Q1DrMjjqmFe6jtNqztgkOV
         1E9V6AygBANlYgZ3sN/BqFtgpprcKyx/c1HeLovT2OrNd1GmAO0BcGIe/Q9KCSdgwNso
         BsnAbNX+uAdeu4XnKmWbGsERI1dr2/PBNXgM2+wR2gB/rN1wwxF+JyUgwCcoZ5yUbuJF
         3SO7ExiXF6KjzYLiItPl0r9Pam5Zgbl7TIASZcX/xbk910z9YtqKHEVm5wrw3xYcrexn
         bwepZj5ihyhC3Zy1cbQjvT0z39+G9mo7igZILJ4s4nrdVtxcywZsi3B7gjMK7Hu+8n86
         9KOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzgN4xtdQFOu1SZJCgmkXlZgHvz5dqmhxqF98e7wCnCmEQkRhewHe+PoQsqYwdEKPxJFqLCc5Cw2cy4Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwB2mRRZLrEvfP38tXWXsqXLDa2XM1aVQUFWG9H7D55G9ECOsZR
	oIjdZzMjFy6Q3Z7F0kGXXMFRBGu5wq2AYIzaAbOTRy0VUl0P6uAo9Cwy
X-Gm-Gg: AY/fxX5Ve8rRExNkERYJ9IZ7kyYx1bg0UfMpK2gAnSq/dtyjWuQAmVY0p6jYiVKA09H
	0Fd+gjwvUdhbbnUIU2+LwFuxxdIKSc/BKGel8T7VbMj7MsSSMLt3n4x5ABScA9GxZ4m/XXV4SNQ
	cEanyJNx8cXFvELgYwr9X8Wf8/1QYCCCELiiiraIpXtnWpWrIOsaCOiWjg7gSpghmXqYZmqa8zk
	ZnJO+wrEuaOPAE+X9DIHboRR546y62nuk1PTv7dn3GII7M/dz7M+27B0cbXKf/3/pLuqIYqKz53
	fd63AslcRRNmWN394hCLo0TQxcpORpXi33FRILX+lTx/kHxTCSrRrAz15zGJietFfpEKWCPQ3/c
	1LvSPR8yQyphFSDNGq4VpuYcmyzhnoi6qy3CVUg8XLrk3H46KDm6bldhRJCjaNyNmgpQhkU8M1M
	fCCtrxUQZx2CAdpja+YB3LGQ==
X-Google-Smtp-Source: AGHT+IFI05SxiqzyVxrtwlwkOSyv5QgkYxJTLKrxiL89jyMTQiggaVXS4Xp6MUQnnRzRml9tzxON7Q==
X-Received: by 2002:a05:6a21:3297:b0:364:be7:6ffc with SMTP id adf61e73a8af0-3898f88ef78mr4557167637.18.1767864611947;
        Thu, 08 Jan 2026 01:30:11 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm7509050a12.3.2026.01.08.01.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:30:11 -0800 (PST)
Message-ID: <96bae224-c971-44f6-94aa-eb0328021bc2@gmail.com>
Date: Thu, 8 Jan 2026 17:30:07 +0800
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
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
 <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
 <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/8/26 17:25, Gao Xiang wrote:
> Hi Sheng,
> 
> On 2026/1/8 17:14, Sheng Yong wrote:
>> On 1/8/26 11:07, Gao Xiang wrote:
>>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>>> stack overflow when stacking an unlimited number of EROFS on top of
>>> each other.
>>>
>>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>>> (and such setups are already used in production for quite a long time).
>>>
>>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>>> from 2 to 3, but proving that this is safe in general is a high bar.
>>>
>>> After a long discussion on GitHub issues [1] about possible solutions,
>>> one conclusion is that there is no need to support nesting file-backed
>>> EROFS mounts on stacked filesystems, because there is always the option
>>> to use loopback devices as a fallback.
>>>
>>> As a quick fix for the composefs regression for this cycle, instead of
>>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>>> nesting file-backed EROFS over EROFS and over filesystems with
>>> `s_stack_depth` > 0.
>>>
>>> This works for all known file-backed mount use cases (composefs,
>>> containerd, and Android APEX for some Android vendors), and the fix is
>>> self-contained.
>>>
>>> Essentially, we are allowing one extra unaccounted fs stacking level of
>>> EROFS below stacking filesystems, but EROFS can only be used in the read
>>> path (i.e. overlayfs lower layers), which typically has much lower stack
>>> usage than the write path.
>>>
>>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>>> stack usage analysis or using alternative approaches, such as splitting
>>> the `s_stack_depth` limitation according to different combinations of
>>> stacking.
>>>
>>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>>> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
>>> Reported-by: Timothée Ravier <tim@siosm.fr>
>>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>>> Acked-by: Alexander Larsson <alexl@redhat.com>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>
>>
>> I tested the APEX scenario on an Android phone. APEX images are
>> filebacked-mounted correctly.
> 
> 
>> And for a stacked APEX testcase, it reports error as expected.
> 
Hi, Xiang,

> Just to make sure it's an invalid case (should not be used on
> Android), yes? If so, thanks for the test on the APEX side.

No, it's not a real use case, just an invalid case, and only
used to test the error handling path.

thanks,
shengyong
> 
> Thanks,
> Gao Xiang
> 
>>
>> thanks,
>> shengyong


