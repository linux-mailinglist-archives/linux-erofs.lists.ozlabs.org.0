Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8975A52A597
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 17:04:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2fXG2tPTz3bwL
	for <lists+linux-erofs@lfdr.de>; Wed, 18 May 2022 01:03:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2yFj4k6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=91.121.223.63; helo=out1.migadu.com;
 envelope-from=chao.yu@linux.dev; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=q2yFj4k6; dkim-atps=neutral
X-Greylist: delayed 572 seconds by postgrey-1.36 at boromir;
 Wed, 18 May 2022 01:03:50 AEST
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2fX65MK1z2ypD
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 May 2022 01:03:50 +1000 (AEST)
Message-ID: <d9964d97-d692-5f26-3789-f5c9e8fc810f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1652799244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuiXOz92GELRu+TD6vjbhZEdX2kOuUTBlSV7uf2sVvg=;
 b=q2yFj4k61zZYOsCjFXnc+Uhh1FFZoyKRC1tmhpf1yW6xreTPkOvN++r2QXThV3H/pmDzNX
 9E/YqNAuNMEV6l3XqqQnvd07CLP3XCGsG0R/FYGKtM7l3NmsePJsvlmlr3XKcJwSJs/jHm
 R7m0jfo5v0UMc2ITGmE/4T1f/lxn9BE=
Date: Tue, 17 May 2022 22:53:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] erofs: do not prompt for risk any more when using big
 pcluster
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
References: <20220407050101.12556-1-huyue2@coolpad.com>
 <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chao Yu <chao.yu@linux.dev>
In-Reply-To: <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, zbesathu@gmail.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/4/7 13:18, Gao Xiang wrote:
> On Thu, Apr 07, 2022 at 01:01:23PM +0800, Yue Hu wrote:
>> The big pluster feature has been merged for a year, it has been mostly
>> stable now.
>>
>> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
