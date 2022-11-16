Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9943C62BD5A
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 13:18:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NC2BS1ZVtz3cJK
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 23:18:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NC2BK2PDRz3cF7
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Nov 2022 23:17:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUxx6gz_1668601073;
Received: from 30.221.128.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUxx6gz_1668601073)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 20:17:54 +0800
Message-ID: <68463af5-952b-a024-21fd-fa9e5fc37eb3@linux.alibaba.com>
Date: Wed, 16 Nov 2022 20:17:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com, dhowells@redhat.com
References: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
 <20221116104502.107431-2-jefflexu@linux.alibaba.com>
 <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeff,

Thanks for the comment!

On 11/16/22 7:58 PM, Jeff Layton wrote:

>>  
>> -/*
>> - * Prepare a read operation, shortening it to a cached/uncached
>> - * boundary as appropriate.
>> - */
>> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
>> -						      loff_t i_size)
>> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
>> +					loff_t *_start, size_t *_len,
>> +					unsigned long *_flags, loff_t i_size)
> 
> _start is never changed, so it should be passed by value instead of by
> pointer. 

Yeah, start is indeed unchanged, and I think it's also reasonable to
pass it by value rather than by pointer.


> I'd also reverse the position of the arguments for _flags and
> i_size.  Otherwise, the CPU/compiler have to shuffle things around more
> in cachefiles_prepare_ondemand_read before they call this.

Yeah I didn't notice the details.


I will fix the above two issues in a quick v4 version.

Many thanks for the feedback.



-- 
Thanks,
Jingbo
