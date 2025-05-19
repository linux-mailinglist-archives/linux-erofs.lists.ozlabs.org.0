Return-Path: <linux-erofs+bounces-342-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC09ABB30A
	for <lists+linux-erofs@lfdr.de>; Mon, 19 May 2025 03:59:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b117x0j5Hz2yVV;
	Mon, 19 May 2025 11:59:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747619949;
	cv=none; b=BdXzKos/3XpBOvu0Pn40oytxOOE1Onall+EBJOufObexrwizkEqAvZ7AitMERE8HPk6vGlrteGCGF0p9UdGHnOBAQKogQf/ZlIEQnpH6RDgQXuDYB73903oVYFiC3+D9hzWuDisKs24HhaodSezqJygQvyhn5gEQRa/zHEmMK0ty26+rnZfC1282afJlIV5ioZqTl6sU1qzldYphgv7ZRzMnAipP9zzR6doAxM21lZVi76DoFIVn59RjPZVuvEtAgyhAzkNYNsvuMFCIdVWsCMJ9jXD3Rn7ppdmpVCujRsiwcnnRjYA/85IEg0vS3J0xIve1CrhzW44MJU1uqcH7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747619949; c=relaxed/relaxed;
	bh=465ybCN69urWCKwsV8zHhnkvhBdyoDe9eDKU2Bo8TAI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zf5KIN2Ox1ho3wuuq8sRKA5JihGAoskzZSrYqh5iXQP2bNpGcXzEMy5410x2+Tg9E59jEsF8tQvaGIqVs8dKMg1rwPuGatvHuWAgptWL3CmmOwJHqW9dP/YcD7GaIOp9wH7RYoflMBJLf1YmBKEOe3fIBl2LW8lZjuebwiIesNpP8LkBRVmJmOM1VblsdTLmxyWXlYGp7CNkJZzoBsFVTRz4yAPlCP7afYLblWqO/GYXR/puY+lH6LjucCkQvoxK4H38/BPHi9f6+LkbJpqv4/jdSjm/QfAFnY9+wn5MhvaEEJHVDPd+Ees4QNz9Q5UUd0htFEpx6WwDhHyEJSO8UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hfm9C2k8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hfm9C2k8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b117v2Jhhz2yFQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 11:59:06 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-231f325366eso19685025ad.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 18 May 2025 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747619943; x=1748224743; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=465ybCN69urWCKwsV8zHhnkvhBdyoDe9eDKU2Bo8TAI=;
        b=hfm9C2k8z0xiPYnCJFPAiKqZfSFH6eLjRPKGV1a2wjs0UbUIc+JAnR7t4o5iKC+8+W
         iLAWJXwxNDLQA9iy8x7KtuGWT3t+tEUub55/P5AWZbiQ05fZ6aYR0ePush7b3hRAhQ7N
         vG87RKj4lJFk8pk6cFW2nRYUtdawtw61WNBQLP0Mh9aAWuR8YxEKZ2fuOiHU0+fxOnRZ
         obrKZxRvkb7IbYiMWZki9wBE1bZuVEfnfwjspOCfGLNM75/asaC+LSk/pUfd7Z+Ekpmp
         slKfOG19o0K2S9R/kbvMqL17nuDkQqMfHXt9eRvhfbz2l8Jl/elrRiLNlF9OwaxNbshh
         OwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747619943; x=1748224743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=465ybCN69urWCKwsV8zHhnkvhBdyoDe9eDKU2Bo8TAI=;
        b=bStzCup6V/yB3AZbjup6Dx0xB66iAfrIX+JVIS41CQsWJUtPa6ozFoGcfAX7WyuJpa
         W5c0a9IpmuBPnhwEgmDEmkucgk1B9f9D6dXMzNk8KCVTVkOVIb5WYq96a4yJHUqbMkYu
         Sgr58H7SzVU9GoMJL72EI7kVGXx/+Ebm09RlJzjhkeddqJoKif+/b03yQQOapRKrPYo8
         V7+LiW5nuDNh0H6GR54LZh0F8aEKmzSQZ57lqvtt8252f9BH++/bIHT31VFyvRD7Ysnl
         L5akfyKNnPo2ZFgkxYXLCKQHhnGoP9YQQ+eUmPa8waTBiuv1iyI9Uykszg+Q3BqhHt9k
         f+ng==
