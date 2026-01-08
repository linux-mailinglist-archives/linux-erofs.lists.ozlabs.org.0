Return-Path: <linux-erofs+bounces-1714-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060ED01D0A
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 10:25:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmzzN5Hymz2xcB;
	Thu, 08 Jan 2026 20:25:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767864352;
	cv=none; b=G4qYm6RCmoYB9ibOBP/wJvVHotuwMVAH+452NWrwvjFaCqUZWmkuvkDnPmlRzVLzguoWaSAuuJTeUKeRPTKVdz9+59cUxs287VnTToVD+2F4VU94jFGFvagBPDKVfxux1fiAqjROaSEZ5x7MXW67pnkCsJqGTboGqastV9BXlyT/WBqVaP8dBJK0U7vFSG2Xa5cGGb1joB9T4KSxiSdL0xLiXhuwd87xkQE6n01el3RwaVgy949JelGjlDqZENqVHHrGno7HWyZuv3b0szrMQKtMsFokgZiv6SyF/D9GGeoOze4tFa2IOp3p8F2DeFWifeD98u/jey3+OpNjeol1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767864352; c=relaxed/relaxed;
	bh=R81n7a/YK49HxVlPNyTqmXKfaVXMmyysflz3STjD8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaY2tsW+Thj/ZUle/kHBO7AmROnxPx/9xqccEJDuW1ZngCiVLhmT6BUWdCd0MF76hVEPbk7/2nZCaY7G5cSPrLEEdnZgDFDSpTfnq8TFu97xFmZEVTKZ6GudOYctwKBUIhn3QJ+d9q+YCtIwCj0vcI3Oy/WRnXHAJndqfj2KzKaHdp8pdGhMEd91ovk4bN61z4LPtkn5C5ccduP0uImpRyuJpSWm/mdjcL8fUcKoy2qTBAVS3pNgYxw/hMrytK8ge8DvmPznthTWsc004fxtkr9P8noai1u8COEpcDLHirM9HFLBy8s6QuLT9pgy19T0RydZcTle4fH9Hsy4IT5AfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H5LhsN1t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H5LhsN1t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmzzK5BFyz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 20:25:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767864341; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R81n7a/YK49HxVlPNyTqmXKfaVXMmyysflz3STjD8Zc=;
	b=H5LhsN1tw7hlIf8530PIFr/O9A8VdHpWD86xn80S4MDmYFeLkum8gkqHrE7gIdgKpiPQBVJ0EKH18ng0tcd5j61wsrtxPY22MoODNoLTuy/9n+PWNH5kYZ6ns56QTj6EkgFHRCXA1ckHchJ5kurR28IEtFgqxRcERoQ3ji8r0oI=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwc942C_1767864338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 17:25:39 +0800
Message-ID: <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Date: Thu, 8 Jan 2026 17:25:37 +0800
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
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Sheng Yong <shengyong2021@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: shengyong1@xiaomi.com, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
 <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sheng,

On 2026/1/8 17:14, Sheng Yong wrote:
> On 1/8/26 11:07, Gao Xiang wrote:
>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>> stack overflow when stacking an unlimited number of EROFS on top of
>> each other.
>>
>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>> (and such setups are already used in production for quite a long time).
>>
>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>> from 2 to 3, but proving that this is safe in general is a high bar.
>>
>> After a long discussion on GitHub issues [1] about possible solutions,
>> one conclusion is that there is no need to support nesting file-backed
>> EROFS mounts on stacked filesystems, because there is always the option
>> to use loopback devices as a fallback.
>>
>> As a quick fix for the composefs regression for this cycle, instead of
>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>> nesting file-backed EROFS over EROFS and over filesystems with
>> `s_stack_depth` > 0.
>>
>> This works for all known file-backed mount use cases (composefs,
>> containerd, and Android APEX for some Android vendors), and the fix is
>> self-contained.
>>
>> Essentially, we are allowing one extra unaccounted fs stacking level of
>> EROFS below stacking filesystems, but EROFS can only be used in the read
>> path (i.e. overlayfs lower layers), which typically has much lower stack
>> usage than the write path.
>>
>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>> stack usage analysis or using alternative approaches, such as splitting
>> the `s_stack_depth` limitation according to different combinations of
>> stacking.
>>
>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
>> Reported-by: Timothée Ravier <tim@siosm.fr>
>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>> Acked-by: Alexander Larsson <alexl@redhat.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>
> 
> I tested the APEX scenario on an Android phone. APEX images are
> filebacked-mounted correctly.


> And for a stacked APEX testcase, it reports error as expected.

Just to make sure it's an invalid case (should not be used on
Android), yes? If so, thanks for the test on the APEX side.

Thanks,
Gao Xiang

> 
> thanks,
> shengyong

