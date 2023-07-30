Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BD768613
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 16:37:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDP960WX4z2yDy
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 00:37:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDP926x8lz2yDT
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 00:37:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoW-1km_1690727840;
Received: from 192.168.75.41(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoW-1km_1690727840)
          by smtp.aliyun-inc.com;
          Sun, 30 Jul 2023 22:37:21 +0800
Message-ID: <ab54e2a5-ecbf-508f-b382-05648fb3a36c@linux.alibaba.com>
Date: Sun, 30 Jul 2023 22:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
 <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
 <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/30 22:28, Thomas Weißschuh wrote:
> Hi Gao!
> 
> On 2023-07-30 22:01:11+0800, Gao Xiang wrote:
>> On 2023/7/30 21:31, Thomas Weißschuh wrote:
>>> On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
>>>> Later we're going to try the self-contained image verification.
>>>> The current superblock checksum feature has quite limited
>>>> functionality, instead, merkle trees can provide better protection
>>>> for image integrity.
>>>
>>> The crc32c checksum is also used by libblkid to gain more confidence
>>> in its filesystem detection.
>>> I guess a merkle tree would be much harder to implement.
>>>
>>> This is for example used by the mount(8) cli program to allow mounting
>>> of devices without explicitly needing to specify a filesystem.
>>>
>>> Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
>>> break when the checksum is removed.
> 
>> I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
>> checksum instead (e.g. just sum each byte up if both
>> EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
>> ignore checksums completely at least in the kernel) if the better
>> filesystem detection by using sb chksum is needed (not sure if other
>> filesystems have sb chksum or just do magic comparsion)?
> 
> Overloading EROFS_FEATURE_SB_CSUM in combination with
> COMPAT_XATTR_FILTER would break all existing deployments of libblkid, so
> it's not an option.

I think for libblkid, you could still use:
   EROFS_FEATURE_SB_CSUM is not set, don't check anything;
   EROFS_FEATURE_SB_CSUM only is set, check with crc32c;
   EROFS_FEATURE_SB_CSUM | COMPAT_XATTR_FILTER (or some other bit) is
set, check with a simpler hash?

> 
> All other serious and halfway modern filesystems do have superblock
> checksums which are also checked by libblkid.
> 
>> The main problem here is after xattr name filter feature is added
>> (xxhash is generally faster than crc32c), there could be two
>> hard-depended hashing algorithms, this increases more dependency
>> especially for embededed devices.
> 
>  From libblkid side nothing really speaks against a simpler checksum.
> XOR is easy to implement and xxhash is already part of libblkid for
> other filesystems.
> 
> The drawbacks are:
> * It would need a completely new feature bit in erofs.
> * Old versions of libblkid could not validate checksums on newer
>    filesystems.

just checking magic for Old versions of libblkid will cause false
positive in which extent?

Thanks,
Gao Xiang

