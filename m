Return-Path: <linux-erofs+bounces-1623-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E32DCDFB6A
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Dec 2025 13:41:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ddhtZ2zz5z2xlP;
	Sat, 27 Dec 2025 23:41:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766839286;
	cv=none; b=RaHrGVXKEs9Bm+GWBc+IuRQ081eAY2HlVRF4IoxhlAvmoSbYAvfvquXPT8Xc1jYqs6Ss2luA5lEyHT6XxtAsh0JgzHtmtBaKEpj5eOezBRvpkUwYB062bZL+hHjMmGSifoiWhy7NXF8YBLE6l11JLrZgK/qp4L298reJVdFrU50pVtasE7867KyFhJxaqXuuDFAHdf+ZuGA7cG0nlaXK0Dd7jllOaAzLHNsS0cS3x3q3Si0k5auqLElDqro2Gv0l7BQwllzj4NBY3y4UL4/AjsqVVyBmq03DiDhkN3nw6+1XDAsJchjdnKdujd89DcaZx2VsIJlXMUZA2/a8FGr0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766839286; c=relaxed/relaxed;
	bh=bMWLFPX8de3XONVkFOG8yVJLNS7tQq95HEAqSzxJjvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhEHxQRI+Mo47FIzRBvsQ1RDXDLiDlVgUxwd3H9oJMDu/DdPJZGIw+/xcO9aqvJHHyQjZ5CVnRY2WkO9LM6Vn9o6/fi1Vpc9EurLvDlTkuMdSB0G5jGfl2DOX3gVLrv++mKWkUVQXjZpO4l5nYSGBeAZdFKRIUMv39INZZCBPL7pBSTaWL1FjuyTBV10MneZPf/1iH4unkBO45A3RiMRPzWi5w6dTxNXxTMfvhD3wz7HwxEPvjp45CgZZxlBEh3BkKiPs5ZvNCBhG+V6iowT+JiSQt3VByIvZvd0hXbDMGqyTv/3ejnz+xBy14/CPvubLeHvmXFqfsARnimpEOhQ9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dcz4z/Sr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dcz4z/Sr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ddhtW00S1z2x99
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 23:41:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766839270; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bMWLFPX8de3XONVkFOG8yVJLNS7tQq95HEAqSzxJjvY=;
	b=Dcz4z/SrUXZm2XymdUf+m/aW8EEoijeYRkrSD1SyUC+eLBhQU9frB9HpoIDiGAnd+jWERUpFazdsONK4rl5dneC90txP7Q/yRj/Oxro6qdIzJMh9cSSwkOQNc0V+I8xnXPox58tXWgp9SeTfUF8SOIf+jfnkUxwcksyzfnyq6cY=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvjvBHu_1766839260 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 27 Dec 2025 20:41:07 +0800
Message-ID: <21413630-b4b9-4fdf-9daf-5081ec16aa07@linux.alibaba.com>
Date: Sat, 27 Dec 2025 20:40:59 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: mount: fix ioctl-based NBD disconnect
 behavior
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251227113933.45791-1-zhaoyifan28@huawei.com>
 <20251227113933.45791-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251227113933.45791-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/12/27 19:39, Yifan Zhao wrote:
> Currently erofsmount_startnbd() doesn't ignore SIGPIPE, causing
> erofsmount_nbd_loopfn() to be killed abruptly without clean up during
> disconnect. Moreover, -EPIPE from NBD socket I/O is expected while
> disconnecting, and erofsmount_startnbd() treats it as error, leading to
> redundant print:
> ```
> <E> erofs: NBD worker failed with [Error 32] Broken pipe
> ```
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   mount/main.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index 5ba2e0a..965b0b8 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -621,11 +621,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
>   		off_t pos;
>   
>   		err = erofs_nbd_get_request(ctx->sk.fd, &rq);
> -		if (err < 0) {
> -			if (err == -EPIPE)
> -				err = 0;
> +		if (err < 0)
>   			break;
> -		}
>   
>   		if (rq.type != EROFS_NBD_CMD_READ) {
>   			err = erofs_nbd_send_reply_header(ctx->sk.fd,
> @@ -653,6 +650,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
>   out:
>   	erofs_io_close(&ctx->vd);
>   	erofs_io_close(&ctx->sk);
> +	if (err == -EPIPE)
> +		err = 0;
>   	return (void *)(uintptr_t)err;
>   }
>   
> @@ -663,6 +662,12 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
>   	pthread_t th;
>   	int err, err2;
>   
> +	/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
> +	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
> +		err = -errno;
> +		goto out_closefd;
> +	}

Can we register a signal handler for SIGPIPE instead, and setup
a disconnected variable for erofsmount_nbd_loopfn() to notice
for example too (in case of unnecessary erofs_nbd_get_request()).

Thanks,
Gao Xiang

> +
>   	if (source->type == EROFSNBD_SOURCE_OCI) {
>   		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
>   			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,


