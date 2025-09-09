Return-Path: <linux-erofs+bounces-988-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E28B4A37D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 09:28:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLb5j12mtz30Lt;
	Tue,  9 Sep 2025 17:28:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757402905;
	cv=none; b=e4nmLZCgKs/sA2n/p9swy97n9aueBYhKNN1EU7I5DgRdJ1Z5xzqINtxcc4nQnNzu8NnfkwvViIge0px2acfu11sBK+8+ODaEl4mHzEsfPu3Stp+WfUBneR/FBpUHLDCKZS4uG7a0JnJA6l7Jv3CjHPGxy1L7T15Pt5bOuqNJdFi3XE42mXQsbevgQFsCVxIQQERnebFoxZ+9soMabNs8+MNf772+F5mR4V5manETWHr/y8QW1pCUKMpOjtbbyiEMEV1FrjcjaHE97wyJzNOHCVlBmC/m62QoTVI0gx1G6ZilBsBcGeSIgdWalq9PBzFNoQdzVVh0DyYxuftNQHF9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757402905; c=relaxed/relaxed;
	bh=u5F7JH3wVkAR3+FqOgMCx1g/xJgq89wSn76EEFoou+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRpO6V+4cyLq4rooTBXf6TBcV1Wn4orZBGGuOI5wuJz07pT3oX5nztI7TmiwRfBvxQ7E6tYGwt/MM+S/tviU3GcgPF2wg64N2pbZlLAemyBTGgj3xHNPr7OYhony8GhHN4Ck7f2qxLB0Cb/Mgj8nu3FMble3OZDeN0AP/mBxO/LXWXR+RvkhYOK9DRPWrri1EzUz1N/+xh2X6EA5gCIePSHVpJ8SeAldCdSlCIDjSLbwaXEe6oPIuPEYEM3Mwuu1a4AbZweu/bx2J2D4QxcV5L7f3O0eu2p5EUlC9TM18bGDQ3Q5XVlJFhHbWMcXtq6Cy8zcEekBvcBzyCbba1hJpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vTDNXh2R; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vTDNXh2R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLb5h1pBDz2yqh
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 17:28:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757402900; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u5F7JH3wVkAR3+FqOgMCx1g/xJgq89wSn76EEFoou+0=;
	b=vTDNXh2R9NM9XsALghlOgKUR++MQ9Wy84UNz9/Dkj2fRxkutOqVgMhf/atzcmjF3GoEykcvD9RnpdHXmxgLwa6osxE9RryC/lTDElZ91Uk+A5L7FEdhVi8LmM8RKZJi51l5Affdb4d0e1g/VEKvp7EUqKw2zJ44/mQPaExDV4Yo=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wncwdtc_1757402898 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:28:18 +0800
Message-ID: <3b4445f4-e408-4b30-b7be-31327d6f6cd1@linux.alibaba.com>
Date: Tue, 9 Sep 2025 15:28:18 +0800
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
Subject: Re: [PATCH v1] erofs-utils:mount: fix memory leak in
 erofs_nbd_get_identifier
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250909065500.75576-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250909065500.75576-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/9 14:55, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> The erofs_nbd_get_identifier() function returns dynamically allocated
> memory via getline(), but the caller in erofsmount_nbd() was not
> freeing this memory, causing a 120-byte memory leak.
> 
> Add proper memory cleanup by calling free(id) when the identifier
> is not an error pointer.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

The subject line should be fixed from:

`erofs-utils:mount: fix memory leak in erofs_nbd_get_identifier`
              ^
to
`erofs-utils: mount: fix memory leak in erofs_nbd_get_identifier`

Otherwise it looks good to me, will apply.

Thanks,
Gao Xiang

> ---
>   mount/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mount/main.c b/mount/main.c
> index 0daf232..d4f1cda 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -741,6 +741,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>   			if (err)
>   				erofs_warn("failed to turn on autoclear for nbd%d: %s",
>   					   num, erofs_strerror(err));
> +			if (!IS_ERR(id))
> +				free(id);
>   		}
>   	}
>   	return err;