X-Forwarded-Encrypted: i=1; AJvYcCUGYlEtFnMUD2AMUffB8ioHKcLg7x+r4+v5Nef/J5uab4G5tAUyKutCKIllmgy3kFQaBoNwihCKflLIqw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKVPRPgHir9b+0i7jfyy0yDOvRd3Bm+oNEia893d+xJbpjX20h
	t3bC3cMvzXYE0BF/orIkTs6IlG1Sw0I5Ur1aYl6RGroNzo9hysObe5xX
X-Gm-Gg: ASbGnctUsI+a9fhHmMZfziQeCDTNP0HXHylHCgIjpCW11DpfTeqyM+SZuH+6VAoof3I
	LCJ1H0GwleV3hyYk7yH9zfruSrUjYaycqk36DvT2//GaQonHN9+OFDOhKed9gpLuZcD8so2GGA6
	0/sQmtl7iMyBb57E6VKYeiLIADwuCBa+WyZf7rGUpg+Kkchef9cWtiyO0sK2rLIbUDUsA7RvQQr
	nrlbbX2otKnzeapP2sgWn6XggPkxX6TNpdzX1BD5vldsauMERhdfWw7/15wWjMYEL1hb/EjYbeW
	TkLmay/z4IHQdGHvwkz4nNa0HYrupAxLCfmWguDY9bo9aHHtFQMwuNLnZzvuOmA=
X-Google-Smtp-Source: AGHT+IGtbaL6Rwx3Tp83tljaaL5Fb4pAonzvRiQVTrT6/GDNWs9E3hM2f206ofLvP2fHF/APsFgzIw==
X-Received: by 2002:a17:902:f643:b0:224:1294:1d24 with SMTP id d9443c01a7336-231d43dc980mr123322975ad.3.1747619942933;
        Sun, 18 May 2025 18:59:02 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4aff935sm49179165ad.94.2025.05.18.18.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 18:59:02 -0700 (PDT)
Message-ID: <2faff963-c96c-4576-8680-a3e9b432aba5@gmail.com>
Date: Mon, 19 May 2025 09:58:59 +0800
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
Cc: shengyong2021@gmail.com, oe-kbuild-all@lists.linux.dev,
 Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Wang Shuai <wangshuai12@xiaomi.com>
Subject: Re: [xiang-erofs:dev-test 5/5] fs/erofs/super.c:659:22: error: no
 member named 'off' in 'struct erofs_device_info'
To: kernel test robot <lkp@intel.com>, Sheng Yong <shengyong1@xiaomi.com>
References: <202505190150.4HUHevyn-lkp@intel.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <202505190150.4HUHevyn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/19/25 02:06, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> head:   7cd18799175c533c3f9b1c2b2cb6551e2a86c921
> commit: 7cd18799175c533c3f9b1c2b2cb6551e2a86c921 [5/5] erofs: add 'fsoffset' mount option to specify filesystem offset
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505190150.4HUHevyn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> fs/erofs/super.c:659:22: error: no member named 'off' in 'struct erofs_device_info'
>       659 |                                        sbi->dif0.off, 1 << sbi->blkszbits);

Hi, Xiang,

dif0.off has already been changed to dif0.fsoff, shall I resend the patch to fix that?

thanks,
shengyong

>           |                                        ~~~~~~~~~ ^
>     include/linux/fs_context.h:239:52: note: expanded from macro 'invalfc'
>       239 | #define invalfc(fc, fmt, ...) (errorfc(fc, fmt, ## __VA_ARGS__), -EINVAL)
>           |                                                    ^~~~~~~~~~~
>     include/linux/fs_context.h:227:65: note: expanded from macro 'errorfc'
>       227 | #define errorfc(fc, fmt, ...) __plog((&(fc)->log), 'e', fmt, ## __VA_ARGS__)
>           |                                                                 ^~~~~~~~~~~
>     include/linux/fs_context.h:192:17: note: expanded from macro '__plog'
>       192 |                                         l, fmt, ## __VA_ARGS__)
>           |                                                    ^~~~~~~~~~~
>     1 error generated.
[...]


