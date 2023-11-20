Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE517F0B08
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 04:31:21 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JoUsK73I;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYY2H10Byz3cPS
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 14:31:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JoUsK73I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYY275mhnz30P0
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 14:31:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 9177BB80DCB;
	Mon, 20 Nov 2023 03:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4606FC433C7;
	Mon, 20 Nov 2023 03:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700451065;
	bh=uxxAGRWdwqBmgwfEnUwOzhTgqvnU5E0LeL4YVdvlZk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JoUsK73IFpg6cVkHckq09vpfXPv+i83dvhY3VhS/9lDU4sNMaF6A7g/mRX7jRLmEj
	 Th4MxtGaH3qSdfJwqlJuzpU9+Gre6aF0bcR1Azc17UqAk7wEcXzXT5rOI8xlpFAyka
	 q6S+d0ytUZ++AuKTWzsAltANwA438nv9zmZrRxvy/bJmx3wzOgrNhtNz3J3Uv0HOnX
	 dmoROY2ji976QOL9xNQvclfXDzBL0OQpCzlXquKMSBkvmIzr+zeGY4MqrAWthtuPhK
	 5YRRLujXDPJQ2k8GBWRDS8NdEDwsJpIEisk6WfA2Fjchn1fLAq0twaf0qqoV5YCFeF
	 7pZ/eyR5ZFmIg==
Message-ID: <43466ecc-7218-e813-7a4f-bcce30f9b3fb@kernel.org>
Date: Mon, 20 Nov 2023 11:31:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add EROFS webpage
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
 <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
 <056d09c0-eb0d-2092-0766-bf253a9d8751@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <056d09c0-eb0d-2092-0766-bf253a9d8751@linux.alibaba.com>
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
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/11/20 11:23, Gao Xiang wrote:
> 
> 
> On 2023/11/20 11:18, Chao Yu wrote:
>> On 2023/11/17 16:53, Gao Xiang wrote:
>>> Add a new `W:` field of the EROFS entry points to the documentation
>>> site at <https://erofs.docs.kernel.org>.
>>>
>>> In addition, update the in-tree documentation and Kconfig too.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Nice work!
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Hi Chao,
> 
> Thanks for the time and review! but I've already do a tag this morning
> for Linus later so it may not contain this tag, sorry about that.

Xiang,

No problem, it seems I replied a little bit late. :-P

Thanks,

> 
> Thanks for the review again!
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>> ---
>>>   Documentation/filesystems/erofs.rst | 4 ++++
>>>   MAINTAINERS                         | 1 +
>>>   fs/erofs/Kconfig                    | 2 +-
>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
>>> index 57c6ae23b3fc..cc4626d6ee4f 100644
>>> --- a/Documentation/filesystems/erofs.rst
>>> +++ b/Documentation/filesystems/erofs.rst
>>> @@ -91,6 +91,10 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
>>>   - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>>> +For more information, please also refer to the documentation site:
>>> +
>>> +- https://erofs.docs.kernel.org
>>> +
>>>   Bugs and patches are welcome, please kindly help us and send to the following
>>>   linux-erofs mailing list:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 97f51d5ec1cf..cf39d16ad22a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7855,6 +7855,7 @@ R:    Yue Hu <huyue2@coolpad.com>
>>>   R:    Jeffle Xu <jefflexu@linux.alibaba.com>
>>>   L:    linux-erofs@lists.ozlabs.org
>>>   S:    Maintained
>>> +W:    https://erofs.docs.kernel.org
>>>   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>>>   F:    Documentation/ABI/testing/sysfs-fs-erofs
>>>   F:    Documentation/filesystems/erofs.rst
>>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>>> index e540648dedc2..1d318f85232d 100644
>>> --- a/fs/erofs/Kconfig
>>> +++ b/fs/erofs/Kconfig
>>> @@ -21,7 +21,7 @@ config EROFS_FS
>>>         performance under extremely memory pressure without extra cost.
>>>         See the documentation at <file:Documentation/filesystems/erofs.rst>
>>> -      for more details.
>>> +      and the web pages at <https://erofs.docs.kernel.org> for more details.
>>>         If unsure, say N.
