Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91674EE4F3
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 01:56:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KV0ZY4B0Vz2yWn
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 10:56:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.11;
 helo=out199-11.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com
 [47.90.199.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KV0ZQ3WMZz2xB1
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Apr 2022 10:56:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8kzjE3_1648770976; 
Received: from 30.0.141.35(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8kzjE3_1648770976) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 01 Apr 2022 07:56:17 +0800
Message-ID: <557bcf75-2334-5fbb-d2e0-c65e96da566d@linux.alibaba.com>
Date: Fri, 1 Apr 2022 07:56:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 00/19] fscache,erofs: fscache-based on-demand read
 semantics
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/31/22 7:57 PM, Jeffle Xu wrote:
> changes since v6:
> - cachefiles: "fscache: export fscache_end_operation()" is still needed.
>   Since it has been pull requested for 5.18 (not merged yet), it's not
>   included in this patchset.

> 
> 
> Kernel Patchset
> ---------------
> Git tree:
> 
>     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v7
> 
> Gitweb:
> 
>     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v7
> 
> 

I have rebased it to the latest upstream, which has contained David's PR
on fscache/cachefiles. There's no git conflic when rebasing.


-- 
Thanks,
Jeffle
