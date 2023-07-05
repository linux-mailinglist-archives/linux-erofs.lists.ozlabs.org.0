Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3383747C3A
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 06:59:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwnWn4NDQz2yLP
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 14:59:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwnWh2WmZz307K
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 14:59:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfLZPq_1688533159;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmfLZPq_1688533159)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 12:59:20 +0800
Message-ID: <8b2a0c63-939f-720a-b532-495fcbba2611@linux.alibaba.com>
Date: Wed, 5 Jul 2023 12:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] erofs-utils: Provide identical functionality without
 libuuid
To: Norbert Lange <nolange79@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230703215803.4476-1-nolange79@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230703215803.4476-1-nolange79@gmail.com>
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
Cc: Huang Jianan <huangjianan@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/4 05:58, Norbert Lange wrote:
> The motivation is to have standalone (statically linked) erofs binaries
> for simple initrd images, that are nevertheless able to (re)create
> erofs images with a given UUID.
> 
> For this reason a few of libuuid functions have implementations added
> directly in erofs-utils.
> A header liberofs_uuid.h provides the new functions, which are
> always available. A further sideeffect is that code can be simplified
> which calls into this functionality.
> 
> The uuid_unparse function replacement is always a private
> implementation and split into its own file, this further restricts
> the (optional) dependency on libuuid only to the erofs-mkfs tool.
> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>

I've rebased it on -dev branch (rather than other branches) and
apply it to experimental branch for testing.
