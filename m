Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E01F920E
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 10:45:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49llKX17yQzDqYJ
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 18:45:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 959 seconds by postgrey-1.36 at bilbo;
 Mon, 15 Jun 2020 18:45:44 AEST
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49llKN3PYNzDqXJ
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2020 18:45:40 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 22705C249E38EBCC0C97;
 Mon, 15 Jun 2020 16:29:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 15 Jun
 2020 16:29:00 +0800
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
To: Gao Xiang <hsiangkao@redhat.com>, Jason Yan <yanaijie@huawei.com>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
 <20200615072521.GA25317@xiangao.remote.csb>
 <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
 <20200615080714.GB25317@xiangao.remote.csb>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4319ff76-c61f-e266-354f-83526207c767@huawei.com>
Date: Mon, 15 Jun 2020 16:29:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200615080714.GB25317@xiangao.remote.csb>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
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
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/6/15 16:07, Gao Xiang wrote:
> On Mon, Jun 15, 2020 at 03:43:09PM +0800, Jason Yan wrote:
>>
>>
>> �?2020/6/15 15:25, Gao Xiang 写道:
>>> Hi Jason,
>>>
>>> On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
>>>> This is an effort to eliminate the uninitialized_var() macro[1].
>>>>
>>>> The use of this macro is the wrong solution because it forces off ANY
>>>> analysis by the compiler for a given variable. It even masks "unused
>>>> variable" warnings.
>>>>
>>>> Quoted from Linus[2]:
>>>>
>>>> "It's a horrible thing to use, in that it adds extra cruft to the
>>>> source code, and then shuts up a compiler warning (even the _reliable_
>>>> warnings from gcc)."
>>>>
>>>> The gcc option "-Wmaybe-uninitialized" has been disabled and this change
>>>> will not produce any warnnings even with "make W=1".
>>>>
>>>> [1] https://github.com/KSPP/linux/issues/81
>>>> [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>>>>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Chao Yu <yuchao0@huawei.com>
>>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>>> ---
>>>
>>> I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
>>> I've also asked Kees for it in private previously.
>>>
>>> I still remembered that Kees sent out a treewide patch. Sorry about that
>>> I don't catch up it... But what is wrong with the original patchset?
>>>
>>
>> Yes, Kees has remind me of that and I will let him handle it. So you can
>> ignore this patch.
> 
> Okay, I was just wondering if this part should be send out via EROFS tree
> for this cycle. However if there was an automatic generated patch by Kees,
> I think perhaps Linus could pick them out directly. But anyway, both ways
> are fine with me. ;) Ping me when needed.

Either way is okay to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Jason
>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>
>>> .
>>>
>>
> 
> .
> 
