Return-Path: <linux-erofs+bounces-806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8566EB1E31F
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 09:23:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bywVZ1vYpz3cPG;
	Fri,  8 Aug 2025 17:23:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754637798;
	cv=none; b=fAzkSZLJdvThpzxZz/0ivqVF5/K4RxClkQeTzt3alNByaxBt8Fsv+BaK08SxJSpl5Qm8KgXo7g5U8GZDSq/jtcnYhz8PokdnuZMUrCQTvF5ZgZCgBlrYbkGWeWCtE43J4CwR03VBUTfzvPfWntwf3Vhzvz33UnspYSDw4YsQJ37WeBuTVYyBls3qP9e7DjN55dlIW0LUr4JyalO04+yWdGW21nmvx4F9lnbBX33koFn9hjT33WktXFTuYevEFG/lzXo10mB90W5OLUA8xmK44t4xWdPY0fdvT6mGr2fGB8LEMhc8YIUJT+3ILNUUcA/VqgoU9MNkIXTBVPkdvEoT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754637798; c=relaxed/relaxed;
	bh=0dgGJoeofdI7MSo4uWblTSqGVjSsJvQakXfVGf1Krl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbf2n1pPyFjiYa1h+QDhwOwjtiiPoKxUkCOt4V3yg6Jgn9GeMutwKrbFHDXQhxU7+bSSUuK6fsGcrvwxp92Wl5WBodTKsLeaOXdc+FHGleJ+rWoTSt6GlHfqa6dq0NPKxmmIuC7/ak3JKFxg4bzaF/GsjnTgjNZsJ8Ql+wcb2RdxsXtLQ5Z7g0VJOewdqQavvumCZ8RZLPASBH66VJZQEIIopy7K6Oq6wYonjvLSKLWSBKZgkAHYE33Ir4jd6OpDgQvfACT4ibGF8WdRi8551Oh2F9eHpqpUVZoYDDlaA4S6ltsYH1DSvinZC6KMaAJerC54qiWjz/PZ7CyQKCxJ3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RQ5y7K5P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RQ5y7K5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bywVY3CmLz2xcC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 17:23:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754637793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0dgGJoeofdI7MSo4uWblTSqGVjSsJvQakXfVGf1Krl4=;
	b=RQ5y7K5P8CAd4+OYMBmKVflTDpaY6JfL0pJ/mTIn5ZL2+nyrIU5fpR/hE93Ypoe9Sr4rEbXcxHWeAXC7NHunFmkbPgjQyfcoIO9KDJoo4JIx7so+4H3x69RaDTTN9mRlnMIJa5gZCq8GNNB7BOdUxQhy7z2LPYAJvZ6irnm+kys=
Received: from 30.221.129.72(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlGaH98_1754637789 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 15:23:10 +0800
Message-ID: <c3326927-1202-4aee-a75e-ac4138b9cc0c@linux.alibaba.com>
Date: Fri, 8 Aug 2025 15:23:09 +0800
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
Subject: Re: [PATCH v7 4/4] erofs-utils: mkfs: support EROFS meta-only image
 generation from S3
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
 <20250808031508.346771-4-hsiangkao@linux.alibaba.com>
 <b9c8395a-e50a-46ad-89b9-5679f8b71fad@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b9c8395a-e50a-46ad-89b9-5679f8b71fad@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/8 15:16, Hongbo Li wrote:

...

>> +                dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL)
> 
> Did you forget setting dataimport_mode as EROFS_MKFS_DATA_IMPORT_ZEROFILL?
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 07bc3ed..edc8fff 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1220,6 +1220,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>                          err = mkfs_parse_s3_cfg(optarg);
>                          if (err)
>                                  return err;
> +                       dataimport_mode = EROFS_MKFS_DATA_IMPORT_ZEROFILL;
>                          break;
>   #endif
>                  case 'V':

No, users need to specify `--clean=0` to make it work.

The default mode is still -EOPNOTSUPP.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Hongbo
> 
>> +                err = -EOPNOTSUPP;
>> +            else
>> +                err = s3erofs_build_trees(root, &s3cfg,
>> +                              cfg.c_src_path);
>> +            if (err)
>> +                goto exit;
>>   #endif
>>           }


