Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A700A494E1F
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jan 2022 13:44:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JfhzB3Fjlz30QX
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jan 2022 23:44:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jfhz1673Gz2xXW
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jan 2022 23:44:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V2MYYzM_1642682637; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2MYYzM_1642682637) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 20:43:59 +0800
Message-ID: <a5b495d3-cafe-548a-2130-b7aa9e597f41@linux.alibaba.com>
Date: Thu, 20 Jan 2022 20:43:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
 <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
 <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
 <YegQOHs9yjIgu1Qi@casper.infradead.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YegQOHs9yjIgu1Qi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/19/22 9:20 PM, Matthew Wilcox wrote:
> On Wed, Jan 12, 2022 at 05:02:13PM +0800, JeffleXu wrote:
>> I'm afraid IDR can't be replaced by xarray here. Because we need an 'ID'
>> for each pending read request, so that after fetching data from remote,
>> user daemon could notify kernel which read request has finished by this
>> 'ID'.
>>
>> Currently this 'ID' is get from idr_alloc(), and actually identifies the
>> position of corresponding read request inside the IDR tree. I can't find
>> similar API of xarray implementing similar function, i.e., returning an
>> 'ID'.
> 
> xa_alloc().
> 

Oh yes. Thanks. I will try to convert to xarray API...

-- 
Thanks,
Jeffle
