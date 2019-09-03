Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0ADA6184
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 08:33:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MxwP6s0hzDqkx
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 16:33:09 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MxtB5JL9zDqkL
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 16:31:12 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7037E8B6A2F31DF55807;
 Tue,  3 Sep 2019 14:31:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Sep 2019
 14:30:56 +0800
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
To: <dsterba@suse.cz>, Chao Yu <chao@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, Gao Xiang <gaoxiang25@huawei.com>,
 <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>, Amir Goldstein
 <amir73il@gmail.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, "Dave
 Chinner" <david@fromorbit.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara
 <jack@suse.cz>, Richard Weinberger <richard@nod.at>, Linus Torvalds
 <torvalds@linux-foundation.org>, <linux-erofs@lists.ozlabs.org>, Miao Xie
 <miaoxie@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>, Fang Wei
 <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org> <20190902130644.GT2752@suse.cz>
 <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
 <20190902142037.GW2752@twin.jikos.cz>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <12d37c63-dd0e-04fb-91f8-f4b930e867e5@huawei.com>
Date: Tue, 3 Sep 2019 14:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902142037.GW2752@twin.jikos.cz>
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

On 2019/9/2 22:20, David Sterba wrote:
> Oh right, I think the reasons are historical and that we can remove the
> options nowadays. From the compatibility POV this should be safe, with
> ACLs compiled out, no tool would use them, and no harm done when the
> code is present but not used.
> 
> There were some efforts by embedded guys to make parts of kernel more
> configurable to allow removing subsystems to reduce the final image
> size. In this case I don't think it would make any noticeable
> difference, eg. the size of fs/btrfs/acl.o on release config is 1.6KiB,
> while the whole module is over 1.3MiB.

Actually, btrfs's LOC is about 20 times larger than erofs's, acl part's LOC
could be very small one in btrfs.

EROFS can be slimmed about 10% size if we disable XATTR/ACL config, which is
worth to keep that, at least for now.

Thanks,


