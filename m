Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50F78231B
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 07:21:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTgmp4Y7Lz30P0
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 15:20:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RTgmf2wNZz2yVC
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Aug 2023 15:20:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VqAWnpw_1692595240;
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqAWnpw_1692595240)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 13:20:42 +0800
Message-ID: <ea93ff7d-fa24-5151-0504-020f0278c57b@linux.alibaba.com>
Date: Mon, 21 Aug 2023 13:20:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] erofs-utils: mkfs: introduce multi-thread compression
To: Guo Xuenan <guoxuenan@huawei.com>, linux-erofs@lists.ozlabs.org,
 Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20230819180104.4824-1-zhaoyifan@sjtu.edu.cn>
 <8e890c0d-bddb-139d-def0-9e5fac977d37@linux.alibaba.com>
 <3c645595-e612-f6a2-f301-4bc28f845a6d@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3c645595-e612-f6a2-f301-4bc28f845a6d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2023/8/21 13:11, Guo Xuenan via Linux-erofs wrote:
> Hi，Xiang
> 
> Is there a develop branch for multi-thread compression，
> then we can work together to make it better.

If needed, an erofs-utils fork can be made for collaboration
on github.

What's your github username (and yifan's github username as
well)?  Let me send some invitation to you.

Thanks,
Gao Xiang

> 
> Thanks
> Xuenan
