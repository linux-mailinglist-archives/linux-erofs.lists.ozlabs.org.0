Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF3B607323
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 11:00:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtz200cpnz3drW
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 20:00:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666342808;
	bh=ezMSvDrY3DZBmJJm3C3hflsncD1eIFVmvd8eMJYE/Ow=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DIM/alTm2ucOR61BTMRq6jzt12gZKuZtQXx4X60xB5HosmPux7DnyaTQvUHLYjyHI
	 iA6D078hHM42DS8kMe7nM0yTdFogO3DzEabZ2XWIxtJDhDFOuryvsVfOEWdskg0N8w
	 W83jYkatwkFU+7ZW9yYwlDLVHKGOrV05vQpvwu6eT7SsCvt969499cajh6EQLSioPf
	 +COA6fs5fcNsvYVJTSnvs1QIzmZtjaYHVLDjbXkmUQs0azMqJO9IwNm/RwdsL/PBye
	 NATugUu5zMIvqUEsOjAht2Qo3QVwhnTd3wm0IvBNtwp8aMI75yYo4LfLNa/Ar7yIsW
	 /eyO2umZkbEbw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtz1v2nBNz3bY8
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 20:00:00 +1100 (AEDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtz1T2m19zHvFM;
	Fri, 21 Oct 2022 16:59:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:59:48 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:59:47 +0800
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
To: Greg KH <gregkh@linuxfoundation.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
 <Y1JZ9IUPL6jZIQ8E@kroah.com>
Message-ID: <f1210e20-d167-26c4-7aba-490d8fb7241e@huawei.com>
Date: Fri, 21 Oct 2022 16:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1JZ9IUPL6jZIQ8E@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2022/10/21 16:36, Greg KH wrote:
> On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
>> On 2022/10/21 13:37, Greg KH wrote:
>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>> The previous discussion link:
>>>>> https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
>>>> The very first discussion on this was here:
>>>>
>>>> https://www.spinics.net/lists/dri-devel/msg368077.html
>>>>
>>>> Please use this link, and not the that one up there you which quoted above,
>>>> and whose commit description is taken verbatim from the this link.
>>>>
>>>>> kset_register() is currently used in some places without calling
>>>>> kset_put() in error path, because the callers think it should be
>>>>> kset internal thing to do, but the driver core can not know what
>>>>> caller doing with that memory at times. The memory could be freed
>>>>> both in kset_put() and error path of caller, if it is called in
>>>>> kset_register().
>>>> As I explained in the link above, the reason there's
>>>> a memory leak is that one cannot call kset_register() without
>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>
>>>> Thus, the most common usage is something like this:
>>>>
>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>> 	kset->kobj.kset = parent_kset;
>>>> 	kset->kobj.ktype = ktype;
>>>> 	res = kset_register(kset);
>>>>
>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>> by the common idiom shown above. This needs to be mentioned in
>>>> the documentation, at least, in case, in the future this is absolved
>>>> in kset_register() redesign, etc.
>>> Based on this, can kset_register() just clean up from itself when an
>>> error happens?  Ideally that would be the case, as the odds of a kset
>>> being embedded in a larger structure is probably slim, but we would have
>>> to search the tree to make sure.
>> I have search the whole tree, the kset used in bus_register() - patch #3,
>> kset_create_and_add() - patch #4
>> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
>> amdgpu_discovery.c - patch #10
>> is embedded in a larger structure. In these cases, we can not call
>> kset_put() in error path in kset_register()
> Yes you can as the kobject in the kset should NOT be controling the
> lifespan of those larger objects.
>
> If it is, please point out the call chain here as I don't think that
> should be possible.
>
> Note all of this is a mess because the kobject name stuff was added much
> later, after the driver model had been created and running for a while.
> We missed this error path when adding the dynamic kobject name logic,
> thank for looking into this.
>
> If you could test the patch posted with your error injection systems,
> that could make this all much simpler to solve.

The patch posted by Luben will cause double free in some cases.


 From 71e0a22801c0699f67ea40ed96e0a7d7d9e0f318 Mon Sep 17 00:00:00 2001
From: Luben Tuikov <luben.tuikov@amd.com>
Date: Fri, 21 Oct 2022 03:34:21 -0400
Subject: [PATCH] kobject: Add kset_put() if kset_register() fails
X-check-string-leak: v1.0

If kset_register() fails, we call kset_put() before returning the
error. This makes sure that we free memory allocated by kobj_set_name()
for the kset, since kset_register() cannot be called unless the kset has
a name, usually gotten via kobj_set_name(&kset->kobj, format, ...);

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
  lib/kobject.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa2334..c122b979f2b75e 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -844,8 +844,10 @@ int kset_register(struct kset *k)

      kset_init(k);
      err = kobject_add_internal(&k->kobj);
-    if (err)
+    if (err) {
+        kset_put(k);
          return err;
+    }
      kobject_uevent(&k->kobj, KOBJ_ADD);
      return 0;
  }
-- 
2.38.0-rc2

>
> thanks,
>
> greg k-h
> .
