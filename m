Return-Path: <linux-erofs+bounces-1145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE49BAC2CE
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 11:07:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbXHn37CGz3cZt;
	Tue, 30 Sep 2025 19:07:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759223221;
	cv=none; b=AnW6h8LLw7SK3ELXXwi3zmusH0/6F4ukVvnqSLb+1gw9NuwzxlRWLlA2G29feZGSivoSnGXvaANweNkTUYkUwdrguWWyxQVvhBVdo4+Kje3VIxzMfPfeBu73tH2ywkJYDWQqBzI/rLo1aQbVtflpaa7+L6t5CPUi/ijtQ+xBPnXLpaXYs9tl/RikGOcXMe5yQWTwPu2hTRuKZy0nh2oe7FIqJY6rAgL75yEoL3jwSyem/8T8bME9Fp4hkcPknRv6QKtszgsZjdmO+git6kzkTPH7WWMP3pg9KQtqBBf35Gh+O8wBcKA4HhKWu6gSzeHUAo/M9ST1VIO5OMRQc26ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759223221; c=relaxed/relaxed;
	bh=SuIVY1GqRZGnxe5zlUzZRslhRt3P8GU1Pes2JYFq8ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpErSG6jpj9R9yGPGyTK2Q/wv9Yh0lxDS+BvquYrFHAi3gsK5Bh7VN7KiE4lFt64T68KWfCYnLobGQPumm1x7TB2rb6pCgacjq2sJQZ7r7YPJhuxwwc0OY7kGGzcGrnD8ENLSpdycih5oQY2UJPwp2srSAW1ibSGbhCa2gZY7w+eq16aGDYVHMG04N9Bn4grrOXVCdzf+QUhKZJv8Y8iXn88EHnJ5vC2K2m8ySM0dnjp1gIipt6s8W8B4kKXipt/twncLHua9ikJGajWT7gawYy2OZ/Ie6PLDpM+JzSEx8m683MNJ41oycuCMYWAhdZVyte6FVzt9Jj0ZqlnEu5ebw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KBn6lzjQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KBn6lzjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbXHl3M31z3cZ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 19:06:57 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759223213; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SuIVY1GqRZGnxe5zlUzZRslhRt3P8GU1Pes2JYFq8ac=;
	b=KBn6lzjQ+AEWKIZQ1WhqzegWLEfgTUXZ78jv2WZuw8Tx0DP2P03qSGEG3V+2YYHtYYAdbmS+24B3Hf6qhId+ytsj9bs8yIbddPTaitdM3i73AzrT1BKUOlQXyEv5jSnX/JLtG678xOjzSTSznrNWGW7B6/bcm+ftgzFVLpFyjY0=
Received: from 30.221.129.112(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpAwRoY_1759223212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 17:06:52 +0800
Message-ID: <8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com>
Date: Tue, 30 Sep 2025 17:06:50 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: simplify s3erofs_prepare_url logic
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20250930084056.170447-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250930084056.170447-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/9/30 16:40, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> `mkfs.erofs` failed to generate image from Huawei OBS with the following command:
> 
> 	mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket
> 
> because it mistakenly generated a url with repeated '/':
> 
> 	https://test-bucket.<endpoint>//<keyname>
> 
> In fact, the splitting of bucket name and path has already been performed prior
> to the call to `s3erofs_prepare_url`, and this function does not need to handle
> this logic. This patch simplifies this part accordingly and fixes the problem.
> 
> Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only image generation from S3")
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/remotes/s3.c | 35 ++++++++++-------------------------
>   1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 2e7763e..2bd5322 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -41,17 +41,16 @@ struct s3erofs_curl_request {
>   
>   static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>   			       const char *endpoint,
> -			       const char *path, const char *key,

I really think we should at least add a unittest for this.

you could simply add

#ifdef TEST
int main(int argc, char argv[])
{
	testfunc1();		// and use assert() if test fails
	testfunc2();
}
#endif

and use gcc -o s3_test -Iinclude -lcurl lib/remote/s3.c to generate a test program.

Thanks,
Gao Xiang


