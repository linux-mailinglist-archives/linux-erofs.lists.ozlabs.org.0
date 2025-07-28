Return-Path: <linux-erofs+bounces-707-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9549B132ED
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 04:15:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br2BJ0j2yz307K;
	Mon, 28 Jul 2025 12:15:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753668920;
	cv=none; b=VMatmH3ia+PAcpev5qTLmFIuTfszOdk8xTVncSqG50XJpf6PGimzL4LDSUTuCTBo3UX3/RWoo56Wnceamk5jUs/natmHSeeOTQz1gZ7ts+HQiVWs0EBkVlmnQLcgZJvRyWrVpevptTImWpnSabxvoJSr6RqeYib0uxr5v5sGsLa3SE0ACTGxL/ogmvG8IHVuHzM/FvAixlCivS9pAn3/w3WbfcBTasHOaTFsdhbdiDxQQkAMr+Bp6E3FFQ18pEZmCJ4DwC9wWLJer0+BVP1pJHDNls2ue8QRSBsleJEYwMCyGvgpfI61Xiin1AUt9HWQrcO6kZ/FjXmdB9VRVKjhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753668920; c=relaxed/relaxed;
	bh=FEPnAFfBuhelvYgk4HkToaKPJkYvMhErtm3vm6ZD9KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwinhpVnG747cIN9g4h8BRKheKPIo53tftjF9UborFyX/NNrV7bR/LTEENK2/0rokeeyt483xmOm8Je2f84l5bqQclcdkiExw8SyKYOzRxH8XJ9x/1e+kly5ntHzjFA/1GhernI9yCSmJk5AYavG09v8wSTyhHse8t+Vup7KZ63CWy8fswxEPrdh82p1QnMmAA3WWb54kjzhBwKir4vL5tL2prgda0ggBLjVEbn9Zha0ABLcmtYU/Hi7406mrpyUaBYsJCpZ/cnOuO+AvJh5Ux3hydJe/+kDr5Xo6Ninx598u4UaJ2ixp9fw0a5TTg19FKjG3MqWZqgZ3p1Ks9u1VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NerZxr1y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NerZxr1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br2BF5bRRz2xRq
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 12:15:15 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753668910; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FEPnAFfBuhelvYgk4HkToaKPJkYvMhErtm3vm6ZD9KQ=;
	b=NerZxr1yutztUFt0ZhdqJcHkmcfHUY9p1HZmvioKeX6lTQqoeRz/rkUjMK2NZNFOIoCxqyWznTBG+dOoTLIFzu5R8zV1VbWpnFro4KjOB6wvQrYVHMhZf4iNAbe9kTb5++pqoNZgxSQwBRNwt7Kni1JqdfzYAI+nj5clj/mzNHU=
Received: from 30.221.131.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkBZsOZ_1753668908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 10:15:09 +0800
Message-ID: <1af1693e-a56e-4835-9744-e0190c28b1ea@linux.alibaba.com>
Date: Mon, 28 Jul 2025 10:15:08 +0800
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
Subject: Re: [PATCH v1] erofs: Fallback to normal access if DAX is not
 supported on extra device
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org, Friendy Su <friendy.su@sony.com>,
 Jacky Cao <jacky.cao@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yuezhang,

On 2025/7/28 09:49, Yuezhang Mo wrote:
> If using multiple devices, we should check if the extra device support
> DAX instead of checking the primary device when deciding if to use DAX
> to access a file.
> 
> If an extra device does not support DAX we should fallback to normal
> access otherwise the data on that device will be inaccessible.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Jacky Cao <jacky.cao@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   fs/erofs/super.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index e1020aa60771..ad1578bb0f7b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   		if (!erofs_is_fileio_mode(sbi)) {
>   			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
>   					&dif->dax_part_off, NULL, NULL);
> +			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
> +				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
> +						dif->path);

The patch itself looks good to me, yes, I don't think out
a reasonable way to enable partial DAX for multiple devices.

So it'd better to just disable such case.

Just a nitpick, it would be better to align `dif->path` to the
following char of `(` in the line above.

Also if it's possible, please remove the unnecessary comment
("/* handle multiple devices */") above erofs_scan_devices()
together since:

  - it was obvious and it might be not inaccurrate;

  - it now handles some primary device stuff too.

Thanks,
Gao XIang

