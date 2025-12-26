Return-Path: <linux-erofs+bounces-1609-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E9CDE63B
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 07:51:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcx9h6XnCz2xg9;
	Fri, 26 Dec 2025 17:51:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766731912;
	cv=none; b=V7jUNii9emDVPz9kF7CxgB5iHrQehQs4isbfuVQQ1nhq/cFjjLytJRy1exlIMtfL6iOcSeJJPDrp9qlN9XaFQF7F4Pg+GISTRbxiw7bTF+gAu4dfTSg2LpGZyslEeT7tHmCmWxpBt1jcD4FuoTZob0E+VJ0JHfRPIAMq0jGdvTtC+cdaAVTrJ1WRnfRhRgJ5Oqvfp4hxBaz/qsKGs34perNXKwR6HaxnNr3WoY/v0XPn+7TSGvo+BIQohAeVFxdvr8W5FUUfqXzKbo7bDFlKhM3Tb2UgzrCEn9xjp+3DO38ys3NIO5yJjG4eF/TUmZ0qGpdnY7T6GPSjSyr0eTZ/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766731912; c=relaxed/relaxed;
	bh=Ysx+sN10GJZyK2kOvnbtf+f4CMaBd88VB0wP9DEbUvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTLA359hx/EW51D9H5NX+Lpk0v8RYuS4KIGXDi4L9B6X6A/6NiajdcNgC3zDm+vn1oG9ab99xtweUEIU9I2RcFuixr2Y+Ox2udeVKXPAFPNxQGjSgyQQNoj8D8y1hfz/zSgfEgYF+6q85Thx+BwnTSJCB9gDrlDNoA5hNHaM5Tw2ugsVzv7OdAU9NxjIIM88X9wUPx9/g0fPItVv7eiGGvzXK2E4fSP2UAAe7cCBqYTU4GpqOLm2n2L3fhjBqnGM+v1N7juvko7e1g4va4DrydTX4LeMpFO8x6/Ryvq/4ME2qfOnvCu6vuhJE3CI3mgvpFEnnpke1GeV6dj9XWk0ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vZJYjWrN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vZJYjWrN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcx9f5Vp1z2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 17:51:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766731906; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ysx+sN10GJZyK2kOvnbtf+f4CMaBd88VB0wP9DEbUvw=;
	b=vZJYjWrNPXtm32Le5CeUJtXipJtcjzRrqjMSWbQdtdUeMNmR/vSjCgjdvOSPWEE02rMKvgtE30Nn+NRZY5nLOa4LuYJ0FjDDwoFNbqmjDO0PyNAioVE+vgjTWJc9NcM0NfrQ2GzyUgNKP/pl8AM2icnsy6KHqdHp2AzTEAd4CIw=
Received: from 30.221.133.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvgk-Ox_1766731904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 14:51:44 +0800
Message-ID: <ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com>
Date: Fri, 26 Dec 2025 14:51:44 +0800
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
Subject: Re: [PATCH 5/5] erofs-utils: mount: stop checking
 `/sys/block/nbdX/pid`
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-4-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223100452.229684-4-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/12/23 18:04, Yifan Zhao wrote:
> The `current erofsmount_nbd()` implementation verifies that the value in
> `/sys/block/nbdX/pid`` matches the PID of the process executing
> `erofsmount_nbd_loopfn()`, using this as an indicator that the NBD
> device is ready. This check is incorrect, as the PID recorded in the
> aforementioned sysfs file may belong to a kernel thread rather than a
> userspace process (see [1]).

Do you have a way to reproduce that?

> 
> Moreover, since this verification only occurs after the child process
> has successfully issued and returned from the NBD connect request,
> removing it introduces no risk of NBD device hijacking by malicious
> actors. This patch removes the erroneous check.

It's not used to avoid device hijacking by malicious actors but
detecting if the NBD device is reused by another daemon.

Thanks,
Gao Xiang

> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/block/nbd.c#L1501
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/backends/nbd.c | 16 +++++-----------
>   lib/liberofs_nbd.h |  2 +-
>   mount/main.c       |  5 ++---
>   3 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
> index 46e75cd..2d941a9 100644
> --- a/lib/backends/nbd.c
> +++ b/lib/backends/nbd.c
> @@ -52,7 +52,8 @@ struct nbd_reply {
>   	};
>   } __packed;
>   
> -long erofs_nbd_in_service(int nbdnum)
> +/* Return: 0 while nbd is in service, <0 otherwise */
> +int erofs_nbd_in_service(int nbdnum)
>   {
>   	int fd, err;
>   	char s[32];
> @@ -72,17 +73,10 @@ long erofs_nbd_in_service(int nbdnum)
>   		return -ENOTCONN;
>   
>   	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/pid", nbdnum);
> -	fd = open(s, O_RDONLY);
> -	if (fd < 0)
> +	if (access(s, F_OK) < 0)
>   		return -errno;
> -	err = read(fd, s, sizeof(s));
> -	if (err < 0) {
> -		err = -errno;
> -		close(fd);
> -		return err;
> -	}
> -	close(fd);
> -	return strtol(s, NULL, 10);
> +
> +	return 0;
>   }
>   
>   int erofs_nbd_devscan(void)
> diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
> index 78c8af5..b719d80 100644
> --- a/lib/liberofs_nbd.h
> +++ b/lib/liberofs_nbd.h
> @@ -34,7 +34,7 @@ struct erofs_nbd_request {
>   /* 30-day timeout for NBD recovery */
>   #define EROFS_NBD_DEAD_CONN_TIMEOUT	(3600 * 24 * 30)
>   
> -long erofs_nbd_in_service(int nbdnum);
> +int erofs_nbd_in_service(int nbdnum);
>   int erofs_nbd_devscan(void);
>   int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
>   char *erofs_nbd_get_identifier(int nbdnum);
> diff --git a/mount/main.c b/mount/main.c
> index d2d4815..f6cba33 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1270,6 +1270,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>   
>   	while (1) {
>   		err = erofs_nbd_in_service(msg.nbdnum);
> +		if (!err)
> +			break;
>   		if (err == -ENOENT || err == -ENOTCONN) {
>   			err = waitpid(child, &child_status, WNOHANG);
>   			if (err < 0)
> @@ -1280,9 +1282,6 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>   			usleep(50000);
>   			continue;
>   		}
> -		if (err >= 0)
> -			err = (err != child ? -EBUSY : 0);
> -		break;
>   	}
>   
>   	if (!err) {


