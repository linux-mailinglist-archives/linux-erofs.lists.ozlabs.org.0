Return-Path: <linux-erofs+bounces-1684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D828CF691B
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 04:11:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlblz0kVYz2xqr;
	Tue, 06 Jan 2026 14:11:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767669071;
	cv=none; b=daX6CimCJhzC+SmSZchqUy0ji4OlFU1Ee6PrsEiwN/JiPkmiZid/682JKXMW6T7M9rs57HcsYLL1x2C7A9MF/EthIwKXziyJQRM4eGb+YWDKV4+1cdl4aL4VFE/iH5TjcMDuTl5IYngAVkQCPcvKHhS/PnAdjSTuRa+QuxAz8ErKhWY0PynmhHH0ILJxAK8BNUApCuujJy37b/nCeGTZ613/4t+fxI70WYt227Ax30XeRT9CbFO3qJJzRx94GwKXiqDIgQP1zfhyOzmTimpuhUhbYQ9C0J7F5p8/D6ePzHVY0fvcODHkGDw3gv2eCW2pC/imBepe2M/2NTThSNobBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767669071; c=relaxed/relaxed;
	bh=42pAs3+fIQYhuJ9SLWC+Fz0cYorrswLXs6TEhqtdXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ2oHn3PC6y0VkUIkp8bnt9syz8olmMmID/qhWNQ75tupwF2mhai4kGNd2h37V8LhZskq19ecXb4e3C6reZCwxYnGgbvY2kGPlRfF9NoDTZ3tu1Wmm9zZqqqx1lyJfBqKuqdvZntC1ywey3sqAGdFsqomKFmHRfeT9WLArFCt+pPC/zc/VPM6oCbXr9GWHFq0Gh0zKb3i2gFSoqvbLmA+PKeI39K5Y2CKvmzTUKJipS3hXbqkz+YeD3rt5MD0G7rI2LF9h7NsVyzSdjMWXno1dIQR4WAXaSpYjU6Ak9sjOk0sct6LSWJUAxyPF5U93Vn/NC0rJXvy+FlRgqxYV41NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rZC2Kz9u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rZC2Kz9u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlblw66Ctz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 14:11:06 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767669060; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=42pAs3+fIQYhuJ9SLWC+Fz0cYorrswLXs6TEhqtdXBY=;
	b=rZC2Kz9um9jcbdFLkI+44t2Fzc6Ch+wXKSJzWQPWzhk1/1wXCZHpXzVI68YVEMjX9WQ0fEpibG7ElKNWWWLCGChjsqPUubn58XXksUho565yzJSc7bm3fcAzbJVNUHl9TyCWLllSNrymNli3ZrruXlTGIiirQya1ctFQgnPLlMU=
Received: from 30.221.131.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwUFXOR_1767669057 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 11:10:58 +0800
Message-ID: <3a0b7e98-5578-48f8-bcf2-8711a99adbc7@linux.alibaba.com>
Date: Tue, 6 Jan 2026 11:10:57 +0800
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
Subject: Re: [PATCH v1] erofs: Fix state inconsistency when updating
 fsid/domain_id
To: Baolin Liu <liubaolin12138@163.com>, xiang@kernel.org, chao@kernel.org
Cc: zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com, guochunhai@vivo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260106025502.133470-1-liubaolin12138@163.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260106025502.133470-1-liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Baolin,

On 2026/1/6 10:55, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> When updating fsid or domain_id, the code frees the old pointer before
> allocating a new one. If allocation fails, the pointer becomes NULL
> while the old value is already freed, causing state inconsistency.
> 
> Fix by allocating the new value first, and only freeing the old value
> on success.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> ---
>   fs/erofs/super.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..6e083d7e634c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -509,16 +509,22 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		break;
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   	case Opt_fsid:
> -		kfree(sbi->fsid);
> -		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
> -		if (!sbi->fsid)
> +		char *new_fsid;

could you move

char *new_fsid, *new_domain_id;

to the beginning of `erofs_fc_parse_param()`
to avoid variable definitions in the switch statement?

or maybe just call it as:

char *newstr;

Thanks,
Gao Xiang

> +
> +		new_fsid = kstrdup(param->string, GFP_KERNEL);
> +		if (!new_fsid)
>   			return -ENOMEM;
> +		kfree(sbi->fsid);
> +		sbi->fsid = new_fsid;
>   		break;
>   	case Opt_domain_id:
> -		kfree(sbi->domain_id);
> -		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> -		if (!sbi->domain_id)
> +		char *new_domain_id;
> +
> +		new_domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!new_domain_id)
>   			return -ENOMEM;
> +		kfree(sbi->domain_id);
> +		sbi->domain_id = new_domain_id;
>   		break;
>   #else
>   	case Opt_fsid:


