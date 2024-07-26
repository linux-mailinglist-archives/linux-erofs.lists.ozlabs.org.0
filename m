Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971EA93D0A3
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 11:51:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U2jtsJ/6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVjgd3lXdz3dFH
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 19:51:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U2jtsJ/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVjgY3RhTz3cyc
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 19:51:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 51ACBCE136E;
	Fri, 26 Jul 2024 09:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CB1C32782;
	Fri, 26 Jul 2024 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987460;
	bh=kyxWm7vi7Uey+9KCC09pWxJM549AzmLQVR6ZyDB2V3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U2jtsJ/6IhszHDVTicPZLDLrsVd5S7ryG1SOYMt/2+gK7dZxtyqzgMEYT1z0V/lSA
	 a02xwSeG/mHKEd01ch0QPkdiu2rTdMfh1LSx68JJKJ5soSIRII/HYhuJuziiOEi72w
	 jtsux5x+8VN91ruI/jJEXQu33gCreDTTP5/jSjfqJt21h30IwvfmM+Xx7pnkGUiMUL
	 9NoF0XMNNVErHuC9d0aQXKkaiiiNBCy0wyRDMqn+h159p38j4KWt2TUtN48+1PXxDV
	 +FseXsVM9BeDgSOk76xIxoSJgePUObnAAqv/1mn0/R9lHKc2Ad1l6E4AyXFWKp16d2
	 k1BeQFu6Dtf7g==
Message-ID: <dc70af85-5357-4787-92fb-6da1b298ca79@kernel.org>
Date: Fri, 26 Jul 2024 17:50:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support STATX_DIOALIGN
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
 <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
 <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/7/18 16:35, Gao Xiang wrote:
> 
> 
> On 2024/7/18 16:32, Gao Xiang wrote:
>> From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
> 
> Also I will fix the email address issue
> (Hongbo Li <lihongbo22@huawei.com>) when applying too.
> 
>>
>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>> alignment restrictions are exposed to userspace in a generic
>> way.
>>
>> [Before]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:0
>> dio offset align:0
>> ```
>>
>> [After]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:512
>> dio offset align:512
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
