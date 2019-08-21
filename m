Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876396F48
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 04:13:09 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CrmL4wc9zDrFF
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 12:13:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CrmG0hbMzDrDr
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 12:13:00 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 53AE02C24E7B201D87F2;
 Wed, 21 Aug 2019 10:12:55 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 21 Aug
 2019 10:12:47 +0800
Subject: Re: [PATCH] erofs: move erofs out of staging
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Gao Xiang <hsiangkao@aol.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
 <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>
 <735b8d15-bcb5-b11b-07c1-0617eb1e5ce9@gmx.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <92e44c38-d52b-cd13-c893-351f959beb54@huawei.com>
Date: Wed, 21 Aug 2019 10:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <735b8d15-bcb5-b11b-07c1-0617eb1e5ce9@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Richard Weinberger <richard@nod.at>, Eric Biggers <ebiggers@kernel.org>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/8/20 16:46, Qu Wenruo wrote:
> [...]
>>
>> Yeah, it looks like we need searching more levels mapping to find the final
>> physical block address of inode/node/data in btrfs.
>>
>> IMO, in a little lazy way, we can reform and reuse existed function in
>> btrfs-progs which can find the mapping info of inode/node/data according to
>> specified ino or ino+pg_no.
> 
> Maybe no need to go as deep as ino.
> 
> What about just go physical bytenr? E.g. for XFS/EXT* choose a random
> bytenr. Then verify if that block is used, if not, try again.
> 
> If used, check if it's metadata. If not, try again.
> (feel free to corrupt data, in fact btrfs uses some data as space cache,
> so it should make some sense)
> 
> If metadata, corrupt that bytenr/bytenr range in the metadata block,
> regenerate checksum, call it a day and let kernel suffer.
> 
> For btrfs, just do extra physical -> logical convert in the first place,
> then follow the same workflow.
> It should work for any fs as long as it's on single device.

Agree, it will be easier to trigger random injection in specific area, and also
I agreed with Ted, some of the time we prefer to do injection in specified field
of meta, it looks developer needs to do more work for that.

> 
>>
>>>
>>> It may depends on the granularity. But definitely a good idea to do so
>>> in a generic way.
>>> Currently we depend on super kind student developers/reporters on such
>>
>> Yup, I just guess Wen Xu may be interested in working on a generic way to fuzz
>> filesystem, as I know they dig deep in filesystem code when doing fuzz.
> 
> Don't forget Yoon Jungyeon, I see more than one times he reported fuzzed
> images with proper reproducer and bugzilla links.

Of course I remember him. :)

I guess btrfs/f2fs should has improved their stability/robustness a lot due to
Jungyeon and Wen Xu's gret fuzz bug report.

> Even using his personal mail address, not school mail address.
> 
> Those guys are really awesome!
> 
>> BTW,
>> which impresses me is, constructing checkpoint by injecting one byte, and then
>> write a correct recalculated checksum value on that checkpoint, making that
>> checkpoint looks valid...
> 
> IIRC F2FS guys may be also investigating a similar mechanism, as they
> also got a hard fight against reports from those awesome reporters.

Actually, f2fs only support realtime fault injection framework, which allows us
to inject memory exhausting, IO error, lack of free blocks, shutdown... error
during fsstress test.

I do think f2fs needs that kind of tool later.

Thanks,

> 
> So such fuzzed image is a new trend for fs development.
> 
> Thanks,
> Qu
> 
>>
>> Thanks,
>>
> 
