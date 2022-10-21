Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D155607215
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:25:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtyFR1QkZz3bXn
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:24:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666340699;
	bh=4tpxnqik1XAnrGlJyGCwUtdkI9g+xhisCqPaAlOGh3M=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fSa5PCKTQR6LbVvN9g1VtMIgi+R1u5Utwo5wykOD+qI3Nw57xGD0ipD7f+hsT7D4a
	 xz1qF1U8F/mCacgAUDjTRZ9416C1v6uOlLkHJzkM3FrJKOGTBJ+W8VnCg3KJZIVvHP
	 hHU8HsYfAs46HanEQNJ1VHs8R6/S69FIrA3dvrHzrTK5kiPtVfpRpbpxBF3aP8ALd0
	 2B9Ggz9ufPLtjXhBs4fPPrL9A/JiPZfPyifND6HKEKLP5pGAKpPAwJEFNsfZfHGF4x
	 r2Z0ED/DBGFHssXtGlbEFRNTgPHAwXkjxBKDb678bcVqCTKQZKHNJZNk13x973+06F
	 ULtiq0Ditt5wA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtyFM5qjQz3bXn
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:24:55 +1100 (AEDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mty7v25HnzVj06;
	Fri, 21 Oct 2022 16:20:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:24:25 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:24:24 +0800
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
To: Greg KH <gregkh@linuxfoundation.org>, Luben Tuikov <luben.tuikov@amd.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
Message-ID: <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
Date: Fri, 21 Oct 2022 16:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1IwLOUGayjT9p6d@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
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
From: Yang Yingliang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yang Yingliang <yangyingliang@huawei.com>
Cc: rafael@kernel.org, qemu-devel@nongnu.org, richard@nod.at, somlo@cmu.edu, mst@redhat.com, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-f2fs-devel@lists.sourceforge.net, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, jlbec@evilplan.org, hsiangkao@linux.alibaba.com, alexander.deucher@amd.com, jaegeuk@kernel.org, akpm@linux-foundation.org, huangjianan@oppo.com, linux-erofs@lists.ozlabs.org, mark@fasheh.com, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2022/10/21 13:37, Greg KH wrote:
> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>> The previous discussion link:
>>> https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
>> The very first discussion on this was here:
>>
>> https://www.spinics.net/lists/dri-devel/msg368077.html
>>
>> Please use this link, and not the that one up there you which quoted above,
>> and whose commit description is taken verbatim from the this link.
>>
>>> kset_register() is currently used in some places without calling
>>> kset_put() in error path, because the callers think it should be
>>> kset internal thing to do, but the driver core can not know what
>>> caller doing with that memory at times. The memory could be freed
>>> both in kset_put() and error path of caller, if it is called in
>>> kset_register().
>> As I explained in the link above, the reason there's
>> a memory leak is that one cannot call kset_register() without
>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>> in this case, i.e. kset_register() fails with -EINVAL.
>>
>> Thus, the most common usage is something like this:
>>
>> 	kobj_set_name(&kset->kobj, format, ...);
>> 	kset->kobj.kset = parent_kset;
>> 	kset->kobj.ktype = ktype;
>> 	res = kset_register(kset);
>>
>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>> by the common idiom shown above. This needs to be mentioned in
>> the documentation, at least, in case, in the future this is absolved
>> in kset_register() redesign, etc.
> Based on this, can kset_register() just clean up from itself when an
> error happens?  Ideally that would be the case, as the odds of a kset
> being embedded in a larger structure is probably slim, but we would have
> to search the tree to make sure.
I have search the whole tree, the kset used in bus_register() - patch 
#3, kset_create_and_add() - patch #4
__class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and 
amdgpu_discovery.c - patch #10
is embedded in a larger structure. In these cases, we can not call 
kset_put() in error path in kset_register()
itself.

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
