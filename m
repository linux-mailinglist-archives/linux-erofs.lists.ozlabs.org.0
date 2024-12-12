Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF29EE37C
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 10:55:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y87B70p5tz30Wj
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 20:55:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733997309;
	cv=none; b=IfB2zFuTJ1iAPkfgL6UziKYXNvUepyNEGYm9YnKXy+uVSUZtl3cnX2m4JhPCe+2vX61Q+7bmUhpmO5WGffyX6ByVvZeQyd8NRcwrsVZC0Q+aYBwB6GOtbOb6rdiMabYyRA9IxoI/yFUgyQ9BfjnpugOJZn04dt1NOK4SLFmiIIjWeMpiqE+Wah8zcnz4QMBwcREMNIDnoZJ2sB9U+IemkqOsVMXukPdXFb3w3WY1M6Zro6LSdPpbvynI+eos83bYlujUtZWe28dpP7+vd6FfNL63rSks9wxw0r85G8a/QmpcougOrspmV6emUCuNQzKQ4Vf8/BmepVr9u8M4sNNrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733997309; c=relaxed/relaxed;
	bh=MhPxaohRtcVFCgu+6pO9PV+V21/fUNm3wSUdV7+Tv70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myjhYv6bT6bKcYNvHontDnCRi6i1y9CguPrwr1vcfpYJY1p23hGFy85NyKU14coJsXEqsx3Ey3h3EApCzKt0+sN9HLQJLLuSGym2wEpX1aJOMceHOdQS+5Fbj8r1tUPcaUd7fJ8GfBq0xmRL90+F42+cxk0kDY5R0wP0WxboSy7tE+gfLdUravpOskxT+XpasRDD4SBsJRaKE4MbugUrHN6NcPcbY0Td5lqoFwkVqmpho+rvK90JOtpdwxvBq7uyo27NchEPjOqPxUPCnhOjSz5x95t6UWhwSTMpi8rtR5+CFF3xFFhxUZM94kA6UZoGYc/rfVVhtuQTXA2fnxurig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZaYjHNwh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZaYjHNwh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y87B30SMrz2yFP
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 20:55:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733997299; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MhPxaohRtcVFCgu+6pO9PV+V21/fUNm3wSUdV7+Tv70=;
	b=ZaYjHNwh9poNsKnwIENBlRjYh4mRY+kFjOLS7Kf5wh44FHyZ/AaSt+KKe+5Qk/VwkGCT/uU1bAkXqd1pBJd8NZIOQoMkN0vUE7uAIWJSz/ojTz/FOWtK+EAF9sgtJOZ24mmAz1dOGogUYaZK+0taDqbk6ob9z2F9LefvvL3dGzE=
Received: from 30.221.129.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLIZU1_1733997297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 17:54:58 +0800
Message-ID: <05bd2d2b-1008-4310-8e20-7e44399356d0@linux.alibaba.com>
Date: Thu, 12 Dec 2024 17:54:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add --hardlink-dereference option
To: Paul M <katexochen0@gmail.com>
References: <20241211150734.97830-1-katexochen0@gmail.com>
 <41009b11-08e2-4e48-99be-3d59666593ad@linux.alibaba.com>
 <CAGTe2AE9er2TXc0C2hBgincWXqPEmJzq8_nCzSyLTJkscYqg6w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGTe2AE9er2TXc0C2hBgincWXqPEmJzq8_nCzSyLTJkscYqg6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/12 17:40, Paul M wrote:
> Hi Gao,
> 
> On 2024/12/11 17:11, Gao Xiang wrote:
>>
>> Hi Paul,
>>
>> On 2024/12/11 23:07, Paul Meyer wrote:
>>> Add option --hardlink-dereference to dereference hardlinks when
>>> creating an image. Instead of reusing the inode, hardlinks are added
>>> as separate inodes. This is useful for reproducible builds, when the
>>> rootfs is space-optimized using hardlinks on some machines, but not on
>>> others.
>>
>> Thanks for the patch!
>>
>> Yet I fail to parse the feature, why this feature is useful
>> for reproducible builds? IOWs, without this feature (or
>> hardlinks are used), what's the exact impact that you don't
>> want to?
> 
> Sure, here is our full use case: We are building an erofs image with Nix.
> Nix stores the rootfs in the nix store (/nix/store). Now there is an option
> in nix to enable store optimization via hardlinks. In case optimization is
> enabled, files with identical content are turned into hardlinks to save space,
> as nix store paths are read-only anyway. If I create a rootfs with
> two identical files, those will be hardlinked on systems with optimization
> enabled, but have different inodes on systems where optimization is disabled.
> When building an erofs, the resulting image will have one inode less on
> the system where files are hardlinked.
> The goal is to make the image bit-by-bit reproducible on both systems.
> By dereferencing hardlinks, we get the exact same image no matter whether
> the system uses hardlink optimizations or not.
> 
> There is a comparable tar option with the same name.

Ok, thanks for letting me know.
That sounds more meaningful to me, but
could you update the option as `--hard-dereference` (although
I don't verify the tar behavior) and usage() too?

Otherwise it looks good to me.

Thanks,
Gao Xiang

> 
> Thanks,
> Paul
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
>>> Signed-off-by: Paul Meyer <katexochen0@gmail.com>
>>> ---
>>>    include/erofs/config.h | 1 +
>>>    lib/inode.c            | 2 +-
>>>    mkfs/main.c            | 4 ++++
>>>    3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/erofs/config.h b/include/erofs/config.h
>>> index cff4cea..8399afb 100644
>>> --- a/include/erofs/config.h
>>> +++ b/include/erofs/config.h
>>> @@ -58,6 +58,7 @@ struct erofs_configure {
>>>        bool c_extra_ea_name_prefixes;
>>>        bool c_xattr_name_filter;
>>>        bool c_ovlfs_strip;
>>> +     bool c_hardlink_dereference;
>>>
>>>    #ifdef HAVE_LIBSELINUX
>>>        struct selabel_handle *sehnd;
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 7e5c581..5d181b3 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
>>>         * hard-link, just return it. Also don't lookup for directories
>>>         * since hard-link directory isn't allowed.
>>>         */
>>> -     if (!S_ISDIR(st.st_mode)) {
>>> +     if (!S_ISDIR(st.st_mode) && (!cfg.c_hardlink_dereference)) {
>>>                inode = erofs_iget(st.st_dev, st.st_ino);
>>>                if (inode)
>>>                        return inode;
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index d422787..09e39f5 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -85,6 +85,7 @@ static struct option long_options[] = {
>>>        {"mkfs-time", no_argument, NULL, 525},
>>>        {"all-time", no_argument, NULL, 526},
>>>        {"sort", required_argument, NULL, 527},
>>> +     {"hardlink-dereference", no_argument, NULL, 528},
>>>        {0, 0, 0, 0},
>>>    };
>>>
>>> @@ -846,6 +847,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>>>                        if (!strcmp(optarg, "none"))
>>>                                erofstar.try_no_reorder = true;
>>>                        break;
>>> +             case 528:
>>> +                     cfg.c_hardlink_dereference = true;
>>> +                     break;
>>>                case 'V':
>>>                        version();
>>>                        exit(0);
>>

