Return-Path: <linux-erofs+bounces-280-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3FAAC45C
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 14:38:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsHxs6QS9z2xrL;
	Tue,  6 May 2025 22:38:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746535121;
	cv=none; b=V5A6a7QJIIsXAmAfeghOpldJ1BzjdUNi9BVl9aLvGm9/qvUjeGhTnfEbzR18lvmDMi4n6hyq8qOo16y0y/WZdf41MZg18bz6nIugpG0nUb8j4XoxBpEH1xK7H/9HFLvr74Q1M2XO4yvyqCXX40uvG9VM0wmt+W2M0vZEqkVFjRHaqBhmYKwSMYS7kq9omcgzImhTjOtBSHjfl2BS4E4oiXIq7ey2p9k03GqykDK15CxT2ylGEjCwkrpbazHq6H1PsYEq6U1tAWaaKScg+d/Ywb/FzLRf9q7IzW4pJkSdededAFjMZ4WA7/60AVRvNGtJAb1hwtl4Mi/R7dUOeJ1s0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746535121; c=relaxed/relaxed;
	bh=cayzg0gES0OSMF5RppmGNlwrHS/3kdF3lPzpkpw7ynI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSeLr5bb7nMzoO9LmeADwLwqNRbRiNeH6IsdZf+rTscPeOrP8tQziHysL4x+dMutDWnleZ7wCUw6tfIon+hwQ4Iqc/4ErjKg+tbACjejlFxnf4RIOBrU4ofhBHlC0TqW0R/hgHoWZDmQK6zYA2JIvDUGrJu/aeBQUJuEHhv/T4s3FOfebDXL/8/Last/TLtPggtZ9bivMzzYJ4o7dfD/8AYbGBLh5pfOy0K5i6okb2NuvEpvh4XOoUjChCnu+MECQ5CcZ8eCwd11lFM38Ctynxq67fkb2NoxeT/3wqlR4LdTd/YTlunxyLVQ91kVjgWe1ppjYXJVTpIQVTInfe6z8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PeV4dGHU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PeV4dGHU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsHxq6xBFz2xjN
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 May 2025 22:38:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746535114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cayzg0gES0OSMF5RppmGNlwrHS/3kdF3lPzpkpw7ynI=;
	b=PeV4dGHU2X4h7/1BvS63IntSqvntdUeICG6q3EN9xeTHj9u72qAnbck/LK2CH7BFid0uLNjUpJhk4wPkaDg180/Qz6OaZD3dG5Ip52LKxaCzsQIwaxKBovTPVvGXz8v/IyhfaoRGEh0xrQKa3Bz/maMb6S8iJO3BQDVE6fCjLhg=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZUchPI_1746535111 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 20:38:31 +0800
Message-ID: <aaf3f255-3273-4d31-86c1-4e05c59b7389@linux.alibaba.com>
Date: Tue, 6 May 2025 20:38:30 +0800
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
Subject: Re: build of erofs-utils 1.8.6 fails with musl libc
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>,
 linux-erofs@lists.ozlabs.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
References: <20250506121102.GA15164@m1pro.arvanta.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250506121102.GA15164@m1pro.arvanta.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Milan,

On 2025/5/6 20:11, Milan P. Stanić wrote:
> Hi,
> 
> I'm maintainer of erofs-utils for Alpine linux, distribution which use
> musl libc instead of glibc.
> 
> Building version 1.8.6 gives error:
> ------------------
> Making all in contrib
> make[2]: Entering directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6/contrib'
> cc -DHAVE_CONFIG_H -I. -I..   -DNDEBUG -Wall -I../include -Os -fstack-clash-protection -Wformat -Werror=format-security -fno-plt -MT stress-stress.o -MD -MP -MF .deps/stress-stress.Tpo -c -o stress-stress.o `test -f 'stress.c' || echo './'`stress.c
> stress.c: In function '__getdents_f':
> stress.c:274:16: error: implicit declaration of function 'readdir64'; did you mean 'readdir_r'? [-Wimplicit-function-declaration]
>    274 |         while (readdir64(dir) != NULL)
>        |                ^~~~~~~~~
>        |                readdir_r
> stress.c:274:31: warning: comparison between pointer and integer
>    274 |         while (readdir64(dir) != NULL)
>        |                               ^~
> stress.c: In function '__read_f':
> stress.c:431:17: error: implicit declaration of function 'pread64'; did you mean 'pread'? [-Wimplicit-function-declaration]
>    431 |         nread = pread64(fe->fd, buf, len, off);
>        |                 ^~~~~~~
>        |                 pread
> stress.c: In function 'read_f':
> stress.c:480:15: error: implicit declaration of function 'lseek64'; did you mean 'lseek'? [-Wimplicit-function-declaration]
>    480 |         fsz = lseek64(fe->fd, 0, SEEK_END);
>        |               ^~~~~~~
>        |               lseek
> make[2]: *** [Makefile:420: stress-stress.o] Error 1
> make[2]: Leaving directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6/contrib'
> make[1]: *** [Makefile:447: all-recursive] Error 1
> make[1]: Leaving directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6'
> make: *** [Makefile:379: all] Error 2
>>>> ERROR: erofs-utils: build failed
>>>> erofs-utils: Uninstalling dependencies...
> (1/19) Purging .makedepends-erofs-utils (20250506.063719)
> ------------------
> 
> This is because musl use readdir, pread and lseek instead of readdir64,
> pread64 and lseek64.
> (IMO musl does this properly)
> 
> Natanael Copa <ncopa@alpinelinux.org> created patch with which I build
> erofs-utils successfully. I'm attaching patch to this mail.
> 
> Feel free to contact me if you more information or to try some new
> patches.

Thanks!  I will look into that later and feedback.

Thanks,
Gao Xiang

> 


