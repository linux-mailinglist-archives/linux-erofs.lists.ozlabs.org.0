Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0266F16F
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 06:12:45 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45rrtg3D07zDqdw
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 14:12:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45rrtX1CJWzDqKh
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jul 2019 14:12:35 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3E3EEFAA479FD8ABFB89;
 Sun, 21 Jul 2019 12:12:31 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 21 Jul
 2019 12:12:23 +0800
Subject: Re: [PATCH v2 03/24] erofs: add super block operations
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190711145755.33908-4-gaoxiang25@huawei.com>
 <20190720224955.GD17978@ZenIV.linux.org.uk>
 <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
 <20190721040547.GF17978@ZenIV.linux.org.uk>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <7774f181-a41c-f30a-3b2a-02d7438d3509@huawei.com>
Date: Sun, 21 Jul 2019 12:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190721040547.GF17978@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/21 12:05, Al Viro wrote:
> On Sun, Jul 21, 2019 at 11:08:42AM +0800, Gao Xiang wrote:
> 
>> It is for debugging use as you said below, mainly for our internal
>> testers whose jobs are
>> to read kmsg logs and catch kernel problems. sb->s_id (device number)
>> maybe not
>> straight-forward for them compared with dev_name...
> 
> Huh? ->s_id is something like "sdb7" - it's bdev_name(), not a device
> number...

You are right. Forgive me, actually we use /dev/block/by-name/system
to mount fs... we have to do some lookup if using sdbX instead.


> 
>> The initial purpose of erofs_mount_private was to passing multi private
>> data from erofs_mount
>> to erofs_read_super, which was written before fs_contest was introduced.
> 
> That has nothing to do with fs_context (well, other than fs_context conversions
> affecting the code very close to that).

OK. That is fine.

> 
>> I agree with you, it seems better to just use s_id in community and
>> delete erofs_mount_private stuffs...
>> Yet I don't look into how to use new fs_context, could I keep using
>> legacy mount interface and fix them all?
> 
> Sure.
> 
>> I guess if I don't misunderstand, that is another suggestion -- in
>> short, leave all destructors to .kill_sb() and
>> cleanup fill_super().
> 
> Just be careful with that iput() there - AFAICS, if fs went live (i.e.
> if ->s_root is non-NULL), you really need it done only from put_super();
> OTOH, for the case of NULL ->s_root ->put_super() won't be called at all,
> so in that case you need it directly in ->kill_sb().

I got it. I will do a quick try now :) But in case of introducing issues,
I guess I need to do some fault injection by hand.....

Thanks,
Gao Xiang

> 
