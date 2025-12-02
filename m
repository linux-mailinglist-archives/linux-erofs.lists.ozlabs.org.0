Return-Path: <linux-erofs+bounces-1480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B4C9B27F
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 11:29:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLH7V5wGRz3bpp;
	Tue, 02 Dec 2025 21:29:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764671350;
	cv=none; b=m1IPol/tI/AAopbVp+79FwCQOpHMNWIirhi+ydyEQKw6Y/7u3IC5u1SBQyfv5lq8v2VY3HJUDOg31S+hyYclfZdGky9f/5QBlHkBh6J8b6CFxtjEvYvlxclGjmleCEjOtLbUTaNQPTlBs7PVh6SpcFnCzNoyx/gnFMaYmZswnCbVGMcIngK8+f2piJ3fUuQ3yZJy4qy1tWulp8QDyRNMDOjKyn826ZPRh/ijsK0ufKYYl+OHumsNlVPQ18XNF7SwFoN9Gfde69HBLe1cRPuVfBbvpfXqkW7lHEKETzQCTZz3ZpdCzfW5b/xT1A9nse9flv9s2VsKFX+7n0EgOhSi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764671350; c=relaxed/relaxed;
	bh=7XcbNBJ8bLAZYGVtd+CSZkSoq70R/TPXRQ4333M80og=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HxRdrHP/d3Cw3O27yJnDxOgAFP1aHyijHXSBOzddhJVBOJN9DDT6tw3JK/SDrHRv/nap0RdObrbGXDh08undWUMGVIteaiKSBWHGz0g5YXcE98pNMQZlL6318IGMaNn6Iuay/KJM0j1+ZxBcF0RFIDV8uJcyRF98psBdxV8LW9zTOPLd6yn7i216EErW8g/8MMXes5ixtHA/UqcB+nlYNkXDGzsBw5CEx5eZUZASCtBRbiS3mZ13p53BIrWmcj5afX73fYaewC0d3qkSZ0JGqWKHCKpTecO+9Ay2DCTRibYO2LjMDPnXRPxxM0pq6U7j5kchPzuOF5wJ62dhub/D1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R+j69Y+8; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R+j69Y+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLH7S2rpJz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 21:29:06 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7XcbNBJ8bLAZYGVtd+CSZkSoq70R/TPXRQ4333M80og=;
	b=R+j69Y+8B0aX91IiFQNGEqzcLdo1wHRY3uwbfsqYKswDrkePVNIsUsLORXZPA7vaBmvnIneG6
	GnUu/z9ae1kw5QIxa4DmvYxZp5n6KeRFJ0VrwKAAM+6BMyean0ih4w7q0FxV+9mrpchB2dm3g7y
	c4gvq+L6T8lSoRUrJLPudr4=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dLH4f5WxvzpStQ;
	Tue,  2 Dec 2025 18:26:42 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 809A91402C1;
	Tue,  2 Dec 2025 18:29:00 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Dec 2025 18:28:59 +0800
Message-ID: <b1a8afa4-c297-46ca-8b0a-b96e60bf09f7@huawei.com>
Date: Tue, 2 Dec 2025 18:28:59 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, hudsonZhu <hudson@cyzhu.com>
CC: <linux-erofs@lists.ozlabs.org>, <hudsonzhu@tencent.com>,
	<wayne.ma@huawei.com>, <jingrui@huawei.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
 <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
 <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/12/2 15:40, Gao Xiang wrote:

> Hi Yifan,
>
> Would you mind updating mkfs.erofs manpage too?
>
> Thanks,
> Gao Xiang
>
Hi Xiang,

Do you mean document `--oci` option in man/mkfs.erofs.1?

Seems there's no manual about `--oci` and `--s3` there? How about adding 
them in a new patch later?


Thanks,
Yifan



