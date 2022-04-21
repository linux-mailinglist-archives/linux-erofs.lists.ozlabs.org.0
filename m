Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F350A37A
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 16:57:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkgdC2KTnz3bWf
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 00:57:51 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kkgd70hBVz2yHD
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 00:57:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAgCg.U_1650553055; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAgCg.U_1650553055) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Apr 2022 22:57:37 +0800
Message-ID: <e2a38f8c-ba20-0368-c3cb-aeb4d5212cc6@linux.alibaba.com>
Date: Thu, 21 Apr 2022 22:57:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 04/21] cachefiles: notify user daemon when withdrawing
 cookie
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-5-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1445104.1650549959@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1445104.1650549959@warthog.procyon.org.uk>
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
Cc: linux-erofs@lists.ozlabs.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/21/22 10:05 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	 * It's possiblie that object id is still 0 if the cookie looking up
> 
> possiblie -> possible

Thanks.

> 
> Otherwise:
> 
> Acked-by: David Howells <dhowells@redhat.com>

-- 
Thanks,
Jeffle
