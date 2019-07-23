Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F11BD72596
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 05:53:16 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45thJp1VSXzDq6N
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 13:53:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tHrB0c58zDq9j
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 22:30:32 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6BAE3AD7B;
 Tue, 23 Jul 2019 12:30:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 3BB05DA7D5; Tue, 23 Jul 2019 14:31:05 +0200 (CEST)
Date: Tue, 23 Jul 2019 14:31:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
Message-ID: <20190723123104.GB2868@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <hsiangkao@aol.com>,
 Gao Xiang <gaoxiang25@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
 <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, dsterba@suse.cz,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 22, 2019 at 06:58:59PM +0800, Gao Xiang wrote:
> On 2019/7/22 ????6:18, David Sterba wrote:
> > On Mon, Jul 22, 2019 at 10:50:42AM +0800, Gao Xiang wrote:
> >> +choice
> >> +	prompt "EROFS Data Decompression mode"
> >> +	depends on EROFS_FS_ZIP
> >> +	default EROFS_FS_ZIP_CACHE_READAROUND
> >> +	help
> >> +	  EROFS supports three options for decompression.
> >> +	  "In-place I/O Only" consumes the minimum memory
> >> +	  with lowest random read.
> >> +
> >> +	  "Cached Decompression for readaround" consumes
> >> +	  the maximum memory with highest random read.
> >> +
> >> +	  If unsure, select "Cached Decompression for readaround"
> >> +
> >> +config EROFS_FS_ZIP_CACHE_DISABLED
> >> +	bool "In-place I/O Only"
> >> +	help
> >> +	  Read compressed data into page cache and do in-place
> >> +	  I/O decompression directly.
> >> +
> >> +config EROFS_FS_ZIP_CACHE_READAHEAD
> >> +	bool "Cached Decompression for readahead"
> >> +	help
> >> +	  For each request, it caches the last compressed page
> >> +	  for further reading.
> >> +	  It still does in-place I/O for the rest compressed pages.
> >> +
> >> +config EROFS_FS_ZIP_CACHE_READAROUND
> >> +	bool "Cached Decompression for readaround"
> >> +	help
> >> +	  For each request, it caches the both end compressed pages
> >> +	  for further reading.
> >> +	  It still does in-place I/O for the rest compressed pages.
> >> +
> >> +	  Recommended for performance priority.
> > 
> > The number of individual Kconfig options is quite high, are you sure you
> > need them to be split like that?
> 
> You mean the above? these are 3 cache strategies, which impact the
> runtime memory consumption and performance. I tend to leave the above
> as it-is...

No, I mean all Kconfig options, they're scattered over several patches,
best seen in the checked out branch. The cache strategies are actually
just one config option (choice).

> I'm not sure vm_map_ram() is always better than vmap() for all
> platforms (it has noticeable performance impact). However that
> seems true for my test machines (x86-64, arm64).
> 
> If vm_map_ram() is always the optimal choice compared with vmap(),
> I will remove vmap() entirely, that is OK. But I am not sure for
> every platforms though.

You can select the implementation by platform, I don't know what are the
criteria like cpu type etc, but I expect it's something that can be
determined at module load time. Eventually a module parameter can be the
the way to set it.

> > And so on. I'd suggest to go through all the options and reconsider them
> > to be built-in, or runtime settings. Debugging features like the fault
> > injections could be useful on non-debugging builds too, so a separate
> > option is fine, otherwise grouping other debugging options under the
> > main EROFS_FS_DEBUG would look more logical.
> 
> The remaining one is EROFS_FS_CLUSTER_PAGE_LIMIT. It impacts the total
> size of z_erofs_pcluster structure. It's a hard limit, and should be
> configured as small as possible. I can remove it right now since multi-block
> compression is not available now. However, it will be added again after
> multi-block compression is supported.
> 
> So, How about leave it right now and use the default value?

From the Kconfig and build-time settings perspective I think it's
misplaced. This affects testing, you'd have to rebuild and reinstall the
module to test any change, while it's "just" a number that can be either
module parameter, sysfs knob, mount option or special ioctl.

But I may be wrong, EROFS is a special purpose filesystem, so the
fine-grained build options might make sense (eg. due to smaller code).
The question should be how does each option affect typical production
build targets. Fewer is IMHO better.
