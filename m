Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 606FF934434
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 23:50:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A4bdWKoP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPV3V23tBz3cXL
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 07:50:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A4bdWKoP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPV3M31Cnz3cT7
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 07:50:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721253000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ayWUSpzPDksInpWBKyhbJM2xt5VQIyjhpxP07mk9mOw=;
	b=A4bdWKoP1nlQG2KoJo/ZNQB/0/Qt15PJ8OpXHQ7fkY7KdWL8SjNMT+mrpTeH+zM5DpYzOgiyyqcWNNhP2D1/W0HftQrM1shcWPozwsS2FCrVb+2WIfLuwau2xfQSjmOdCRosWDqopyZAiNFUtEyoZdPyTCCon3nxO9R50doK1Tc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WAm-c5g_1721252997;
Received: from 192.168.1.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAm-c5g_1721252997)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 05:49:58 +0800
Message-ID: <15929409-cb08-45dc-ac5c-4e3017482498@linux.alibaba.com>
Date: Thu, 18 Jul 2024 05:49:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue of erofs use zstd
To: Sandeep Dhavale <dhavale@google.com>
References: <0a71474744854fcf967e99666e8eab38@xiaomi.com>
 <f630cbad-d653-44e7-8d31-3cbb90899401@linux.alibaba.com>
 <CAB=BE-RKg1sV7BdCOQi-q90U-EdepBYVE2JXGurrbQXD+DLgZA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RKg1sV7BdCOQi-q90U-EdepBYVE2JXGurrbQXD+DLgZA@mail.gmail.com>
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 04:11, Sandeep Dhavale wrote:
> On Mon, Jul 15, 2024 at 12:43 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/7/15 15:33, 肖淼森 via Linux-erofs wrote:
>>> Hi GaoXiang,
>>>
>>>
>>> We just update the last erofs version, and want to test the zstd compress feature.
>>>
>>> But it will throw some error when using the mkfs.erofs making the new image, could you help to check? thanks!
>>
>> Please fix your own environment issue yourself, thanks.
>>
>> This mailing list is not used for discussing such out-of-topic issue.
>>
>> Thanks,
>> Gao Xiang
> This may be due to having multiple versions of zstd lib available in
> your environment. Please check which one it is linking with and which
> one it is loading.

Agreed, anyway, currently erofs-utils uses pkg-config to generate
linker flags, but it may have no way to what library version is
finally loaded.

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.
