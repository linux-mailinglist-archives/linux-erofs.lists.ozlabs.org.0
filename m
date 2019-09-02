Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A2A587E
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 15:57:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MWq612DmzDqcw
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 23:57:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="E3s8rI8t"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MWk45h3CzDqdP
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 23:52:44 +1000 (AEST)
Received: from [192.168.0.111] (unknown [180.111.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D15621897;
 Mon,  2 Sep 2019 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567432361;
 bh=gOroYR0C5WTKOPu/VQ5CFcFa5lQQvYa++hC+79eQH/s=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=E3s8rI8tch1TVAzcgD5OWZZEOzgqwPPkjn9lFP0l3a86miClAmSD7sW/vGDeQeo4E
 kFk1hwJddCNd0nS6dWRYlB397xGjb7rBbX3Jp4CLXwCWWKaiUYRxp3YzNQc2lL7/7L
 XpNaXqFE1v92DhuZzZgnOEy87oZHgv8QzzWvN8VU=
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
 Gao Xiang <gaoxiang25@huawei.com>, linux-fsdevel@vger.kernel.org,
 devel@driverdev.osuosl.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, Amir Goldstein <amir73il@gmail.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Dave Chinner <david@fromorbit.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jan Kara <jack@suse.cz>, Richard Weinberger <richard@nod.at>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Miao Xie <miaoxie@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Fang Wei <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org> <20190902130644.GT2752@suse.cz>
From: Chao Yu <chao@kernel.org>
Message-ID: <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
Date: Mon, 2 Sep 2019 21:51:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902130644.GT2752@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 2019-9-2 21:06, David Sterba wrote:
> On Mon, Sep 02, 2019 at 05:57:11AM -0700, Christoph Hellwig wrote:
>>> +config EROFS_FS_XATTR
>>> +	bool "EROFS extended attributes"
>>> +	depends on EROFS_FS
>>> +	default y
>>> +	help
>>> +	  Extended attributes are name:value pairs associated with inodes by
>>> +	  the kernel or by users (see the attr(5) manual page, or visit
>>> +	  <http://acl.bestbits.at/> for details).
>>> +
>>> +	  If unsure, say N.
>>> +
>>> +config EROFS_FS_POSIX_ACL
>>> +	bool "EROFS Access Control Lists"
>>> +	depends on EROFS_FS_XATTR
>>> +	select FS_POSIX_ACL
>>> +	default y
>>
>> Is there any good reason to make these optional these days?
> 
> I objected against adding so many config options, not to say for the
> standard features. The various cache strategies or other implementation
> details have been removed but I agree that making xattr/acl configurable
> is not necessary as well.

I can see similar *_ACL option in btrfs/ext4/xfs, should we remove them as well
due to the same reason?

Thanks,

> 
