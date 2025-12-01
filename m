Return-Path: <linux-erofs+bounces-1466-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBECC95FE0
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 08:21:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKb1r4j64z2yvD;
	Mon, 01 Dec 2025 18:21:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764573712;
	cv=none; b=RqiJnEbso1LiKc05lPK6BMG+hMvzjAmK9/3jni5ede418xcjHGxAAz85myTLGHKGuwFx8Tt1X3MNcYWkhB0HzkFnngvlY9AdNbfdLZI6+6jUQrCaEfi+K17szV62e0YIZ0dxmW+fiolbLX6DUZGUVShfNcx1OQwR9l+mQK4n/cFeGtFVjf63GswCziRqLcI3bH1JkhHlDMHVjt4NbRaJXUjpdI/26p89vRnknTr11ydmE/kq0YzRK4lWqcQbfGIoza2NOXXlQlozwAYWtxrEen3tfjdIi6+XUwSXflwVkQGKmlAgAagQZaVajBUJafgUhHYCAH9sWjXUZ8FDmNpPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764573712; c=relaxed/relaxed;
	bh=1Fj+680NkjrL3M2RzeMallbPDvVp78sXyBn/GQp1DYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lesZAKSu8sfIXIvfKjMMZRHc9TrYqUu/S8z9Gzpe/UYeWl9IvrPSJbsrM9frHB+nl1sgHslU/UB2ymCOTibuWWmnJ99g2+9o6OEdK/XdNc9R36N5OzD6WsIt8K7FX1yJBGQsdB2YW5FzBnBp7Fz35XT4zpd3CQDi19jCcK2DZQ7zfFkHL9FT3NQVsQx6N+tT+1JigOstalyPmG9RuCYIXlOSnxuZ1DSWxFrWdw+QzoVxtZqHfehbQPZCFJvi7+2vg2ABm3tZ5mP6Z7j5yKDLTbMEkGvi94hFjrkEjy9OLAwoSv5UvFbz/Ao2oI7Hx7BCu+feFjcpdE0SJjxjwXxhgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Gc/6S2tM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Gc/6S2tM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKb1n18Y8z2yN2
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 18:21:48 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1Fj+680NkjrL3M2RzeMallbPDvVp78sXyBn/GQp1DYc=;
	b=Gc/6S2tM8FtpGAxszoFNLKwHbbHl7nIjq3lpvfgbGk8Z4LfZeJ385Hz+Ktd/vdNk3HjsXtvdx
	WK6m5Ua2PuPD1dhzy7Z1f98z/PNcscCSahZfsikayFE5/W2ikYD85plxsPHD3lRKDIlGid/HLJg
	blZeR2GH8rSA7TxHSjobuBA=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dKZyy0hq6znTVV;
	Mon,  1 Dec 2025 15:19:22 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id BDFDB1A016C;
	Mon,  1 Dec 2025 15:21:44 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Dec 2025 15:21:44 +0800
Message-ID: <0e9e01cb-6140-441f-968a-a520fe4e7e6a@huawei.com>
Date: Mon, 1 Dec 2025 15:21:43 +0800
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
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/1 10:38, Gao Xiang wrote:
> Switch to the permissive MIT license to make the EROFS on-disk format
> more interoperable across various use cases.
> 
> It was previously recommended by the Composefs folks, for example:
> https://github.com/composefs/composefs/pull/216#discussion_r1356409501
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/erofs_fs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3d5738f80072..e24268acdd62 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +/* SPDX-License-Identifier: MIT */
>   /*
>    * EROFS (Enhanced ROM File System) on-disk format definition
>    *

