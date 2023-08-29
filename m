Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980978C737
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 16:19:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZqL92szTz3Wts
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 00:19:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZqL62183z2xr6
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 00:19:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqrkzRY_1693318744;
Received: from 30.236.24.176(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqrkzRY_1693318744)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 22:19:04 +0800
Message-ID: <b5077ec9-4ade-910d-b204-8c49ece23c5d@linux.alibaba.com>
Date: Tue, 29 Aug 2023 22:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/3] erofs-utils: update on-disk format for xattr name
 filter
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230829124127.36719-1-jefflexu@linux.alibaba.com>
 <20230829124127.36719-3-jefflexu@linux.alibaba.com>
 <de02e15d-5bda-760f-dada-e3c8ca8d3390@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <de02e15d-5bda-760f-dada-e3c8ca8d3390@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/29/23 8:49 PM, Gao Xiang wrote:
> 
> 
> On 2023/8/29 20:41, Jingbo Xu wrote:
>> The xattr name bloom filter feature is going to be introduced to speed
>> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
>> lookup when running "ls -lR" workload.
> 
> 
> I think you could just say
> "Let's keep in sync with kernel commit <12-char commit id>."
> 
> here.
> 
> ...
> 
>> ---
> 
> 
> ...
> 
>> +#define EROFS_XATTR_NAME_LEN_MAX    UCHAR_MAX
> 
> where is EROFS_XATTR_NAME_LEN_MAX used?

Indeed it's not used and I can't remember where it's used in the initial
implementation...

I will drop it later.

-- 
Thanks,
Jingbo
