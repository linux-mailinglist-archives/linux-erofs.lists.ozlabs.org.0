Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC245BA4A8
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 04:36:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTJ9842DLz3bcF
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 12:36:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTJ910bWRz2xGq
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 12:36:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPv3AqH_1663295754;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPv3AqH_1663295754)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 10:35:55 +0800
Message-ID: <96a96aff-5d16-a2e3-2529-58e154e0f728@linux.alibaba.com>
Date: Fri, 16 Sep 2022 10:35:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 3/6] erofs: introduce fscache-based domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-4-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-4-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/15/22 8:42 PM, Jia Zhu wrote:
>  
> +static void erofs_fscache_domain_put(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	mutex_lock(&erofs_domain_list_lock);
> +	if (refcount_dec_and_test(&domain->ref)) {
> +		list_del(&domain->list);
> +		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_unlock(&erofs_domain_list_lock);

I think we can mutex_unlock as long as the domain is removed from the list.


Otherwise LGTM.
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
