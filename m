Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66074E5B2
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 06:08:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0S5v3cHwz3bbZ
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 14:08:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0S5q6mxVz30PJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 14:08:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vn7.lZs_1689048488;
Received: from 30.97.48.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn7.lZs_1689048488)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 12:08:10 +0800
Message-ID: <c0dab57b-0687-5b44-cdbf-151475f77576@linux.alibaba.com>
Date: Tue, 11 Jul 2023 12:08:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: enable dax for chunk based regular file
To: Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, huyue2@coolpad.com
References: <20230711040239.7410-1-yinxin.x@bytedance.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230711040239.7410-1-yinxin.x@bytedance.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xin,

On 2023/7/11 12:02, Xin Yin wrote:
> DAX can be used to share page cache between VMs, reducing guest memory
> overhead. And chunk based data format is widely used for VM and
> container image. So enable dax support for it, make erofs better used
> for VM scenarios.
> 
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

I really think it's a regression honestly, how about updating
the subject line to:

"erofs: fix fsdax unavailability for chunk-based regular files"

Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")

Thanks,
Gao Xiang
