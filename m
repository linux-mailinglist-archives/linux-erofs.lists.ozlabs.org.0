Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0974CB71
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 06:55:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzsBX0TcGz3bY2
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 14:55:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzsBR3TWVz301Q
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 14:55:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VmxtpcR_1688964906;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmxtpcR_1688964906)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 12:55:07 +0800
Message-ID: <ead1cb72-392d-f00f-da32-4afa671ec9bf@linux.alibaba.com>
Date: Mon, 10 Jul 2023 12:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] erofs-utils: add a built-in DEFLATE compressor
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Eric Biggers <ebiggers@kernel.org>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
 <20230709182511.96954-3-hsiangkao@linux.alibaba.com>
 <20230710023300.GA185469@sol.localdomain>
 <52875e72-4871-7615-3f20-f02cd9548898@linux.alibaba.com>
 <20230710041638.GA21080@sol.localdomain>
 <607b9642-7bdc-e4f6-f8cc-0096e3c99341@linux.alibaba.com>
In-Reply-To: <607b9642-7bdc-e4f6-f8cc-0096e3c99341@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


(forgot to respond something...)

On 2023/7/10 12:51, Gao Xiang wrote:
> 
> 

...

>>
>>>
>>> I think we could use this way first for the new Zstd support (if they don't have
>>> bandwidth to add a offical fixed-sized output approach), but considering deflate
>>> algorithm is quite easy for me to understand so at least I could have a simple
>>> built-in one to avoid external dependency (mainly considering zlib since it's
>>> quite outdated).  Since EROFS is actually offline compression so the compressed
>>> data correctness can always be checked in advance before image release.
>>
>> Writing an optimized compressor, especially one that implements high compression
>> levels, is very hard.  Are you sure it's something you want to implement and
>> maintain in erofs-utils?

Nope, as I said earlier, I'd like to write a simple one to replace zlib
functionality (kite_deflate already does), and I hope more popular encoders
could have offical modes for EROFS in the long term.  That is something that
I wish to the opensource communities...

Thanks,
Gao Xiang
