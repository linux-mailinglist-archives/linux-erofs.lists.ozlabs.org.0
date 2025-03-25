Return-Path: <linux-erofs+bounces-124-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E12A6E802
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Mar 2025 02:37:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZMCGl2CZPz2yLJ;
	Tue, 25 Mar 2025 12:37:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742866671;
	cv=none; b=Te3MXEBwYmA+GOwSoz1gvlSxE+eD8ga1M4QAFSeZE/d0zCf7+grsY1VPe0xtap0kL/YAMAGmGI057VpJOvsskGlVaOIJUIBjn3BH+ASNMLFmGq5169e7ptUKb4K1cOGZHcI3045XE4IbEsVtm+0+N5oQWWXuER6KAQceokIKhgdqEDYeJN4CIye9d2q5SuoBdJUSt1BQy0XTNPvBAGeX4pEhG6Eibc4SD0boQZ3kdW80cSOgjmSrXei7g50n2ISqq8Hck/6lZlpjbz20L5Kj1A3dWZ8SJbWM6320CIG7NQJQcl+oc/2XYuoGcPvyRkyBuLGeu6x6zyXqHs8N0WZS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742866671; c=relaxed/relaxed;
	bh=7aZMCkZ+HE4An/i1C0+Ohtb/3lMZesSY8n0GYQcLRTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9NkQe/krV96Yy7/5gnSc2py0f849LhWZjZEyEFpjBM5VogFkSyt7kKmngs0agps0E83rfKH7pj7m1HvLs4NXHs34khvUYTLBhpVz7op8NH2xHUG+jTUhJ+kJTyLt9n3YHAdR68F4ZnzYOuwjK4wpnovF/KCYOGtoviEOooZs0bWKSv9gyPmrtwss2pOyIqGfvgUySx/Al62d8VLuSQVUoFHAzej3BvLaaojM8Rp98xjXk6ar1jMgsregBKMXkmAEOrWwmMq/ZOcXr8u/5/Rr6UaDxSzQfSsAN10e+roDtdWoY2Q313JYwcuS6IbsD2gt41W9jBN5CCbAjNPHWoxyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Rab0Un59; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Rab0Un59;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZMCGh2ZcNz2xmk
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Mar 2025 12:37:46 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742866662; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7aZMCkZ+HE4An/i1C0+Ohtb/3lMZesSY8n0GYQcLRTo=;
	b=Rab0Un59i+bnsPLqf6Flk11JlWxq3YABX4gVtVBpPjJo0ViUxm8W9e//49bY2BXdfWmmBGcx8dT25+4rdyvgzCpAXOr3SOk6vnEf29n5vX4ICa6fKPkDU7cVxA+OEu93KtgfmidXWQ7g3jpDE2ECNBq5Q5H3NqMEr2ONz/yMuxM=
Received: from 30.74.129.51(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WStBDvD_1742866660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Mar 2025 09:37:40 +0800
Message-ID: <1b0ce59a-30a7-46e3-9c63-72c3f8d44b77@linux.alibaba.com>
Date: Tue, 25 Mar 2025 09:37:39 +0800
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
Subject: Re: [RFC PATCH] erofs: add start offset for file-backed mount
To: Sheng Yong <shengyong2021@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sheng Yong <shengyong1@xiaomi.com>,
 Wang Shuai <wangshuai12@xiaomi.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250324022849.2715578-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250324022849.2715578-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong!

On 2025/3/24 10:28, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> device is still needed to attach the image file at an appropriate
> offset first.
> 
> To address this issue, this patch parses the `source' parameter in
> EROFS to accept a start offset for the file-backed mount. The format
> is `/path/to/archive_file:offs', where `offs' represents the start
> offset. EROFS will add this offset before performing read requests.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>

Sorry for late reply. Yeah, that is a great feature.

> ---

...

> @@ -411,6 +412,31 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>   #endif
>   }
>   
> +static loff_t erofs_fc_parse_source(struct fs_context *fc,
> +				    struct fs_parameter *param)
> +{
> +	const char *devname = param->string;
> +	const char *fofs_start __maybe_unused;
> +	loff_t fofs = 0;
> +
> +	if (!devname || !*devname)
> +		return invalfc(fc, "Empty source");
> +
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +	fofs_start = strchr(devname, ':');
> +	if (!fofs_start)
> +		goto out;
> +	if (kstrtoll(fofs_start + 1, 0, &fofs) < 0)
> +		return invalfc(fc, "Invalid filebacked offset %s", fofs_start);
> +	fc->source = kstrndup(devname, fofs_start - devname, GFP_KERNEL);
> +	return fofs;
> +out:
> +#endif
> +	fc->source = devname;
> +	param->string = NULL;
> +	return fofs;
> +}

Could we just add a new mount option for this, and apply this feature
for both file-backed mounts and bdev-based mounts?

Twist source option is not quite clean on my side.



> +
>   static int erofs_fc_parse_param(struct fs_context *fc,
>   				struct fs_parameter *param)
>   {
> @@ -507,6 +533,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
>   #endif
>   		break;
> +	case Opt_source:
> +		sbi->dif0.fofs = erofs_fc_parse_source(fc, param);
> +		if (sbi->dif0.fofs < 0)
> +			return -EINVAL;
> +		break;
>   	}
>   	return 0;
>   }
> @@ -697,6 +728,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>   		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
>   		if (IS_ERR(file))
>   			return PTR_ERR(file);
> +		if (sbi->dif0.fofs + PAGE_SIZE >= i_size_read(file_inode(file))) {
> +			fput(file);
> +			return invalf(fc, "Start offset too large");
> +		}

I guess we need to verify the offset is block-aligned too.

Thanks,
Gao Xiang

