Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28151E742
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 15:08:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KwSRh2Zxlz3c8t
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 23:08:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KwSRZ6GB5z3byS
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 23:08:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0VCWsufy_1651928895; 
Received: from 30.32.88.199(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCWsufy_1651928895) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 May 2022 21:08:16 +0800
Message-ID: <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
Date: Sat, 7 May 2022 21:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2] erofs: change to use asyncronous io for fscache
 readpage/readahead
Content-Language: en-US
To: Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
 dhowells@redhat.com
References: <20220507083154.18226-1-yinxin.x@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220507083154.18226-1-yinxin.x@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/7/22 4:31 PM, Xin Yin wrote:
> Use asyncronous io to read data from fscache may greatly improve IO
> bandwidth for sequential buffer read scenario.
> 
> Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> and read data from fscache asyncronously. Make .readpage()/.readahead()
> to use this new helper.
> 
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---

s/asyncronous/asynchronous/
s/asyncronously/asynchronously/

BTW, "convert to asynchronous readahead" may be more concise?

Apart from that, LGTM

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jeffle
