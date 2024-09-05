Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0F96CCDE
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 04:56:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzkXW2D4fz2ypP
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 12:56:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725505000;
	cv=none; b=HCJnJjBkL69++P+pik7HDYshbOmkpL7mx12x0kwUSHFQTBSeX94KQkzN7DiuHhlOGGXykYS2Jw9qOEU7GndfKpqCVmSqDy7x1VpOoeTh8N75+T8lyMwrSDqroHr0XLKWpB0oSYKQZkLe1kT8rHOZiOloUsax+FGiNDXWzea8X2GcrjV9wqd9hip7R+T5KQykcuJ5SG8J4TyFMsFXBIVqviqJWi5f1qxjl+/130O0ftPxi6fCKdeUwEGkRmHNcCYXdKdNIlBwH/NTIMlxn6+9Nh7w66lOEVDNafokvwVKLEXUz9xUK+bq/Dqo+uSD/F0K0Pl4kt1FbMKCAZB36ihsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725505000; c=relaxed/relaxed;
	bh=sWJsfhZEAzimw/CjSg2O/sJw8fyoCvVhBpsr3Oj7WI0=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To:Content-Type; b=YbWa8uHJea3Cex/ngZBwYz55I+1uE6o0BGQP56W+DxKeJiljoozclJLNMF0rHN6rTo2PlIDwjqoKCz1Q4XGISzNEVcinXOClF/br4LAdL2spjwyK0hQFkDT2QF8A/uZKtGJ3A1Cjd5/yRNpdH1Zysls7LEs2R18zvJkthgZzwb//PNqRhzls9d/4x2JmVFZX0W9X7mG+8VYEMXyom5henkdfnFh5Dv5R6gdf6mvIcKZ+fV9dlFYDhXRc6prdOqfHZzt6pNKgmKx6JC2laIw5QqMlkqYKdTZMe5MsvfR8M3/AqJ2yiJe0xgY549NeQbkUT4NecpGcicbRm+XfpPKo4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sucokPDj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sucokPDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzkXQ6qh6z2xYk
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 12:56:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725504993; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=sWJsfhZEAzimw/CjSg2O/sJw8fyoCvVhBpsr3Oj7WI0=;
	b=sucokPDjCECaLcOvsw5e8EnOqLVDJ3mpyPxCcuSck2z65ZBIqjH0uvLxidOzfgNRFY59q374wGKHWItrHElrRKHN8BJBI2EdnRaahrXb2aLL9myxVONkA1zHgKveO6DhdJy2C30oyQ0FEIVfVrvqn/6doCGZo/LgXB/H2ilTLl0=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJYsWO_1725504991)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 10:56:31 +0800
Message-ID: <5e9801aa-5655-4762-b0f7-538dad273f16@linux.alibaba.com>
Date: Thu, 5 Sep 2024 10:56:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sandeep Dhavale <dhavale@google.com>, liujinbao1 <jinbaoliu365@gmail.com>
References: <20240829122342.309611-1-jinbaoliu365@gmail.com>
 <CAB=BE-QfSB_BZNA_ZPt6G6WTbruHs8QtN9guGfZTkyjGjJNy5Q@mail.gmail.com>
 <7e1b1c15-dd7c-4565-a1dc-ba6a49cf249f@linux.alibaba.com>
In-Reply-To: <7e1b1c15-dd7c-4565-a1dc-ba6a49cf249f@linux.alibaba.com>
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
Cc: mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/31 10:58, Gao Xiang wrote:
> Hi Sandeep,
> 
> On 2024/8/31 05:46, Sandeep Dhavale wrote:
>> Hi Liujinbao,
>> On Thu, Aug 29, 2024 at 5:24 AM liujinbao1 <jinbaoliu365@gmail.com> wrote:
>>>
>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>
>>> When i=0 and err is not equal to 0,
>>> the while(-1) loop will enter into an
>>> infinite loop. This patch avoids this issue
>>>
>>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
>>> ---
>>>   fs/erofs/decompressor.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>>> index c2253b6a5416..672f097966fa 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -534,18 +534,18 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>>
>>>   int __init z_erofs_init_decompressor(void)
>>>   {
>>> -       int i, err;
>>> +       int i, err = 0;
>>>
>>>          for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>                  err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>> -               if (err) {
>>> -                       while (--i)
>>> +               if (err && i) {
>>> +                       while (i--)
>> Actually there is a subtle bug in this fix. We will never enter the if
>> block here when i=0 and err is set which we were trying to fix.
>> This will cause z_erofs_decomp[0]->init() error to get masked and we
>> will continue the outer for loop (i.e. when i=0 and err is set).
> 

Ping? could anyone submit a proper fix for this?

Or just

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..dfb77f4e68b4 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,8 +539,8 @@ int __init z_erofs_init_decompressor(void)
         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
                 if (err) {
-                       while (--i)
-                               if (z_erofs_decomp[i])
+                       while (i)
+                               if (z_erofs_decomp[--i])
                                         z_erofs_decomp[i]->exit();
                         return err;
                 }

to avoid underflowed `i` (although it should have no real impact.)

Thanks,
Gao Xiang
