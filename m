Return-Path: <linux-erofs+bounces-237-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA66A9DEC2
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 04:49:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZlWJc4jVBz2ylr;
	Sun, 27 Apr 2025 12:49:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745722192;
	cv=none; b=C0BW+IjdCf51FuATW8Qa2Y2as9efhMX7NENR8MuHSEtG2Cf4zlpLLBJ9RZtHojP3iTZmrPrS7XpzLnLeFPuTTu3OWeqfhqIKt4ztXMp70ybeUOr5gZsIZcCD0Jmw2cuFte7p5uYRKyg0iyyGBMBlc4QyNDl4VztoEk5xPLWQmtXKpMtJ/VzZEu0682aBE8WToUEZP/vGi6MUiLyWBIX3iQUYeNvj7tx4saKP92yhCqOyJI3akQN3SeADygzLpeyZnbR9X2A/YbeLG9wyA52clkNFczqMV51BQaWnTnkPT/AbWnaYimSoH0vIthRsDKhclhZXdHeDx/6g/RzJAe0VKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745722192; c=relaxed/relaxed;
	bh=fWKDRLUn4MGeTPGx5wok3Pyc4TO/YrYIknWLDhx9GVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QquRK2LtjIiD6HPW+2j5y1GlIQIa9/am089NTjaIkRwpw0eaKaZVBMEjGz0ZRd4gy7aWiRtl3a0d0OOpX31/VtCX5WJJXftuyxi1rsVKxZMEjKBGqOdOh9EDG1gktw4+RK85t0n/926B9ULEfjNuRb29dZLxXkYjCA/rJrSh3cDSCzfDVAYFMMi196Pd6b2opvX2JAUPXKrT7XbkqSH7WZ+5JvkiFSycVgvtjmWoozX7voao51+FBDJZmHxRh5imtFxEjenHxlQT5Omfk5wTDemRnlARrh6/EFJf6aufgoiDSdVLFAbVVWJyYpM94J9Y7GkyTtZp/9RQMv4yISn3xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZlWJb2trQz2xk5
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 12:49:49 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZlWDN1H7gz8wvL;
	Sun, 27 Apr 2025 10:46:12 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 725291402CC;
	Sun, 27 Apr 2025 10:49:43 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 27 Apr 2025 10:49:43 +0800
Message-ID: <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
Date: Sun, 27 Apr 2025 10:49:42 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix `--blobdev=X`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 10:15, Gao Xiang wrote:
> Create one if the file doesn't exist.
> 
> Fixes: b6b741d8daaf ("erofs-utils: lib: get rid of tmpfile()")

I think the real fixes should be Fixes: bbeec3c93076 ("erofs-utils: 
mkfs: add extra blob device support").
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/blobchunk.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index e6386d6..301f46a 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
>   		blobfile = erofs_tmpfile();
>   		multidev = false;
>   	} else {
> -		blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
> +		blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
> +						O_TRUNC | O_BINARY, 0666);
To maintain consistency, is it better to set the default permission to 0644?

Thanks,
Hongbo
>   		multidev = true;
>   	}
>   	if (blobfile < 0)

