Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED356FD9C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 12:18:03 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45scxh6v3SzDqNN
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 20:18:00 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45scxc56DKzDqHw
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 20:17:49 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4BEDBB062;
 Mon, 22 Jul 2019 10:17:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 3FF33DA882; Mon, 22 Jul 2019 12:18:18 +0200 (CEST)
Date: Mon, 22 Jul 2019 12:18:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
Message-ID: <20190722101818.GN20977@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <gaoxiang25@huawei.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722025043.166344-24-gaoxiang25@huawei.com>
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
 Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 22, 2019 at 10:50:42AM +0800, Gao Xiang wrote:
> +choice
> +	prompt "EROFS Data Decompression mode"
> +	depends on EROFS_FS_ZIP
> +	default EROFS_FS_ZIP_CACHE_READAROUND
> +	help
> +	  EROFS supports three options for decompression.
> +	  "In-place I/O Only" consumes the minimum memory
> +	  with lowest random read.
> +
> +	  "Cached Decompression for readaround" consumes
> +	  the maximum memory with highest random read.
> +
> +	  If unsure, select "Cached Decompression for readaround"
> +
> +config EROFS_FS_ZIP_CACHE_DISABLED
> +	bool "In-place I/O Only"
> +	help
> +	  Read compressed data into page cache and do in-place
> +	  I/O decompression directly.
> +
> +config EROFS_FS_ZIP_CACHE_READAHEAD
> +	bool "Cached Decompression for readahead"
> +	help
> +	  For each request, it caches the last compressed page
> +	  for further reading.
> +	  It still does in-place I/O for the rest compressed pages.
> +
> +config EROFS_FS_ZIP_CACHE_READAROUND
> +	bool "Cached Decompression for readaround"
> +	help
> +	  For each request, it caches the both end compressed pages
> +	  for further reading.
> +	  It still does in-place I/O for the rest compressed pages.
> +
> +	  Recommended for performance priority.

The number of individual Kconfig options is quite high, are you sure you
need them to be split like that?

Eg. the xattrs, acls and security labels seem to be part of the basic
set of features so I wonder who does not want to enable them by default.
I think you copied ext4 as a skeleton for the options, but for a new
filesystem it's not necessary copy the history where I think features
were added over time.

Then eg. the option EROFS_FS_IO_MAX_RETRIES looks like a runtime
setting, the config help text does not explain anything about the change
in behaviour leaving the user with 'if not sure take the defaut'.

EROFS_FS_USE_VM_MAP_RAM is IMO a very low implementation detail, why
does it need to be config option at all?

And so on. I'd suggest to go through all the options and reconsider them
to be built-in, or runtime settings. Debugging features like the fault
injections could be useful on non-debugging builds too, so a separate
option is fine, otherwise grouping other debugging options under the
main EROFS_FS_DEBUG would look more logical.
