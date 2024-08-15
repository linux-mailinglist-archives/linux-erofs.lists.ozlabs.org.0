Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12081952846
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 05:28:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cJAQWbed;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkrFL6QJjz2yYf
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 13:28:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cJAQWbed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkrFF49p1z2yTy
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 13:28:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723692522; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o8guPVMpd+KRFZm81Y1FVTRfJUl5lzVITg93HFo0VyU=;
	b=cJAQWbednkkAeczM7pUmCaAaxkHg9kOtoWgGViecki4BY+sUyZCpHCvA/8B16/zFnfqxQ9AQGFqzweHokM+a+7gl+LGWWJluuAKEXr6vvLoHQFNcxzEDtPil/j3kJuFrYbaAmR48kW08+HBqsEkbfp6XTKXdIKoVrI+aewlJqWo=
Received: from 30.221.131.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCvAqKd_1723692519)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 11:28:41 +0800
Message-ID: <96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com>
Date: Thu, 15 Aug 2024 11:28:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: adjust volume label maximum length to the
 kernel implementation
To: Naoto Yamaguchi <wata2ki@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
 <20240814155353.19076-1-naoto.yamaguchi@aisin.co.jp>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240814155353.19076-1-naoto.yamaguchi@aisin.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Naoto,

On 2024/8/14 23:53, Naoto Yamaguchi wrote:
> The erofs implementation of kernel has limitation of the volume label length.
> The volume label data size of super block is 16 bytes.
> The kernel implementation requires to null terminate inside a that 16 bytes.
> 
> Logs:
>    $ ./mkfs/mkfs.erofs test16.erofs -L 0123456789abcdef test/
>    $ mount -o loop ./test16.erofs ./mnt/
>    $ dmesg
>    [26477.019283] erofs: (device loop0): erofs_read_superblock: bad volume name without NIL terminator
> 
>    $ ./mkfs/mkfs.erofs test15.erofs -L 0123456789abcde test/
>    $ mount -o loop ./test15.erofs ./mnt/
>    $ dmesg
>    [26500.516871] erofs: (device loop0): mounted with root inode @ nid 36.
> 
> This patch adjusts volume label maximum length to the kernel implementation.
> 
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>

Thanks for catching this, it's indeed an issue.

Although that is not intended, but considering it has
been the case for quite long time.

> ---
>   mkfs/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b7129eb..ff26c16 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -151,7 +151,7 @@ static void usage(int argc, char **argv)
>   	printf(
>   		" -C#                   specify the size of compress physical cluster in bytes\n"
>   		" -EX[,...]             X=extended options\n"
> -		" -L volume-label       set the volume label (maximum 16)\n"
> +		" -L volume-label       set the volume label (maximum 15 character)\n"

15 character might be ambiguous here, since there could be other encodings I guess?

Thanks,
Gao Xiang
