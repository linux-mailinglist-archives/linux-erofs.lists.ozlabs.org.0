Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B42994298
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 10:48:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN8n93zr4z2yNs
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 19:48:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728377308;
	cv=none; b=gOGPuj9AVYAunjXZJJFim5UiteZB5itwdiFHFbMTGQQPF1WYoabZ1bSxFKJbZfkcCaiBwiQn+TTQaBH5/tZcngFTOu986tzwLX4RULL5Dl6virx0r2v435J5FDPfArmM7HaU5Ahh9fCmU6Vh0gIPPrGzQtHFryuqvmWnZQIgX32B9kYS6fkD7dY5P4i0g65aCyNBzy++slVoQdrE65atZre0c+yenwJl5QLhlEVSSuDpkzf5P2bO9NxdIA+a4BixJAVLdANlohEsgCAIkx4RPzQ9LDgY0auq9Cj2yTLxD93oFKfKSnNJ76uqAh4hEJhW2+vcc9cPLz93VH76Fvev5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728377308; c=relaxed/relaxed;
	bh=0NyW6bEkcTAV3r2ZXDGCX9ZEqYnZHArarZL+caGXqFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipQlTVJttTWWMwR0BTgb58v0lpya138eyHNVyIDLZ1Vco0ZdgnHh9YPzFgEPRUep1jXMAQujXg2mdTNBU3z5Js3U96Ik+1UXDK5wNmZ9REOW4G5HvtJxnpX9a//5UbQxycJs1XqkfLOUrbBdXd88pgnjWDysqvWib945cpH3YKsSQ3rKRZbADl7FrcdpgXqCky+gspdDwRZ0E0ZcuYjSjgvmdF4zpO5nw4qRDF1ofMydrKkt6pYYk6QC3R3JYYlvLwbROljCWqcI2uaXLb2Pz12UM+RihYm5cOQGA92i2uXtbyLYh5jYnzxAJDJVDkEdp+Pxvw8iCl+F+Ex0elO1Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a5qbs/CR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a5qbs/CR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN8n45DLQz2xHb
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 19:48:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728377298; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0NyW6bEkcTAV3r2ZXDGCX9ZEqYnZHArarZL+caGXqFU=;
	b=a5qbs/CRAr3rNVQKucnvpNty32K8tnZ/FnauzqKFgwFTrXslRwb8dbhX2wi6KOTruvApD/o7RAmxoFSTRcDERIbnvhPOepj9JSVzL5CKGmu0tbtiD3m3B+UE1heVQSPkNMP8QCFl+YKV2TStZDEbJ4WticoBAL90cxQy0Lohv9o=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGcMdA8_1728377295)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 16:48:16 +0800
Message-ID: <e164898b-0094-4e66-a462-4302d56a8f71@linux.alibaba.com>
Date: Tue, 8 Oct 2024 16:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Christian Brauner <brauner@kernel.org>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
 <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
 <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/8 16:46, Christian Brauner wrote:
> On Tue, Oct 08, 2024 at 10:13:31AM GMT, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2024/10/7 19:35, Christian Brauner wrote:
>>> On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
>>
>> ...
>>
>>>>
>>>> Hi Christian, if possible, could you give some other
>>>> idea to handle this case better? Many thanks!
>>
>> Thanks for the reply!
>>
>>>
>>> (1) Require that the path be qualified like:
>>>
>>>       fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
>>>
>>>       and match on it in either erofs_*_get_tree() or by adding a custom
>>>       function for the Opt_source/"source" parameter.
>>
>> IMHO, Users could create names with the prefix `file:`,
>> it's somewhat strange to define a fixed prefix by the
>> definition of source path fc->source.
>>
>> Although there could be some escape character likewise
>> way, but I'm not sure if it's worthwhile to work out
>> this in kernel.
>>
>>>
>>> (2) Add a erofs specific "source-file" mount option. IOW, check that
>>>       either "source-file" or "source" was specified but not both. You
>>>       could even set fc->source to "source-file" value and fail if
>>>       fc->source is already set. You get the idea.
>>
>> I once thought to add a new mount option too, yet from
>> the user perpertive, I think users may not care about
>> the source type of an arbitary path, and the kernel also
>> can parse the type of the source path directly... so..
>>
>>
>> So.. I wonder if it's possible to add a new VFS interface
>> like get_tree_bdev_by_dev() for filesystems to specify a
>> device number rather than hardcoded hard-coded source path
>> way, e.g. I could see the potential benefits other than
>> the EROFS use case:
>>
>>   - Filesystems can have other ways to get a bdev-based sb
>>     in addition to the current hard-coded source path way;
>>
>>   - Some pseudo fs can use this way to generate a fs from a
>>     bdev.
>>
>>   - Just like get_tree_nodev(), it doesn't strictly tie to
>>     fc->source too.
>>
>> Also EROFS could lookup_bdev() (this kAPI is already
>> exported) itself to check if it uses get_tree_bdev_by_dev()
>> or get_tree_nodev()... Does it sounds good?  Many thanks!
> 
> Sounds fair to me.

Okay, thanks! Let me submit patches for this.

Thanks,
Gao Xiang
