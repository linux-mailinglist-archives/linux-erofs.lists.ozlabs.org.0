Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7000688F27
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 06:55:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7Pz10VFwz3f4y
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 16:55:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7Pyx6vKTz3bfj
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 16:55:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VandA8f_1675403748;
Received: from 30.221.129.149(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VandA8f_1675403748)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 13:55:49 +0800
Message-ID: <9d14321a-2406-df05-0401-699547c1b12d@linux.alibaba.com>
Date: Fri, 3 Feb 2023 13:55:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] erofs: call erofs_map_dev() inside erofs_map_blocks()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
 <20230203035303.35082-4-jefflexu@linux.alibaba.com>
 <cc67566e-6b49-c351-b8e7-9c842df8325e@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <cc67566e-6b49-c351-b8e7-9c842df8325e@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/3/23 1:52 PM, Gao Xiang wrote:
> 
> 
> On 2023/2/3 11:53, Jingbo Xu wrote:
>> For now erofs_map_blocks() is always followed by erofs_map_dev().
>> Make erofs_map_dev() called inside erofs_map_blocks() to reduce code
>> duplication.
> 
> Could we just integrate mdev into struct erofs_map_blocks?

Okay I will give it a try.


> 
> BTW, I still think erofs_map_dev() is useful since it can handle
> non-inode IO requests, so let's keep this rather than mergeing all
> code into erofs_map_blocks()

Yeah erofs_map_dev() is kept as a separated function API.


-- 
Thanks,
Jingbo
