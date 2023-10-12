Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD697C6286
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Oct 2023 04:01:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S5XtY6yZ9z3c6Q
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Oct 2023 13:01:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S5XtQ62Cjz30Ng
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Oct 2023 13:01:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtyWj9M_1697076068;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VtyWj9M_1697076068)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:01:10 +0800
Message-ID: <f06fbb72-dbea-6bfa-e5a0-337567708e7b@linux.alibaba.com>
Date: Thu, 12 Oct 2023 10:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To: Chao Yu <chao@kernel.org>, Tiwei Bie <tiwei.btw@antgroup.com>,
 linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
 <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
 <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
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
Cc: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On 2023/10/12 09:10, Chao Yu wrote:
> On 2023/10/10 21:06, Gao Xiang wrote:
>>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Looks fine to me for the version in dev-test branch.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Yeah, thanks! I will add the tag when applying to -next.

Thanks,
Gao Xiang

> 
> Thanks,
