Return-Path: <linux-erofs+bounces-1676-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34867CF07D4
	for <lists+linux-erofs@lfdr.de>; Sun, 04 Jan 2026 02:44:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dkKwP3WFkz2yGq;
	Sun, 04 Jan 2026 12:44:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767491045;
	cv=none; b=HZOb0Uok4MwJJ/jIb02Xl/9NSnaaGMiKZ+jeR9MMhUzIFp+iJTt7b7s+ZexgSmwk7E3Zi314fv52Pg0WdD7aZj03THZjqcgO7DLjDJZPyrz4JNRU51mKPIZzCp9h2FBdI/1KJu1QFZ5EGnOs+IMhVTH2pMHFzKmOMiPJWo/Xp5oLB+xb7FGpuRVGqTZIogqnanJvsUMJAoaXk2BQsJvtWEFWJebG4Rq0hde1zrhO05/NVnkE/eY24oM/VVtqyIMNzOmA/Z7hosCoBvyWD5ouH83mSeOKe4qKOb727sgNnlaUGTLlSAWoAOrdpFRvW8r3eLg+l8HjBPLbPvS42mcVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767491045; c=relaxed/relaxed;
	bh=V67DEebMX5dTsxzHpR4RuFmusgtjqI9GijExM9BNU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=U8DJkyVrG3QheRZ7SjVYW5GYikmT+7rfWlvSD6r91eFNVrkRCZ6sBfvr6aA1tGlli53th3q5nBVm4j+3n6VIUACA+CRNVzIwFVy2Mm0SBk+j/sjJuEnjUmfvb7v+1bke0MYgKlQr6cVaEbbZoht8rOgXDoQcYvSQoVLNAtdEynk4LVUej4YHQLTs9BWSBqGlZYGbrcGW5pEPQ3BsNZgWGtTTxX2oUy28viNI/mDNEXGLxKdJTYN14fFKJ8Dynh1JkiLYMKV7PVP1+ro5p34DjxogX4nXkDtsuvpvkr0Urmueq8vpzKnAmSh/uu+lhfdw7iAZGSexEd+fjVe65MjZIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sXo+HV8I; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sXo+HV8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dkKwN1sP4z2yFh
	for <linux-erofs@lists.ozlabs.org>; Sun, 04 Jan 2026 12:44:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767491039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V67DEebMX5dTsxzHpR4RuFmusgtjqI9GijExM9BNU+k=;
	b=sXo+HV8IsKA7WSRM0q/kcsFcZM2Q1oeCXQ1+EQdtBj4jMZieM5spnoPnHRE+elAsCQ85nYtiltYFZ6V7aCZy996J55WtoC+BO9LQHxkdvnopjefH5rxB5jaWml+GvQhpPEGTOOjqq0IEMjoy8M56ZbFtBbZd5EOcd0GPTVDe7b0=
Received: from 30.221.131.151(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ww9ltBa_1767491037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 09:43:58 +0800
Message-ID: <f3eced6d-5874-4f08-80c8-604c393fdd58@linux.alibaba.com>
Date: Sun, 4 Jan 2026 09:43:57 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: Drop configure checks for unused
 functions
To: James Le Cuirot <chewi@gentoo.org>, Gao Xiang <xiang@kernel.org>
References: <20260102153830.150891-2-chewi@gentoo.org>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260102153830.150891-2-chewi@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi James,

On 2026/1/2 23:38, James Le Cuirot wrote:
> Signed-off-by: James Le Cuirot <chewi@gentoo.org>

I will apply this patch, but Cc the erofs mailing list as well.

Thanks,
Gao Xiang

> ---
>   configure.ac | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 2d42b1f..4d34e1f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -233,29 +233,6 @@ AC_CHECK_MEMBERS([struct stat.st_atim])
>   AC_CHECK_MEMBERS([struct stat.st_atimensec])
>   AC_TYPE_UINT64_T
>   
> -#
> -# Check to see if llseek() is declared in unistd.h.  On some libc's
> -# it is, and on others it isn't..... Thank you glibc developers....
> -#
> -AC_CHECK_DECL(llseek,
> -  [AC_DEFINE(HAVE_LLSEEK_PROTOTYPE, 1,
> -    [Define to 1 if llseek declared in unistd.h])],,
> -  [#include <unistd.h>])
> -
> -#
> -# Check to see if lseek64() is declared in unistd.h.  Glibc's header files
> -# are so convoluted that I can't tell whether it will always be defined,
> -# and if it isn't defined while lseek64 is defined in the library,
> -# disaster will strike.
> -#
> -# Warning!  Use of --enable-gcc-wall may throw off this test.
> -#
> -AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
> -  [Define to 1 if lseek64 declared in unistd.h])],,
> -  [#define _LARGEFILE_SOURCE
> -   #define _LARGEFILE64_SOURCE
> -   #include <unistd.h>])
> -
>   AC_CHECK_DECL(memrchr,[AC_DEFINE(HAVE_MEMRCHR, 1,
>     [Define to 1 if memrchr declared in string.h])],,
>     [#define _GNU_SOURCE
> @@ -274,8 +251,6 @@ AC_CHECK_FUNCS(m4_flatten([
>   	lsetxattr
>   	memset
>   	realpath
> -	lseek64
> -	ftello64
>   	pread64
>   	pwrite64
>   	pwritev


