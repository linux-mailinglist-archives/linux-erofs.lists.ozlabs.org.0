Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0B96EF2
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 03:34:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Cqvg0t55zDrDJ
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 11:34:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CqvZ39ZtzDqSH
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 11:34:17 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7E40CECFBE302ADD17A5;
 Wed, 21 Aug 2019 09:34:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 21 Aug
 2019 09:34:04 +0800
Subject: Re: [PATCH] erofs: move erofs out of staging
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Gao Xiang <hsiangkao@aol.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>, Dave Chinner
 <david@fromorbit.com>, David Sterba <dsterba@suse.cz>, Miao Xie
 <miaoxie@huawei.com>, devel <devel@driverdev.osuosl.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Amir Goldstein <amir73il@gmail.com>, linux-erofs
 <linux-erofs@lists.ozlabs.org>, Al Viro <viro@zeniv.linux.org.uk>, "Jaegeuk
 Kim" <jaegeuk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Li
 Guifu" <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>, "Pavel
 Machek" <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, torvalds
 <torvalds@linux-foundation.org>
References: <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <20190820155623.GA10232@mit.edu>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <9d8f88ee-4b81-bdfa-b0d7-9c7d5d54e70a@huawei.com>
Date: Wed, 21 Aug 2019 09:34:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190820155623.GA10232@mit.edu>
Content-Type: text/plain; charset="windows-1252"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/8/20 23:56, Theodore Y. Ts'o wrote:
> The reason why there needs to be at least some file system specific
> code for fuzz testing is because for efficiency's sake, you don't want
> to fuzz every single bit in the file system, but just the ones which
> are most interesting (e.g., the metadata blocks).  For file systems
> which use checksum to protect against accidental corruption, the file
> system fuzzer needs to also fix up the checksums (since you can be
> sure malicious attackers will do this).

Yup, IMO, if we really want such tool, it needs to:
- move all generic fuzz codes (trigger random fuzzing in meta/data area) into
that tool, and
- make filesystem generic fs_meta/file_node lookup/inject/pack function as a
callback, such as
 * .find_fs_sb
 * .inject_fs_sb
 * .pack_fs_sb
 * .find_fs_bitmap
 * .inject_fs_bitmap
 * .find_fs_inode_bitmap
 * .inject_fs_inode_bitmap
 * .find_inode_by_num
 * .inject_inode
 * .pack_inode
 * .find_tree_node_by_level
...
then specific filesystem can fill the callback to tell how the tool can locate a
field in inode or a metadata in tree node and then trigger the designed fuzz.

It will be easier to rewrite whole generic fwk for each filesystem, because
existed filesystem userspace tool should has included above callback's detail
codes...

> On Tue, Aug 20, 2019 at 10:24:11AM +0800, Chao Yu wrote:
>> filesystem fill the tool's callback to seek a node/block and supported fields
>> can be fuzzed in inode.

> 
> What you *can* do is to make the file system specific portion of the
> work as small as possible.  Great work in this area is Professor Kim's
> Janus[1][2] and Hydra[2] work.  (Hydra is about to be published at SOSP 19,
> and was partially funded from a Google Faculty Research Work.)
> 
> [1] https://taesoo.kim/pubs/2019/xu:janus.pdf
> [2] https://github.com/sslab-gatech/janus
> [3] https://github.com/sslab-gatech/hydra

Thanks for the information!

It looks like janus and hydra alreay have generic compress/decompress function
across different filesystems, it's really a good job, I do think it may be the
one once it becomes more generic.

Thanks

> 
