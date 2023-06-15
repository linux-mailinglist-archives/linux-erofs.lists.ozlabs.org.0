Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119827318F4
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 14:26:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhhP86NRRz3bNn
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 22:26:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhhP15XXxz30FW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 22:26:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlBPdjL_1686831997;
Received: from 30.221.131.153(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VlBPdjL_1686831997)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 20:26:38 +0800
Message-ID: <49bc2731-5ab6-0156-1915-f14e6c397c45@linux.alibaba.com>
Date: Thu, 15 Jun 2023 20:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] erofs-utils: lib: refactor erofs compressors init
To: Guo Xuenan <guoxuenan@huaweicloud.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-2-guoxuenan@huawei.com>
 <e03b6dd2-91dd-b457-a95b-b7bb22905e46@linux.alibaba.com>
 <7a120496-8e00-1ae1-3268-e5b8d2643919@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7a120496-8e00-1ae1-3268-e5b8d2643919@huaweicloud.com>
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/15 19:37, Guo Xuenan wrote:
> 

...

> Yes, of course, your suggestion is better!
>> Also, please use `struct erofs_compressor` here.
> struct erofs_compressor has been used  lib/compressor.h:15

So we might need another name for this.

Thanks,
Gao Xiang
