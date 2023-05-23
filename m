Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAEC70D296
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 05:55:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQL8562Wpz3cPl
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 13:55:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQL801q1Hz3bWC
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 13:55:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjIKnwx_1684814136;
Received: from 30.97.48.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjIKnwx_1684814136)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 11:55:38 +0800
Message-ID: <f32ab134-5eba-9e71-a61f-31f1544eaecf@linux.alibaba.com>
Date: Tue, 23 May 2023 11:55:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: EROFS Receives Some Useful Improvements With Linux 6.4
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CAD3upLsZ_Y=b4vyWzv4_aX9JOGes=Y-rwqMJ52pDQ+Na+j0xtg@mail.gmail.com>
 <ZGw3a63tT6E+YjS5@debian.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZGw3a63tT6E+YjS5@debian.me>
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
Cc: ceo@teo-en-ming-corp.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/23 20:47, Bagas Sanjaya wrote:
> On Mon, May 01, 2023 at 05:05:06PM +0800, Turritopsis Dohrnii Teo En Ming wrote:
>> Article: EROFS Receives Some Useful Improvements With Linux 6.4
>> Link: https://www.phoronix.com/news/Linux-6.4-EROFS
> 
> Linux 6.4 is on -rc phase (currently v6.4-rc3). Can you try it with
> erofs enabled and report any issues found?
> 
> Also, again, you've mistaken LKML with personal blog/forum. There are
> many forums on the Web discussing Linux for this kind of message (for
> example: Hacker News and linux.org forums). Please DO NOT do spam like
> this in the future.

Yeah, I saw the original post and really had no idea what happened.
If there could be any issue/suggestion about EROFS, you could report
so I could seek time to address it.

Thanks,
Gao XIang

> 
> Bye!
> 
