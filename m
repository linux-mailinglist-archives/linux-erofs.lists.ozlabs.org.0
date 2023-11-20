Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE727F0AF0
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 04:23:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYXs96rSqz3cPR
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 14:23:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.16; helo=out199-16.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYXs619fzz30P0
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 14:23:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vwg0Exo_1700450581;
Received: from 30.97.48.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vwg0Exo_1700450581)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 11:23:02 +0800
Message-ID: <056d09c0-eb0d-2092-0766-bf253a9d8751@linux.alibaba.com>
Date: Mon, 20 Nov 2023 11:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: erofs: add EROFS webpage
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
 <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
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



On 2023/11/20 11:18, Chao Yu wrote:
> On 2023/11/17 16:53, Gao Xiang wrote:
>> Add a new `W:` field of the EROFS entry points to the documentation
>> site at <https://erofs.docs.kernel.org>.
>>
>> In addition, update the in-tree documentation and Kconfig too.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Nice work!
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Hi Chao,

Thanks for the time and review! but I've already do a tag this morning
for Linus later so it may not contain this tag, sorry about that.

Thanks for the review again!

Thanks,
Gao Xiang

> 
> Thanks,
> 
>> ---
>>   Documentation/filesystems/erofs.rst | 4 ++++
>>   MAINTAINERS                         | 1 +
>>   fs/erofs/Kconfig                    | 2 +-
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
>> index 57c6ae23b3fc..cc4626d6ee4f 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -91,6 +91,10 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
>>   - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>> +For more information, please also refer to the documentation site:
>> +
>> +- https://erofs.docs.kernel.org
>> +
>>   Bugs and patches are welcome, please kindly help us and send to the following
>>   linux-erofs mailing list:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97f51d5ec1cf..cf39d16ad22a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7855,6 +7855,7 @@ R:    Yue Hu <huyue2@coolpad.com>
>>   R:    Jeffle Xu <jefflexu@linux.alibaba.com>
>>   L:    linux-erofs@lists.ozlabs.org
>>   S:    Maintained
>> +W:    https://erofs.docs.kernel.org
>>   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>>   F:    Documentation/ABI/testing/sysfs-fs-erofs
>>   F:    Documentation/filesystems/erofs.rst
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index e540648dedc2..1d318f85232d 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -21,7 +21,7 @@ config EROFS_FS
>>         performance under extremely memory pressure without extra cost.
>>         See the documentation at <file:Documentation/filesystems/erofs.rst>
>> -      for more details.
>> +      and the web pages at <https://erofs.docs.kernel.org> for more details.
>>         If unsure, say N.
