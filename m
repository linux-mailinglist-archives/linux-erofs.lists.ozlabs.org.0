Return-Path: <linux-erofs+bounces-1496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B599ACC144B
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 08:18:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVpFB238sz2xqf;
	Tue, 16 Dec 2025 18:18:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765869518;
	cv=none; b=B2ON5uViqBz0wCCujLEb8EFNHIKWFVY72xucxilHwKUAZTfJCgmaI9Wv78Y4d+uhj+w5jgKn1aoRSZFWqethx43XhdLFBv9oAnPz1bIO6d8/sNYuJllw68uejW+BRhShJSZw/q1YPIOmutmCBNEoTjFayq/vcfLYzsA96NmGJy7aCLEZN9wPpeqiuEMd15vXgTyqJ7+rjxi2VXHZThwKLQjQ1pMS4sPZZmVr1tZWXkSK2dJtmerO2JdlGM5bOrU2gqqzHWPMxuurFUMucfh4d33fw/PstmWMwJXWSam8RL4y9zkc13zrpDmctIIfsmuE/AanoY8nIETWM/RXOPEftw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765869518; c=relaxed/relaxed;
	bh=RVce/Buq0B5hhDk2zkS7tXTKw/wwujyMy/J/mK4lzYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5LQj2e5t8Zzf18DRu2D3IYEpDElsnVn1IBObkIPask7VrSZ93GuQWvAhT9OP+DLfCqq5akmGQCFI6O7XE3Aot7gdw2O4a07+/D/h8WNtC4GkKMP6l6ls27bv/9pQ8l616foOdRNm/ZQ6aZOvsXkhb5N0ELbx7uZf1ltubCkblYJA4DNQhFK/yT4I3b3po6skITXkVXk33YTeCpTnHxZN9lZRSSIcju3gf4lbaKpKhrLrRh66on4fO/kpAItdQt6z81DpKYRu2tj13MDpQFHvCcbFU8+Di1Qcm9xLRVJ7U484ufntF76zz8qqHrfvpYuBMjsKHgP3J4xaz+MEoXPTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sqzT63Wz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sqzT63Wz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVpF7457Vz2xJ6
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 18:18:33 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765869508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RVce/Buq0B5hhDk2zkS7tXTKw/wwujyMy/J/mK4lzYM=;
	b=sqzT63WzkYMxjE0SAOkGZXIkyQAoDEIqpnwM3qRo606rrekFU8SpempBITxrvH2sqiZlsBtr0rOBISQS+jsRyXLAc0dS9GIek60PQ4FekhH0j16VoW2SCZIoLa1B4kWJ0kx8dZ+3mpFqrYQHGbe92rQKoE03n+GB94LYmdmoN9I=
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WuyJEsS_1765869505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Dec 2025 15:18:26 +0800
Message-ID: <772b645f-6ca3-4447-8e6f-09e735440110@linux.alibaba.com>
Date: Tue, 16 Dec 2025 15:18:25 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: mount: gracefully exit when
 `erofsmount_nbd()` encounts an error
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hudson@cyzhu.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251216070557.743122-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/12/16 16:05, Yifan Zhao wrote:
> If the main process of `erofsmount_nbd()` encounters an error after the
> nbd device has been successfully set up, it fails to disconnect it
> before exiting, resulting in the subprocess not being cleaned up and
> blocked on `ioctl(nbdfd, NBD_DO_IT, 0)`.

Do you have a simple test case (IOWs, how do you test this?)
And is it possible to move the test case to erofs-utils tests?

> 
> This patch resolves the issue by invoking `erofs_nbd_disconnect()`
> before exiting on error.

See below.

> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/liberofs_nbd.h | 2 +-
>   mount/main.c       | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
> index 260605a..93daa24 100644
> --- a/lib/liberofs_nbd.h
> +++ b/lib/liberofs_nbd.h
> @@ -28,7 +28,7 @@ struct erofs_nbd_request {
>   		char   handle[8];	/* older spelling of cookie */
>   	};
>   	u64 from;
> -        u32 len;
> +	u32 len;
>   } __packed;
>   
>   /* 30-day timeout for NBD recovery */
> diff --git a/mount/main.c b/mount/main.c
> index 758e8f8..a093167 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1206,6 +1206,14 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>   				free(id);
>   		}
>   	}
> +
> +	if (err < 0) {
> +		nbdfd = open(nbdpath, O_RDWR);

I'm not sure if it's a best-practice (is it possible
nbdpath can be reused?)

Could we just kill the subprocess instead?

Also ioctl is discouraged and netlink is preferred now.

Thanks,
Gao Xiang

> +		if (nbdfd > 0) {
> +			erofs_nbd_disconnect(nbdfd);
> +			close(nbdfd);
> +		}
> +	}
>   	return err;
>   }
>   


