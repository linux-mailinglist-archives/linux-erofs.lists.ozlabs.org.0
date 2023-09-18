Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943337A47BA
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Sep 2023 13:01:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rq20n0W8rz2yts
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Sep 2023 21:01:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rq20d23S0z2yTN
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Sep 2023 21:01:19 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsLYMEx_1695034871;
Received: from 30.221.128.148(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsLYMEx_1695034871)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 19:01:12 +0800
Message-ID: <c6141f42-1f3d-1e3a-fb81-b6d830c8931e@linux.alibaba.com>
Date: Mon, 18 Sep 2023 19:01:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v9] erofs-utils: add support for fuse 2/3 lowlevel API
To: Li Yiyan <lyy0627@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230903113823.873232-1-lyy0627@sjtu.edu.cn>
 <26f9be6d-34c0-3c40-ba88-1c9c3af9ee02@linux.alibaba.com>
 <afc85f30-948f-405c-8c52-f696666d1e5e@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <afc85f30-948f-405c-8c52-f696666d1e5e@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yiyan,

On 2023/9/18 17:01, Li Yiyan wrote:
> Hi Xiang:
> 
> Thanks for your thoughtful comments, here are my replies.

Thanks for the reply.  I will check this later, but we're
too late for this commit in erofs-utils v1.7 since erofsfuse
is an important tool which could have impacts.  I tend to
apply it after erofs-utils v1.7 is released.

Thanks,
Gao Xiang
