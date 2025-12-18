Return-Path: <linux-erofs+bounces-1515-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03851CCB362
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 10:39:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dX5Gm4DTmz2xqr;
	Thu, 18 Dec 2025 20:39:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766050768;
	cv=none; b=Bj65eYV06KGin1z8LPZjRCHC1GokpimPUXkvVqn03viCKtS0esSGgUT9AXXu/GpNXLB+gMB7fmadbqMbt6V2TTR0mmJbVL3yCoFrPrXFtRg4NWcSeC49l2cC5ZAsdHAzMSiUrD0ZF7NfvX6t48DeGlbhwjNRU/bHSFu0D3WXQmFYuIWJIMtlC8iqdTtJ5YHdoZBn1HCA68Lr75uMFsw1L6ojqP4cvXdbW+hF4K6os+FpD7KI0PqM8BxCN6dRkYXyP24vn6+v0Z9KOEmwXnURl78v17SytvpNE1mHp0D8fb4EntxFZKIj/L7v8IiZqk34HQ4Mq5uA/dOwKWZ7zCNiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766050768; c=relaxed/relaxed;
	bh=jyUurced2M47LBIgVGQ9fwM32yM22XERanbWaSOApyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NnA5fdKVECxjMZC+KyrYA4BE2/KCSPDPYKTRuegGBVt4qETA3GdD5OH4lvKjAgS4jy2pmzKH8l2E1JOd+vV4QZyoO4gQzWOWMF7Yabu5aNyKBg8tRtBO2ZvnzebAtX72HKFMHswFESTg04toUneDbUA1GPcsAQhXG8+cjM5n4VgAzpTD+B/ZYWhGZbhbTiiaUYAry7qnIvQxhK/gWeWO8tj5Jwm4TOQ5rcqN9L3E/cGKjK8IeSWV6oERk/Nuy67dYuGcXwhd4KoA4PIjIXE75pHlcRUCcv85qTVay8+dGNl4G/6ino6T5DW64/SBhbD4g+pI8QIVVOb38QiRLCPPQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0MvNszeE; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0MvNszeE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dX5Gk2xRbz2xqm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 20:39:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jyUurced2M47LBIgVGQ9fwM32yM22XERanbWaSOApyc=;
	b=0MvNszeEaGdrn7ywBe5HLLB7qxp9OXqc9OVR7CZY8O4Va0RzzvvWSVGLytAFF+cRuo8gQif+Y
	RNnWVtvnwv3IDv2179wIuaKTLgE6FpYxN4Cbu8AzIKjx+GHXFNYZzn5D7+uCNebI2+R/3YHoW1u
	GbjMp9yJec42a+eEgsm1Brc=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX5Bx5ywszKm6G;
	Thu, 18 Dec 2025 17:36:09 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id C256C14010D;
	Thu, 18 Dec 2025 17:39:13 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 18 Dec 2025 17:39:13 +0800
Message-ID: <74f84d5c-d81e-4a94-94ff-d3b70faa8578@huawei.com>
Date: Thu, 18 Dec 2025 17:39:12 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to
 registry
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <hudsonzhu@tencent.com>,
	<wayne.ma@huawei.com>, <jingrui@huawei.com>, hudsonZhu <hudson@cyzhu.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
 <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
 <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
 <b1a8afa4-c297-46ca-8b0a-b96e60bf09f7@huawei.com>
 <333670e0-cebb-435b-afa2-ce0e3191a173@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <333670e0-cebb-435b-afa2-ce0e3191a173@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,


Could you please consider these two patches?


The first patch includes unit tests covering the modified parts,

while for the second patch, I added some simple smoke tests [1] to 
prevent regressions.


As we previously discussed, I suggest handling the documentation updates 
in a separate,

subsequent commit—since the entire `--oci=` (and also `--s3=`) argument 
is currently

undocumented, not just the newly added `oci.insecure` option.


[1] https://github.com/erofs/erofsnightly/pull/2


Thanks,

Yifan Zhao

On 2025/12/2 18:41, Gao Xiang wrote:
>
>
> On 2025/12/2 18:28, zhaoyifan (H) wrote:
>> On 2025/12/2 15:40, Gao Xiang wrote:
>>
>>> Hi Yifan,
>>>
>>> Would you mind updating mkfs.erofs manpage too?
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>> Hi Xiang,
>>
>> Do you mean document `--oci` option in man/mkfs.erofs.1?
>>
>> Seems there's no manual about `--oci` and `--s3` there? How about 
>> adding them in a new patch later?
>
> Yes, a seperate patch is absolutely fine.
>
> Since it's about time to release erofs-utils 1.9, so it'd be
> helpful to update outdated manpage.
>
> Thanks,
> Gao Xiang
>
>>
>>
>> Thanks,
>> Yifan
>>
>

