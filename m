Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CE966EFA
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 04:59:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwfqP4FLWz30Tt
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 12:58:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725073135;
	cv=none; b=DhLK8z6q3T4G71ZmFG0zKZc8Kfnu0fWBm0z8a9Mtn+qjH/0Fe9B10l8UTZN9GeEPpds4UjCMCieuu/sGhoBPdQw76N1xt+cZ+DFaPExs9DwKtvr3/87Z5TxCZL/tMXTjWoygZEy0mlJXWexu/thX511Vjo/rBDDVW9HliShWbeqAviSMo1oLBhFGqQ6Gg6tvchhj6dyNhYRjqeNA77sNhHe64ejLNcWPq1dGcWf2SkwJYTHnmVDCvVG0nrnZ+lyrJI5wM+xOzN6gaygYsxzUuYqUfYmDVWlTMXt/5ASyJPcq5WJRAGGn88gNnjl0rk88QeqWtGeppZuKqXYKbqE0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725073135; c=relaxed/relaxed;
	bh=l0ZN0V2wDGVdJYLmBlxDemZT06auDRxXuERgQRkl+h4=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=IeQdyChMxZqJ9cTfAhYRJS8vNokbK7dN5sPmOkqz1MF+8zSE4qxuxOlo6H1095AQ5SazLAVPSbqIY+obOufHKG76ChJ2cucUXkPlJuiQBamh5O7U1UoVUGonnIqx1ten5KC7bebADBOW2a4dpHlq1YPwZ1GlNeMwkhbW6Daq6jyNNrQTLLz7BupIBI4HMLtpWjgpXzkp6uCyH+011f6hsJpe7VGTHa4vNWpJ8rDr9v4WUgrelHciOkiKVh6JH9udc60O7zjR7RTh8+uqHqeR0LYs3FHJSqZL5io3LD4VgrVgyiBrlDwryJd6rNCv8u4asA8tpqy5aX23GhNJqunaVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EKMBnSF4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EKMBnSF4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwfqM2sHDz2ywy
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 12:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725073131; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l0ZN0V2wDGVdJYLmBlxDemZT06auDRxXuERgQRkl+h4=;
	b=EKMBnSF4of7wqeDRMpKaXoYandb8uYtLeEjXkirWzKeF9MnBluy4kIr+/M6X6J7Mo1O7Pk2OTf3ADZLOIrNJu6obqsxZomsbiqN3fWKyJ1VK2li/XD2L4gkwFdgiI+bJ4Y66fpzq4tjnjHmwvukDqXIa1dTf0H6PqigfKd4x8o4=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyCJXa_1725073129)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 10:58:50 +0800
Message-ID: <7e1b1c15-dd7c-4565-a1dc-ba6a49cf249f@linux.alibaba.com>
Date: Sat, 31 Aug 2024 10:58:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
To: Sandeep Dhavale <dhavale@google.com>, liujinbao1 <jinbaoliu365@gmail.com>
References: <20240829122342.309611-1-jinbaoliu365@gmail.com>
 <CAB=BE-QfSB_BZNA_ZPt6G6WTbruHs8QtN9guGfZTkyjGjJNy5Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-QfSB_BZNA_ZPt6G6WTbruHs8QtN9guGfZTkyjGjJNy5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: mazhenhua@xiaomi.com, kernel-team@android.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/8/31 05:46, Sandeep Dhavale wrote:
> Hi Liujinbao,
> On Thu, Aug 29, 2024 at 5:24 AM liujinbao1 <jinbaoliu365@gmail.com> wrote:
>>
>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>
>> When i=0 and err is not equal to 0,
>> the while(-1) loop will enter into an
>> infinite loop. This patch avoids this issue
>>
>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
>> ---
>>   fs/erofs/decompressor.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index c2253b6a5416..672f097966fa 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -534,18 +534,18 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>
>>   int __init z_erofs_init_decompressor(void)
>>   {
>> -       int i, err;
>> +       int i, err = 0;
>>
>>          for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>                  err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>> -               if (err) {
>> -                       while (--i)
>> +               if (err && i) {
>> +                       while (i--)
> Actually there is a subtle bug in this fix. We will never enter the if
> block here when i=0 and err is set which we were trying to fix.
> This will cause z_erofs_decomp[0]->init() error to get masked and we
> will continue the outer for loop (i.e. when i=0 and err is set).

Thanks for catching this!

Yes, that needs to be resolved, and I will replace the
patch to the new version.

Thanks,
Gao Xiang

> 
> Yes original code had the bug but probably simpler and readable fix could be
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c2253b6a5416..abf2db2ba10c 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -539,7 +539,7 @@ int __init z_erofs_init_decompressor(void)
>          for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>                  err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>                  if (err) {
> -                       while (--i)
> +                       while (i-- > 0)
>                                  if (z_erofs_decomp[i])
>                                          z_erofs_decomp[i]->exit();
>                          return err;
> 
> Let me know if you want me to send a fix with your Reported-by or you
> can send quick v3.
> 
> Thanks,
> Sandeep.
> 
