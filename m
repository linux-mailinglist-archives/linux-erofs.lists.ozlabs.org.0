Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E374EA97
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 11:32:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0bJN4c5rz30Np
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 19:32:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0bJD6M8Nz302F
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 19:32:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vn8JXbV_1689067957;
Received: from 30.97.48.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn8JXbV_1689067957)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 17:32:38 +0800
Message-ID: <ae0778ff-da50-d498-f217-5ad18931fbe1@linux.alibaba.com>
Date: Tue, 11 Jul 2023 17:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: fix fsdax unavailability for chunk-based regular
 files
To: Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, huyue2@coolpad.com
References: <20230711062130.7860-1-yinxin.x@bytedance.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230711062130.7860-1-yinxin.x@bytedance.com>
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



On 2023/7/11 14:21, Xin Yin wrote:
> DAX can be used to share page cache between VMs, reducing guest memory
> overhead. And chunk based data format is widely used for VM and
> container image. So enable dax support for it, make erofs better used
> for VM scenarios.
> 
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
