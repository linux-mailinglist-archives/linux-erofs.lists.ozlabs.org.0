Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA24EFF0E
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Apr 2022 07:32:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KVm061525z2yn9
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Apr 2022 16:32:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KVlzy6wx9z2xfT
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Apr 2022 16:32:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8yMzNQ_1648877547; 
Received: from 30.225.24.59(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8yMzNQ_1648877547) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 02 Apr 2022 13:32:29 +0800
Message-ID: <11bb4271-8a87-945f-96ef-be3a1acd01a5@linux.alibaba.com>
Date: Sat, 2 Apr 2022 13:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 02/19] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
 <20220331115753.89431-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20220331115753.89431-3-jefflexu@linux.alibaba.com>
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
>  
> +	ret = cachefiles_ondemand_init_object(object);
> +	if (ret < 0) {
> +		file = ERR_PTR(ret);
> +		goto out_unuse;
> +	}
> +

Sorry, this patch really depends on [1] which introduces "out_unuse" label.

[1] https://www.spinics.net/lists/linux-cachefs/msg05972.html


My git branch has already contained this commit [2].

[2]
https://github.com/lostjeffle/linux/commit/3c71705e777fa75d37f784640a232db14ce62c31


-- 
Thanks,
Jeffle
