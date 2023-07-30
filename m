Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F876861C
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 16:56:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDPb34s74z2yDy
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 00:56:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDPb01mBpz2y3Y
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 00:56:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoW3cYo_1690728979;
Received: from 30.27.65.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoW3cYo_1690728979)
          by smtp.aliyun-inc.com;
          Sun, 30 Jul 2023 22:56:21 +0800
Message-ID: <abe47891-3bcf-6f0c-d71f-e7bbe24999d4@linux.alibaba.com>
Date: Sun, 30 Jul 2023 22:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
 <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
 <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
 <ab54e2a5-ecbf-508f-b382-05648fb3a36c@linux.alibaba.com>
 <498e86f9-a7c3-4689-b277-319633a11789@t-8ch.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <498e86f9-a7c3-4689-b277-319633a11789@t-8ch.de>
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



On 2023/7/30 22:49, Thomas Weißschuh wrote:
> On 2023-07-30 22:37:19+0800, Gao Xiang wrote:
>> On 2023/7/30 22:28, Thomas Weißschuh wrote:
>>> On 2023-07-30 22:01:11+0800, Gao Xiang wrote:
>>>> On 2023/7/30 21:31, Thomas Weißschuh wrote:
>>>>> On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
>>>>>> Later we're going to try the self-contained image verification.
>>>>>> The current superblock checksum feature has quite limited
>>>>>> functionality, instead, merkle trees can provide better protection
>>>>>> for image integrity.
>>>>>
>>>>> The crc32c checksum is also used by libblkid to gain more confidence
>>>>> in its filesystem detection.
>>>>> I guess a merkle tree would be much harder to implement.
>>>>>
>>>>> This is for example used by the mount(8) cli program to allow mounting
>>>>> of devices without explicitly needing to specify a filesystem.
>>>>>
>>>>> Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
>>>>> break when the checksum is removed.
>>>
>>>> I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
>>>> checksum instead (e.g. just sum each byte up if both
>>>> EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
>>>> ignore checksums completely at least in the kernel) if the better
>>>> filesystem detection by using sb chksum is needed (not sure if other
>>>> filesystems have sb chksum or just do magic comparsion)?
>>>
>>> Overloading EROFS_FEATURE_SB_CSUM in combination with
>>> COMPAT_XATTR_FILTER would break all existing deployments of libblkid, so
>>> it's not an option.
>>
>> I think for libblkid, you could still use:
>>    EROFS_FEATURE_SB_CSUM is not set, don't check anything;
>>    EROFS_FEATURE_SB_CSUM only is set, check with crc32c;
>>    EROFS_FEATURE_SB_CSUM | COMPAT_XATTR_FILTER (or some other bit) is
>> set, check with a simpler hash?
> 
> We could change this in newer versions of libblkid.
> But we can't change the older versions that are already deployed today.
> 
> And the current code does
> 
> if (EROFS_FEATURE_SB_CSUM)
>    validate_crc32c();
> 
> So to stay compatible we need to keep the relationship of
> EROFS_FEATURE_SB_CSUM -> crc32c.

Yes, you are right, thanks for reminder.  We really need a new bit
for this.

> 
>>> All other serious and halfway modern filesystems do have superblock
>>> checksums which are also checked by libblkid.
>>>
>>>> The main problem here is after xattr name filter feature is added
>>>> (xxhash is generally faster than crc32c), there could be two
>>>> hard-depended hashing algorithms, this increases more dependency
>>>> especially for embededed devices.
>>>
>>>   From libblkid side nothing really speaks against a simpler checksum.
>>> XOR is easy to implement and xxhash is already part of libblkid for
>>> other filesystems.
>>>
>>> The drawbacks are:
>>> * It would need a completely new feature bit in erofs.
>>> * Old versions of libblkid could not validate checksums on newer
>>>     filesystems.
>>
>> just checking magic for Old versions of libblkid will cause false
>> positive in which extent?
> 
> Hard to tell for sure. But it would not surprise me if it would indeed
> affect users as experience has shown.
> 
> Imagine for example erofs filesystems that have then been overwritten
> with another filesystem but still have a valid erofs magic.
> With the checksum validation the new filesystem is detected correctly,
> without it will find the old erofs.
> 
> Sometimes the files inside some filesystem look like the superblock of
> another filesystem and break the detection.
> 
> etc.
> 
> Having some sort of checksum makes this much easier to handle.

Yes, but just checking magic for old versions of libblkid for new
generated images only.

I'm not sure about this all (I just suggest that we might need a simpler
algorithm like XOR instead for sb_chksum otherwise it seems too heavy),
let me just drop this commit from -next for further discussion.

Thanks,
Gao Xiang
