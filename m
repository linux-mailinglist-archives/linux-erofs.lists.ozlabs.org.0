Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A226F8D9
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 07:25:33 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sVSB2xD9zDqMF
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 15:25:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sVS669q7zDq8g
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 15:25:25 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8750EAB3666A593AD324;
 Mon, 22 Jul 2019 13:25:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 13:25:13 +0800
Subject: Re: [PATCH v3 01/24] erofs: add on-disk layout
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-2-gaoxiang25@huawei.com>
 <20190722132616.60edd141@canb.auug.org.au> <20190722050522.GA11993@kroah.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <98b70190-a7d8-6251-84d9-599ca115f42b@huawei.com>
Date: Mon, 22 Jul 2019 13:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190722050522.GA11993@kroah.com>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, linux-erofs@lists.ozlabs.org,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2019/7/22 13:05, Greg Kroah-Hartman wrote:
> On Mon, Jul 22, 2019 at 01:26:16PM +1000, Stephen Rothwell wrote:
>> Hi Gao,
>>
>> On Mon, 22 Jul 2019 10:50:20 +0800 Gao Xiang <gaoxiang25@huawei.com> wrote:
>>>
>>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>>> new file mode 100644
>>> index 000000000000..e418725abfd6
>>> --- /dev/null
>>> +++ b/fs/erofs/erofs_fs.h
>>> @@ -0,0 +1,316 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
>>
>> I think the preferred tag is now GPL-2.0-only (assuming that is what is
>> intended).
> 
> Either is fine, see the LICENSE/preferred/GPL-2.0 file for the list of
> valid ones.

Yes, I noticed the LICENSE text before and I can do in the either way (use
GPL-2.0 or GPL-2.0-only). This modification won't take too much time...
If it is needed, I am happy to do that... That is fine :)

Thanks,
Gao Xiang
